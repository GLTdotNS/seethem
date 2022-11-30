import os
import subprocess
from ProgressBar import  progress_bar
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

    progress_bar.loading()







