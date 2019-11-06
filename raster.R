library(sf)
library(tmap)
library(ceramic)


pathfile="https://raw.githubusercontent.com/djouallah/ceramic/master/sa.csv"
dataset <- read_csv(pathfile,col_types = cols(id = col_character(),labels = col_character()))

Sys.setenv(MAPBOX_API_KEY = "pk.eyJ1IjoibWltNzg3IiwiYSI6ImNqb2E0M2prejBhdnEzd281amg2c3VnczAifQ.MDaWbNOfd-SJDHK398OSMg")
dataset<-filter(dataset, !is.na(labels))

map <- st_as_sf(dataset, coords = c("x", "y"), crs = 4326)

background <- cc_location(map)


chartlegend <- unique(dataset[c("status", "color")])

m2 <- tm_shape(background)+
      tm_rgb() +
      tm_shape(map) +
      tm_text(text="labels",col="color",size = 0.5)+
      tm_add_legend(type='fill',labels=chartlegend$status, col=chartlegend$color)
      tmap_save(m2,"map.pdf",width=3508, height=4961)
m2