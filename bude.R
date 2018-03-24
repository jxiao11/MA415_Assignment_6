library(ggmap)
library(tidyverse)
library(knitr)

# choose the center of map to be Summerleaze Beach
#center <- geocode("Summerleaze Beach, Summerleaze Cres, Bude EX23 8HN, UK")
center <- geocode("S W Coast Path, Bude EX23 8HN, England")
# map
m <- get_map(center, zoom = 15)
# water map
m_w <- get_map(center, maptype = "watercolor", zoom = 15)

beach1 <- geocode("Crooklets Beach, Bude, England")
beach2 <- geocode("Summerleaze Beach, Bude, England")
# North Cornwall Cricket ground
crickground <- geocode("S W Coast Path, Bude EX23 8HN, England")
# the barrel
pub <-  geocode("36 Lansdown Rd, Bude EX23 8BN, UK")

d <- rbind(beach1,beach2,crickground,pub)
names <- c("Crooklet's Beach","Summerleaze Beach","Cricket ground","The Barrel Pub")
d <- cbind(d,names)
source <- "S W Coast Path, Bude EX23 8HN, UK"
dest <- "36 Lansdown Rd, Bude EX23 8BN, UK"
rou <- route(source, dest,mode="walking", structure = "route")
ggmap(m) +
  geom_label(
    aes(x = lon, y = lat, label = names, col=names),
    fontface = "plain" ,data = d,
    vjust = 1.3, hjust = (0.5)
  ) +
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
