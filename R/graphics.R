library(data.table)
library(ggplot2)
alien <- read.csv(paste0(getwd(), "/data/tidy/alien_species.csv"))
familiar <- read.csv(paste0(getwd(), "/data/tidy/familiar_species.csv"))
time_cuts <- c(61, 181, 301, 421) #index for first time step of new stimulus
alien$event[alien$time < alien$time[time_cuts[1]]] <- 1
alien$event[alien$time < alien$time[time_cuts[2]] & alien$time >= alien$time[time_cuts[1]]] <- 2
alien$event[alien$time < alien$time[time_cuts[3]] & alien$time >= alien$time[time_cuts[2]]] <- 3
alien$event[alien$time < alien$time[time_cuts[4]] & alien$time >= alien$time[time_cuts[3]]] <- 4
alien$event[alien$time <= alien$time[480] & alien$time >= alien$time[time_cuts[4]]] <- 5
alien$event <- as.factor(alien$event)
familiar$event <- alien$event
alien <- as.data.table(alien)
familiar <- as.data.table(familiar)
#Box Plots
p1 <- ggplot(alien, aes(x = event, y = oxygen/start_weight, fill = stimuli)) +
  geom_boxplot() +
  labs(x = "Event", y = "Oxygen consumption per weight in ml/gr", fill = "Stimuli") +
  theme_bw() +
  scale_fill_manual(values=c("Bird Cry" = "#1b9e77", "#d95f02", "#7570b3"), labels = c("Alien Brid Cry", "None", "Random Noise")) +
  scale_y_continuous(limits = c(0, 0.2), expand = c(0, 0)) +
  theme(panel.grid.major.x = element_blank(), axis.text = element_text(size = 12), axis.title = element_text(size = 18))
ggsave(paste0(getwd(), "/graphs/boxplot_alien.pdf"), p1)
p2 <- ggplot(familiar, aes(x = event, y = oxygen/start_weight, fill = stimuli)) +
  geom_boxplot() +
  labs(x = "Event", y = "Oxygen consumption per weight in ml/gr", fill = "Stimuli") +
  theme_bw() +
  scale_fill_manual(values=c("Bird Cry" = "#1b9e77", "#d95f02", "#7570b3"), labels = c("Familiar Brid Cry", "None", "Random Noise")) +
  scale_y_continuous(limits = c(0, 0.2), expand = c(0, 0)) +
  theme(panel.grid.major.x = element_blank(), axis.text = element_text(size = 12), axis.title = element_text(size = 18))
ggsave(paste0(getwd(), "/graphs/boxplot_familiar.pdf"), p2)
#Point + Line
alien$mean_o <- ave(alien$oxygen/alien$start_weight, alien$time)
familiar$mean_o <- ave(familiar$oxygen/familiar$start_weight, familiar$time)

p3 <- ggplot(alien, aes(x = time, y = mean_o)) +
  geom_point(size = 2, color = "#a6cee3") +
  geom_smooth(size = 2, color = "#1f78b4") +
  geom_vline(xintercept = alien$time[time_cuts], size = 1, linetype = "dashed") +
  labs(x = "Time in s", y = "Oxygen consumption per weight in ml/gr", fill = "Stimuli", title = "Alien species") +
  theme_bw() +
  scale_y_continuous(limits = c(0.1, 0.125), expand = c(0, 0)) +
  scale_x_continuous(limits = c(0, 2400), expand = c(0, 0)) +
  theme(panel.grid.major.x = element_blank(), axis.text = element_text(size = 12), axis.title = element_text(size = 18), plot.title = element_text(size = 24))
ggsave(paste0(getwd(), "/graphs/o2_vs_t_alien.pdf"), p3)
p4 <- ggplot(familiar, aes(x = time, y = mean_o)) +
  geom_point(size = 2, color = "#a6cee3") +
  geom_smooth(size = 2, color = "#1f78b4") +
  geom_vline(xintercept = alien$time[time_cuts], size = 1, linetype = "dashed") +
  labs(x = "Time in s", y = "Oxygen consumption per weight in ml/gr", fill = "Stimuli", title = "Familiar species") +
  theme_bw() +
  scale_y_continuous(limits = c(0.1, 0.125), expand = c(0, 0)) +
  scale_x_continuous(limits = c(0, 2400), expand = c(0, 0)) +
  theme(panel.grid.major.x = element_blank(), axis.text = element_text(size = 12), axis.title = element_text(size = 18), plot.title = element_text(size = 24))
ggsave(paste0(getwd(), "/graphs/o2_vs_t_familiar.pdf"), p4)
#Line + Line
p5 <- ggplot(alien, aes(x = time, y = mean_o)) +
  geom_line(size = 2, color = "#a6cee3") +
  geom_smooth(size = 2, color = "#1f78b4") +
  geom_vline(xintercept = alien$time[time_cuts], size = 1, linetype = "dashed") +
  labs(x = "Time in s", y = "Oxygen consumption per weight in ml/gr", fill = "Stimuli", title = "Alien species") +
  theme_bw() +
  scale_y_continuous(limits = c(0.1, 0.125), expand = c(0, 0)) +
  scale_x_continuous(limits = c(0, 2400), expand = c(0, 0)) +
  theme(panel.grid.major.x = element_blank(), axis.text = element_text(size = 12), axis.title = element_text(size = 18), plot.title = element_text(size = 24))
ggsave(paste0(getwd(), "/graphs/o2_vs_t_alien2.pdf"), p5)
p6 <- ggplot(familiar, aes(x = time, y = mean_o)) +
  geom_line(size = 2, color = "#a6cee3") +
  geom_smooth(size = 2, color = "#1f78b4") +
  geom_vline(xintercept = alien$time[time_cuts], size = 1, linetype = "dashed") +
  labs(x = "Time in s", y = "Oxygen consumption per weight in ml/gr", fill = "Stimuli", title = "Familiar species") +
  theme_bw() +
  scale_y_continuous(limits = c(0.1, 0.125), expand = c(0, 0)) +
  scale_x_continuous(limits = c(0, 2400), expand = c(0, 0)) +
  theme(panel.grid.major.x = element_blank(), axis.text = element_text(size = 12), axis.title = element_text(size = 18), plot.title = element_text(size = 24))
ggsave(paste0(getwd(), "/graphs/o2_vs_t_familiar2.pdf"), p6)
