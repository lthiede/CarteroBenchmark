library("rjson")
library("ggplot2")
json_file_100 <- "results_latencies/results_64_partitions_16_clientsXpartition_100_messagesXs_target.json"
json_file_50_000 <- "results_latencies/results_64_partitions_16_clientsXpartition_50000_messagesXs_target.json"
json_file_100_000 <- "results_latencies/results_64_partitions_16_clientsXpartition_100000_messagesXs_target.json"
json_file_150_000 <- "results_latencies/results_64_partitions_16_clientsXpartition_150000_messagesXs_target.json"
json_file_200_000 <- "results_latencies/results_64_partitions_16_clientsXpartition_200000_messagesXs_target.json"
# json_file_225_000 <- "results_latencies/results_64_partitions_16_clientsXpartition_225000_messagesXs_target.json"
# json_file_250_000 <- "results_latencies/results_64_partitions_16_clientsXpartition_250000_messagesXs_target.json"
json_file_275_000 <- "results_latencies/results_64_partitions_16_clientsXpartition_275000_messagesXs_target.json"
json_file_resource_consumption <- "results_latencies/result0.json"

json_data_100 <- as.data.frame(fromJSON(file=json_file_100))
json_data_50_000 <- as.data.frame(fromJSON(file=json_file_50_000))
json_data_100_000 <- as.data.frame(fromJSON(file=json_file_100_000))
json_data_150_000 <- as.data.frame(fromJSON(file=json_file_150_000))
json_data_200_000 <- as.data.frame(fromJSON(file=json_file_200_000))
# json_data_225_000 <- as.data.frame(fromJSON(file=json_file_225_000))
# json_data_250_000 <- as.data.frame(fromJSON(file=json_file_250_000))
json_data_275_000 <- as.data.frame(fromJSON(file=json_file_275_000))
json_data_resource_consumption <- fromJSON(file=json_file_resource_consumption)
json_data_resource_consumption$'275000' <- json_data_resource_consumption$'second_275000'
json_data_resource_consumption$'second_275000' <- NULL
json_data_resource_consumption$'100' <- NULL
json_data_resource_consumption$'225000' <- NULL
json_data_resource_consumption$'250000' <- NULL

# for (key in names(json_data_resource_consumption)) {
#   value <- json_data_resource_consumption[[key]]
#   json_data_resource_consumption[[key]] <- value[["4"]]
# }

# aggregated_consume_rates_MB <- c(mean(json_data_100$consumeRate), mean(json_data_50_000$consumeRate), mean(json_data_100_000$consumeRate), mean(json_data_150_000$consumeRate), mean(json_data_200_000$consumeRate), mean(json_data_225_000$consumeRate), mean(json_data_250_000$consumeRate), mean(json_data_275_000$consumeRate)) / 1000
# aggregated_end_to_end_latencies_50pct <- c(json_data_100$aggregatedEndToEndLatency50pct[1], json_data_50_000$aggregatedEndToEndLatency50pct[1], json_data_100_000$aggregatedEndToEndLatency50pct[1], json_data_150_000$aggregatedEndToEndLatency50pct[1], json_data_200_000$aggregatedEndToEndLatency50pct[1], json_data_225_000$aggregatedEndToEndLatency50pct[1], json_data_250_000$aggregatedEndToEndLatency50pct[1], json_data_275_000$aggregatedEndToEndLatency50pct[1])

aggregated_consume_rates_MB <- c(mean(json_data_50_000$BytesPerSecondMeasurements), mean(json_data_100_000$BytesPerSecondMeasurements), mean(json_data_150_000$BytesPerSecondMeasurements), mean(json_data_200_000$BytesPerSecondMeasurements), mean(json_data_275_000$BytesPerSecondMeasurements)) / 1000000
produce_latencies_50pct <- c(json_data_50_000$Latency50Pct[1], json_data_100_000$Latency50Pct[1], json_data_150_000$Latency50Pct[1], json_data_200_000$Latency50Pct[1], json_data_275_000$Latency50Pct[1]) * 1000


aggregate_disk_write <- function(x) {
  for (i in 1:length(x$log$iotop_disk_write)) {
    inner_list <- x$log$iotop_disk_write[[i]]
    x$log$iotop_disk_write[[i]] = inner_list[-1]
  }
  mean(unlist(c(x$log$iotop_disk_write[1], x$log$iotop_disk_write[2], x$log$iotop_disk_write[3])))
}

aggregated_log_disk_write_MB <- sapply(json_data_resource_consumption, aggregate_disk_write) / 1000

aggregate_net_tx <- function(x) {
  for (i in 1:length(x$broker$bmon_tx_Bps)) {
    inner_list <- x$broker$bmon_tx_Bps[[i]]
    x$broker$bmon_tx_Bps[[i]] = inner_list[-1]
  }
  mean(unlist(c(x$broker$bmon_tx_Bps[1])))
}

aggregated_p_net_tx_MB <- sapply(json_data_resource_consumption, aggregate_net_tx) / 1000000

data_latency <- data.frame(
  aggregated_consume_rates_MB = aggregated_consume_rates_MB,
  produce_latencies_50pct = produce_latencies_50pct
)

data_disk_write_throughput <- data.frame(
  aggregated_consume_rates_MB = aggregated_consume_rates_MB,
  aggregated_log_disk_write_MB = aggregated_log_disk_write_MB  
)

data_net_throughput <- data.frame(
  aggregated_p_net_tx_MB = aggregated_p_net_tx_MB,
  aggregated_consume_rates_MB = aggregated_consume_rates_MB
)

# ggplot(data_latency, aes(x = aggregated_consume_rates_MB, y = produce_latencies_50pct)) +
#   geom_path(size = 0.25) +
#   geom_point(size = 2, shape = 'x') +
#   scale_y_continuous(trans = "log2", breaks = c(15, 20, 25, 30, 35)) +
#   coord_cartesian(xlim = c(0, 1000), clip = "off") +
#   scale_x_continuous( breaks = seq(0, 1000, 200)) +
#   xlab("average produce rate in MB/s") +
#   ylab("50pct produce latency in ms")

# ggplot(data_disk_write_throughput, aes(x = aggregated_consume_rates_MB, y = aggregated_log_disk_write_MB)) +
#     geom_path(size = 0.25) +
#     geom_point(size = 2, shape = 'x') +
#     scale_y_continuous( breaks = seq(0, 2000, 250)) +
#     coord_cartesian(xlim = c(0, 1000), clip = "off") +
#     scale_x_continuous( breaks = seq(0, 1000, 250)) +
#     xlab("average produce rate in MB/s") +
#     ylab("max disk write throughput in MB/s") +
#     geom_hline(yintercept = 1099.0, linetype = "dashed", color = "red", size = 0.25)

ggplot(data_net_throughput, aes(x = aggregated_consume_rates_MB, y = aggregated_p_net_tx_MB)) +
      geom_path(size = 0.25) +
      geom_point(size = 2, shape = 'x') +
      scale_y_continuous( breaks = seq(0, 6500, 1000)) +
      coord_cartesian(xlim = c(0, 1000), clip = "off") +
      scale_x_continuous( breaks = seq(0, 1000, 250)) +
      xlab("average consume rate in MB/s") +
      ylab("max broker net send in MB/s") +
      geom_hline(yintercept = 6250, linetype = "dashed", color = "red", size = 0.25)
