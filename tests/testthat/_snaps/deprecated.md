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

# geoboundaries: Single country

    Code
      this <- geoboundaries("andorra")
    Condition
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.

---

    Code
      this3 <- geoboundaries("andorra", type = "SSCGS")
    Condition
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.

# geoboundaries: cgaz

    Code
      this <- geoboundaries()
    Condition
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.
    Message
      i Redirecting to `rgeoboundaries::gb_get_world()`.

---

    Code
      this3 <- geoboundaries("andorra", type = "CGAZ")
    Condition
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.
    Message
      ! `type = "cgaz"` not needed. Just use `rgeoboundaries::gb_get()` or `rgeoboundaries::gb_get_adm()` without `country`.
      i Redirecting to `rgeoboundaries::gb_get_world()`.

# gb_adm: single country

    Code
      a <- gb_adm0(cnt, type = "simplified")
    Condition
      Warning:
      `gb_adm0()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_adm0()` or `gb_get_world()` instead.
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.

---

    Code
      a <- gb_adm1(cnt, type = "simplified")
    Condition
      Warning:
      `gb_adm1()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_adm1()` or `gb_get_world()` instead.
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.

---

    Code
      a <- gb_adm2(cnt, type = "simplified")
    Condition
      Warning:
      `gb_adm2()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_adm2()` or `gb_get_world()` instead.
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.

---

    Code
      a <- gb_adm3(cnt, type = "simplified")
    Condition
      Warning:
      `gb_adm3()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_adm3()` or `gb_get_world()` instead.
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.

---

    Code
      a <- gb_adm4(cnt, type = "simplified")
    Condition
      Warning:
      `gb_adm4()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_adm4()` or `gb_get_world()` instead.
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.

---

    Code
      a <- gb_adm5(cnt, type = "simplified")
    Condition
      Warning:
      `gb_adm5()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_adm5()` or `gb_get_world()` instead.
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.

# gb_adm: cgaz

    Code
      this <- gb_adm0()
    Condition
      Warning:
      `gb_adm0()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_adm0()` or `gb_get_world()` instead.
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.
    Message
      i Redirecting to `rgeoboundaries::gb_get_world()`.

---

    Code
      this3 <- gb_adm0("andorra", type = "CGAZ")
    Condition
      Warning:
      `gb_adm0()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_adm0()` or `gb_get_world()` instead.
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.
    Message
      ! `type = "cgaz"` not needed. Just use `rgeoboundaries::gb_get()` or `rgeoboundaries::gb_get_adm()` without `country`.
      i Redirecting to `rgeoboundaries::gb_get_world()`.

---

    Code
      gb_adm3()
    Condition
      Warning:
      `gb_adm3()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get_adm3()` or `gb_get_world()` instead.
      Warning:
      `geoboundaries()` was deprecated in rgeoboundaries 2.0.0.
      i Please use `gb_get()` or `gb_get_world()` instead.
    Message
      i Redirecting to `rgeoboundaries::gb_get_world()`.
    Condition
      Error in `assert_adm_lvl()`:
      ! Invalid `adm_lvl` code ("3").
      Accepted values are "adm0", "adm1", "adm2", "0", "1", and "2".

