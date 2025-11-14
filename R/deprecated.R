#' Deprecated and renamed functions in \pkg{rgeoboundaries} 2.0.0
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' \pkg{rgeoboundaries} 2.0.0 renamed a number of functions to ensure that
#' every function has a `object_verb()` naming scheme and avoiding magical
#' defaults.
#'
#' * `gb_metadata()` -> [gb_get_metadata()]
#' * `gb_max_adm_lvl()` -> [gb_get_max_adm_lvl()]
#'
#' These functions are likely to be removed in the future.
#'
#' @rdname deprecated
#' @name deprecated
#' @keywords internal
#' @family deprecated
#' @inheritParams gb_get_metadata
#' @export
#'
#' @returns
#' These functions are re-directed to their replacement, providing the same
#' output.
#'
#' @references
#'
#' rOpenSci, Anderson B, Chamberlain S, DeCicco L, Gustavsen J, Krystalli A,
#' Lepore M, Mullen L, Ram K, Ross N, Salmon M, Vidoni M, Riederer E, Sparks A,
#' Hollister J (2024).
#' *rOpenSci Packages: Development, Maintenance, and Peer Review*.
#' <doi:10.5281/zenodo.10797633>.
#'
#' The tidyverse team. *The Tidyverse Style Guide*,
#' <https://style.tidyverse.org/>. Accessed 14 Nov. 2025.
#'
#' Wickham, Hadley. “Tidy Design Principles.” *Tidyverse.org*, 2025,
#' <https://design.tidyverse.org/>. Accessed 14 Nov. 2025.
#'
#' @examplesIf httr2::is_online()
#' # Show deprecation messages
#' gb_metadata()
gb_metadata <- function(
  country = NULL,
  adm_lvl = "all",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative")
) {
  lifecycle::deprecate_warn("2.0.0", "gb_metadata()", "gb_get_metadata()")
  if (is.null(country)) {
    country <- "all"
  }
  gb_get_metadata(
    country = country,
    adm_lvl = adm_lvl,
    release_type = release_type
  )
}

#' @rdname deprecated
#' @export
gb_max_adm_lvl <- function(
  country = NULL,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative")
) {
  lifecycle::deprecate_warn("2.0.0", "gb_max_adm_lvl()", "gb_get_max_adm_lvl()")
  if (is.null(country)) {
    country <- "all"
  }
  gb_get_max_adm_lvl(country = country, release_type = release_type)
}
