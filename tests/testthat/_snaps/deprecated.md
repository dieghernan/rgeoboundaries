# Single country

    Code
      db_old <- gb_metadata(country = "Spain", adm_lvl = 1)
    Condition
      Warning:
      `gb_metadata()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_metadata()` instead.

# All countries, NULL is ALL

    Code
      db_old <- gb_metadata(adm_lvl = 1, release_type = "gbHumanitarian")
    Condition
      Warning:
      `gb_metadata()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_metadata()` instead.

