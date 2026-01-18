# Retrieve global composite data (CGAZ) from geoBoundaries

[Attribution](https://www.geoboundaries.org/index.html#usage) is
required for all uses of this dataset.

This function returns a global composite for the requested
administrative level, clipped to international boundaries, with gaps
filled between adjacent borders.

## Usage

``` r
gb_get_world(
  country = "all",
  adm_lvl = "adm0",
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
)
```

## Source

geoBoundaries API Service <https://www.geoboundaries.org/api.html>.

## Arguments

- country:

  Character vector of country identifiers. This can be `"all"` (to
  return data for all countries), a vector of country names, or ISO3
  country codes. See also
  [`countrycode::countrycode()`](https://vincentarelbundock.github.io/countrycode/reference/countrycode.html).

- adm_lvl:

  Type of boundary. Accepted values are administrative levels 0, 1,
  and 2. `"adm0"` corresponds to national boundaries, `"adm1"` to
  first‑level subnational boundaries, and `"adm2"` to second‑level
  boundaries. Uppercase variants (e.g., `"ADM1"`) and numeric values
  (`0`, `1`, `2`) are also accepted.

- quiet:

  logical. If `TRUE`, suppress informational messages.

- overwrite:

  logical. If `TRUE`, force a fresh download of the source `.zip` file,
  even if it is already cached.

- path:

  Character. Path to a cache directory. If `NULL` (the default), data
  are stored in the default cache directory (see
  [`gb_set_cache()`](gb_cache.md)). If no cache directory has been
  configured, files are stored in a temporary directory (see
  [`base::tempdir()`](https://rdrr.io/r/base/tempfile.html)).

## Value

An [`sf`](https://r-spatial.github.io/sf/reference/sf.html) object
containing the requested boundaries.

## Details

Comprehensive Global Administrative Zones (CGAZ) is a set of global
composite administrative boundary products. There are two key
differences between these global composites and individual country
downloads:

- Boundaries undergo extensive simplification to ensure file sizes
  remain manageable for typical desktop software.

- Disputed areas are removed and replaced with polygons defined
  according to U.S. Department of State guidelines.

## References

Runfola, D. et al. (2020) geoBoundaries: A global database of political
administrative boundaries. *PLoS ONE* 15(4): e0231866.
[doi:10.1371/journal.pone.0231866](https://doi.org/10.1371/journal.pone.0231866)
.

## See also

Other API functions: [`gb_get()`](gb_get.md),
[`gb_get_adm`](gb_get_adm.md)

## Examples

``` r
# This download may take some time
# \dontrun{
world <- gb_get_world()

library(ggplot2)

ggplot(world) +
  geom_sf() +
  coord_sf(expand = FALSE) +
  labs(caption = "Source: www.geoboundaries.org")

# }
```
