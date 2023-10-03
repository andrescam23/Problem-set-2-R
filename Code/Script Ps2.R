#    PROBLEM SET 2  #
# Andres Camilo Vega 201914797 #
# R version 4.3.1 #
rm(list=ls()) 
require (pacman)
p_load(rio, 
       skimr, 
       janitor,
       dplyr,
       data.table,
       tidyverse) 
############### Esta es la preparacion de la sesion#############

### PUNTO 1
#Para este punto se descargaron las bases de datos en cuestion en la carpeta input

###PUNTO 2
#2.1
identification = import(file="Input/Modulo_identificacion/Modulo de identificacion.csv")
location = import(file="Input/Modulo_sitio_ubicacion/Modulo de sitio o ubicacion.csv")
view (identification)
view (location)
#2.2
export(x=identification , file="output/identification.rds")
export(x=location , file="output/location.rds")

###PUNTO 3
#3.1
identification$bussiness_type = ifelse(identification$GRUPOS4 == 1, "Agricultura",
                                ifelse(identification$GRUPOS4 == 2, "Industria manufacturera",
                                ifelse(identification$GRUPOS4 == 3, "Comercio",
                                 ifelse(identification$GRUPOS4 == 4, "Servicios", NA))))
#3.2
location$local = ifelse(test=location$P3053>=6 & location$P3053<=7, yes=1 , no=0)

###PUNTO 4
#4.1
identification_sub = filter(.data = identification, GRUPOS4 == 2)
#4.2
location_sub = select(location ,DIRECTORIO, SECUENCIA_P, SECUENCIA_ENCUESTA, P3054, P469, COD_DEPTO, F_EXP)
#4.3
identification_sub = select(identification_sub ,DIRECTORIO, SECUENCIA_P, SECUENCIA_ENCUESTA, P35, P241, P3032_1, P3032_2, P3032_3, P3033, P3034)

###PUNTO 5
sub_id_loc <- left_join(location_sub, identification_sub, by = c("DIRECTORIO", "SECUENCIA_P", "SECUENCIA_ENCUESTA"))
##Este ultimo punto me toco buscarlo en internet porque no encontre el contenido de la clase 7


###EXPORTAR LOS RESULTADOS FINALES###
export(x=identification_sub , file="output/identification_sub.rds")
export(x=location_sub , file="output/location_sub.rds")
export(x=sub_id_loc , file="output/sub_identification_location.rds")
