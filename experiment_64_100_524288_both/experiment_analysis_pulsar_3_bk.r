library("rjson")
library("ggplot2")
c_file_03 <- "experiment_64_100_524288_both/experiment_64_100_524288/results_64_p_32_c_100_b_524288_b_340000_mxs.json"
c_file_06 <- "experiment_64_100_524288_both/experiment_64_100_524288/results_64_p_32_c_100_b_524288_b_680000_mxs.json"
c_file_10 <- "experiment_64_100_524288_both/experiment_64_100_524288/results_64_p_32_c_100_b_524288_b_1020000_mxs.json"
c_file_13 <- "experiment_64_100_524288_both/experiment_64_100_524288/results_64_p_32_c_100_b_524288_b_1360000_mxs.json"
c_file_17 <- "experiment_64_100_524288_both/experiment_64_100_524288/results_64_p_32_c_100_b_524288_b_1700000_mxs.json"
c_file_23 <- "experiment_64_100_524288_both/experiment_64_100_524288/results_64_p_32_c_100_b_524288_b_2300000_mxs.json"
c_file_rc_03 <- "experiment_64_100_524288_both/experiment_64_100_524288/result_64p_100b_524288b_340000m.json"
c_file_rc_06 <- "experiment_64_100_524288_both/experiment_64_100_524288/result_64p_100b_524288b_680000m.json"
c_file_rc_10 <- "experiment_64_100_524288_both/experiment_64_100_524288/result_64p_100b_524288b_1020000m.json"
c_file_rc_13 <- "experiment_64_100_524288_both/experiment_64_100_524288/result_64p_100b_524288b_1360000m.json"
c_file_rc_17 <- "experiment_64_100_524288_both/experiment_64_100_524288/result_64p_100b_524288b_1700000m.json"
c_file_rc_23 <- "experiment_64_100_524288_both/experiment_64_100_524288/result_64p_100b_524288b_2300000m.json"

p_file_03 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/1-topic-64-partition-1kb-380000-rate-Pulsar-2025-01-31-23-10-59.json"
p_file_07 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/1-topic-64-partition-1kb-760000-rate-Pulsar-2025-01-31-23-14-15.json"
p_file_11 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/1-topic-64-partition-1kb-1140000-rate-Pulsar-2025-01-31-23-17-29.json"
p_file_15 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/1-topic-64-partition-1kb-1520000-rate-Pulsar-2025-01-31-23-21-11.json"
p_file_19 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/1-topic-64-partition-1kb-1900000-rate-Pulsar-2025-01-31-23-24-39.json"
p_file_23 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/1-topic-64-partition-1kb-2300000-rate-Pulsar-2025-01-31-23-06-41.json"
p_file_rc_03 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/result_64p_100b_380000m.json"
p_file_rc_07 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/result_64p_100b_760000m.json"
p_file_rc_11 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/result_64p_100b_1140000m.json"
p_file_rc_15 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/result_64p_100b_1520000m.json"
p_file_rc_19 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/result_64p_100b_1900000m.json"
p_file_rc_23 <- "experiment_64_100_524288_both/experiment_64_100_524288_pulsar_copy/result_64p_100b_2300000m.json"

c_data_03 <- as.data.frame(fromJSON(file = c_file_03))
c_data_06 <- as.data.frame(fromJSON(file = c_file_06))
c_data_10 <- as.data.frame(fromJSON(file = c_file_10))
c_data_13 <- as.data.frame(fromJSON(file = c_file_13))
c_data_17 <- as.data.frame(fromJSON(file = c_file_17))
c_data_23 <- as.data.frame(fromJSON(file = c_file_23))
c_data_rc_03 <- fromJSON(file = c_file_rc_03)
c_data_rc_06 <- fromJSON(file = c_file_rc_06)
c_data_rc_10 <- fromJSON(file = c_file_rc_10)
c_data_rc_13 <- fromJSON(file = c_file_rc_13)
c_data_rc_17 <- fromJSON(file = c_file_rc_17)
c_data_rc_23 <- fromJSON(file = c_file_rc_23)

