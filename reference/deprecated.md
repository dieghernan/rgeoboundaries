# Deprecated and renamed functions in [rgeoboundaries](https://CRAN.R-project.org/package=rgeoboundaries)

**\[deprecated\]**

[rgeoboundaries](https://CRAN.R-project.org/package=rgeoboundaries)
2.0.0 renamed a number of functions to ensure that every function has a
`object_verb()` naming scheme and avoiding magical defaults.

- `geoboundaries()` -\> [`gb_get()`](gb_get.md) and
  [`gb_get_world()`](gb_get_world.md).

- `gb_adm*` family -\> [`gb_get_adm*`](gb_get_adm.md) family.

- `gb_metadata()` -\> [`gb_get_metadata()`](gb_get_metadata.md).

- `gb_max_adm_lvl()` -\>
  [`gb_get_max_adm_lvl()`](gb_get_max_adm_lvl.md).

These functions are likely to be removed in the future.

## Usage

``` r
geoboundaries(
  country = NULL,
  adm_lvl = "adm0",
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
)

gb_adm0(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
)

gb_adm1(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
)

gb_adm2(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
)

gb_adm3(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
)

gb_adm4(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
)

gb_adm5(
  country = NULL,
  type = "unsimplified",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative"),
  quiet = TRUE,
  overwrite = FALSE,
  version = deprecated()
)

gb_metadata(
  country = NULL,
  adm_lvl = "all",
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative")
)

gb_max_adm_lvl(
  country = NULL,
  release_type = c("gbOpen", "gbHumanitarian", "gbAuthoritative")
)
```

## Arguments

- country:

  A character vector of country codes. It could be either `"all"` (that
  would return the data for all countries), a vector of country names or
  ISO3 country codes. See also
  [`countrycode::countrycode()`](https://vincentarelbundock.github.io/countrycode/reference/countrycode.html).

- adm_lvl:

  Type of boundary Accepted values are `"all"` (all available
  boundaries) or the ADM level (`"adm0"` is the country boundary,
  `"adm1"` is the first level of sub national boundaries, `"adm2"` is
  the second level and so on. Upper case version (`"ADM1"`) and the
  number of the level (`1, 2, 3, 4, 5`) and also accepted.

- type:

  character. One of `"simplified"` and `"unsimplified"`. Other values
  would be assumed as `"unsimplified"`.

- release_type:

  One of `"gbOpen"`, `"gbHumanitarian"`, `"gbAuthoritative"`. For most
  users, we suggest using `"gbOpen"` (the default), as it is CC-BY 4.0
  compliant and can be used for most purposes so long as attribution is
  provided:

  - `"gbHumanitarian"` files are mirrored from [UN
    OCHA](https://www.unocha.org/), but may have less open licensure.

  - `"gbAuthoritative"` files are mirrored from [UN
    SALB](https://salb.un.org/en), and cannot be used for commercial
    purposes, but are verified through in-country processes.

- quiet:

  logical. If `TRUE` suppresses informational messages.

- overwrite:

  logical. When set to `TRUE` it would force a fresh download of the
  source `.zip` file.

- version:

  Deprecated argument.

## Value

These functions are re-directed to their replacement, providing the same
output.

## References

rOpenSci, Anderson B, Chamberlain S, DeCicco L, Gustavsen J, Krystalli
A, Lepore M, Mullen L, Ram K, Ross N, Salmon M, Vidoni M, Riederer E,
Sparks A, Hollister J (2024). *rOpenSci Packages: Development,
Maintenance, and Peer Review*. <doi:10.5281/zenodo.10797633>.

The tidyverse team. *The Tidyverse Style Guide*,
<https://style.tidyverse.org/>. Accessed 14 Nov. 2025.

Wickham, Hadley. “Tidy Design Principles.” *Tidyverse.org*, 2025,
<https://design.tidyverse.org/>. Accessed 14 Nov. 2025.

## Examples

``` r
# Show deprecation messages
gb_metadata()
#> Warning: `gb_metadata()` was deprecated in rgeoboundaries 2.0.0.
#> ℹ Please use `gb_get_metadata()` instead.
#> # A tibble: 715 × 32
#>    boundaryID       boundaryName boundaryISO boundaryYearRepresen…¹ boundaryType
#>    <chr>            <chr>        <chr>       <chr>                  <chr>       
#>  1 ABW-ADM0-133965… Aruba        ABW         2021                   ADM0        
#>  2 AFG-ADM0-778584… Afghanistan  AFG         2014                   ADM0        
#>  3 AFG-ADM1-126533… Afghanistan  AFG         2007                   ADM1        
#>  4 AFG-ADM2-176988… Afghanistan  AFG         2014                   ADM2        
#>  5 AGO-ADM0-711927… Angola       AGO         2021                   ADM0        
#>  6 AGO-ADM1-264088… Angola       AGO         2021                   ADM1        
#>  7 AGO-ADM2-914247… Angola       AGO         2006                   ADM2        
#>  8 AGO-ADM3-770603… Angola       AGO         2014                   ADM3        
#>  9 AIA-ADM0-967247… Anguilla     AIA         2021                   ADM0        
#> 10 ALB-ADM0-442218… Albania      ALB         2003                   ADM0        
#> # ℹ 705 more rows
#> # ℹ abbreviated name: ¹​boundaryYearRepresented
#> # ℹ 27 more variables: boundaryCanonical <chr>, boundarySource <chr>,
#> #   boundaryLicense <chr>, licenseDetail <chr>, licenseSource <chr>,
#> #   boundarySourceURL <chr>, sourceDataUpdateDate <dttm>, buildDate <date>,
#> #   Continent <chr>, `UNSDG-region` <chr>, `UNSDG-subregion` <chr>,
#> #   worldBankIncomeGroup <chr>, admUnitCount <dbl>, meanVertices <dbl>, …
```
