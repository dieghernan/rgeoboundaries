test_that("type of object returned is as expected", {
  library(sf)
  p <- gb_adm0(country = "Mali")
  expect_s3_class(p, "sf")
  expect_true(st_geometry_type(p) %in% c("MULTIPOLYGON", "POLYGON"))
})

test_that("simplified boundaries take less size on memory", {
  p1 <- gb_adm0(country = "Cabo Verde", type = "unsimplified")
  p2 <- gb_adm0(country = "Cabo Verde", type = "simplified")

  expect_gt(object.size(p1), object.size(p2))
})

test_that("Downloaded data are cached", {
  expect_silent(current <- gb_get_cache())

  # Set a temp cache dir

  testdir <- expect_silent(gb_set_cache(
    file.path(tempdir(), "download_test"),
    quiet = TRUE
  ))

  gb_list_cache(full_path = TRUE)
  gb_clear_cache()
  expect_equal(length(gb_list_cache()), 0)
  p <- gb_adm0(country = "Mali")
  expect_gte(length(gb_list_cache()), 1)

  # Clear cache and restore
  expect_message(gb_clear_cache(clear_config = FALSE, quiet = FALSE))

  # Cache dir should be deleted now
  expect_false(dir.exists(testdir))

  # Restore cache
  expect_message(gb_set_cache(current, quiet = FALSE))
  expect_silent(gb_set_cache(current, quiet = TRUE))
  expect_equal(current, Sys.getenv("RGEOBOUNDARIES_CACHE_DIR"))
  expect_true(dir.exists(current))
})

test_that("ISO3 also works!", {
  p1 <- gb_adm0(country = "algeria")
  p2 <- gb_adm0(country = "dza")
  expect_equal(p1, p2)
})

test_that("adm_lvl can be any of the characters '0', ..., '5'", {
  p1 <- geoboundaries("benin", adm_lvl = "1")
  p2 <- geoboundaries("benin", adm_lvl = "adm1")
  expect_equal(p1, p2)
})

test_that("adm_lvl can be an integer between 0 and 5", {
  p1 <- geoboundaries("benin", adm_lvl = 0)
  p2 <- geoboundaries("benin", adm_lvl = "adm0")
  expect_equal(p1, p2)
})
