test_that("Assert admin levels", {
  expect_snapshot(
    assert_adm_lvl(1:2),
    error = TRUE
  )

  expect_snapshot(
    assert_adm_lvl(adm_lvl = 10),
    error = TRUE
  )

  expect_identical(
    assert_adm_lvl(1),
    "ADM1"
  )

  expect_identical(
    assert_adm_lvl("adm5"),
    "ADM5"
  )

  expect_identical(
    assert_adm_lvl("all", dict = "all"),
    "ALL"
  )

  # Ignore case, this feature is not documented
  expect_identical(
    assert_adm_lvl("ADM5"),
    "ADM5"
  )
  expect_identical(
    assert_adm_lvl("ALL", dict = "all"),
    "ALL"
  )

  # Test integers
  vec_integers <- vapply(0:5, assert_adm_lvl, FUN.VALUE = character(1))
  expect_identical(
    vec_integers,
    paste0("ADM", 0:5)
  )
})

test_that("Utils names", {
  skip_on_cran()

  expect_snapshot(rgbnd_dev_country2iso(c("Espagne", "United Kingdom")))
  expect_error(rgbnd_dev_country2iso("UA"))
  expect_snapshot(rgbnd_dev_country2iso(
    c("ESP", "POR", "RTA", "USA")
  ))
  expect_snapshot(rgbnd_dev_country2iso(c("ESP", "Alemania")))
})

test_that("Problematic names", {
  expect_snapshot(rgbnd_dev_country2iso(c("Espagne", "Antartica")))
  expect_snapshot(rgbnd_dev_country2iso(c("spain", "antartica")))

  # Special case for Kosovo
  expect_snapshot(rgbnd_dev_country2iso(c("Spain", "Kosovo", "Antartica")))
  expect_snapshot(rgbnd_dev_country2iso(c("ESP", "XKX", "DEU")))
  expect_snapshot(
    rgbnd_dev_country2iso(c("Spain", "Rea", "Kosovo", "Antartica", "Murcua"))
  )

  expect_snapshot(
    rgbnd_dev_country2iso("Kosovo")
  )
  expect_snapshot(
    rgbnd_dev_country2iso("XKX")
  )
  full <- rgbnd_dev_country2iso(c("Antarctica", "Kosovo"))
  expect_identical(full, c("ATA", "XKX"))
})

test_that("Test full name conversion", {
  skip_on_cran()
  skip_if_offline()
  aa <- rgbnd_dev_country2iso(c("all", "ESP"))
  bb <- rgbnd_dev_country2iso(c("ALL", "Italy"))
  expect_identical(aa, "ALL")
  expect_identical(aa, bb)
  allnames <- gb_get_metadata(adm_lvl = "ADM0")
  nm <- unique(allnames$boundaryName)
  expect_silent(nm2 <- rgbnd_dev_country2iso(nm))
  isos <- unique(allnames$boundaryISO)
  expect_silent(isos2 <- rgbnd_dev_country2iso(isos))
  expect_identical(length(nm), length(isos2))
  expect_identical(length(nm), length(nm2))
})

test_that("Test mixed countries", {
  expect_silent(cnt <- rgbnd_dev_country2iso(c("Germany", "USA")))
  expect_identical(cnt, c("DEU", "USA"))
})