p_json_03 <- fromJSON(file = p_file_03)
p_json_03$aggregatedPublishDelayLatencyQuantiles <- NULL
p_json_03$aggregatedPublishLatencyQuantiles <- NULL
p_json_03$aggregatedEndToEndLatencyQuantiles <- NULL
p_json_07 <- fromJSON(file = p_file_07)
p_json_07$aggregatedPublishDelayLatencyQuantiles <- NULL
p_json_07$aggregatedPublishLatencyQuantiles <- NULL
p_json_07$aggregatedEndToEndLatencyQuantiles <- NULL
p_json_11 <- fromJSON(file = p_file_11)
p_json_11$aggregatedPublishDelayLatencyQuantiles <- NULL
p_json_11$aggregatedPublishLatencyQuantiles <- NULL
p_json_11$aggregatedEndToEndLatencyQuantiles <- NULL
p_json_15 <- fromJSON(file = p_file_15)
p_json_15$aggregatedPublishDelayLatencyQuantiles <- NULL
p_json_15$aggregatedPublishLatencyQuantiles <- NULL
p_json_15$aggregatedEndToEndLatencyQuantiles <- NULL
p_json_19 <- fromJSON(file = p_file_19)
p_json_19$aggregatedPublishDelayLatencyQuantiles <- NULL
p_json_19$aggregatedPublishLatencyQuantiles <- NULL
p_json_19$aggregatedEndToEndLatencyQuantiles <- NULL
p_json_23 <- fromJSON(file = p_file_23)
p_json_23$aggregatedPublishDelayLatencyQuantiles <- NULL
p_json_23$aggregatedPublishLatencyQuantiles <- NULL
p_json_23$aggregatedEndToEndLatencyQuantiles <- NULL
p_data_03 <- as.data.frame(p_json_03)
p_data_07 <- as.data.frame(p_json_07)
p_data_11 <- as.data.frame(p_json_11)
p_data_15 <- as.data.frame(p_json_15)
p_data_19 <- as.data.frame(p_json_19)
p_data_23 <- as.data.frame(p_json_23)
p_data_rc_03 <- fromJSON(file = p_file_rc_03)
p_data_rc_07 <- fromJSON(file = p_file_rc_07)
p_data_rc_11 <- fromJSON(file = p_file_rc_11)
p_data_rc_15 <- fromJSON(file = p_file_rc_15)
p_data_rc_19 <- fromJSON(file = p_file_rc_19)
p_data_rc_23 <- fromJSON(file = p_file_rc_23)

c_mean_produce_rates <- c(
  mean(c_data_03$SentMessagesPerSecondMeasurements),
  mean(c_data_06$SentMessagesPerSecondMeasurements),
  mean(c_data_10$SentMessagesPerSecondMeasurements),
  mean(c_data_13$SentMessagesPerSecondMeasurements),
  mean(c_data_17$SentMessagesPerSecondMeasurements),
  mean(c_data_23$SentMessagesPerSecondMeasurements)
)
c_produce_latencies_50pct <- c(
  c_data_03$Latency50Pct[1] * 1000,
  c_data_06$Latency50Pct[1] * 1000,
  c_data_10$Latency50Pct[1] * 1000,
  c_data_13$Latency50Pct[1] * 1000,
  c_data_17$Latency50Pct[1] * 1000,
  c_data_23$Latency50Pct[1] * 1000
)

p_mean_produce_rates <- c(
  mean(p_data_03$publishRate),
  mean(p_data_07$publishRate),
  mean(p_data_11$publishRate),
  mean(p_data_15$publishRate),
  mean(p_data_19$publishRate),
  mean(p_data_23$publishRate)
)
p_produce_latencies_50pct <- c(
  p_data_03$aggregatedPublishLatency50pct[1],
  p_data_07$aggregatedPublishLatency50pct[1],
  p_data_11$aggregatedPublishLatency50pct[1],
  p_data_15$aggregatedPublishLatency50pct[1],
  p_data_19$aggregatedPublishLatency50pct[1],
  p_data_23$aggregatedPublishLatency50pct[1]
)

c_mean_disk_write <- function(x) {
  for (i in 1:length(x$log$iotop_disk_write)) {
    inner_list <- x$log$iotop_disk_write[[i]]
    x$log$iotop_disk_write[[i]] = inner_list[-1]
  }
  mean(unlist(
    c(
      x$log$iotop_disk_write[1],
      x$log$iotop_disk_write[2],
      x$log$iotop_disk_write[3]
    )
  ))
}

p_mean_disk_write <- function(x) {
  for (i in 1:length(x$bookkeeper$iotop_disk_write)) {
    inner_list <- x$bookkeeper$iotop_disk_write[[i]]
    x$bookkeeper$iotop_disk_write[[i]] = inner_list[-1]
  }
  mean(unlist(
    c(
      x$bookkeeper$iotop_disk_write[1],
      x$bookkeeper$iotop_disk_write[2],
      x$bookkeeper$iotop_disk_write[3]
    )
  ))
}

