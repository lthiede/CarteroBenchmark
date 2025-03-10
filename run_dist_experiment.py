from distexprunner import *
import json
import re

#client = {
#   "35.166.36.153" = "10.0.0.149"
#   "44.244.72.253" = "10.0.0.203"
# }
# client_ssh_host = "44.244.72.253"
# logservice = {
#   "34.209.151.182" = "10.0.0.14"
#   "44.243.69.110" = "10.0.0.139"
#   "54.200.76.113" = "10.0.0.16"
# }
# messageservice = {
#   "18.237.49.19" = "10.0.0.132"
# }

# sudo ./target/release/rust-segmentstore server --ip 10.0.0.14:50000 --ssd-paths /dev/nvme1n1 --ssd-paths /dev/nvme2n1 --number-threads 12
# sudo ./target/release/rust-segmentstore server --ip 10.0.0.139:50000 --ssd-paths /dev/nvme1n1 --ssd-paths /dev/nvme2n1 --number-threads 12
# sudo ./target/release/rust-segmentstore server --ip 10.0.0.16:50000 --ssd-paths /dev/nvme1n1 --ssd-paths /dev/nvme2n1 --number-threads 12

# ./server -s 10.0.0.132:8080 -o 10.0.0.14:50000 -o 10.0.0.139:50000 -o 10.0.0.16:50000

# ./via_broker -p 64 -n 32 -l 100 -a 524288 -e 60 -m 2300000 -c 15 -s 10.0.0.204:8080

# server has no attribute name
server_list = ServerList(
    Server('broker-0', '10.0.0.132', 20000, broker=True, log=False, client=False),
    Server('log-0', '10.0.0.14', 20000, broker=False, log=True, client=False),
    Server('log-1', '10.0.0.139', 20000, broker=False, log=True, client=False),
    Server('log-2', '10.0.0.16', 20000, broker=False, log=True, client=False),
    Server('client-0', '10.0.0.149', 20000, broker=False, log=False, client=True),
    Server('client-1', '10.0.0.203', 20000, broker=False, log=False, client=True),
)

class Print:
    def __init__(self, name):
        self.__name = name
    
    def __call__(self, line):
        print(f'{self.__name} {line}')

    def __str__(self):
        return "this class doesn't store any command output" 

class Pid:
    def __init__(self, name):
        self.__name = name
        self.__pid = None

    def __call__(self, line):
        print(f'{self.__name} {line}')
        if self.__pid is None:
            self.__pid = re.search(r"\d+", line).group()

    def __str__(self):
        return self.__pid

class CPU:
    def __init__(self, name):
        self.__name = name
        self.__user = []
        self.__kernel = []
        self.__idle = []
        self.__wait_io = []

    def __call__(self, line):
        # if self.__name == "log-0":
        #    print(f'{self.__name} {line}')
        if "%Cpu(s)" not in line:
            # if self.__name == "log-0":
            #     print("skipping line")
            return
        # us : time running un-niced user processes
        # sy : time running kernel processes
        # ni : time running niced user processes
        # id : time spent in the kernel idle handler
        # wa : time waiting for I/O completion
        # hi : time spent servicing hardware interrupts
        # si : time spent servicing software interrupts
        # st : time stolen from this vm by the hypervisor
        match = re.search('(\d+\.\d+)\sus', line)
        us = float(match.group(1))
        match = re.search('(\d+\.\d+)\ssy', line)
        sy = float(match.group(1))
        match = re.search('(\d+\.\d+)\sni', line)
        ni = float(match.group(1))
        match = re.search('(\d+\.\d+)\sid', line)
        idle = float(match.group(1))
        match = re.search('(\d+\.\d+)\swa', line)
        wait_io = float(match.group(1))
        match = re.search('(\d+\.\d+)\shi', line)
        hi = float(match.group(1))
        match = re.search('(\d+\.\d+)\ssi', line)
        si = float(match.group(1))
        match = re.search('(\d+\.\d+)\sst', line)
        st = float(match.group(1))
        user = us + ni
        kernel = sy + hi + si
        # if self.__name == "log-0":
        #     print(f'read user {user}% kernel {kernel}% idle {idle}% wait io {wait_io}%')
        self.__user.append(user)
        self.__kernel.append(kernel)
        self.__idle.append(idle)
        self.__wait_io.append(wait_io)

    def __str__(self):
        return str(self.__cpu)

    def user(self):
        return self.__user
    
    def kernel(self):
        return self.__kernel
    
    def idle(self):
        return self.__idle
    
    def wait_io(self):
        return self.__wait_io

class IO:
    def __init__(self, name):
        self.__name = name
        self.__r = []
        self.__w = []
    
    def __call__(self, line):
        # if self.__name == "log-0":
        #    print(f'{self.__name} {line}')
        if 'Current DISK WRITE' not in line:
            # if self.__name == "log-0":
            #     print("skipping line")
            return
        matches = re.findall(r"\d+\.\d+ K/s", line)
        read_tp = float(matches[0].removesuffix(' K/s'))
        write_tp = float(matches[1].removesuffix(' K/s'))
        self.__r.append(read_tp)
        self.__w.append(write_tp)
        # if self.__name == 'log-0':
        #     print(f'read read_tp {read_tp} write_tp {write_tp}')

    def __str__(self):
        dict = {'disk_write_tp': self.__w, 'disk_read_tp': self.__r}
        return str(dict)
    
    def disk_read(self):
        return self.__r
    
    def disk_write(self):
        return self.__w

