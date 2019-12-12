
#install.packages("dplyr")

#install.packages("sqldf")
#Actalizacion de paquetes 
#update.packages()

library(readr)
library(dplyr)#manejo de ficheros
library(purrr)
library(tidyr)
library(stringr)
library(tidytext)
library(tm)
library(colorspace)
library(plotly)
library(sqldf)


carpeta = "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp"
carpeta_base = paste(carpeta,"Bases",sep="/")
nombres = dir(carpeta_base)
nombres = as.data.frame(nombres)

Sys.setenv("plotly_username"="observatorio2019")
Sys.setenv("plotly_api_key"="BObHnm3fSEoIg5SCk3a2")

pat ="(RT|via)(((?:\\b\\W*|)@\\w+)+)|,|:|(https|http)://t.co/[A-Za-z\\d]+|&amp;|http\\w*|@\\w+|(\\w+\\.|)\\w+\\.\\w+(/\\w+)*"
patref ="@[A-Za-z0-9]*[^\\s:_.<]"
patHashtag="#[A-Za-z0-9????]*"

ubicacion_resultados <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados"
ubicacion_resultadosGenerales <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/ResultadosGenerales"
ubicacion_conversaciongriterio <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/ConversacionGriterio"


ubicacion_evolucion <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/Evolucion"
ubicacion_comunidad  <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/Comunidad"
ubicacion_categorizacion <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/Categorizacion"
ubicacion_CaracTecnicas <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/CaracteristicasTecnicas"
ubicacion_determinantes <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/DeterminantesSemanticos"

ubicacion_histograma <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/Evolucion/Histograma"
ubicacion_reproduccion <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/Evolucion/Reproduccion-Produccion-Iteracion"

ubicacion_nube <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/DeterminantesSemanticos/Nube"
ubicacion_bigrama <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/DeterminantesSemanticos/Bigrama"

ubicacion_referentes <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/Comunidad/Referentes"
ubicacion_influenciadores <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/Comunidad/Influenciadores"
ubicacion_Movilizadores <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/Comunidad/Movilizadores"

#Carpeta efectos y exitos (Falta el item de categorizacion)

ubicacion_aceptacion <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/Categorizacion/Aceptacion"
ubicacion_viralizacion <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/Categorizacion/Viralizacion"

ubicacion_caracteres <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/CaracteristicasTecnicas/Caracteres"
ubicacion_multimedia <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/CaracteristicasTecnicas/Multimedia"
ubicacion_dispositivos <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/CaracteristicasTecnicas/Dispositivos"
ubicacion_PorcentajeGeo <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/CaracteristicasTecnicas/PorcentajeGeoreferencia"
ubicacion_RankingGeo <- "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/CaracteristicasTecnicas/RankingGeoreferencia"

