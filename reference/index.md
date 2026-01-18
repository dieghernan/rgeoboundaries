# Package index

## Boundaries

These functions return [sf](https://CRAN.R-project.org/package=sf)
objects with political boundaries.

- [`gb_get()`](gb_get.md) : Get individual country boundary files from
  geoBoundaries
- [`gb_get_adm0()`](gb_get_adm.md) [`gb_get_adm1()`](gb_get_adm.md)
  [`gb_get_adm2()`](gb_get_adm.md) [`gb_get_adm3()`](gb_get_adm.md)
  [`gb_get_adm4()`](gb_get_adm.md) [`gb_get_adm5()`](gb_get_adm.md) :
  Retrieve geoBoundaries country files for a specified administrative
  level
- [`gb_get_world()`](gb_get_world.md) : Retrieve global composite data
  (CGAZ) from geoBoundaries

## Metadata

These functions return metadata in tibble format.

- [`gb_get_max_adm_lvl()`](gb_get_max_adm_lvl.md) : Retrieve the highest
  available administrative level for a country
- [`gb_get_metadata()`](gb_get_metadata.md) : Retrieve metadata of
  individual country files from geoBoundaries

## Cache management

- [`gb_set_cache()`](gb_cache.md) [`gb_get_cache()`](gb_cache.md)
  [`gb_list_cache()`](gb_cache.md) [`gb_clear_cache()`](gb_cache.md)
  [`gb_delete_from_cache()`](gb_cache.md) :

  [rgeoboundaries](https://CRAN.R-project.org/package=rgeoboundaries)
  cache utilities

## About the package

- [`rgeoboundaries`](rgeoboundaries-package.md)
  [`rgeoboundaries-package`](rgeoboundaries-package.md) :
  rgeoboundaries: A Client for the 'geoBoundaries' Administrative
  Boundaries Dataset
