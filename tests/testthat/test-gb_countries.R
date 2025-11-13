test_that("type of object returned is as expected", {
  p <- gb_adm0(country = "Mali")
  expect_s3_class(p, "sf")
  expect_true(sf::st_geometry_type(p) == "MULTIPOLYGON")
})
