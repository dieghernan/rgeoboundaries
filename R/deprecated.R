#' Deprecated and renamed functions in \CRANpkg{rgeoboundaries}
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' Version 2.0.0 of \CRANpkg{rgeoboundaries} renamed a number of functions to
#' ensure that all exported functions follow an `object_verb()` naming scheme
#' and to avoid magical defaults.
#'
#' The following changes were introduced:
#'
#' - `geoboundaries()` → [gb_get()] and [gb_get_world()].
#' - The `gb_adm` family → the [`gb_get_adm`][gb_get_adm] family.
#' - `gb_metadata()` → [gb_get_metadata()].
#' - `gb_max_adm_lvl()` → [gb_get_max_adm_lvl()].
#'
#' These deprecated functions will be removed in a future release.
#'
#' @name deprecated
#' @rdname deprecated
#' @keywords internal
#' @family deprecated
#' @inheritParams gb_get
#' @encoding UTF-8
#'
#' @param type Character. One of `"simplified"` or `"unsimplified"`. Any other
#'   value is treated as `"unsimplified"`.
#' @param version Deprecated argument.
#' @export
#'
#' @returns
#' The call is forwarded to the corresponding replacement function and returns
#' the same output.
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
#' Wickham, Hadley. "Tidy Design Principles." *Tidyverse.org*, 2025,
#' <https://design.tidyverse.org/>. Accessed 14 Nov. 2025.
#'
#' @examplesIf httr2::is_online()
#' # Show deprecation messages
#' gb_metadata()
geoboundaries <- function(
  country = NULL,
  adm_lvl = "adm0",
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
) {
  lifecycle::deprecate_warn(
    "2.0.0",
    "geoboundaries()",
    details = "Please use `gb_get()` or `gb_get_world()` instead."
  )
  type <- tolower(type)

  simplified <- grepl("^simplified$", type, ignore.case = TRUE)

  if (type == "cgaz" && !is.null(country)) {
    cli::cli_alert_warning(
      c(
        "{.arg type = \"cgaz\"} not needed. ",
        "Just use {.fun rgeoboundaries::gb_get} or ",
        "{.fun rgeoboundaries::gb_get_adm} without {.arg country}."
      )
    )
    country <- NULL
  }

  release_type <- match.arg(release_type)

  if (is.null(country)) {
    cli::cli_alert_info("Redirecting to {.fun rgeoboundaries::gb_get_world}.")
    res <- gb_get_world(
      country = "all",
      adm_lvl = adm_lvl,
      quiet = quiet,
      overwrite = overwrite
    )
  } else {
    res <- gb_get(
      country = country,
      adm_lvl = adm_lvl,
      simplified = simplified,
      quiet = quiet,
      overwrite = overwrite
    )
  }

  res
}

#' @rdname deprecated
#' @aliases gb_adm
#' @export
gb_adm0 <- function(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
) {
  lifecycle::deprecate_warn(
    "2.0.0",
    "geoboundaries()",
    details = "Please use `gb_get_adm0()` or `gb_get_world()` instead."
  )

  geoboundaries(
    country = country,
    adm_lvl = 0,
    type = type,
    release_type = release_type,
    quiet = quiet,
    overwrite = overwrite,
    version = version
  )
}
#' @rdname deprecated
#' @export
gb_adm1 <- function(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
) {
  lifecycle::deprecate_warn(
    "2.0.0",
    "geoboundaries()",
    details = "Please use `gb_get_adm1()` or `gb_get_world()` instead."
  )

  geoboundaries(
    country = country,
    adm_lvl = 1,
    type = type,
    release_type = release_type,
    quiet = quiet,
    overwrite = overwrite,
    version = version
  )
}

#' @rdname deprecated
#' @export
gb_adm2 <- function(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
) {
  lifecycle::deprecate_warn(
    "2.0.0",
    "geoboundaries()",
    details = "Please use `gb_get_adm2()` or `gb_get_world()` instead."
  )

  geoboundaries(
    country = country,
    adm_lvl = 2,
    type = type,
    release_type = release_type,
    quiet = quiet,
    overwrite = overwrite,
    version = version
  )
}

#' @rdname deprecated
#' @export
gb_adm3 <- function(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
) {
  lifecycle::deprecate_warn(
    "2.0.0",
    "geoboundaries()",
    details = "Please use `gb_get_adm3()` or `gb_get_world()` instead."
  )

  geoboundaries(
    country = country,
    adm_lvl = 3,
    type = type,
    release_type = release_type,
    quiet = quiet,
    overwrite = overwrite,
    version = version
  )
}

#' @rdname deprecated
#' @export
gb_adm4 <- function(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
) {
  lifecycle::deprecate_warn(
    "2.0.0",
    "geoboundaries()",
    details = "Please use `gb_get_adm4()` or `gb_get_world()` instead."
  )

  geoboundaries(
    country = country,
    adm_lvl = 4,
    type = type,
    release_type = release_type,
    quiet = quiet,
    overwrite = overwrite,
    version = version
  )
}
#' @rdname deprecated
#' @export
gb_adm5 <- function(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
) {
  lifecycle::deprecate_warn(
    "2.0.0",
    "geoboundaries()",
    details = "Please use `gb_get_adm5()` or `gb_get_world()` instead."
  )

  geoboundaries(
    country = country,
    adm_lvl = 5,
    type = type,
    release_type = release_type,
    quiet = quiet,
    overwrite = overwrite,
    version = version
  )
}
#' @rdname deprecated
#' @export
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
