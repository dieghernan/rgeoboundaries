# Get individual country boundary files from geoBoundaries

[Attribution](https://www.geoboundaries.org/index.html#usage) is
required for all uses of this dataset.

This function returns boundary data for individual countries *as they
represent themselves*, without any special identification of disputed
areas.

If you require data that explicitly includes disputed areas, use
[`gb_get_world()`](gb_get_world.md) instead.

## Usage

``` r
gb_get(
  country,
  adm_lvl = "adm0",
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

- adm_lvl:

  Type of boundary to retrieve. Accepted values are `"all"` (all
  available administrative levels) or a specific ADM level. `"adm0"`
  corresponds to country boundaries, `"adm1"` to first-level subnational
  boundaries, `"adm2"` to second-level boundaries, and so on. Uppercase
  variants (e.g. `"ADM1"`) and numeric values (`0`, `1`, `2`, `3`, `4`,
  `5`) are also accepted.

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

The following convenience wrappers are also available:

- [`gb_get_adm0()`](gb_get_adm.md) returns country boundaries.

- [`gb_get_adm1()`](gb_get_adm.md) returns first-level administrative
  boundaries (e.g. states in the United States).

- [`gb_get_adm2()`](gb_get_adm.md) returns second-level administrative
  boundaries (e.g. counties in the United States).

- [`gb_get_adm3()`](gb_get_adm.md) returns third-level administrative
  boundaries (e.g. municipalities in some countries).

- [`gb_get_adm4()`](gb_get_adm.md) returns fourth-level administrative
  boundaries.

- [`gb_get_adm5()`](gb_get_adm.md) returns fifth-level administrative
  boundaries.

## References

Runfola, D. et al. (2020) geoBoundaries: A global database of political
administrative boundaries. *PLoS ONE* 15(4): e0231866.
[doi:10.1371/journal.pone.0231866](https://doi.org/10.1371/journal.pone.0231866)
.

## See also

Other API functions: [`gb_get_adm`](gb_get_adm.md),
[`gb_get_world()`](gb_get_world.md)

## Examples

``` r
# \donttest{
# Level 2 administrative boundaries in Sri Lanka
sri_lanka <- gb_get(
  "Sri Lanka",
  adm_lvl = 2,
  simplified = TRUE
)

sri_lanka
#> Simple feature collection with 25 features and 5 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 79.65102 ymin: 5.919017 xmax: 81.87896 ymax: 9.835791
#> Geodetic CRS:  WGS 84
#> # A tibble: 25 × 6
#>    shapeName     shapeISO shapeID shapeGroup shapeType                  geometry
#>  * <chr>         <chr>    <chr>   <chr>      <chr>            <MULTIPOLYGON [°]>
#>  1 Jaffna Distr… LK-41    463711… LKA        ADM2      (((79.7152 9.529465, 79.…
#>  2 Kilinochchi … LK-42    463711… LKA        ADM2      (((80.01015 9.472403, 80…
#>  3 Mannar Distr… LK-43    463711… LKA        ADM2      (((80.11535 9.209068, 80…
#>  4 Mullaitivu D… LK-45    463711… LKA        ADM2      (((80.61353 9.456581, 80…
#>  5 Vavuniya Dis… LK-44    463711… LKA        ADM2      (((80.23541 8.680412, 80…
#>  6 Galle Distri… LK-31    463711… LKA        ADM2      (((79.98757 6.440352, 79…
#>  7 Hambantota D… LK-33    463711… LKA        ADM2      (((80.67006 6.306029, 80…
#>  8 Matara Distr… LK-32    463711… LKA        ADM2      (((80.3818 5.965264, 80.…
#>  9 Ampara Distr… LK-52    463711… LKA        ADM2      (((81.70788 6.51073, 81.…
#> 10 Anuradhapura… LK-71    463711… LKA        ADM2      (((80.03237 8.527211, 80…
#> # ℹ 15 more rows

library(ggplot2)
ggplot(sri_lanka) +
  geom_sf() +
  labs(caption = "Source: www.geoboundaries.org")

# }

# Inspect metadata and licensing
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
gb_get_metadata(
  "Sri Lanka",
  adm_lvl = 2
) |>
  select(boundaryISO, boundaryType, licenseDetail, licenseSource) |>
  glimpse()
#> Rows: 1
#> Columns: 4
#> $ boundaryISO   <chr> "LKA"
#> $ boundaryType  <chr> "ADM2"
#> $ licenseDetail <chr> "Open Data Commons Open Database License 1.0"
#> $ licenseSource <chr> "www.openstreetmap.org/copyright"
```
