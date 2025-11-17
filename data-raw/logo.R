## code to prepare `logo` dataset goes here

library(rgeoboundaries)
library(sf)
library(tidyverse)

all2 <- gb_get_world(adm_lvl = 1)

# Sea
bbox_temp <- st_bbox(all2)

newbb <- c(-179.9, -89, 179.9, 89)
names(newbb) <- names(bbox_temp)
class(newbb) <- class(bbox_temp)

poly <- newbb |>
  st_as_sfc() |>
  st_set_crs(st_crs(all2)) |>
  st_segmentize(dfMaxLength = 50000)

line <- poly |> st_cast("LINESTRING")
p <- ggplot(poly) +
  geom_sf(fill = "#bee0ff") +
  geom_sf(data = all2, fill = "#f0b323", color = "white", linewidth = 0.1) +
  geom_sf(data = line, color = "black") +
  coord_sf(expand = TRUE, crs = "+proj=robin") +
  theme_void()


ggsave("data-raw/world.png", p)
