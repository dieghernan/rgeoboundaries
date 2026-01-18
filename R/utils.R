assert_adm_lvl <- function(
  adm_lvl,
  dict = c("all", paste0("adm", 0:5), 0:5)
) {
  if (length(adm_lvl) > 1) {
    cli::cli_abort(
      paste0(
        "You cannot mix different {.arg adm_lvl} values. You entered ",
        "{.val {adm_lvl}}."
      )
    )
  }

  adm_lvl_clean <- tolower(as.character(adm_lvl))
  if (!adm_lvl_clean %in% dict) {
    cli::cli_abort(
      c(
        "Invalid {.arg adm_lvl} code ({.val {adm_lvl_clean}}).",
        "Accepted values are {.val {dict}}."
      )
    )
  }

  # If numeric, return the correctly formatted ADM level
  if (is.numeric(adm_lvl)) {
    adm_lvl <- paste0("ADM", adm_lvl)
  }

  toupper(adm_lvl)
}

#' Helper function to convert country names to ISO codes
#'
#' Convert country names or codes to standardized ISO codes.
#'
#' @param names A vector of country names or codes.
#' @param out Output code format (default: `"iso3c"`).
#'
#' @return A vector of ISO codes.
#'
#' @noRd
rgbnd_dev_country2iso <- function(names, out = "iso3c") {
  # Correct common misspelling
  names[tolower(names) == "antartica"] <- "Antarctica"

  # Force output format
  out <- "iso3c"

  if (any(tolower(names) == "all")) {
    return("ALL")
  }

  # Vectorized conversion
  outnames <- lapply(names, function(x) {
    if (grepl("Kosovo", x, ignore.case = TRUE)) {
      return("XKX")
    }
    if (grepl("XKX", x, ignore.case = TRUE)) {
      return("XKX")
    }

    maxname <- max(nchar(x))

    if (maxname > 3) {
      outnames <- countrycode::countryname(x, out, warn = FALSE)
    } else if (maxname == 3) {
      outnames <- countrycode::countrycode(x, "iso3c", out, warn = FALSE)
    } else {
      cli::cli_abort(
        "Invalid country names. Provide a vector of names or ISO3 codes."
      )
    }

    outnames
  })

  outnames <- unlist(outnames)
  linit <- length(outnames)
  outnames2 <- outnames[!is.na(outnames)]
  lend <- length(outnames2)

  if (linit != lend) {
    ff <- names[is.na(outnames)] # nolint
    cli::cli_alert_warning(
      "Some values could not be matched unambiguously: {ff}"
    )
    cli::cli_alert_info("Check the names or use ISO3 codes instead.")
  }

  outnames2
}

rgbnd_dev_sf_helper <- function(data_sf) {
  # Adapted from sf/read.R:
  # https://github.com/r-spatial/sf/blob/master/R/read.R
  set_utf8 <- function(x) {
    n <- names(x)
    Encoding(n) <- "UTF-8"

    to_utf8 <- function(x) {
      if (is.character(x)) {
        Encoding(x) <- "UTF-8"
      }
      x
    }

    structure(lapply(x, to_utf8), names = n)
  }
  # End borrowed code

  # Convert column names to UTF-8
  names <- names(data_sf)

  # Extract geometry
  g <- sf::st_geometry(data_sf)

  # Ensure all geometries are MULTIPOLYGON
  geomtype <- sf::st_geometry_type(g)

  # nocov start
  if (any(geomtype == "POLYGON")) {
    g <- sf::st_cast(g, "MULTIPOLYGON")
  }
  # nocov end

  # Identify geometry column
  which_geom <- which(vapply(
    data_sf,
    function(f) inherits(f, "sfc"),
    TRUE
  ))

  nm <- names(which_geom)

  # Convert attributes to UTF-8
  data_utf8 <- as.data.frame(
    set_utf8(sf::st_drop_geometry(data_sf)),
    stringsAsFactors = FALSE
  )
  data_utf8 <- dplyr::as_tibble(data_utf8)

  # Rebuild sf object with corrected encoding
  data_sf <- sf::st_as_sf(data_utf8, g)

  # Restore original geometry column name
  newnames <- names(data_sf)
  newnames[newnames == "g"] <- nm
  colnames(data_sf) <- newnames
  data_sf <- sf::st_set_geometry(data_sf, nm)

  data_sf
}
