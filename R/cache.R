#' Caching geoBoundaries downloaded files
#'
#' Manage cached geoBoundaries downloaded files
#'
#' @name gb_cache
#'
#' @details The default cache directory is
#' `~/.cache/R/gb_cache`, but you can set
#' your own path using `gb_set_cache(path)`
#'
#'
#' @examples \dontrun{
#' gb_cache
#' ## change the default cache directory
#' tmp <- tempdir()
#' gb_set_cache(tmp)
#'
#' ## print current cache directory
#' gb_get_cache()
#'
#' ## List available files in the current cache directory
#' gb_list_cache()
#'
#' l <- gb_list_cache()[1] ## get the first file
#' gb_delete_from_cache(l) ## delete it
#'
#' gb_clear_cache() ## delete all cached files
#' }
NULL


#' Set the cache directory
#'
#' @rdname gb_cache
#'
#' @param path character; path of the directory to set
#'
#' @return the cache directory
#' @export
gb_set_cache <- function(
  path,
  overwrite = FALSE,
  install = FALSE,
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
  path
}

#' Displays the full path to the cache directory
#'
#' @rdname gb_cache
#'
#' @param create logical; if TRUE create missing cache
#'
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


#' Clear all cached files
#'
#' @rdname gb_cache
#'
#' @note This function will clear all cached files
#' @param force logical; force delete. default: `FALSE`
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

#' List of files available in the cache directory
#'
#' @rdname gb_cache
#'
#' @param full_path logical; if TRUE returns the full path of the file
#'
#' @return list of files in the cache
#' @export
gb_list_cache <- function(full_path = FALSE) {
  list.files(gb_get_cache(), full.names = full_path)
}

#' Delete a given file from cache
#'
#' @rdname gb_cache
#'
#' @param file Character, the file to delete
#'
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


#' Creates `cache_dir`
#' Helper function
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
