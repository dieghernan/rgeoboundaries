test_that("Check meta", {
  skip_on_cran()
  skip_if_offline()

  adm1 <- gb_get_metadata(adm_lvl = "ADM1")
  expect_s3_class(adm1, "tbl")
  expect_identical(unique(adm1$boundaryType), "ADM1")

  adm5 <- gb_get_metadata(adm_lvl = "ADM5")
  expect_s3_class(adm5, "tbl")
  expect_identical(unique(adm5$boundaryType), "ADM5")

  # Another source
  aa <- gb_get_metadata(release_type = "gbHumanitarian", adm_lvl = "ADM1")
  expect_s3_class(aa, "tbl")

  expect_lt(nrow(aa), nrow(adm1))
})
test_that("Check meta errors", {
  skip_on_cran()
  skip_if_offline()

  expect_snapshot(
    db <- gb_get_metadata(country = "ESP", adm_lvl = "ADM5"),
  )
  expect_s3_class(db, "tbl_df")
  expect_equal(nrow(db), 0)
})
