import socket
import multiprocessing
import subprocess
import platform

from Pinger import pinger
from ProgressBar import progress_bar

def get_remote_system_info(ip):
    try:
        result = subprocess.run(['ssh', ip, 'uname -a'], capture_output=True, text=True, timeout=10)
        system_info = result.stdout.strip()
        return system_info
    except subprocess.TimeoutExpired:
        return "Timeout: Unable to retrieve system information"
    except subprocess.CalledProcessError as e:
        return f"Command execution failed: {e}"

def get_system_info(ip):
    system_info = {}
    try:
        system_info['hostname'] = socket.gethostbyaddr(ip)[0]
        system_info['ip_address'] = ip
        system_info['os_info'] = get_remote_system_info(ip)
        system_info['os_type'] = platform.system()
    except socket.herror as e:
        system_info['hostname'] = f"Unknown ({e})"
        system_info['ip_address'] = ip
        system_info['os_info'] = "N/A (Host not found)"
    except Exception as e:
        system_info['hostname'] = f"Unknown ({e})"
        system_info['ip_address'] = ip
        system_info['os_info'] = f"Error: {e}"
    return system_info

def get_my_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    ip = s.getsockname()[0]
    s.close()
    return ip

def map_network(pool_size=255):
    ip_list = []

    ip_parts = get_my_ip().split('.')
    base_ip = ip_parts[0] + '.' + ip_parts[1] + '.' + ip_parts[2] + '.'

    jobs = multiprocessing.Queue()
    results = multiprocessing.Queue()

    pool = [multiprocessing.Process(target=pinger.pinger, args=(jobs, results)) for i in range(pool_size)]

    for p in pool:
        p.start()

    for i in range(1, 255):
        jobs.put(base_ip + '{0}'.format(i))

    for p in pool:
        jobs.put(None)

    for p in pool:
        p.join()

    while not results.empty():
        ip = results.get()
        system_info = get_system_info(ip)
        ip_list.append((ip, system_info))

    return ip_list