if(dir.exists(paste(carpeta, "Resultados", sep = "/")))
{}else
{
  dir.create(paste(carpeta, "Resultados", sep = "/"))
 
  #If para crear los directorios dentro de la carpeta Resultados
  if((dir.exists(paste( ubicacion_resultados, "Evolucion", sep = "/")))
     &(dir.exists(paste( ubicacion_resultados, "Comunidad", sep = "/")))
     &(dir.exists(paste( ubicacion_resultados, "Categorizacion", sep = "/")))
     &(dir.exists(paste( ubicacion_resultados, "CaracteristicasTecnicas", sep = "/")))
     &(dir.exists(paste( ubicacion_resultados, "DeterminantesSemanticos", sep = "/")))
     &(dir.exists(paste( ubicacion_resultados, "ConversacionGriterio", sep = "/")))
     &(dir.exists(paste( ubicacion_resultados, "ResultadosGenerales", sep = "/")))
     )
    
  {}else
  {
    dir.create(paste( ubicacion_resultados, "Evolucion", sep = "/"))
    dir.create(paste( ubicacion_resultados, "Comunidad", sep = "/"))
    dir.create(paste( ubicacion_resultados, "Categorizacion", sep = "/"))
    dir.create(paste( ubicacion_resultados, "CaracteristicasTecnicas", sep = "/"))
    dir.create(paste( ubicacion_resultados, "DeterminantesSemanticos", sep = "/"))
    dir.create(paste( ubicacion_resultados, "ConversacionGriterio", sep = "/"))
    dir.create(paste( ubicacion_resultados, "ResultadosGenerales", sep = "/"))
    
    #Variables con las rutas de las SubDirectorios

    
    #if de las carpetas EVOLUCION Y SENTIDO
    if((dir.exists(paste( ubicacion_evolucion, "Histograma", sep = "/")))
       & (dir.exists(paste( ubicacion_evolucion, "Grafico Torta", sep = "/"))))
    {}else
    {
      dir.create(paste( ubicacion_evolucion, "Histograma", sep = "/"))
      dir.create(paste( ubicacion_evolucion, "Grafico Torta", sep = "/"))
    }
    
    # if de las carpetas DETERMINANTES SEMANTICOS
    if((dir.exists(paste( ubicacion_determinantes, "Nube", sep = "/")))
       & (dir.exists(paste( ubicacion_determinantes, "Bigrama", sep = "/"))))
    {}else
    {
      dir.create(paste( ubicacion_determinantes, "Nube", sep = "/"))
      dir.create(paste( ubicacion_determinantes, "Bigrama", sep = "/"))

    }
    # if de las carpetas COMUNIDADES 
    if((dir.exists(paste(  ubicacion_comunidad, "Referentes", sep = "/")))
       & (dir.exists(paste(  ubicacion_comunidad, "Influenciadores", sep = "/")))
       & (dir.exists(paste(  ubicacion_comunidad, "Movilizadores", sep = "/"))))
    {}else
    {
      dir.create(paste(  ubicacion_comunidad, "Referentes", sep = "/"))
      dir.create(paste(  ubicacion_comunidad, "Influenciadores", sep = "/"))
      dir.create(paste(  ubicacion_comunidad, "Movilizadores", sep = "/"))
    
    }
    # if de las carpetas CATEGORIZACION 
    if((dir.exists(paste( ubicacion_categorizacion, "Aceptacion", sep = "/")))
       & (dir.exists(paste( ubicacion_categorizacion, "Viralizacion", sep = "/"))))
    {}else
    {
      dir.create(paste(ubicacion_categorizacion, "Aceptacion", sep = "/"))
      dir.create(paste(ubicacion_categorizacion, "Viralizacion", sep = "/"))
    }
    
    # if de las carpetas CARACTERISTICAS TECNICAS 
    if((dir.exists(paste(ubicacion_CaracTecnicas, "Caracteres", sep = "/")))
       & (dir.exists(paste(ubicacion_CaracTecnicas, "Multimedia", sep = "/")))
       & (dir.exists(paste(ubicacion_CaracTecnicas, "Dispositivos", sep = "/")))
       & (dir.exists(paste(ubicacion_CaracTecnicas, "PorcentajeGeoreferencia", sep = "/")))
       & (dir.exists(paste(ubicacion_CaracTecnicas, "RankingGeoreferencia", sep = "/")))
    )
    {}else
    {
      dir.create(paste(ubicacion_CaracTecnicas, "Caracteres", sep = "/"))
      dir.create(paste(ubicacion_CaracTecnicas, "Multimedia", sep = "/"))
      dir.create(paste(ubicacion_CaracTecnicas, "Dispositivos", sep = "/"))
      dir.create(paste(ubicacion_CaracTecnicas, "PorcentajeGeoreferencia", sep = "/"))
      dir.create(paste(ubicacion_CaracTecnicas, "RankingGeoreferencia", sep = "/"))
    
    }
  }
}


i = 1
numArchivos = nrow(nombres)


