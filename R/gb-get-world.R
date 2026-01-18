#' Retrieve global composite data (CGAZ) from geoBoundaries
#'
#' @description
#' [Attribution](https://www.geoboundaries.org/index.html#usage) is required
#' for all uses of this dataset.
#'
#' This function returns a global composite for the requested administrative
#' level, clipped to international boundaries, with gaps filled between
#' adjacent borders.
#'
#' @family API functions
#'
#' @inheritParams gb_get
#' @encoding UTF-8
#' @inherit gb_get
#'
#' @param adm_lvl Type of boundary. Accepted values are administrative
#'   levels 0, 1, and 2. `"adm0"` corresponds to national boundaries,
#'   `"adm1"` to first‑level subnational boundaries, and `"adm2"` to
#'   second‑level boundaries. Uppercase variants (e.g., `"ADM1"`) and
#'   numeric values (`0`, `1`, `2`) are also accepted.
#'
#' @export
#'
#' @details
#' Comprehensive Global Administrative Zones (CGAZ) is a set of global
#' composite administrative boundary products. There are two key differences
#' between these global composites and individual country downloads:
#'
#' - Boundaries undergo extensive simplification to ensure file sizes remain
#'   manageable for typical desktop software.
#' - Disputed areas are removed and replaced with polygons defined according
#'   to U.S. Department of State guidelines.
#'
#' @examplesIf httr2::is_online()
#'
#' # This download may take some time
#' \dontrun{
#' world <- gb_get_world()
#'
#' library(ggplot2)
#'
#' ggplot(world) +
#'   geom_sf() +
#'   coord_sf(expand = FALSE) +
#'   labs(caption = "Source: www.geoboundaries.org")
#' }
#'
gb_get_world <- function(
  country = "all",
  adm_lvl = "adm0",
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
) {
  adm_lvl <- assert_adm_lvl(adm_lvl, dict = c(paste0("adm", 0:2), 0:2))
  country <- rgbnd_dev_country2iso(country)

  # Get from repo
  baseurl <- paste0(
    "https://github.com/wmgeolab/geoBoundaries/",
    "raw/main/releaseData"
  )

  fname <- paste0("geoBoundariesCGAZ_", adm_lvl, ".zip")

  urlend <- paste(baseurl, "CGAZ", fname, sep = "/")

  world <- rgbnd_dev_shp_query(
    urlend,
    subdir = "CGAZ",
    path = path,
    overwrite = overwrite,
    quiet = quiet,
    cgaz_country = country,
    simplified = FALSE
  )

  tokeep <- setdiff(names(world), "id")

  world <- world[, tokeep]

  world
}
