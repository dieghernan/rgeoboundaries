# [rgeoboundaries](https://CRAN.R-project.org/package=rgeoboundaries) cache utilities

Utilities to manage the local cache directory used by
[rgeoboundaries](https://CRAN.R-project.org/package=rgeoboundaries) to
store downloaded boundary files. These helpers allow you to set a cache
directory, retrieve the active directory, list cached files, and remove
cached files or the entire cache.

The main functions are:

- `gb_set_cache()`: Configure where cached files are stored (temporary
  by default).

- `gb_get_cache()`: Retrieve the active cache directory path.

- `gb_list_cache()`: List files currently stored in the cache.

- `gb_clear_cache()`: Remove all cached files (and optionally the
  installed cache configuration).

- `gb_delete_from_cache()`: Remove one or more specific cached files.

## Usage

``` r
gb_set_cache(path, install = FALSE, overwrite = FALSE, quiet = FALSE)

gb_get_cache(create = deprecated())

gb_list_cache(full_path = FALSE)

gb_clear_cache(force = TRUE, clear_config = FALSE, quiet = FALSE)

gb_delete_from_cache(file)
```

## Arguments

- path:

  character. Path to the directory to use as the cache. If omitted or
  empty, a temporary directory inside
  [`base::tempdir()`](https://rdrr.io/r/base/tempfile.html) is used.

- install:

  logical. If `TRUE`, write the selected path to the package
  configuration directory so it is reused in future sessions. Defaults
  to `FALSE`. If `path` is omitted or refers to
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html), `install` is
  forced to `FALSE`.

- overwrite:

  logical. If `TRUE` and `install = TRUE`, overwrite any existing
  installed cache path. Defaults to `FALSE`.

- quiet:

  logical. If `TRUE`, suppress informational messages.

- create:

  **\[deprecated\]**.

- full_path:

  logical. If `TRUE`, return full file paths to cached files. If
  `FALSE`, return paths relative to the cache directory.

- force:

  logical. Should permissions be changed (if possible) to allow the file
  or directory to be removed?

- clear_config:

  logical. If `TRUE`, also delete the installed cache configuration
  directory of
  [rgeoboundaries](https://CRAN.R-project.org/package=rgeoboundaries).

- file:

  character. Base name of the cached file to delete.

## Value

- `gb_set_cache()`: Invisibly returns the cache directory path
  (character) that was set.

- `gb_get_cache()`: Returns the active cache directory path (character).

- `gb_list_cache()`: Returns a character vector of cached file names or
  full paths, depending on the `full_path` argument.

- `gb_clear_cache()` and `gb_delete_from_cache()`: Called for their side
  effects.

## Details

By default, when no cache `path` is set, the package uses a directory
inside [`base::tempdir()`](https://rdrr.io/r/base/tempfile.html). Files
stored there are temporary and are removed when the **R** session ends.

To persist a cache across **R** sessions, use
`gb_set_cache(path, install = TRUE)`. This writes the selected path to a
small configuration file under
`tools::R_user_dir("rgeoboundaries", "config")`, which is read
automatically in future sessions.

## Caching strategies

- For occasional use, rely on the default
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html)-based cache (no
  installation required).

- To change the cache location for a single session, use
  `gb_set_cache(path)`.

- For reproducible workflows, install a persistent cache with
  `gb_set_cache(path, install = TRUE)`, which is reused across **R**
  sessions.

- To cache files in a custom location on a per-call basis, use the
  `path` argument of the corresponding function (see
  [`gb_get()`](gb_get.md)).

## See also

[`tools::R_user_dir()`](https://rdrr.io/r/tools/userdir.html),
[`base::tempdir()`](https://rdrr.io/r/base/tempfile.html)

## Examples

``` r
# Caution: this example may modify your current cache state

# \dontrun{
my_cache <- gb_get_cache()

# Set an example cache directory
ex <- file.path(tempdir(), "example", "cache")
gb_set_cache(ex, quiet = TRUE)

newcache <- gb_get_cache()
newcache
#> [1] "C:\\Users\\RUNNER~1\\AppData\\Local\\Temp\\RtmpiujuNa/example/cache"

# Write example files to the cache
cat(1:10000L, file = file.path(newcache, "a.txt"))
cat(1:10000L, file = file.path(newcache, "b.txt"))
cat(1:10000L, file = file.path(newcache, "c.txt"))

# List cached files
gb_list_cache()
#> [1] "a.txt" "b.txt" "c.txt"

# Delete one file
gb_delete_from_cache("a.txt")
#> ✔ File C:\Users\RUNNER~1\AppData\Local\Temp\RtmpiujuNa/example/cache/a.txt deleted.
gb_list_cache()
#> [1] "b.txt" "c.txt"

# Delete all cached files
gb_clear_cache(quiet = FALSE)
#> ! rgeoboundaries cache data deleted: C:\Users\RUNNER~1\AppData\Local\Temp\RtmpiujuNa/example/cache
gb_list_cache()
#> character(0)

# Restore the initial cache
gb_set_cache(my_cache)
#> ✔ rgeoboundaries cache directory set to C:\Users\RUNNER~1\AppData\Local\Temp\RtmpiujuNa/rgeoboundaries.
#> ℹ To reuse this `path` in future sessions, run this function with `install = TRUE`.
identical(my_cache, gb_get_cache())
#> [1] TRUE
# }
```
