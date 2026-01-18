# Retrieve geoBoundaries country files for a specified administrative level

[Attribution](https://www.geoboundaries.org/index.html#usage) is
required for all uses of this dataset.

These functions are convenience wrappers around [`gb_get()`](gb_get.md)
for retrieving boundaries at different administrative levels:

- `gb_get_adm0()` returns national boundaries.

- `gb_get_adm1()` returns first‑level administrative boundaries (e.g.,
  states in the United States).

- `gb_get_adm2()` returns second‑level administrative boundaries (e.g.,
  counties in the United States).

- `gb_get_adm3()` returns third‑level administrative boundaries (e.g.,
  towns or cities in some countries).

- `gb_get_adm4()` returns fourth‑level administrative boundaries.

- `gb_get_adm5()` returns fifth‑level administrative boundaries.

Note that administrative hierarchies vary by country. Use
[gb_get_max_adm_lvl](gb_get_max_adm_lvl.md) to check the maximum
available level.

## Usage

``` r
gb_get_adm0(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
)

gb_get_adm1(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
)

gb_get_adm2(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
)

gb_get_adm3(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
)

gb_get_adm4(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  path = NULL
)

gb_get_adm5(
  country,
  simplified = FALSE,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
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

- simplified:

  logical. If `TRUE`, return simplified boundaries. If `FALSE` (the
  default), use the premier geoBoundaries release.

- release_type:

  One of `"gbOpen"`, `"gbHumanitarian"`, or `"gbAuthoritative"`. For
  most users, `"gbOpen"` (the default) is recommended, as it is CC-BY
  4.0 compliant and suitable for most purposes provided proper
  attribution is given:

  - `"gbHumanitarian"` files are mirrored from [UN
    OCHA](https://www.unocha.org/) and may have more restrictive
    licensing.

  - `"gbAuthoritative"` files are mirrored from UN SALB and cannot be
    used for commercial purposes, but are verified through in-country
    processes.

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

Individual boundary files in the geoBoundaries database are governed by
the license or licenses specified in their associated metadata (see
[`gb_get_metadata()`](gb_get_metadata.md)). Users working with
individual boundary files should ensure that they comply with these
licenses and cite the original data sources listed in the metadata. See
**Examples**.

## References

Runfola, D. et al. (2020) geoBoundaries: A global database of political
administrative boundaries. *PLoS ONE* 15(4): e0231866.
[doi:10.1371/journal.pone.0231866](https://doi.org/10.1371/journal.pone.0231866)
.

## See also

[`gb_get_max_adm_lvl()`](gb_get_max_adm_lvl.md).

Other API functions: [`gb_get()`](gb_get.md),
[`gb_get_world()`](gb_get_world.md)

## Examples

``` r
# \donttest{
lev2 <- gb_get_adm2(
  c("Italia", "Suiza", "Austria"),
  simplified = TRUE
)


library(ggplot2)

ggplot(lev2) +
  geom_sf(aes(fill = shapeGroup)) +
  labs(
    title = "Second-level administration",
    subtitle = "Selected countries",
    caption = "Source: www.geoboundaries.org"
  )

# }
```
