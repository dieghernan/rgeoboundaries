#' \pkg{rgeoboundaries}: cache utilities
#'
#' @description
#' Utilities to manage a local cache directory used by \pkg{rgeoboundaries} for
#' downloaded boundary files. These helpers let you set a cache directory,
#' retrieve the active directory, list cached files and remove cached files or
#' the whole cache.
#'
#' The primary functions are:
#' - `gb_set_cache()`: configure where files will be stored (temporary by
#'    default)
#' - `gb_get_cache()`: get the active cache directory path
#' - `gb_list_cache()`: list files present in the cache
#' - `gb_clear_cache()`: remove all cached files (and optionally the
#'    installed config)
#' - `gb_delete_from_cache()`: remove one or more specific cached files
#'
#' @details
#' By default, when no cache `path` is set the package uses a folder inside
#' [base::tempdir()] (so files are temporary and are removed when the R session
#' ends). To persist a cache across **R** sessions, use
#' `gb_set_cache(path, install = TRUE)` which writes the chosen path to a small
#' configuration file under `tools::R_user_dir("rgeoboundaries", "config")`.
#'
#' @section Caching strategies:
#'
#' - For occasional use, rely on the default [tempdir()]-based cache (no
#'   install).
#' - For reproducible workflows, install a persistent cache with
#'   `gb_set_cache(path, install = TRUE)`.
#'
#' @rdname gb_cache
#' @name gb_cache
#'
#' @param path character. Path to the directory to use as cache. If omitted or
#'   empty, a temporary directory inside [base::tempdir()] is used.
#' @param install logical. If `TRUE`, write the chosen path to the package
#'   configuration directory so it is used in future sessions. Defaults to
#'   `FALSE`. If path is omitted or is the [tempdir()], install is forced to
#'   `FALSE`.
#' @param overwrite logical. If `TRUE` and `install = TRUE`, overwrite any
#'   existing installed cache path. Defaults to `FALSE`.
#' @param quiet logical. If `TRUE` suppresses informational messages. Defaults
#'   to `FALSE`.
#'
#' @return
#' - `gb_set_cache()`: (invisibly) returns the cache directory path (character)
#'    that was set.
#' - `gb_get_cache()`: returns the active cache directory path (character).
#' - `gb_list_cache()`: returns a character vector with cached file names or
#'    full paths depending on the `full_path` argument.
#' - `gb_clear_cache()` and `gb_delete_from_cache()`: Called for their side
#'    effects.
#'
#' @seealso
#' [tools::R_user_dir()], [base::tempdir()]
#'
#' @examples
#'
#' # Caution! This may modify your current state
#'
#' \dontrun{
#' my_cache <- gb_get_cache()
#' # Set an example cache
#' ex <- file.path(tempdir(), "example", "cache")
#' gb_set_cache(ex, quiet = TRUE)
#'
#' newcache <- gb_get_cache()
#' newcache
#'
#' # Write files to path
#' cat(1:10000L, file = file.path(newcache, "a.txt"))
#' cat(1:10000L, file = file.path(newcache, "b.txt"))
#' cat(1:10000L, file = file.path(newcache, "c.txt"))
#'
#' # List cache
#' gb_list_cache()
#'
#' # Delete one file
#' gb_delete_from_cache("a.txt")
#'
#' gb_list_cache()
#'
#' # Delete all
#' gb_clear_cache(quiet = FALSE)
#'
#' gb_list_cache()
#'
#' # Restore initial cache
#' gb_set_cache(my_cache)
#' identical(my_cache, gb_get_cache())
#' }
#'
#' @export
gb_set_cache <- function(
  path,
  install = FALSE,
  overwrite = FALSE,
  quiet = FALSE
) {
  verbose <- isFALSE(quiet)
  # Default if not provided
  if (missing(path) || path == "") {
    if (verbose) {
      cli::cli_alert_info(
        c(
          "Using a temporary cache directory. ",
          "Set {.arg path} to a value for store permanently"
        )
      )
    }
    # Create a folder on tempdir
    path <- file.path(tempdir(), "rgeoboundaries")
    is_temp <- TRUE
    install <- FALSE
  } else {
    is_temp <- FALSE
  }

  # Validate
  stopifnot(is.character(path), is.logical(overwrite), is.logical(install))

  # Expand
  path <- path.expand(path)

  # Create cache dir if it doesn't exists
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }

  if (verbose) {
    cli::cli_alert_success(
      "{.pkg rgeoboundaries} cache directory is {.path {path}}."
    )
  }

  # Install path on environ var.
  # nocov start

  if (install) {
    config_dir <- tools::R_user_dir("rgeoboundaries", "config")
    # Create cache dir if not presente
    if (!dir.exists(config_dir)) {
      dir.create(config_dir, recursive = TRUE)
    }

    rgeoboundaries_file <- file.path(config_dir, "RGEOBOUNDARIES_PATH")

    if (!file.exists(rgeoboundaries_file) || overwrite == TRUE) {
      # Create file if it doesn't exist
      writeLines(path, con = rgeoboundaries_file)
    } else {
      cli::cli_abort(
        paste0(
          "An installed cache directory already exists. ",
          "You can overwrite it with ",
          "the argument {.arg overwrite = TRUE}"
        )
      )
    }
    # nocov end
  } else {
    if (verbose && !is_temp) {
      cli::cli_alert_info(
        paste0(
          "To install your {.arg path} for use in future sessions ",
          "run this function with {.arg install = TRUE}."
        )
      )
    }
  }

  Sys.setenv(RGEOBOUNDARIES_CACHE_DIR = path)
  invisible(path)
}

