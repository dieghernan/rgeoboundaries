#' Retrieve the highest available administrative level for a country
#'
#' @description
#' Generate a summary of selected countries—or all countries—and the highest
#' administrative level available in the geoBoundaries dataset.
#'
#' @family metadata functions
#'
#' @inheritParams gb_get_metadata
#' @inherit gb_get_metadata source
#' @encoding UTF-8
#'
#' @return
#' A [tibble][tibble::tbl_df] containing country names and their corresponding
#' highest available administrative level.
#'
#' @export
#'
#' @examplesIf httr2::is_online()
#'
#' all <- gb_get_max_adm_lvl()
#' library(dplyr)
#'
#' # Countries with only 1 level available
#' all |>
#'   filter(maxBoundaryType == 1)
#'
#' # Countries with level 4 available
#' all |>
#'   filter(maxBoundaryType == 4)
#'
gb_get_max_adm_lvl <- function(
  country = "all",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative")
) {
  release_type <- match.arg(release_type)
  country <- rgbnd_dev_country2iso(country)
  df <- gb_get_metadata(
    country = country,
    adm_lvl = "all",
    release_type = release_type
  )
  df$rank <- as.integer(as.factor(df$boundaryType))
  res <- tapply(df$rank, df$boundaryISO, max)
  tib <- dplyr::tibble(boundaryISO = names(res), maxBoundaryType = res - 1)
  tib$maxBoundaryType <- as.integer(tib$maxBoundaryType)
  tib
}
