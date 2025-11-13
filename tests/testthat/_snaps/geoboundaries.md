# Deprecations

    Code
      r <- geoboundaries("benin", adm_lvl = 0, type = "simplified", version = "4")
    Condition
      Warning:
      The `version` argument of `geoboundaries()` is deprecated as of rgeoboundaries 0.5.

---

    Code
      r <- gb_adm0("benin", type = "simplified", version = "4")
    Condition
      Warning:
      The `version` argument of `gb_adm0()` is deprecated as of rgeoboundaries 0.5.

---

    Code
      r <- gb_adm1("benin", type = "simplified", version = "4")
    Condition
      Warning:
      The `version` argument of `gb_adm1()` is deprecated as of rgeoboundaries 0.5.

---

    Code
      r <- gb_adm2("benin", type = "simplified", version = "4")
    Condition
      Warning:
      The `version` argument of `gb_adm2()` is deprecated as of rgeoboundaries 0.5.

---

    Code
      r <- gb_adm3("benin", type = "simplified", version = "4")
    Condition
      Warning:
      The `version` argument of `gb_adm3()` is deprecated as of rgeoboundaries 0.5.

---

    Code
      r <- gb_adm4("austria", type = "simplified", version = "4")
    Condition
      Warning:
      The `version` argument of `gb_adm4()` is deprecated as of rgeoboundaries 0.5.

---

    Code
      r <- gb_adm5("rwanda", type = "simplified", version = "4")
    Condition
      Warning:
      The `version` argument of `gb_adm5()` is deprecated as of rgeoboundaries 0.5.

# CGAZ

    Code
      pp <- geoboundaries("Andorra", type = "cgaz")
    Condition
      Warning:
      'cgaz' type not needed, just use `geoboundaries` or `gb_adm` without `country`

# Not available

    Code
      gb_adm5(country = "ESP")
    Condition
      Error:
      ! ADM5 not available!

