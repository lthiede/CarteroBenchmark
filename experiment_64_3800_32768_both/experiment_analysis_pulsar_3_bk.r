library("rjson")
library("ggplot2")
c_file_06 <- "experiment_64_3800_32768_both/experiment_64_3800_32768/results_64_p_32_c_3800_b_32768_b_60526_mxs.json"
c_file_12 <- "experiment_64_3800_32768_both/experiment_64_3800_32768/results_64_p_32_c_3800_b_32768_b_121052_mxs.json"
c_file_18 <- "experiment_64_3800_32768_both/experiment_64_3800_32768/results_64_p_32_c_3800_b_32768_b_181578_mxs.json"
c_file_24 <- "experiment_64_3800_32768_both/experiment_64_3800_32768/results_64_p_32_c_3800_b_32768_b_242105_mxs.json"
c_file_30 <- "experiment_64_3800_32768_both/experiment_64_3800_32768/results_64_p_32_c_3800_b_32768_b_302631_mxs.json"
c_file_rc_06 <- "experiment_64_3800_32768_both/experiment_64_3800_32768/result_64p_3800b_32768b_60526m.json"
c_file_rc_12 <- "experiment_64_3800_32768_both/experiment_64_3800_32768/result_64p_3800b_32768b_121052m.json"
c_file_rc_18 <- "experiment_64_3800_32768_both/experiment_64_3800_32768/result_64p_3800b_32768b_181578m.json"
c_file_rc_24 <- "experiment_64_3800_32768_both/experiment_64_3800_32768/result_64p_3800b_32768b_242105m.json"
c_file_rc_30 <- "experiment_64_3800_32768_both/experiment_64_3800_32768/result_64p_3800b_32768b_302631m.json"

p_file_06 <- "experiment_64_3800_32768_both/experiment_64_3800_32768_pulsar_copy/1-topic-64-partition-1kb-60526-rate-Pulsar-2025-01-31-23-30-40.json"
p_file_12 <- "experiment_64_3800_32768_both/experiment_64_3800_32768_pulsar_copy/1-topic-64-partition-1kb-121052-rate-Pulsar-2025-01-31-23-33-52.json"
p_file_18 <- "experiment_64_3800_32768_both/experiment_64_3800_32768_pulsar_copy/1-topic-64-partition-1kb-181578-rate-Pulsar-2025-01-31-23-36-29.json"
p_file_24 <- "experiment_64_3800_32768_both/experiment_64_3800_32768_pulsar_copy/1-topic-64-partition-1kb-242105-rate-Pulsar-2025-01-31-23-39-05.json"
p_file_30 <- "experiment_64_3800_32768_both/experiment_64_3800_32768_pulsar_copy/1-topic-64-partition-1kb-302631-rate-Pulsar-2025-01-31-23-41-43.json"
p_file_rc_06 <- "experiment_64_3800_32768_both/experiment_64_3800_32768_pulsar_copy/result_64p_3800b_60526m.json"
p_file_rc_12 <- "experiment_64_3800_32768_both/experiment_64_3800_32768_pulsar_copy/result_64p_3800b_121052m.json"
p_file_rc_18 <- "experiment_64_3800_32768_both/experiment_64_3800_32768_pulsar_copy/result_64p_3800b_181578m.json"
p_file_rc_24 <- "experiment_64_3800_32768_both/experiment_64_3800_32768_pulsar_copy/result_64p_3800b_242105m.json"
p_file_rc_30 <- "experiment_64_3800_32768_both/experiment_64_3800_32768_pulsar_copy/result_64p_3800b_302631m.json"

c_data_06 <- as.data.frame(fromJSON(file = c_file_06))
c_data_12 <- as.data.frame(fromJSON(file = c_file_12))
c_data_18 <- as.data.frame(fromJSON(file = c_file_18))
c_data_24 <- as.data.frame(fromJSON(file = c_file_24))
c_data_30 <- as.data.frame(fromJSON(file = c_file_30))
c_data_rc_06 <- fromJSON(file = c_file_rc_06)
c_data_rc_12 <- fromJSON(file = c_file_rc_12)
c_data_rc_18 <- fromJSON(file = c_file_rc_18)
c_data_rc_24 <- fromJSON(file = c_file_rc_24)
c_data_rc_30 <- fromJSON(file = c_file_rc_30)

