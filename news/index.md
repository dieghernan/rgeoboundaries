# Changelog

## rgeoboundaries (development version)

### Breaking changes

The API has been completely revised to provide clearer function names
and improve internal maintainability. Most old functions [have been
deprecated](https://lifecycle.r-lib.org/articles/stages.html#deprecated)
will issue a warning when used, providing guidance on the appropriate
replacement. Internally, calls to deprecated functions are redirected to
their corresponding replacements.

Additionally, the former [magical
default](https://design.tidyverse.org/def-magical.html) `country = NULL`
argument (which returned the global composite dataset) has been
deprecated. It has been replaced with a dedicated function:
[`gb_get_world()`](../reference/gb_get_world.md).

Renamed functions:

- [`geoboundaries()`](../reference/deprecated.md) -\>
  [`gb_get()`](../reference/gb_get.md) and
  [`gb_get_world()`](../reference/gb_get_world.md). The latter retrieves
  the composite global dataset, and per-country calls can be generated
  on the fly from this dataset.
- `gb_adm*` family -\> `gb_get_adm*` family.
- [`gb_metadata()`](../reference/deprecated.md) -\>
  [`gb_get_metadata()`](../reference/gb_get_metadata.md).
- [`gb_max_adm_lvl()`](../reference/deprecated.md) -\>
  [`gb_get_max_adm_lvl()`](../reference/gb_get_max_adm_lvl.md).

### Other changes

#### Internals

- Download logic is now implemented using **httr2**.
- Internal informational messages are generated using **cli**.

#### Cache management

Cache handling has been fully reviewed:

- By default, the cache directory is located under
  [`base::tempdir()`](https://rdrr.io/r/base/tempfile.html).  
  You can change it using:
  - Temporary cache (single R session): `gb_set_cache(path)`.
  - Persistent cache across R sessions:
    `gb_set_cache(path, install = TRUE)`.
  - Specific files: use the `path` argument in the corresponding
    function e.g. `gb_get(..., path = path)`.

Redesigned cache-management functions:

- [`gb_set_cache()`](../reference/gb_cache.md): configure where files
  are stored.
- [`gb_get_cache()`](../reference/gb_cache.md): retrieve the active
  cache directory.
- [`gb_list_cache()`](../reference/gb_cache.md): list files in the
  cache.
- [`gb_clear_cache()`](../reference/gb_cache.md): remove all cached
  files (optionally removing the installed config).
- [`gb_delete_from_cache()`](../reference/gb_cache.md): remove one or
  more specific cached files.

#### Documentation

- Review `README`.
- Create **pkgdown** site
  <https://dieghernan.github.io/rgeoboundaries/>.
- Add vignette.

#### Testing and internals

- Improved package tests and coverage.
- Added CI checks via GitHub Actions.

#### Package `DESCRIPTION`

- New maintainer: Diego Hernangómez (<https://github.com/dieghernan/>).
- Added William & Mary geoLab as copyright holder.
- Revised `Title` and `Description` with clearer links and citations.
- Tidy dependencies.

#### New files added

- `inst/CITATION` (using
  [`bibentry()`](https://rdrr.io/r/utils/bibentry.html) from
  <https://doi.org/10.1371/journal.pone.0231866>).
- `inst/COPYRIGHTS`.
- `inst/REFERENCES.bib`.
- `CITATION.cff`
- `codemeta.json` and `inst/schemaorg.json`.

#### Project infrastructure and clean-up

- Removed legacy files and reorganized repository layout.
- Redesigned logo.

## rgeoboundaries 1.3

CRAN release: 2024-03-12

CRAN submission.

## rgeoboundaries 1.2.9

CRAN release: 2023-12-08

Initial CRAN submission.
