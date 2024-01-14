import socket
import multiprocessing
from Pinger import pinger
from ProgressBar import progress_bar
def get_my_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    ip = s.getsockname()[0]
    s.close()

    return ip



def map_network(pool_size=255):
    ip_list = list()


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
        ip_list.append(ip)


    return ip_list
