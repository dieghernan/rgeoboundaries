# gb_metadata: Single country

    Code
      db_old <- gb_metadata(country = "Spain", adm_lvl = 1)
    Condition
      Warning:
      `gb_metadata()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_metadata()` instead.

# gb_metadata: All countries, NULL is ALL

    Code
      db_old <- gb_metadata(adm_lvl = 1, release_type = "gbHumanitarian")
    Condition
      Warning:
      `gb_metadata()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_metadata()` instead.

# gb_max_adm_lvl: Single country

    Code
      db_old <- gb_max_adm_lvl(country = "Spain")
    Condition
      Warning:
      `gb_max_adm_lvl()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_max_adm_lvl()` instead.

# gb_max_adm_lvl: All countries, NULL is ALL

    Code
      db_old <- gb_max_adm_lvl(release_type = "gbHumanitarian")
    Condition
      Warning:
      `gb_max_adm_lvl()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_max_adm_lvl()` instead.