#' @rdname gb_cache
#' @param create `r lifecycle::badge("deprecated")`.
#' @export
gb_get_cache <- function(create = deprecated()) {
  if (lifecycle::is_present(create)) {
    lifecycle::deprecate_warn(
      when = "2.0.0",
      what = "gb_get_cache(create)"
    )
  }
  # Try from getenv
  getvar <- Sys.getenv("RGEOBOUNDARIES_CACHE_DIR")

  if (is.null(getvar) || is.na(getvar) || getvar == "") {
    # Not set - tries to retrieve from cache
    cache_config <- file.path(
      tools::R_user_dir("rgeoboundaries", "config"),
      "RGEOBOUNDARIES_PATH"
    )

    # nocov start
    if (file.exists(cache_config)) {
      cached_path <- readLines(cache_config)

      # Case on empty cached path - would default
      if (any(is.null(cached_path), is.na(cached_path), cached_path == "")) {
        cache_dir <- gb_set_cache(overwrite = TRUE, quiet = TRUE)
        return(cache_dir)
      }

      # 3. Return from cached path
      Sys.setenv(RGEOBOUNDARIES_CACHE_DIR = cached_path)
      cached_path
      # nocov end
    } else {
      # 4. Default cache location

      cache_dir <- gb_set_cache(overwrite = TRUE, quiet = TRUE)
      cache_dir
    }
  } else {
    getvar
  }
}

#' @rdname gb_cache
#' @param full_path logical, if `TRUE` returns the full path all the cached
#'    files. If `FALSE` just the base names is provided.
#' @export
gb_list_cache <- function(full_path = FALSE) {
  list.files(gb_get_cache(), full.names = full_path)
}


#' @rdname gb_cache
#' @inheritParams base::unlink
#' @param clear_config logical. If `TRUE`, will delete the configuration
#'   folder of \pkg{\pkg{rgeoboundaries}}.
#' @export
gb_clear_cache <- function(force = TRUE, clear_config = FALSE, quiet = FALSE) {
  verbose <- isFALSE(quiet)

  config_dir <- tools::R_user_dir("rgeoboundaries", "config")
  data_dir <- gb_get_cache()

  # nocov start
  if (clear_config && dir.exists(config_dir)) {
    unlink(config_dir, recursive = TRUE, force = force)

    if (verbose) {
      cli::cli_alert_warning("{.pkg rgeoboundaries} installed cache deleted")
    }
    Sys.setenv(RGEOBOUNDARIES_CACHE_DIR = "")
  }
  # nocov end

  if (dir.exists(data_dir)) {
    unlink(data_dir, recursive = TRUE, force = TRUE)
    if (verbose) {
      cli::cli_alert_warning(
        "{.pkg rgeoboundaries} data deleted: {.file {data_dir}}"
      )
    }
  }

  # Reset cache dir
  invisible()
}


#' @rdname gb_cache
#' @param file character. Base name of the cached file to delete.
#' @export
gb_delete_from_cache <- function(file) {
  path <- gb_get_cache()

  l2 <- list.files(
    path = path,
    pattern = paste0(file, "$"),
    recursive = TRUE,
    full.names = TRUE
  )

  if (length(l2) == 0) {
    cli::cli_alert_info(
      "File {.file {file}} not found in cache directory {.path {path}}."
    )
    return(invisible())
  }

  unlink(l2, force = TRUE)
  cli::cli_alert_success(
    "File {.file {l2}} deleted."
  )
  invisible()
}


#' Creates `path`
#'
#' Helper function, only use for development of \pkg{rgeoboundaries}
#'
#' @noRd
rgbnd_dev_cachedir <- function(path = NULL) {
  # Check cache dir from options if not set
  if (is.null(path)) {
    path <- gb_get_cache()
  }

  # Create cache dir if needed
  if (isFALSE(dir.exists(path))) {
    dir.create(path, recursive = TRUE)
  }
  path
}
