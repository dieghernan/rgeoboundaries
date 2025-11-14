test_that("Single country", {
  skip_on_cran()
  skip_if_offline()

  expect_snapshot(db_old <- gb_metadata(country = "Spain", adm_lvl = 1))
  db_new <- gb_get_metadata(country = "Spain", adm_lvl = 1)
  expect_identical(db_old, db_new)
})

test_that("All countries, NULL is ALL", {
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
