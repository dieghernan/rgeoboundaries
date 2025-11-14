test_that("Convert country codes", {
  esp <- country_to_iso3("Spain")
  expect_identical(esp, "ESP")
  expect_identical(country_to_iso3("kosovo"), "XKX")
  country_to_iso3(c("Spain", "Kosovo"))
  expect_snapshot(country_to_iso3(c("Spain", "Kosovo", "Murcia")), error = TRUE)
})

test_that("Assert admin levels", {
  expect_snapshot(
    assert_adm_lvl(1:2),
    error = TRUE
  )

  expect_snapshot(
    assert_adm_lvl(adm_lvl = 10),
    error = TRUE
  )
})


test_that("gb_max_lvl", {
  md <- gb_max_adm_lvl(country = "Andorra")
  expect_identical(md, c("Andorra" = 1L))

  md_aus <- gb_max_adm_lvl(country = "Austria")

  expect_identical(md_aus, c("Austria" = 4L))
})
