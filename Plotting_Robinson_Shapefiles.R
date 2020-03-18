# Generic plotting for Robinson-projected shapefiles
# Written by Dave Schoeman (USC)
# March 2020

# Packages
library(tidyverse)
library(sf)
library(tmap)
library(raster)

source("fRaster2Robinson180.R")

# Requires function FUN_raster2Robinson180.R

# Read in the data
world <- st_read("ne_50m_land_Robinson.shp")
rob180 <- "+proj=robin +lon_0=180 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84=0,0,0"

# Plot with Outline		
dLine1 <- data.frame(x = 0.0001, y = seq(-90, 90, .1), attr = 1, id = "a") %>% 
  st_as_sf(coords = c("x", "y"), crs = tmaptools::get_proj4("longlat", output = "character")) %>%
  summarize(m = mean(attr),do_union=FALSE) %>% st_cast("LINESTRING")
dLine2 <- data.frame(x = -.0001, y = seq(-90, 90, .1), attr = 1, id = "a") %>% 
  st_as_sf(coords = c("x", "y"), crs = tmaptools::get_proj4("longlat", output = "character")) %>%
  summarize(m = mean(attr),do_union=FALSE) %>% st_cast("LINESTRING")
dLine3 <- data.frame(x = c(.0001, -.0001), y = c(90, 90), attr = 1, id = "a") %>% 
  st_as_sf(coords = c("x", "y"), crs = tmaptools::get_proj4("longlat", output = "character")) %>%
  summarize(m = mean(attr),do_union=FALSE) %>% st_cast("LINESTRING")
dLine4 <- data.frame(x = c(.0001, -.0001), y = c(-90, -90), attr = 1, id = "a") %>% 
  st_as_sf(coords = c("x", "y"), crs = tmaptools::get_proj4("longlat", output = "character")) %>%
  summarize(m = mean(attr),do_union=FALSE) %>% st_cast("LINESTRING")

# With a raster
r <- stack("VelocityOfClimateChange.grd")
R <- raster2Robinson180(r)

#	tm_shape(r, projection = rob180) +
tm_shape(R) +
  tm_raster(palette = "-RdBu") +
  tm_shape(world) +
  tm_polygons() +
  tm_shape(dLine1) +
  tm_lines() +
  tm_shape(dLine2) +
  tm_lines() +
  tm_shape(dLine3) +
  tm_lines() +
  tm_shape(dLine4) +
  tm_lines() +
  tm_layout(inner.margins = c(.1, .1, .1, .1))
