library(data.table)
library(ggplot2)
library(gganimate)
library(gifski)

ispfPalette <- c("#56B4E9", "#B359B4", "#FF9D37", "#009FA4", "#999999", "#FF0000", "#D55E00", "#CC79A7", "#345687")

theme_ispf <- function (base_size = 8, base_family = "Roboto Light") 
{
  bgcolor <- "#FFFFFF"
  ret <- theme(rect = element_rect(fill = bgcolor, linetype = 0, colour = NA), 
               text = element_text(size = base_size, family = base_family), 
               title = element_text(size = base_size,hjust = 0.5, family = "Roboto Light"), 
               plot.title = element_text(hjust = 0.5, family = "Roboto Light"), 
               axis.title.x = element_blank(),
               axis.title.y = element_text(hjust = 0.5, family = base_family),
               panel.grid.major.y = element_line(colour = "#D8D8D8"), 
               panel.grid.minor.y = element_blank(),
               panel.grid.major.x = element_blank(), 
               panel.grid.minor.x = element_blank(), 
               panel.border = element_blank(), 
               panel.background = element_blank(),
               legend.key = element_rect(fill = "#FFFFFF00"),
               plot.margin=grid::unit(c(0,0,0,0), "mm"),
               legend.position = "bottom",
               legend.direction = "horizontal",
               legend.title = element_blank(),
               legend.margin=margin(t = 0, unit='cm'),
               legend.key.width=unit(0.2, "cm"),
               legend.text = element_text(size = base_size, family = base_family))
  ret
}

decorateDataTable <- function(dt){
  dt[, AgeQ80:= factor(AgeQ80)]
  dt[, AgeQ80:= relevel(AgeQ80, "Moins de 5 ans")]
  dt[, Sexe:=as.factor(Sexe)]
  dt[Sexe=="1", Sexe:="Hommes"]
  dt[Sexe=="2", Sexe:="Femmes"]
  dt
}

createggplotPyramide <- function(dt){
  ggplot(dt,aes(x = AgeQ80,y=PartPopulationMoyenne)) +
    geom_bar(data = dt, stat = "identity", aes(fill = factor(Sexe)),alpha=0.8, width=0.8) +
    coord_flip() + 
    xlab("") +  ylab("") + theme_ispf()+
    scale_fill_manual(values=ispfPalette)+
    scale_colour_manual(values=ispfPalette)+
    theme_ispf()+
    theme(legend.position = "bottom", legend.direction = "horizontal")
}
