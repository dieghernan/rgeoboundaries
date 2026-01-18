# Assert admin levels

    Code
      assert_adm_lvl(1:2)
    Condition
      Error in `assert_adm_lvl()`:
      ! You cannot mix different `adm_lvl` values. You entered 1 and 2.

---

    Code
      assert_adm_lvl(adm_lvl = 10)
    Condition
      Error in `assert_adm_lvl()`:
      ! Invalid `adm_lvl` code ("10").
      Accepted values are "all", "adm0", "adm1", "adm2", "adm3", "adm4", "adm5", "0", "1", "2", "3", "4", and "5".

# Utils names

    Code
      rgbnd_dev_country2iso(c("Espagne", "United Kingdom"))
    Output
      [1] "ESP" "GBR"

---

    Code
      rgbnd_dev_country2iso(c("ESP", "POR", "RTA", "USA"))
    Message
      ! Some values could not be matched unambiguously: POR and RTA
      i Check the names or use ISO3 codes instead.
    Output
      [1] "ESP" "USA"

---

    Code
      rgbnd_dev_country2iso(c("ESP", "Alemania"))
    Output
      [1] "ESP" "DEU"

# Problematic names

    Code
      rgbnd_dev_country2iso(c("Espagne", "Antartica"))
    Output
      [1] "ESP" "ATA"

---

    Code
      rgbnd_dev_country2iso(c("spain", "antartica"))
    Output
      [1] "ESP" "ATA"

---

    Code
      rgbnd_dev_country2iso(c("Spain", "Kosovo", "Antartica"))
    Output
      [1] "ESP" "XKX" "ATA"

---

    Code
      rgbnd_dev_country2iso(c("ESP", "XKX", "DEU"))
    Output
      [1] "ESP" "XKX" "DEU"

---

    Code
      rgbnd_dev_country2iso(c("Spain", "Rea", "Kosovo", "Antartica", "Murcua"))
    Message
      ! Some values could not be matched unambiguously: Rea and Murcua
      i Check the names or use ISO3 codes instead.
    Output
      [1] "ESP" "XKX" "ATA"

---

    Code
      rgbnd_dev_country2iso("Kosovo")
    Output
      [1] "XKX"

---

    Code
      rgbnd_dev_country2iso("XKX")
    Output
      [1] "XKX"

