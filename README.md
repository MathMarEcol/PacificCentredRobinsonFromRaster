# A repo to plot a Pacific Centred Robinson Projection From a Raster

This code is for plotting IPCC-style Robinson projections centred on the dateline (standard for ocean-based outputs). 
This is extremely problematic in R - raster, tmap, ggplot2 do it cleanly with a lot of data often missing. Often the projection simply fails. I spent a day or two trying to resolve this inside R before resorting to calling GDAL directly from inside R to do the job. 

Inside this repo is a function that does the trick, an example plot, a practice raster, and a Pacific-centred, Robinson projected shapefile.

Note that:    
  1 - You will need to install GDAL from the terminal (see https://gist.github.com/kelvinn/f14f0fc24445a7994368f984c3e37724, https://medium.com/@vascofernandes_13322/how-to-install-gdal-on-macos-6a76fb5e24a4, or similar).   
  2 - The paths in both the function (GDAL path) and the example code are relative to this folder.   
  3 - I know that you could potentially use package gdalUtilities, but that requires some extra reading, and I found some initial GDAL script (https://medium.com/planet-stories/a-gentle-introduction-to-gdal-part-2-map-projections-gdalwarp-e05173bd710a) so just modified that for execution from within R.    

