list_files <- list.files(paste0(getwd(), "/data/raw"), pattern = "D0*", full.names = TRUE)
id_list <- list.files(paste0(getwd(), "/data/raw"), pattern = "D0*")
id_list <- substr(id_list, 1, nchar(id_list) - 4)
bird_weights <- read.csv(paste0(getwd(), "/data/raw/Pesos.csv"))
alien <- data.frame(id = factor(), stimuli = factor(), time = double(), oxygen = double(), start_weight = double(), end_weight = double())
familiar <- data.frame(id = factor(), stimuli = factor(), time = double(), oxygen = double(), start_weight = double(), end_weight = double())
for (index in 1:length(list_files)){
  dummie <- read.csv(list_files[index])
  dummie <- dummie[-1,]
  dummie <- dummie[!is.na(dummie$Cantos),]
  dummie$id <- id_list[index]
  dummie$start_weight <- bird_weights$Inter[bird_weights$X == id_list[index]]
  dummie$end_weight <- bird_weights$X.1[bird_weights$X == id_list[index]]
  dummie$start_weight2 <- bird_weights$Intra[bird_weights$X == id_list[index]]
  dummie$end_weight2 <- bird_weights$X.2[bird_weights$X == id_list[index]]
  dummie <- dummie[,c(5:9,1:4)]
  dummie$Cantos[dummie$Cantos == 4] <- 2
  dummie$Cantos[dummie$Cantos == 5] <- 1
  dummie$Muestras <- (dummie$Muestras - 36) * 5
  dummie$Cantos[dummie$Cantos == 1] <- "none"
  dummie$Cantos[dummie$Cantos == 2] <- "random_noise"
  dummie$Cantos[dummie$Cantos == 3] <- "bird_cry"
  colnames(dummie) <- c("id", "start_weight", "end_weight", "start_weight", "end_weight", "stimuli", "time", "oxygen", "oxygen")
  alien <- rbind(alien, dummie[, -c(4, 5, 9)])
  familiar <- rbind(familiar, dummie[, -c(2, 3, 8)])
}
alien$id <- as.factor(alien$id)
alien$stimuli <- as.factor(alien$stimuli)
alien$oxygen <- as.numeric(alien$oxygen)
alien$start_weight <- as.numeric(alien$start_weight)
alien$end_weight <- as.numeric(alien$end_weight)
familiar$id <- as.factor(familiar$id)
familiar$stimuli <- as.factor(familiar$stimuli)
familiar$oxygen <- as.numeric(familiar$oxygen)
familiar$start_weight <- as.numeric(familiar$start_weight)
familiar$end_weight <- as.numeric(familiar$end_weight)
write.csv(alien, paste0(getwd(), "/data/tidy/alien_species.csv"))
write.csv(familiar, paste0(getwd(), "/data/tidy/familiar_species.csv"))