class Network:
    def __init__(self, name):
        self.__name = name
        self.__r = []
        self.__t = []
    
    def __call__(self, line):
        # if self.__name == "client-0":
        #    print(f'{self.__name} {line}')
        numbers = re.findall(r"\d+(?:\.\d\d)?", line)
        rx_bps = float(numbers[0])
        tx_bps = float(numbers[1])
        # if self.__name == "client-0":
        #     print(f'read rx {rx_bps} tx {tx_bps}')
        self.__r.append(rx_bps)
        self.__t.append(tx_bps)
    
    def __str__(self):
        dict = {'rx_bps': self.__r, 'tx_bps': self.__t}
        return str(dict)

    def rx_bps(self):
        return self.__r
    
    def tx_bps(self):
        return self.__t

# latency
# throughput
partition_count = 64
connections = 32
message_size = 3800
max_batch_size = 32768
message_rate = 302_631
max_pending = 240
experiment_duration = 60
num_clients = 1

@reg_exp(servers=server_list)
def benchmark_log(servers):
    main_client = None
    clients = []
    brokers = []
    log_nodes = []
    num_clients_found = 0
    for server in server_list:
        if server.client and num_clients_found < num_clients:
            clients.append(server)
            num_clients_found += 1
        if server.broker:
            brokers.append(server)
        if server.log:
            log_nodes.append(server)
    assert(len(clients) >= num_clients)
    assert(len(brokers) >= 1)
    assert(len(log_nodes) >= 1)

    print(f'starting for partition count {partition_count}, max batch size {max_batch_size}, message size {message_size}')

    # currently only supports one broker
    broker_arg = ''.join(['-s ' + item.ip + ':8080 ' for item in brokers])
    benchmark_cmds = []
    for c in clients:
        benchmark_cmd = c.run_cmd(f'cd /home/ubuntu/message-service-prototype-cartero-integrate-segmentstore-highpoint/experiments/produce_to_log/via_broker/ && ./via_broker -p {partition_count} -l {message_size} -m {message_rate} -a {max_batch_size} -n {connections} -c {max_pending} -e {experiment_duration} {broker_arg}')
        benchmark_cmds.append(benchmark_cmd)
        
    sleep(experiment_duration - 1)
    client_metrics = []
    for c in clients:
        client_metrics.append(start_metric_collectors(c))
    broker_metrics = []
    for p in brokers:
        broker_metrics.append(start_metric_collectors(p))
    log_metrics = []
    for b in log_nodes:
        log_metrics.append(start_metric_collectors(b))
    
    for i in range(num_clients):
        benchmark_cmds[i].wait()
        
    result = {}
    result['clients'] = collect_metrics(client_metrics)
    result['broker'] = collect_metrics(broker_metrics)
    result['log'] = collect_metrics(log_metrics)
    
    with open(f'result_{partition_count}p_{message_size}b_{max_batch_size}b_{message_rate}m.json', 'w') as fp:
        json.dump(result, fp)

def start_metric_collectors(s):
    pid = None
    if s.log:
        pid_output = Pid(s.id)
        pid_cmd = s.run_cmd('ps -aux | grep -E "rust-segmentstore\sserver"', stdout=pid_output).wait()
        pid =  str(pid_output)
    elif s.client:
        pid_output = Pid(s.id)
        pid_cmd = s.run_cmd('ps -aux | grep -E "[0-9]\s\./via_broker\\s-p"', stdout=pid_output).wait()
        pid =  str(pid_output)
    elif s.broker:
        pid_output = Pid(s.id)
        pid_cmd = s.run_cmd('ps -aux | grep -E "server\s-s"', stdout=pid_output).wait()
        pid =  str(pid_output)
    assert(pid is not None)
        
    top_output = CPU(s.id)
    n = int(experiment_duration / 60 * 6)
    # filter by pid to reduce amount of output but actually read combined values for whole machine
    top_cmd = s.run_cmd(f'LC_NUMERIC="en_US.UTF-8" top -b -p {pid_output} -d 10 -n {n}', stdout=top_output)
    iotop_output = IO(s.id)
    # filter by pid to reduce amount of output but actually read combined values for whole machine
    iotop_cmd = s.run_cmd(f'sudo -n iotop-c -b -p {pid_output} -k -d 10 -n {n}', stdout=iotop_output)
    bmon_output = Network(s.id)
    bmon_cmd = s.run_cmd(f'bmon -p \'ens5\' -o format:fmt=\'$(attr:rxrate:bytes) $(attr:txrate:bytes)\n\' -o format:quitafter={n} -r 10', stdout=bmon_output)
    #bmon_cmd = s.run_cmd(f'bmon -p \'enp1s0f0\' -o format:fmt=\'$(attr:rxrate:bytes) $(attr:txrate:bytes)\n\' -o format:quitafter={n} -r 10', stdout=bmon_output)

    return {
        'cmds': [top_cmd, bmon_cmd],
        'top_output': top_output,
        'iotop_output': iotop_output,
        'bmon_output': bmon_output
        }

def collect_metrics(servers):
    result = {
        'top_cpu_user': [],
        'top_cpu_kernel': [],
        'top_cpu_idle': [],
        'top_cpu_wait_io': [],
        'iotop_disk_read': [],
        'iotop_disk_write': [],
        'bmon_rx_Bps': [],
        'bmon_tx_Bps': []
    }
    for s in servers:
        for c in s['cmds']:
            c.wait()
        result['top_cpu_user'].append(s['top_output'].user())
        result['top_cpu_kernel'].append(s['top_output'].kernel())
        result['top_cpu_idle'].append(s['top_output'].idle())
        result['top_cpu_wait_io'].append(s['top_output'].wait_io())
        result['iotop_disk_read'].append(s['iotop_output'].disk_read())
        result['iotop_disk_write'].append(s['iotop_output'].disk_write())
        result['bmon_rx_Bps'].append(s['bmon_output'].rx_bps())
        result['bmon_tx_Bps'].append(s['bmon_output'].tx_bps())
    return result