# [rgeoboundaries](https://CRAN.R-project.org/package=rgeoboundaries): cache utilities

Utilities to manage a local cache directory used by
[rgeoboundaries](https://CRAN.R-project.org/package=rgeoboundaries) for
downloaded boundary files. These helpers let you set a cache directory,
retrieve the active directory, list cached files and remove cached files
or the whole cache.

The primary functions are:

- `gb_set_cache()`: configure where files will be stored (temporary by
  default).

- `gb_get_cache()`: get the active cache directory path.

- `gb_list_cache()`: list files present in the cache.

- `gb_clear_cache()`: remove all cached files (and optionally the
  installed config).

- `gb_delete_from_cache()`: remove one or more specific cached files.

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

  character. Path to the directory to use as cache. If omitted or empty,
  a temporary directory inside
  [`base::tempdir()`](https://rdrr.io/r/base/tempfile.html) is used.

- install:

  logical. If `TRUE`, write the chosen path to the package configuration
  directory so it is used in future sessions. Defaults to `FALSE`. If
  path is omitted or is the
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html), install is forced
  to `FALSE`.

- overwrite:

  logical. If `TRUE` and `install = TRUE`, overwrite any existing
  installed cache path. Defaults to `FALSE`.

- quiet:

  logical. If `TRUE` suppresses informational messages.

- create:

  **\[deprecated\]**.

- full_path:

  logical, if `TRUE` returns the full path all the cached files. If
  `FALSE` just path relative to the cache directory is provided.

- force:

  logical. Should permissions be changed (if possible) to allow the file
  or directory to be removed?

- clear_config:

  logical. If `TRUE`, will delete the configuration folder of
  [rgeoboundaries](https://CRAN.R-project.org/package=rgeoboundaries).

- file:

  character. Base name of the cached file to delete.

## Value

- `gb_set_cache()`: (invisibly) returns the cache directory path
  (character) that was set.

- `gb_get_cache()`: returns the active cache directory path (character).

- `gb_list_cache()`: returns a character vector with cached file names
  or full paths depending on the `full_path` argument.

- `gb_clear_cache()` and `gb_delete_from_cache()`: Called for their side
  effects.

## Details

By default, when no cache `path` is set the package uses a folder inside
[`base::tempdir()`](https://rdrr.io/r/base/tempfile.html) (so files are
temporary and are removed when the R session ends). To persist a cache
across **R** sessions, use `gb_set_cache(path, install = TRUE)` which
writes the chosen path to a small configuration file under
`tools::R_user_dir("rgeoboundaries", "config")`.

## Caching strategies

- For occasional use, rely on the default
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html)-based cache (no
  install).

- Modify the cache for a single session setting `gb_set_cache(path)`.

- For reproducible workflows, install a persistent cache with
  `gb_set_cache(path, install = TRUE)` that would be kept across **R**
  sessions.

- For caching specific files, use the `path` argument in the
  corresponding function. See [`gb_get()`](gb_get.md).

## See also

[`tools::R_user_dir()`](https://rdrr.io/r/tools/userdir.html),
[`base::tempdir()`](https://rdrr.io/r/base/tempfile.html)

## Examples

``` r
# Caution! This may modify your current state

# \dontrun{
my_cache <- gb_get_cache()
# Set an example cache
ex <- file.path(tempdir(), "example", "cache")
gb_set_cache(ex, quiet = TRUE)

newcache <- gb_get_cache()
newcache
#> [1] "C:\\Users\\RUNNER~1\\AppData\\Local\\Temp\\RtmpspbWma/example/cache"

# Write files to path
cat(1:10000L, file = file.path(newcache, "a.txt"))
cat(1:10000L, file = file.path(newcache, "b.txt"))
cat(1:10000L, file = file.path(newcache, "c.txt"))

# List cache
gb_list_cache()
#> [1] "a.txt" "b.txt" "c.txt"

# Delete one file
gb_delete_from_cache("a.txt")
#> ✔ File C:\Users\RUNNER~1\AppData\Local\Temp\RtmpspbWma/example/cache/a.txt deleted.

gb_list_cache()
#> [1] "b.txt" "c.txt"

# Delete all
gb_clear_cache(quiet = FALSE)
#> ! rgeoboundaries data deleted: C:\Users\RUNNER~1\AppData\Local\Temp\RtmpspbWma/example/cache

gb_list_cache()
#> character(0)

# Restore initial cache
gb_set_cache(my_cache)
#> ✔ rgeoboundaries cache directory is C:\Users\RUNNER~1\AppData\Local\Temp\RtmpspbWma/rgeoboundaries.
#> ℹ To install your `path` for use in future sessions run this function with `install = TRUE`.
identical(my_cache, gb_get_cache())
#> [1] TRUE
# }
```
