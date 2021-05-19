library(data.table)
library(dplyr)
library(dbplyr)
library(DBI)

con <- dbConnect(odbc::odbc(),Driver = "SQL Server",Server = "sql",Database = "Demographie")
Pyramide <- tbl(con, in_schema("WEB", "PyramideAges")) %>% collect() 
setDT(Pyramide)
Pyramide <- Pyramide[, .(Annee, AgeQ80, Sexe, PartPopulationMoyenne)]
Pyramide[Sexe==1, PartPopulationMoyenne:=-PartPopulationMoyenne]

con <- dbConnect(odbc::odbc(),Driver = "SQL Server",Server = "sql",Database = "DemographieSubdi")
PyramideSubdi <- tbl(con, in_schema("WEB", "PyramideAges")) %>% collect() 
setDT(PyramideSubdi)
PyramideSubdi <- PyramideSubdi[, .(Annee, Subdivision, AgeQ80, Sexe, PartPopulationMoyenne)]
PyramideSubdi[Sexe==1, PartPopulationMoyenne:=-PartPopulationMoyenne]


fwrite(Pyramide, "input/Pyramide.csv")
fwrite(PyramideSubdi, "input/PyramideSubdi.csv")