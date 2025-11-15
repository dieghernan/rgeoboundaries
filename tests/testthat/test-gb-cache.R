test_that("Test cache", {
  # Get current cache dir
  expect_silent(current <- gb_get_cache())

  # Set a temp cache dir
  expect_message(gb_set_cache(quiet = FALSE))
  testdir <- expect_silent(gb_set_cache(
    file.path(current, "testthat"),
    quiet = TRUE
  ))

  expect_identical(gb_get_cache(), testdir)

  # Clean
  expect_silent(gb_clear_cache(clear_config = FALSE, quiet = TRUE))
  # Cache dir should be deleted now
  expect_false(dir.exists(testdir))

  # Reset just for testing all cases
  testdir <- file.path(tempdir(), "geobounds", "testthat")
  expect_message(gb_set_cache(testdir))

  expect_true(dir.exists(testdir))

  expect_message(gb_clear_cache(clear_config = FALSE, quiet = FALSE))

  # Cache dir should be deleted now
  expect_false(dir.exists(testdir))

  # Restore cache
  expect_message(gb_set_cache(current, quiet = FALSE))
  expect_silent(gb_set_cache(current, quiet = TRUE))
  expect_equal(current, Sys.getenv("RGEOBOUNDARIES_CACHE_DIR"))
  expect_true(dir.exists(current))
})

test_that("Delete cache", {
  expect_silent(current <- gb_get_cache())

  # Set a temp cache dir

  testdir <- expect_silent(gb_set_cache(
    file.path(current, "testthat_test_delete"),
    quiet = TRUE
  ))

  expect_identical(gb_get_cache(), testdir)

  # Write files to path
  cat(1:10000L, file = file.path(testdir, "a.txt"))
  cat(1:10000L, file = file.path(testdir, "b.txt"))
  cat(1:10000L, file = file.path(testdir, "c.txt"))

  expect_identical(gb_list_cache(), c("a.txt", "b.txt", "c.txt"))

  allf <- gb_list_cache()
  expect_message(gb_delete_from_cache(allf), regexp = "deleted.")

  expect_message(
    gb_delete_from_cache("notinpath"),
    "not found in cache directory"
  )

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

test_that("Deprecations", {
  expect_snapshot(p <- gb_get_cache(create = TRUE))
})

test_that("Downloaded data are cached", {
  skip_on_cran()
  skip_if_offline()

  expect_silent(current <- gb_get_cache())

  # Set a temp cache dir

  testdir <- expect_silent(gb_set_cache(
    file.path(tempdir(), "download_test"),
    quiet = TRUE
  ))

  expect_identical(gb_list_cache(full_path = TRUE), character(0))
  gb_clear_cache()
  expect_length(gb_list_cache(), 0)
  p <- gb_get(country = "Andorra")
  expect_length(gb_list_cache(), 1)

  # Clear cache and restore
  expect_message(gb_clear_cache(clear_config = FALSE, quiet = FALSE))

  # Cache dir should be deleted now
  expect_false(dir.exists(testdir))

  # Restore cache
  expect_message(gb_set_cache(current, quiet = FALSE))
  expect_silent(gb_set_cache(current, quiet = TRUE))
  expect_equal(current, Sys.getenv("RGEOBOUNDARIES_CACHE_DIR"))
  expect_equal(current, gb_get_cache())
  expect_true(dir.exists(current))
})
