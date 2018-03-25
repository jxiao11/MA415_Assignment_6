
library(ggmap)
library(tidyverse)


gc <- geocode("Summerleaze Beach, Summerleaze Cres, Bude EX23 8HN, UK")

m <- get_map(gc, zoom = 15)

m_w <- get_map(gc, maptype = "watercolor", zoom = 15)

m_w

beach1 <- geocode("Crooklets Beach, Bude, England")

beach2 <- geocode("Summerleaze Beach, Bude, England")


crick <- geocode("S W Coast Path, Bude EX23 8HN, England")

pub <-  geocode("36 Lansdown Rd, Bude EX23 8BN, UK")


d <- rbind(beach1,beach2,crick,pub)



names <- c("Crooklet's Beach","Summerleaze Beach","Cricket ground","The Barrel Pub")
d <- cbind(d,names)

d

source <- "S W Coast Path, Bude EX23 8HN, UK"
dest <- "36 Lansdown Rd, Bude EX23 8BN, UK"
rou <- route(source, dest,mode="walking", structure = "route")


 
ggmap(m) +
  geom_path(
    aes(x = lon, y = lat), colour = "#ff9f84", size = 1,
    data = rou, lineend = "round"
  ) +
  geom_point(
    aes(x = lon, y = lat, col = names),
    data = d,size = 3) +
  #geom_text(x=-4.550, y=50.8337, angle = 45, colour = "#ff9f84",size = 4)+
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())


ggmap(m_w) +
  geom_label(
    aes(x = lon, y = lat, label = names, col=names),
    fontface = "bold" ,data = d,
    vjust = 1.3, hjust = (0.5)
  ) +
  geom_point(
    aes(x = lon, y = lat, col = names),
    data = d, size = 3 ) +
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),legend.position="none")
#geom_text(x=-4.545, y=50.825, label="Bude",fontface =2,size=10, colour = "tomato4")




###--------------------------------------
### Add hotels by Junpei Xiao
###--------------------------------------

### Create a dataframe for all gecode. The gecode code function may cause over limit query issue
### prefer to type in those geocode.
### Crooklets Beach Cafe: -4.553029,50.83556
### Edgecumbe Hotel:-4.547583 50.83138

df_lon <- c(-4.553962,-4.551349,-4.552814,-4.543023,-4.547858,-4.547583)
df_lat <- c(50.83587,50.83054,50.83347,50.83007,50.82697,50.83138)
df4 <- data.frame("lon" = df_lon, "lat" = df_lat)
Location <- c("Crooklet's Beach","Summerleaze Beach","Cricket ground","The Barrel Pub","Falcon hotel","Edgecumbe Hotel")
df5 <- cbind(df4,Location)

rou <- route(source, dest,mode="walking", structure = "route")

#### get Route_map
route_map <- get_googlemap(center = c(lon=-4.543678,lat=50.82664),zoom = 14)

ggmap(route_map) +
  geom_path(
    aes(x = lon, y = lat), colour = "#ff9f84", size = 1,
    data = rou, lineend = "round"
  ) +
  geom_point(
    aes(x = lon, y = lat, col = Location),
    data = df5,size = 4) +
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())

### get water map
water_map <- get_map(df4,source="stamen",zoom = 15,maptype = "watercolor")

ggmap(water_map) +
  geom_label(
    aes(x = lon, y = lat, label = Location, col=Location,size=3),
    fontface = "bold" ,data = df5,
    vjust = 1.3, hjust = (0.5)
  ) +
  geom_point(
    aes(x = lon, y = lat, col = Location),
    data = df5, size = 3 ) +
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),legend.position="none")

