test_that("Test cache online", {
  # Set a temp cache dir
  tmp <- tempdir()
  gb_set_cache(tmp)
  testdir <- expect_silent(gb_set_cache(
    file.path(tmp, "testthat")
  ))

  expect_identical(gb_get_cache(), testdir)
})
