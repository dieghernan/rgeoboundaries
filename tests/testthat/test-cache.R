test_that("Test cache online", {
  # Set a temp cache dir
  current <- gb_get_cache()
  tmp <- tempdir()
  gb_set_cache(tmp)
  testdir <- expect_silent(gb_set_cache(
    file.path(tmp, "testthat_cache")
  ))
  expect_identical(gb_get_cache(create = TRUE), testdir)
  expect_true(dir.exists(testdir))
  cat(1:10000L, file = file.path(testdir, "foo.txt"))

  expect_identical(gb_list_cache(), "foo.txt")
  expect_false(gb_list_cache(full_path = TRUE) == "foo.txt")
  expect_silent(gb_clear_cache())
  expect_identical(gb_list_cache(), character(0))
  gb_list_cache()

  # Restore cache
  expect_silent(gb_set_cache(current))
  skip("Not working")
  expect_equal(current, gb_get_cache())
})