p_json_06 <- fromJSON(file = p_file_06)
p_json_06$aggregatedPublishDelayLatencyQuantiles <- NULL
p_json_06$aggregatedPublishLatencyQuantiles <- NULL
p_json_06$aggregatedEndToEndLatencyQuantiles <- NULL
p_json_12 <- fromJSON(file = p_file_12)
p_json_12$aggregatedPublishDelayLatencyQuantiles <- NULL
p_json_12$aggregatedPublishLatencyQuantiles <- NULL
p_json_12$aggregatedEndToEndLatencyQuantiles <- NULL
p_json_18 <- fromJSON(file = p_file_18)
p_json_18$aggregatedPublishDelayLatencyQuantiles <- NULL
p_json_18$aggregatedPublishLatencyQuantiles <- NULL
p_json_18$aggregatedEndToEndLatencyQuantiles <- NULL
p_json_24 <- fromJSON(file = p_file_24)
p_json_24$aggregatedPublishDelayLatencyQuantiles <- NULL
p_json_24$aggregatedPublishLatencyQuantiles <- NULL
p_json_24$aggregatedEndToEndLatencyQuantiles <- NULL
p_json_30 <- fromJSON(file = p_file_30)
p_json_30$aggregatedPublishDelayLatencyQuantiles <- NULL
p_json_30$aggregatedPublishLatencyQuantiles <- NULL
p_json_30$aggregatedEndToEndLatencyQuantiles <- NULL
p_data_06 <- as.data.frame(p_json_06)
p_data_12 <- as.data.frame(p_json_12)
p_data_18 <- as.data.frame(p_json_18)
p_data_24 <- as.data.frame(p_json_24)
p_data_30 <- as.data.frame(p_json_30)
p_data_rc_06 <- fromJSON(file = p_file_rc_06)
p_data_rc_12 <- fromJSON(file = p_file_rc_12)
p_data_rc_18 <- fromJSON(file = p_file_rc_18)
p_data_rc_24 <- fromJSON(file = p_file_rc_24)
p_data_rc_30 <- fromJSON(file = p_file_rc_30)

c_mean_produce_rates <- c(
  mean(c_data_06$SentMessagesPerSecondMeasurements),
  mean(c_data_12$SentMessagesPerSecondMeasurements),
  mean(c_data_18$SentMessagesPerSecondMeasurements),
  mean(c_data_24$SentMessagesPerSecondMeasurements),
  mean(c_data_30$SentMessagesPerSecondMeasurements)
)
c_produce_latencies_50pct <- c(
  c_data_06$Latency50Pct[1] * 1000,
  c_data_12$Latency50Pct[1] * 1000,
  c_data_18$Latency50Pct[1] * 1000,
  c_data_24$Latency50Pct[1] * 1000,
  c_data_30$Latency50Pct[1] * 1000
)

p_mean_produce_rates <- c(
  mean(p_data_06$publishRate),
  mean(p_data_12$publishRate),
  mean(p_data_18$publishRate),
  mean(p_data_24$publishRate),
  mean(p_data_30$publishRate)
)
p_produce_latencies_50pct <- c(
  p_data_06$aggregatedPublishLatency50pct[1],
  p_data_12$aggregatedPublishLatency50pct[1],
  p_data_18$aggregatedPublishLatency50pct[1],
  p_data_24$aggregatedPublishLatency50pct[1],
  p_data_30$aggregatedPublishLatency50pct[1]
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
  c_mean_disk_write(c_data_rc_06) / 1000,
  c_mean_disk_write(c_data_rc_12) / 1000,
  c_mean_disk_write(c_data_rc_18) / 1000,
  c_mean_disk_write(c_data_rc_24) / 1000,
  c_mean_disk_write(c_data_rc_30) / 1000
)

p_mean_disk_write_mb <- c(
  p_mean_disk_write(p_data_rc_06) / 1000,
  p_mean_disk_write(p_data_rc_12) / 1000,
  p_mean_disk_write(p_data_rc_18) / 1000,
  p_mean_disk_write(p_data_rc_24) / 1000,
  p_mean_disk_write(p_data_rc_30) / 1000
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
  scale_x_continuous(breaks = c(60000, 120000, 180000, 240000, 300000),
                     limits = c(0, NA)) +
  scale_y_continuous(limits = c(0, NA)) +
  scale_colour_manual(
    values = c(
      "prototype" = "#4CAF50",
      "pulsar" = "#3F51B5"
    )
  ) +
  xlab("produce rate in messages per second") +
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