c_mean_disk_write_mb <- c(
  c_mean_disk_write(c_data_rc_03) / 1000,
  c_mean_disk_write(c_data_rc_06) / 1000,
  c_mean_disk_write(c_data_rc_10) / 1000,
  c_mean_disk_write(c_data_rc_13) / 1000,
  c_mean_disk_write(c_data_rc_17) / 1000,
  c_mean_disk_write(c_data_rc_23) / 1000
)

p_mean_disk_write_mb <- c(
  p_mean_disk_write(p_data_rc_03) / 1000,
  p_mean_disk_write(p_data_rc_07) / 1000,
  p_mean_disk_write(p_data_rc_11) / 1000,
  p_mean_disk_write(p_data_rc_15) / 1000,
  p_mean_disk_write(p_data_rc_19) / 1000,
  p_mean_disk_write(p_data_rc_23) / 1000
)

data <- data.frame(
  c_produce_rates = c_mean_produce_rates,
  p_produce_rates = p_mean_produce_rates,
  c_latencies = c_produce_latencies_50pct,
  p_latencies = p_produce_latencies_50pct,
  c_disk_write_mb = c_mean_disk_write_mb,
  p_disk_write_mb = p_mean_disk_write_mb
)

ggplot(data) +
  geom_line(aes(x = c_produce_rates, y = c_latencies, colour = "prototype"),
            linewidth = 1) +
  geom_point(aes(x = c_produce_rates, y = c_latencies, color = "prototype"), shape = 4, size = 4, stroke = 1.5) +
  geom_line(aes(x = p_produce_rates, y = p_latencies, colour = "pulsar"),
            linewidth = 1) +
  geom_point(aes(x = p_produce_rates, y = p_latencies, color = "pulsar"), shape = 4, size = 4, stroke = 1.5) +
  geom_vline(aes(xintercept=11500000, colour = "70 % SSD"), linetype = "dashed", linewidth = 1) +
  geom_vline(aes(xintercept=8200000, colour = "100 % SSD"), linetype = "dashed", linewidth = 1) +
  scale_x_continuous(breaks = c(2000000, 4000000, 6000000, 8000000, 10000000, 12000000),
                     labels = c("2 000", "4 000", "6 000", "8 000", "10 000", "12 000")) +
  scale_y_continuous(limits = c(0, NA)) +
  scale_colour_manual(
    values = c(
      "prototype" = "#4CAF50",
      "pulsar" = "#3F51B5",
      "70 % SSD\nthroughput" = "#4CAF50",
      "100 % SSD\nthroughput" = "#3F51B5"
    ),
    breaks = c("prototype", "70 % SSD", "pulsar", "100 % SSD")
  ) +
  xlab("produce rate in thousand messages per second") +
  ylab("50th percentile\nproduce latency in ms") +
  labs(colour = "") +
  theme(
    text = element_text(size = 24),
    axis.title = element_text(size = 24),
    axis.text = element_text(size = 19),
    legend.title = element_text(size = 24),
    legend.text = element_text(size = 21)
  )

# ggplot(data) +
#   geom_line(
#     aes(x = c_produce_rates, y = c_disk_write_mb, colour = "prototype"),
#     linewidth = 1
#   ) +
#   geom_point(aes(x = c_produce_rates, y = c_disk_write_mb, color = "prototype"), shape = 4, size = 4, stroke = 1.5) +
#   geom_line(aes(x = p_produce_rates, y = p_disk_write_mb, colour = "pulsar"),
#             linewidth = 1) +
#   geom_point(aes(x = p_produce_rates, y = p_disk_write_mb, color = "pulsar"), shape = 4, size = 4, stroke = 1.5) +
#   geom_hline(aes(yintercept=1600, colour = "maximum"), linetype = "dashed", linewidth = 1) +
#   scale_x_continuous(breaks = c(60000, 120000, 180000, 240000, 300000),
#                      limits = c(0, NA)) +
#   scale_y_continuous(limits = c(0, NA)) +
#   scale_colour_manual(
#     values = c(
#       "prototype" = "#4CAF50",
#       "maximum" = "#F44336",
#       "pulsar" = "#3F51B5"
#     )
#   ) +
#   xlab("produce rate in messages per second") +
#   ylab("SSD write throughput in MB/s") +
#   labs(colour = "") +
#   theme(
#     text = element_text(size = 24),
#     axis.title = element_text(size = 24),
#     axis.text = element_text(size = 19),
#     legend.title = element_text(size = 24),
#     legend.text = element_text(size = 21)
#   )
