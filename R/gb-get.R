#' Get individual country boundary files from geoBoundaries
#'
#' @description
#' [Attribution](https://www.geoboundaries.org/index.html#usage) is required for
#' all uses of this dataset.
#'
#' This function returns boundary data for individual countries *as they
#' represent themselves*, without any special identification of disputed areas.
#'
#' If you require data that explicitly includes disputed areas, use
#' [gb_get_world()] instead.
#'
#' @export
#' @encoding UTF-8
#'
#' @param country Character vector of country identifiers. This can be `"all"`
#'   (to return data for all countries), a vector of country names, or ISO3
#'   country codes. See also [countrycode::countrycode()].
#' @param adm_lvl Type of boundary to retrieve. Accepted values are `"all"` (all
#'   available administrative levels) or a specific ADM level. `"adm0"`
#'   corresponds to country boundaries, `"adm1"` to first-level subnational
#'   boundaries, `"adm2"` to second-level boundaries, and so on. Uppercase
#'   variants (e.g. `"ADM1"`) and numeric values (`0`, `1`, `2`, `3`, `4`, `5`)
#'   are also accepted.
#' @param simplified logical. If `TRUE`, return simplified boundaries. If
#'   `FALSE` (the default), use the premier geoBoundaries release.
#' @param release_type One of `"gbOpen"`, `"gbHumanitarian"`, or
#'   `"gbAuthoritative"`. For most users, `"gbOpen"` (the default) is
#'   recommended, as it is CC-BY 4.0 compliant and suitable for most purposes
#'   provided proper attribution is given:
#'   - `"gbHumanitarian"` files are mirrored from
#'     [UN OCHA](https://www.unocha.org/) and may have more restrictive
#'     licensing.
#'   - `"gbAuthoritative"` files are mirrored from UN SALB and cannot be used
#'     for commercial purposes, but are verified through in-country processes.
#' @param quiet logical. If `TRUE`, suppress informational messages.
#' @param overwrite logical. If `TRUE`, force a fresh download of the source
#'   `.zip` file, even if it is already cached.
#' @param path Character. Path to a cache directory. If `NULL` (the default),
#'   data are stored in the default cache directory (see [gb_set_cache()]). If
#'   no cache directory has been configured, files are stored in a temporary
#'   directory (see [base::tempdir()]).
#'
#' @details
#' Individual boundary files in the geoBoundaries database are governed by the
#' license or licenses specified in their associated metadata (see
#' [gb_get_metadata()]). Users working with individual boundary files should
#' ensure that they comply with these licenses and cite the original data
#' sources listed in the metadata. See **Examples**.
#'
#' The following convenience wrappers are also available:
#'
#' - [gb_get_adm0()] returns country boundaries.
#' - [gb_get_adm1()] returns first-level administrative boundaries
#'   (e.g. states in the United States).
#' - [gb_get_adm2()] returns second-level administrative boundaries
#'   (e.g. counties in the United States).
#' - [gb_get_adm3()] returns third-level administrative boundaries
#'   (e.g. municipalities in some countries).
#' - [gb_get_adm4()] returns fourth-level administrative boundaries.
#' - [gb_get_adm5()] returns fifth-level administrative boundaries.
#'
#' @return
#' An [`sf`][sf::st_sf] object containing the requested boundaries.
#'
#' @source
#' geoBoundaries API Service <https://www.geoboundaries.org/api.html>.
#'
#' @references
#' Runfola, D. et al. (2020) geoBoundaries: A global database of political
#' administrative boundaries. *PLoS ONE* 15(4): e0231866.
#' \doi{10.1371/journal.pone.0231866}.
#'
#' @family API functions
#'
#' @examplesIf httr2::is_online()
#'
#' \donttest{
#' # Level 2 administrative boundaries in Sri Lanka
#' sri_lanka <- gb_get(
#'   "Sri Lanka",
#'   adm_lvl = 2,
#'   simplified = TRUE
#' )
#'
#' sri_lanka
#'
#' library(ggplot2)
#' ggplot(sri_lanka) +
#'   geom_sf() +
#'   labs(caption = "Source: www.geoboundaries.org")
#' }
#'
#' # Inspect metadata and licensing
#' library(dplyr)
#' gb_get_metadata(
#'   "Sri Lanka",
#'   adm_lvl = 2
#' ) |>
#'   select(boundaryISO, boundaryType, licenseDetail, licenseSource) |>
#'   glimpse()
#'
gb_get <- function(
  country,
  adm_lvl = "adm0",
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
) {
  # Input params
  source <- match.arg(release_type)
  adm_lvl <- assert_adm_lvl(adm_lvl)
  country <- rgbnd_dev_country2iso(country)

  meta_df <- gb_get_metadata(
    country = country,
    adm_lvl = adm_lvl,
    release_type = release_type
  )

  if (nrow(meta_df) == 0) {
    cli::cli_alert_danger("Nothing to download, returning {.code NULL}")
    return(NULL)
  }

  url_bound <- meta_df$staticDownloadLink

  # CleanUp
  url_bound <- unique(url_bound)
  url_bound <- url_bound[!is.na(url_bound)]
  url_bound <- url_bound[!is.null(url_bound)]

  # Call and bind
  res_sf <- lapply(url_bound, function(x) {
    rgbnd_dev_shp_query(
      url = x,
      subdir = source,
      quiet = quiet,
      overwrite = overwrite,
      path = path,
      simplified = simplified
    )
  })

  meta_sf <- dplyr::bind_rows(res_sf)

  meta_sf
}


