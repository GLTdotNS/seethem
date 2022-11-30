import sys
import time

def loading():

    syms = ['\\', '|', '/', '-']
    bs = '\b'

    for _ in range(15):
        for sym in syms:
            sys.stdout.write("\b%s" % sym)
            sys.stdout.flush()
            time.sleep(0.1)

