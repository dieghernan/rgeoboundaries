test_that("type of object returned is as expected", {
  library(sf)
  p <- gb_adm0(country = "Mali")
  expect_s3_class(p, "sf")
  expect_true(st_geometry_type(p) %in% c("MULTIPOLYGON", "POLYGON"))
})
