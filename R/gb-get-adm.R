#' Retrieve geoBoundaries country files for a specified administrative level
#'
#' @description
#' [Attribution](https://www.geoboundaries.org/index.html#usage) is required
#' for all uses of this dataset.
#'
#' These functions are convenience wrappers around [gb_get()] for retrieving
#' boundaries at different administrative levels:
#'
#' - `gb_get_adm0()` returns national boundaries.
#' - `gb_get_adm1()` returns first‑level administrative boundaries
#'   (e.g., states in the United States).
#' - `gb_get_adm2()` returns second‑level administrative boundaries
#'   (e.g., counties in the United States).
#' - `gb_get_adm3()` returns third‑level administrative boundaries
#'   (e.g., towns or cities in some countries).
#' - `gb_get_adm4()` returns fourth‑level administrative boundaries.
#' - `gb_get_adm5()` returns fifth‑level administrative boundaries.
#'
#' Note that administrative hierarchies vary by country. Use
#' [gb_get_max_adm_lvl] to check the maximum available level.
#'
#' @rdname gb_get_adm
#' @name gb_get_adm
#'
#' @family API functions
#' @encoding UTF-8
#'
#' @inheritParams gb_get
#' @inherit gb_get
#'
#' @seealso [gb_get_max_adm_lvl()].
#'
#' @export
#'
#' @details
#' Individual boundary files in the geoBoundaries database are governed by the
#' license or licenses specified in their associated metadata (see
#' [gb_get_metadata()]). Users working with individual boundary files should
#' ensure that they comply with these licenses and cite the original data
#' sources listed in the metadata. See **Examples**.
#'
#' @examplesIf httr2::is_online()
#'
#' \donttest{
#' lev2 <- gb_get_adm2(
#'   c("Italia", "Suiza", "Austria"),
#'   simplified = TRUE
#' )
#'
#'
#' library(ggplot2)
#'
#' ggplot(lev2) +
#'   geom_sf(aes(fill = shapeGroup)) +
#'   labs(
#'     title = "Second-level administration",
#'     subtitle = "Selected countries",
#'     caption = "Source: www.geoboundaries.org"
#'   )
#' }
#'
gb_get_adm0 <- function(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
) {
  gb_get(
    country = country,
    release_type = release_type,
    adm_lvl = "ADM0",
    simplified = simplified,
    quiet = quiet,
    overwrite = overwrite,
    path = path
  )
}

#' @rdname gb_get_adm
#' @export
gb_get_adm1 <- function(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
) {
  gb_get(
    country = country,
    release_type = release_type,
    adm_lvl = "ADM1",
    simplified = simplified,
    quiet = quiet,
    overwrite = overwrite,
    path = path
  )
}

#' @rdname gb_get_adm
#' @export
gb_get_adm2 <- function(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
) {
  gb_get(
    country = country,
    release_type = release_type,
    adm_lvl = "ADM2",
    simplified = simplified,
    quiet = quiet,
    overwrite = overwrite,
    path = path
  )
}

#' @rdname gb_get_adm
#' @export
gb_get_adm3 <- function(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
) {
  gb_get(
    country = country,
    release_type = release_type,
    adm_lvl = "ADM3",
    simplified = simplified,
    quiet = quiet,
    overwrite = overwrite,
    path = path
  )
}

#' @rdname gb_get_adm
#' @export
gb_get_adm4 <- function(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
) {
  gb_get(
    country = country,
    release_type = release_type,
    adm_lvl = "ADM4",
    simplified = simplified,
    quiet = quiet,
    overwrite = overwrite,
    path = path
  )
}

#' @rdname gb_get_adm
#' @export
gb_get_adm5 <- function(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
) {
  gb_get(
    country = country,
    release_type = release_type,
    adm_lvl = "ADM5",
    simplified = simplified,
    quiet = quiet,
    overwrite = overwrite,
    path = path
  )
}
