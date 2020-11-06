list_files <- list.files(paste0(getwd(), "/data/raw"), pattern = "*.csv", full.names = TRUE)
id_list <- list.files(paste0(getwd(), "/data/raw"), pattern = "*.csv")
id_list <- substr(id_list, 1, nchar(id_list) - 4)
alien <- data.frame(id = factor(), stimuli = factor(), time = double(), oxygen = double())
familiar <- data.frame(id = factor(), stimuli = factor(), time = double(), oxygen = double())
for (index in 1:length(list_files)){
  dummie <- read.csv(list_files[index])
  dummie <- dummie[-1,]
  dummie$id <- id_list[index]
  dummie <- dummie[,c(5,1:4)]
  dummie$Cantos[dummie$Cantos == 4] <- 2
  dummie$Cantos[dummie$Cantos == 5] <- 1
  dummie$Muestras <- (dummie$Muestras - 36) * 5
  dummie$Cantos[dummie$Cantos == 1] <- "none"
  dummie$Cantos[dummie$Cantos == 2] <- "random_noise"
  dummie$Cantos[dummie$Cantos == 3] <- "bird_cry"
  colnames(dummie) <- c("id", "stimuli", "time", "oxygen", "oxygen")
  alien <- rbind(alien, dummie[, -5])
  familiar <- rbind(familiar, dummie[, -4])
}
alien$id <- as.factor(alien$id)
alien$stimuli <- as.factor(alien$stimuli)
alien$oxygen <- as.numeric(alien$oxygen)
familiar$id <- as.factor(familiar$id)
familiar$stimuli <- as.factor(familiar$stimuli)
familiar$oxygen <- as.numeric(familiar$oxygen)
write.csv(alien, paste0(getwd(), "/data/tidy/alien_species.csv"))
write.csv(familiar, paste0(getwd(), "/data/tidy/familiar_species.csv"))
