# Convert country codes

    Code
      country_to_iso3(c("Spain", "Kosovo", "Murcia"))
    Condition
      Warning:
      Some values were not matched unambiguously: Murcia
      Error:
      ! Murcia not valid name(s)!

# Assert admin levels

    Code
      assert_adm_lvl(1:2)
    Condition
      Error in `assert_adm_lvl()`:
      ! You can't mix different administrative levels!

---

    Code
      assert_adm_lvl(adm_lvl = 10)
    Condition
      Error in `paste()`:
      ! argument is missing, with no default

