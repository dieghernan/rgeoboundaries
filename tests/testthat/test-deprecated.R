test_that("gb_metadata: Single country", {
  skip_on_cran()
  skip_if_offline()

  expect_snapshot(db_old <- gb_metadata(country = "Spain", adm_lvl = 1))
  db_new <- gb_get_metadata(country = "Spain", adm_lvl = 1)
  expect_identical(db_old, db_new)
})

test_that("gb_metadata: All countries, NULL is ALL", {
  skip_on_cran()
  skip_if_offline()

  # All for specific release type
  expect_snapshot(
    db_old <- gb_metadata(adm_lvl = 1, release_type = "gbHumanitarian")
  )
  db_new <- gb_get_metadata(
    country = "ALL",
    adm_lvl = 1,
    release_type = "gbHumanitarian"
  )
  expect_identical(db_old, db_new)
})

test_that("gb_max_adm_lvl: Single country", {
  skip_on_cran()
  skip_if_offline()

  expect_snapshot(db_old <- gb_max_adm_lvl(country = "Spain"))
  db_new <- gb_get_max_adm_lvl(country = "Spain")
  expect_identical(db_old, db_new)
})

test_that("gb_max_adm_lvl: All countries, NULL is ALL", {
  skip_on_cran()
  skip_if_offline()

  # All for specific release type
  expect_snapshot(
    db_old <- gb_max_adm_lvl(release_type = "gbHumanitarian")
  )
  db_new <- gb_get_max_adm_lvl(
    country = "ALL",
    release_type = "gbHumanitarian"
  )
  expect_identical(db_old, db_new)
})

test_that("geoboundaries: Single country", {
  skip_on_cran()
  skip_if_offline()
  expect_snapshot(this <- geoboundaries("andorra"))

  this2 <- gb_get("andorra")
  expect_identical(this, this2)

  # Redirect
  expect_snapshot(this3 <- geoboundaries("andorra", type = "SSCGS"))
  expect_identical(this, this3)

  # Simplified
  expect_warning(thissimp <- geoboundaries("andorra", type = "simplified"))

  expect_lt(object.size(thissimp), object.size(this))

  # Test levels
  expect_warning(this_lvl1 <- geoboundaries("andorra", adm_lvl = 1))
  this_lvl2 <- gb_get("andorra", adm_lvl = 1)
  expect_identical(this_lvl1, this_lvl2)
})

test_that("geoboundaries: cgaz", {
  skip_on_cran()
  skip_if_offline()
  expect_snapshot(this <- geoboundaries())

  this2 <- gb_get_world()
  expect_identical(this[1:10, ], this2[1:10, ])
  expect_gt(nrow(this), 190)

  # Warn with message
  expect_snapshot(this3 <- geoboundaries("andorra", type = "CGAZ"))
  expect_identical(this[1, ], this3[1, ])
})

test_that("gb_adm: single country", {
  skip_on_cran()
  skip_if_offline()
  skip_on_cran()
  skip_if_offline()

  library(dplyr)

  # Get country with all levels
  db <- gb_get_metadata(country = "ALL", adm_lvl = "ALL")

  cnt <- db %>%
    group_by(boundaryISO) %>%
    mutate(n = n()) %>%
    # Countries with all levels
    filter(n == 6) %>%
    ungroup() %>%
    filter(boundaryType == "ADM5") %>%
    mutate(total = admUnitCount * meanVertices) %>%
    # Minimum vertices
    slice_min(order_by = total, n = 1) %>%
    pull(boundaryISO)

  # Check 0
  expect_snapshot(a <- gb_adm0(cnt, type = "simplified"))
  b <- gb_get_adm0(cnt, simplified = TRUE)
  expect_identical(a, b)

  # Check 1
  expect_snapshot(a <- gb_adm1(cnt, type = "simplified"))
  b <- gb_get_adm1(cnt, simplified = TRUE)
  expect_identical(a, b)

  # Check 2
  expect_snapshot(a <- gb_adm2(cnt, type = "simplified"))
  b <- gb_get_adm2(cnt, simplified = TRUE)
  expect_identical(a, b)

  # Check 3
  expect_snapshot(a <- gb_adm3(cnt, type = "simplified"))
  b <- gb_get_adm3(cnt, simplified = TRUE)
  expect_identical(a, b)

  # Check 4
  expect_snapshot(a <- gb_adm4(cnt, type = "simplified"))
  b <- gb_get_adm4(cnt, simplified = TRUE)
  expect_identical(a, b)

  # Check 5
  expect_snapshot(a <- gb_adm5(cnt, type = "simplified"))
  b <- gb_get_adm5(cnt, simplified = TRUE)
  expect_identical(a, b)
})


test_that("gb_adm: cgaz", {
  skip_on_cran()
  skip_if_offline()
  expect_snapshot(this <- gb_adm0())

  this2 <- gb_get_world()
  expect_identical(this[1:10, ], this2[1:10, ])
  expect_gt(nrow(this), 190)

  # Warn with message
  expect_snapshot(this3 <- gb_adm0("andorra", type = "CGAZ"))
  expect_identical(this[1, ], this3[1, ])

  # Error
  expect_snapshot(gb_adm3(), error = TRUE)
})