rgbnd_dev_shp_query <- function(
  url,
  subdir,
  quiet,
  overwrite,
  path,
  cgaz_country = "ALL",
  simplified = FALSE
) {
  filename <- basename(url)
  # Prepare cache
  path <- rgbnd_dev_cachedir(path)
  path <- rgbnd_dev_cachedir(file.path(path, subdir))

  # Create destfile and clean
  file_local <- file.path(path, filename)
  file_local <- gsub("//", "/", file_local, fixed = TRUE)

  fileoncache <- file.exists(file_local)

  # Check if cached
  if (isFALSE(overwrite) && fileoncache) {
    if (!quiet) {
      cli::cli_alert_success("File {.file {file_local}} already cached")
    }
  } else {
    # Download
    if (!quiet) {
      cli::cli_alert_info("Downloading file from {.url {url}}")
      cli::cli_alert("Cache dir is {.path {path}}")
    }

    # Prepare download
    q <- httr2::request(url)
    q <- httr2::req_error(q, is_error = function(x) {
      FALSE
    })
    q <- httr2::req_retry(q, max_tries = 3, is_transient = function(resp) {
      httr2::resp_status(resp) %in% c(429, 500, 503)
    })
    if (!quiet) {
      q <- httr2::req_progress(q)
    }
    get <- httr2::req_perform(q, path = file_local) # nolint

    # In error inform and return NULL
    if (httr2::resp_is_error(get)) {
      unlink(file_local, force = TRUE)
      # nolint start: Error code for message
      err <- paste0(
        c(
          httr2::resp_status(get),
          httr2::resp_status_desc(get)
        ),
        collapse = " - "
      )
      # nolint end
      cli::cli_alert_danger("{.url {url}} gives error {err}")

      return(NULL)
    }
  }

  # Read file names
  shp_zip <- unzip(file_local, list = TRUE)
  shp_zip <- shp_zip$Name
  shp_zip <- shp_zip[grepl("shp$", shp_zip)]
  if (simplified) {
    shp_end <- shp_zip[grepl("simplified", shp_zip, fixed = TRUE)]
  } else {
    shp_end <- shp_zip[!grepl("simplified", shp_zip, fixed = TRUE)]
  }

  # Read with vsizip
  shp_read <- file.path("/vsizip/", file_local, shp_end)
  shp_read <- gsub("//", "/", shp_read, fixed = TRUE)
  outsf <- sf::read_sf(shp_read)

  if (subdir == "CGAZ" && !("ALL" %in% cgaz_country)) {
    outsf <- outsf[outsf$shapeGroup %in% cgaz_country, ]
  }
  outsf <- rgbnd_dev_sf_helper(outsf)
}