while(i <= numArchivos)
{

  nombre = substr(toString(nombres$nombres[i]),1,(str_length(nombres$nombres[i])-4))
  nombre_carpeta = paste(carpeta,"Resultados",sep = "/")
  archivo_temporal = paste(carpeta_base,toString(nombres$nombres[i]),sep="/")
  nombreResultado = nombres$nombres[i]
  
  
  #--- Arreglo de los tildes ---#
  consulta <-read.csv(archivo_temporal,header = TRUE,sep = ",",encoding = "UTF-8")
  #--- Arreglo de los tildes ---#
  consulta$text=gsub("<f1>","?",consulta$text)#ñ
  consulta$text=gsub("<e1>","?",consulta$text)#a
  consulta$text=gsub("<c1>","?",consulta$text)#A
  consulta$text=gsub("<e9>","?",consulta$text)#e
  consulta$text=gsub("<c9>","?",consulta$text)#E
  consulta$text=gsub("<ed>","?",consulta$text)#i
  consulta$text=gsub("<cd>","?",consulta$text)#I
  consulta$text=gsub("<f3>","?",consulta$text)#o
  consulta$text=gsub("<d3>","?",consulta$text)#O
  consulta$text=gsub("<fa>","?",consulta$text)#u
  consulta$text=gsub("<da>","?",consulta$text)#U
  consulta$text=gsub("<40>","?",consulta$text)#@
  
  #Archivos 
  archivolink = paste("porcentajelink",nombreResultado,".csv")
  archivoRanking = paste("ranking",nombreResultado,".csv")
  archivoCaracteres = paste("caracteres",nombreResultado,".csv")
  archivoAceptacion = paste("aceptacion",nombreResultado,".csv")
  archivoAceptacionTweet = paste("aceptacionTweet",nombreResultado,".csv")
  archivoViralizacion = paste("viralizacion",nombreResultado,".csv")
  archivoViralizacionTweet = paste("viralizacionTweet",nombreResultado,".csv")
  archivoReferentes = paste("referentes",nombreResultado,".csv")
  archivoInfluenciadores = paste("influenciadores",nombreResultado,".csv")
  archivoGeoreferencia = paste("georeferencia",nombreResultado,".csv")
  archivoRankingPaises = paste("ranking_paises",nombreResultado,".csv")
  archivoFotos = paste("cantidad_fotos", nombreResultado,".csv")
  archivoUnionDispositivos = paste("consulta_union",nombreResultado,".csv")
  
  aux <- read.csv(archivo_temporal,header = TRUE,sep = ",",encoding = "UTF-7")
  aux <- as.data.frame(aux)
  
  temporal <- sqldf("SELECT created_at,screen_name,text FROM aux")
  tempora_nube <- temporal
  
  
  total_filas <- "SELECT COUNT(user_id) FROM aux"
  total_filas <- sqldf(total_filas)
  
  
  # --- Griterio y conversacion --- #

  
  # --- Evoluci?n y Sentido --- #
  # --- Histograma --- #
  histograma <- sqldf('select  substr(created_at,1,10) FECHA,count(substr(created_at,1,10)) CANTIDAD  
                      from aux 
                      group by substr(created_at,1,10) 
                      ORDER BY substr(created_at,1,10) 
                      DESC')
  
  write.csv(histograma,file = paste(ubicacion_histograma,"histogramax1dia.csv",sep = "/"),row.names=FALSE)
  write.csv(histograma,file = paste(ubicacion_resultadosGenerales,"histogramax1dia.csv",sep = "/"),row.names=FALSE)
  
  # --- Reproducción, Producción, Interacción --- #
  consulta_total_datos = "SELECT COUNT(user_id) totalDatos FROM aux"
  total_datos = sqldf(consulta_total_datos)
  # ===================================================== #
  #Para encontrar retweet cuya columna tiene valores boolean, si es TRUE se pone = 1 y si es FALSE se pone = 0.
  consulta_RT = "SELECT * FROM aux WHERE is_retweet = 1"
  busqueda_RT = sqldf(consulta_RT)
  
  consulta_RTAI = "SELECT * FROM busqueda_RT WHERE text NOT LIKE '@%' AND text NOT LIKE 'RT%'"
  busqueda_RTAI = sqldf(consulta_RTAI)
  
  consulta_RTNAI = "SELECT * FROM busqueda_RT WHERE text NOT LIKE '@%' AND text NOT LIKE 'RT%' AND text NOT LIKE '%@%'"
  busqueda_RTNAI = sqldf(consulta_RTNAI)
  
  consulta_total_RT = "SELECT COUNT(user_id) Retweets FROM busqueda_RT"
  total_RT = sqldf(consulta_total_RT)
  
  consulta_total_RTAI = "SELECT COUNT(user_id) RetweetsAI FROM busqueda_RTAI"
  total_RTAI = sqldf(consulta_total_RTAI)
  
  consulta_total_RTNAI = "SELECT COUNT(user_id) RetweetsNAI FROM busqueda_RTNAI"
  total_RTNAI = sqldf(consulta_total_RTNAI)
  # ===================================================== #
  consulta_AA = "SELECT * FROM aux WHERE text LIKE '@%'"
  busqueda_AA = sqldf(consulta_AA)
  
  consulta_NART = "SELECT * FROM aux WHERE text NOT LIKE '@%' AND text NOT LIKE 'RT%'"
  busqueda_NART = sqldf(consulta_NART)
  
  consulta_total_AA = "SELECT COUNT(user_id) Arroba FROM busqueda_AA"
  total_AA = sqldf(consulta_total_AA)
  
  consulta_total_NART = "SELECT COUNT(user_id) noArrRet FROM busqueda_NART"
  total_NART = sqldf(consulta_total_NART)
  # ===================================================== #
  
  # Grafico Torta #
  consulta_total = "SELECT * FROM total_AA, total_NART, total_RT, total_RTAI, total_RTNAI, total_datos"
  total = sqldf(consulta_total)
  
  #Valores para el grafico de Torta.
  AA = total$Arroba
  NART = total$noArrRet
  RT = total$Retweets
  RTAI = total$RetweetsAI
  RTNAI = total$RetweetsNAI
  N = total$totalDatos
  
  #Porcentaje para el gr?fico.
  RIP = matrix(c(trunc((AA/N)*100*10^2)/10^2,trunc((NART/N)*100*10^2)/10^2,trunc((RT/N)*100*10^2)/10^2,"Interacci?n","Producci?n","Reproducci?n"),ncol = 2)
  colnames(RIP) = c("Porcentaje","Tipo")
  RIP = as.data.frame(RIP)
  
  data <- RIP[,c('Porcentaje', 'Tipo')]
  
  p <- plot_ly(data, labels = ~Tipo, values = ~Porcentaje, type = 'pie') %>%
    layout(title = 'Producci?n, Interacci?n y Reproducci?n',
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  p
  
  plotly_IMAGE(p, format = "png", out_file = "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/Evolucion/Grafico Torta/ReproduccionInteraccionProduccion.png")
  
  # --- Determinantes Semanticos --- #
  # --- Nube --- # Nueva nube
  conectores<-read.csv(paste(carpeta,"conectores.csv",sep = "/"), header = FALSE)
  tempora_nube<-sqldf("select text from consulta")
  tempora_nube<-mutate(tempora_nube,text = str_replace_all(text,pat, ""))
  lis<-unnest_tokens(tempora_nube,word, text, token="ngrams",n=1 )
  nube<-count(lis,word,sort=TRUE)
  
  nube<-as.data.frame(nube)
  conectores<-as.data.frame(conectores)
  
  consulta_conectores=paste0(paste("select * from nube where word!=",conectores$V1[1],sep = "'" ),"' ")
  for(j in 2:length(conectores[,1]))
  {
    consulta_conectores=paste0(paste(consulta_conectores,conectores$V1[j],sep = " and word!='"),"'")
  }
  nube=sqldf(consulta_conectores)
  
  #write.csv(nube, file = paste(nombre_carpeta,"nube.csv",sep = "/"),row.names=FALSE)
  write.csv(nube, file = paste(ubicacion_nube,"nube.csv",sep = "/"),row.names=FALSE)

    # --- Bigrama --- #
  consulta=sqldf("select text from consulta")
  lol=consulta %>%
    
    mutate(text = str_replace_all(text,pat, "")) %>%
    unnest_tokens(word, text, token="ngrams",n=2 ) %>%
    count(word, sort=TRUE) %>% 
    separate(word, c("word1", "word2"), sep = " ") %>% 
    filter(!word1 %in% c(stopwords("es"),"q","d","t","cc","x","html","posted","just","online","streaming","false","na")) %>% 
    filter(!word2 %in% c(stopwords("es"),"q","d","t","cc","x","html","posted","just","online","streaming","false","na")) %>%
    filter(!str_detect(word1,"\\d+")) %>% 
    filter(!str_detect(word2,"\\d+")) %>% 
    unite(bigrama, word1, word2, sep = " ") %>%
    mutate(bigrama=reorder(bigrama,n)) %>% 
    top_n(13,n) %>%
    ungroup()
  
  # --- Guardar Bigrama --- #
  
    data_bigrama=aux %>%
    mutate(text = str_replace_all(text,pat, "")) %>%
    unnest_tokens(word, text, token="ngrams",n=2 ) %>%
    count(word, sort=TRUE) %>% 
    separate(word, c("word1", "word2"), sep = " ") %>% 
    filter(!word1 %in% c(stopwords("es"),"q","d","t","cc","x","html","posted","just","online","streaming","false","na")) %>% 
    filter(!word2 %in% c(stopwords("es"),"q","d","t","cc","x","html","posted","just","online","streaming","false","na")) %>%
    filter(!str_detect(word1,"\\d+")) %>% 
    filter(!str_detect(word2,"\\d+")) %>% 
    unite(bigrama, word1, word2, sep = " ") %>%
    mutate(bigrama=reorder(bigrama,n)) %>% 
    ungroup()
    write.csv(data_bigrama, file = paste(ubicacion_bigrama,"data_bigrama.csv",sep = "/"))
    #write.csv(data_bigrama, file = paste(ubicacion_resultadosGenerales,"data_bigramaA.csv",sep = "/"))
  
  
  # --- Comunidades --- #
  # --- Referentes --- #
  referentes = "SELECT Distinct(mentions_screen_name) as Menciones FROM aux"
  referentes = sqldf(referentes)
  
  write.csv(referentes, file = paste(ubicacion_referentes,archivoReferentes,sep = "/"),row.names=FALSE)
  write.csv(referentes, file = paste(ubicacion_resultadosGenerales,archivoReferentes,sep = "/"),row.names=FALSE)
  
  # --- Influenciadores --- #
  influenciadores = "select retweet_screen_name USUARIO,count(retweet_screen_name) CANTIDAD from aux 
  where is_retweet 
  group by retweet_screen_name 
  order by 
  count(retweet_screen_name) desc"
  influenciadores = sqldf(influenciadores)
  
  write.csv(influenciadores,file = paste(ubicacion_influenciadores,archivoInfluenciadores,sep = "/"),row.names = FALSE)
  write.csv(influenciadores,file = paste(ubicacion_resultadosGenerales,archivoInfluenciadores,sep = "/"),row.names = FALSE)
 
   # --- Movilizadores --- #
  archivoMovi = paste('resumen',nombreResultado,'.csv')
  archivoRanking = paste('ranking',nombreResultado,'.csv')
  
  filas = sqldf("SELECT COUNT(DISTINCT(status_id)) Total FROM aux")
  total = filas$Total
  
  all_words <- unlist(regmatches(aux$text, gregexpr(patHashtag, aux$text)))
  all_words <- str_replace_all(all_words,'#','')
  all_words <- as.data.frame(all_words)
  
  hashtags <- sqldf('SELECT all_words Influenciadores, COUNT(all_words) Suma
                    FROM all_words GROUP BY Influenciadores ORDER BY suma DESC')
  hashtagx <- sqldf('SELECT * FROM hashtags WHERE Influenciadores NOT LIKE ""')
  filashashtag = sqldf('SELECT COUNT(Influenciadores) Total FROM hashtagx')
  totalhashtags = filashashtag$Total
  porcentajeHashtag = trunc((totalhashtags/total)*100*10^2)/10^2
  
  
  ranking = sqldf('SELECT Influenciadores, Suma FROM hashtagx LIMIT 55')
  
  tabla = matrix(c(total,totalhashtags, porcentajeHashtag,
                   'Total Filas','Total Hashtags','% Hashgtags'), ncol = 2)
  colnames(tabla) = c('Valores','Datos')
  tabla = as.data.frame(tabla)
  
  write.csv(tabla, file = paste(ubicacion_Movilizadores,archivoMovi,sep = "/"),row.names=FALSE)
  write.csv(ranking, file = paste(ubicacion_Movilizadores, archivoRanking, sep = "/"), row.names = FALSE)
  write.csv(tabla, file = paste(ubicacion_resultadosGenerales,archivoMovi,sep = "/"),row.names=FALSE)
  write.csv(ranking, file = paste(ubicacion_resultadosGenerales, archivoRanking, sep = "/"), row.names = FALSE)
  
  
  # --- Contenidos multimedia --- #
  consulta_ranking <- "SELECT urls_url, COUNT(urls_url) n
                      FROM aux WHERE urls_url NOT LIKE ''
                      GROUP BY urls_url
                      ORDER BY n DESC
                      LIMIT 10"
  
  columnas_link = "SELECT count(urls_url) as Porcentaje FROM aux"
  cantidad_fotos = "SELECT COUNT(media_url) as '% de fotos' FROM aux"
  
  consulta_ranking <- sqldf(consulta_ranking)
  columnas_links <- sqldf(columnas_link)
  porcentaje_links = (columnas_links/total_filas)*100
  cantidad_fotos = sqldf(cantidad_fotos) 
  fotos = round((cantidad_fotos/total_filas)*100,2)
  
  write.csv(ranking,file = paste(ubicacion_multimedia,archivoRanking,sep = "/"),row.names = FALSE)
  write.csv(porcentaje_links, file=paste(ubicacion_multimedia,archivolink,sep="/"),row.names = FALSE)
  write.csv(fotos, file=paste(ubicacion_multimedia,archivoFotos,sep="/"),row.names = FALSE)
  write.csv(ranking,file = paste(ubicacion_resultadosGenerales,archivoRanking,sep = "/"),row.names = FALSE)
  write.csv(porcentaje_links, file=paste(ubicacion_resultadosGenerales,archivolink,sep="/"),row.names = FALSE)
  write.csv(fotos, file=paste(ubicacion_resultadosGenerales,archivoFotos,sep="/"),row.names = FALSE)
  
  
  
  # --- Efectos y exitos --- #
  # --- Categorizacion --- #
  consultaCategorizacion <- read.csv(archivo_temporal,header = TRUE,sep = ",",encoding = "UTF-8")
  respuesta <- sqldf('select "screen_name","user_id","status_id","text", "retweet_text","is_retweet"  from 	consultaCategorizacion ')
  
  if(length(respuesta[,1])>=1000)
  {
    respuesta <- respuesta[1:1000,]
    archivo_final<-"D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados"
    write.csv(respuesta,file = paste(archivo_final,nombres$nombres[i],sep = "/"),row.names = FALSE)
    
  }else{
    respuesta <- respuesta[1:length(respuesta[,1]),]
    archivo_final<-"D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados"
    write.csv(respuesta,file = paste(archivo_final,nombres$nombres[i],sep = "/"),row.names = FALSE)
  }
  
  
  # --- Aceptacion --- #
  aceptacion = "SELECT user_id as ID_usuario,
                max(favorite_count) as Max_favoritos,
                min(favorite_count) as Min_favoritos,
                avg(favorite_count) as Promedio FROM aux"
                
  aceptacionTweet = "SELECT  user_id as ID_usuario,
                      max(favorite_count) as Max_favoritos,
                      text as Tweet FROM aux"
                      
  aceptacion = sqldf(aceptacion)
  aceptacionTweet = sqldf(aceptacionTweet)
  
  write.csv(aceptacion, file = paste(ubicacion_aceptacion,archivoAceptacion,sep="/" ),row.names = FALSE)
  write.csv(aceptacionTweet, file = paste(ubicacion_aceptacion,archivoAceptacionTweet,sep="/" ),row.names = FALSE)
  write.csv(aceptacion, file = paste(ubicacion_resultadosGenerales,archivoAceptacion,sep="/" ),row.names = FALSE)
  write.csv(aceptacionTweet, file = paste(ubicacion_resultadosGenerales,archivoAceptacionTweet,sep="/" ),row.names = FALSE)
  
  # --- Viralizacion --- #
  viralizacionTweet = "SELECT user_id as ID_usuario,
                        max(retweet_count) as Max_retweet,
                        text as Tweet
                        FROM aux"
  
  viralizacion = "SELECT user_id as ID_usuario,
                  max(retweet_count) as Max_retweet,
                  min(retweet_count) as Min_retweet,
                  avg(retweet_count) as Promedio
                  FROM aux"
  
  viralizacion = sqldf(viralizacion)
  viralizacionTweet = sqldf(viralizacionTweet)
  
  write.csv(viralizacion, file = paste(ubicacion_viralizacion,archivoViralizacion,sep="/" ),row.names = FALSE)
  write.csv(viralizacionTweet, file = paste(ubicacion_viralizacion,archivoViralizacionTweet,sep="/" ),row.names = FALSE)
  write.csv(viralizacion, file = paste(ubicacion_resultadosGenerales,archivoViralizacion,sep="/" ),row.names = FALSE)
  write.csv(viralizacionTweet, file = paste(ubicacion_resultadosGenerales,archivoViralizacionTweet,sep="/" ),row.names = FALSE)
  
  # --- Caracteristicas Tecnicas --- #
  # ---  + - x Caracteres  --- #
  cantidadCaracteres = "SELECT max(display_text_width) as Max_caracteres,
                        min(display_text_width) as Min_caracteres, 
                        avg(display_text_width) as Promedio FROM aux"
  cantidadCaracteres = sqldf(cantidadCaracteres)
  write.csv(cantidadCaracteres, file = paste(ubicacion_caracteres,archivoCaracteres,sep="/"),row.names = FALSE)
  write.csv(cantidadCaracteres, file = paste(ubicacion_resultadosGenerales,archivoCaracteres,sep="/"),row.names = FALSE)
  # --- Contenidos multimedia --- #
  
  # ---  Categorizacion por dispositivo --- #
  consulta_dispositivos = "SELECT COUNT(source) Total FROM aux"
  dispositivos = sqldf(consulta_dispositivos)
  
  dispositivos_android = "SELECT COUNT(source) Androids FROM aux WHERE source LIKE '%Android'"
  androids = sqldf(dispositivos_android)
  
  consulta_iphone = "SELECT COUNT(source) Iphone FROM aux WHERE source LIKE '%iPhone'"
  iphone = sqldf(consulta_iphone)
  
  consulta_web = "SELECT COUNT(source) Web FROM aux WHERE source LIKE '%Web%'"
  web = sqldf(consulta_web)
  
  consulta_otros = "SELECT COUNT(source) Otros FROM aux WHERE source NOT LIKE '%Android' AND source NOT LIKE '%iPhone' AND source NOT LIKE '%Web%'"
  otros = sqldf(consulta_otros)
  
  consulta_union = "SELECT * FROM androids, iphone, web, otros, dispositivos"
  consulta_union = sqldf(consulta_union)
  todos = consulta_union
  
  write.csv(consulta_union, file = paste(ubicacion_dispositivos,archivoUnionDispositivos,sep = "/"),row.names = FALSE)
  write.csv(consulta_union, file = paste(ubicacion_resultadosGenerales,archivoUnionDispositivos,sep = "/"),row.names = FALSE)
  
  A = todos$Androids
  I = todos$Iphone
  W = todos$Web
  O = todos$Otros
  TT = todos$Total
  
  porcentaje = matrix(c(trunc((A/TT)*100*10^2)/10^2,trunc((I/TT)*100*10^2)/10^2,trunc((W/TT)*100*10^2)/10^2,trunc((O/TT)*100*10^2)/10^2,'Android','Iphone','Web','Otros'),ncol = 2)
  colnames(porcentaje) = c('Porcentaje','Dispositivos')
  porcentaje = as.data.frame(porcentaje)
  
  data <- porcentaje[,c('Dispositivos', 'Porcentaje')]
  #
  p <- plot_ly(data, labels = ~Dispositivos, values = ~Porcentaje, type = 'pie') %>%
    layout(title = 'Porcentaje de Dispositivos',
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  
  
  plotly_IMAGE(p, format = "png", out_file = "D:/Users/interbarometro/Desktop/ProgramasR/TodoEnUnoManzanapp/Resultados/CaracteristicasTecnicas/Dispositivos/PorcentajeDispositivos.png")
  
  #--- Georeferencia ---#
  
  georeferencia <- "SELECT count(Location) as Porcentaje_Location FROM aux "
  
  # ---  Ranking de los 5 lugares mas mencionados --- #
  ranking_paises <- "SELECT count(Location) Cantidad, Location as Paises
                    FROM aux WHERE Paises NOT LIKE ''
                    GROUP BY Paises 
                    ORDER BY Cantidad DESC
                    LIMIT 10"
  
  georeferencia <- sqldf(georeferencia)
  porcentaje_georeferencia <- round((georeferencia/total_filas)*100,2)
  ranking_paises <- sqldf(ranking_paises)
  
  write.csv(porcentaje_georeferencia , file = paste(ubicacion_PorcentajeGeo,archivoGeoreferencia,sep = "/"),row.names = FALSE)
  write.csv(ranking_paises, file = paste(ubicacion_RankingGeo,archivoRankingPaises,sep="/" ),row.names = FALSE)
  #write.csv(porcentaje_georeferencia , file = paste(ubicacion_resultadosGenerales,archivoGeoreferencia,sep = "/"),row.names = FALSE)
  #write.csv(ranking_paises, file = paste(ubicacion_resultadosGenerales,archivoRankingPaises,sep="/" ),row.names = FALSE)
  
  
  i = i + 1
  
}





