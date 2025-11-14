assert_adm_lvl <- function(
  adm_lvl,
  dict = c(paste0("adm", seq_len(5)), seq_len(5))
) {
  if (length(adm_lvl) > 1) {
    cli::cli_abort(
      "You can't mix different {.arg adm_lvl}. You entered {.val {adm_lvl}}."
    )
  }
  adm_lvl_clean <- tolower(as.character(adm_lvl))
  if (!adm_lvl_clean %in% dict) {
    cli::cli_abort(
      c(
        "Not a valid {.arg adm_lvl} level code ({.val {adm_lvl_clean}}).",
        "Accepted values are {.val {dict}}."
      )
    )
  }

  # Check if number and return correct adm_lvl format
  if (is.numeric(adm_lvl)) {
    adm_lvl <- paste0("ADM", adm_lvl)
  }
  toupper(adm_lvl)
}

#' Helper function to convert country names to codes
#'
#' Convert country codes
#'
#' @param names vector of names or codes
#'
#' @param out out code
#'
#' @return a vector of names
#'
#' @noRd
rgbnd_dev_country2iso <- function(names, out = "iso3c") {
  names[tolower(names) == "antartica"] <- "Antarctica"
  out <- "iso3c"
  if (any(tolower(names) == "all")) {
    return("ALL")
  }

  # Vectorize
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
        "Invalid country names. Try a vector of names or  ISO3 codes"
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
    cli::cli_alert_warning("Some values were not matched unambiguously: {ff}")
    cli::cli_alert_info("Review the names or switch to ISO3 codes.")
  }

  outnames2
}
