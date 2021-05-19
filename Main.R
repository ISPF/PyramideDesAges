source("src/functions.R")

Pyramide      <- fread("input/Pyramide.csv")
PyramideSubdi <- fread("input/PyramideSubdi.csv")

Pyramide      <- decorateDataTable(Pyramide)
PyramideSubdi <- decorateDataTable(PyramideSubdi)

PyramidePlot <- createggplotPyramide(Pyramide)+
  transition_states(Annee, transition_length = 1, state_length = 1,  wrap = TRUE) +
  ggtitle("Année : {closest_state}")

PyramideSubdiPlot <- createggplotPyramide(PyramideSubdi)+
  facet_wrap(vars(Subdivision))+
  transition_states(Annee, transition_length = 1, state_length = 1, wrap = TRUE) +
  ggtitle("Année : {closest_state}")

animate(PyramidePlot,      nframes = 100, fps = 20, renderer=gifski_renderer("output/Pyramide.gif"))
animate(PyramideSubdiPlot, nframes = 100, fps = 20, renderer=gifski_renderer("output/PyramideSubdi.gif"))
