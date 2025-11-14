# rgeoboundaries (development version)

## Breaking changes

The API has been completely reviewed to provide more clarity on functions naming
and to facilitate internal maintenance. Most old functions [has been
deprecated](https://lifecycle.r-lib.org/articles/stages.html#deprecated) and it
would warn when used, providing advice on the replacement function. Internally,
the calls to these functions would be redirected to the corresponding
replacement. Renamed functions:

-   `gb_metadata()` -\> `gb_get_metadata()`.
-   `gb_max_adm_lvl()` -\> `gb_get_max_adm_lvl()`.

## Other changes

### Cache management

Full review of cache management:

-   By default the cache directory is under `base::tempdir()`. You can change
    it:
    -   Temporary cache (single **R** session): `gb_set_cache(path)`.
    -   Persistent cache across **R** sessions:
        `gb_set_cache(path, install = TRUE)`.
-   Redesigned cache management functions:
    -   `gb_set_cache()`: configure where files are stored.
    -   `gb_get_cache()`: retrieve the active cache directory.
    -   `gb_list_cache()`: list files in the cache.
    -   `gb_clear_cache()`: remove all cached files (optionally removing the
        installed config).
    -   `gb_delete_from_cache()`: remove one or more specific cached files.

### Testing and internals

-   Review and improve package testing and coverage.
-   Added CI checks via GitHub Actions.

### Package metadata

-   Updated `DESCRIPTION`.
    -   New maintainer: Diego Hernangomez (<https://github.com/dieghernan/>).
    -   Added William and Mary geoLab as copyright holder.
    -   Revised `Title` and `Description` with clearer links and citations.
-   New files added:
    -   `inst/CITATION` (`bibentry()` from
        <https://doi.org/10.1371/journal.pone.0231866>).
    -   `inst/COPYRIGHTS`
    -   `inst/REFERENCES.bib`
-   Project infrastructure and clean-up:
-   Removed legacy files and cleaned repository layout.
-   Redesigned logo.

# rgeoboundaries 1.3

-   CRAN submission.

# rgeoboundaries 1.2.9

-   Initial CRAN submission.
