import os
import socket
import multiprocessing
import subprocess
from Colors import colors

def pinger(job_q, results_q):

    DEVNULL = open(os.devnull, 'w')
    while True:

        ip = job_q.get()

        if ip is None:
            break

        try:
            subprocess.check_call(['ping', '-c1', ip],
                                  stdout=DEVNULL)
            results_q.put(ip)
        except:
            pass


def get_my_ip():

    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    ip = s.getsockname()[0]
    s.close()
    return ip


def map_network(pool_size=255):


    ip_list = list()

    # get my IP and compose a base like 192.168.1.xxx
    ip_parts = get_my_ip().split('.')
    base_ip = ip_parts[0] + '.' + ip_parts[1] + '.' + ip_parts[2] + '.'

    # prepare the jobs queue
    jobs = multiprocessing.Queue()
    results = multiprocessing.Queue()

    pool = [multiprocessing.Process(target=pinger, args=(jobs, results)) for i in range(pool_size)]

    for p in pool:
        p.start()

    # cue hte ping processes
    for i in range(1, 255):
        jobs.put(base_ip + '{0}'.format(i))

    for p in pool:
        jobs.put(None)

    for p in pool:
        p.join()

    # collect he results
    while not results.empty():
        ip = results.get()
        ip_list.append(ip)

    return ip_list


print("")


print("")

if __name__ == '__main__':
    print(f""" { colors.console_colors.OKGREEN}       
     _______. _______  _______    .___________. __    __   _______ .___  ___. 
    /       ||   ____||   ____|   |           ||  |  |  | |   ____||   \/   | 
   |   (----`|  |__   |  |__      `---|  |----`|  |__|  | |  |__   |  \  /  | 
    \   \    |   __|  |   __|         |  |     |   __   | |   __|  |  |\/|  | 
.----)   |   |  |____ |  |____        |  |     |  |  |  | |  |____ |  |  |  | 
|_______/    |_______||_______|       |__|     |__|  |__| |_______||__|  |__| 
                                                                              """)

    lst = map_network()

print("")
for d in lst:
    print("")
    print(f"{  colors.console_colors.WARNING}Host is up" + " " + d)