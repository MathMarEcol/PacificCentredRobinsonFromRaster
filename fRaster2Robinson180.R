# A function for projecting lonlat raster to Robinson +180 using GDAL
# Written by Dave Schoeman (USC)
# March 2020

# x is a lonlat raster; gdalP is the path to GDAL install
fRaster2Robinson180 <- function(x, gdalP = "/Library/Frameworks/GDAL.framework/Versions/2.4/Programs/") {
  writeRaster(x, "makeRobRasterXYZ.tif", options = c('TFW=YES'))
  txt <- paste0("system(\"", gdalP, "gdalwarp -t_srs ", 
                "'", "+proj=robin +lon_0=180 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84=0,0,0", "'",
                " -r lanczos -dstalpha -wo SOURCE_EXTRA=1000 -co COMPRESS=LZW ",
                "makeRobRasterXYZ.tif outRobRasterXYZ.tif\")")
  eval(parse(text = txt))
  out <- stack("outRobRasterXYZ.tif")
  # Note that out contains two layers of data, both of which have NAs coded zero, but the second is a NA/data mask
  r_out <- raster(crs = projection(out), resolution = res(out), ext = extent(out)) # An empty raster with the exact dimensions of out
  r_out[] <- NA # Fill with NA
  nonNA <- which(out[[2]][] != 0)
  r_out[nonNA] <- out[[1]][nonNA] # Replace values that are not zero in layer 2 of out with data from layer 1
  file.remove(dir(pattern = "*RobRasterXYZ*"))
  return(r_out)
}
