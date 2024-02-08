from Colors import colors
from Mapping import map_network


def print_hosts():
    lst = map_network.map_network()

    if lst:
        length = len(lst)
        print(f">> {colors.console_colors.OKGREEN}{length} hosts are up")
    else:
        print(">> All hosts are down")

    for index, d in enumerate(lst, start=1):
        ip, system_info = d
        hostname = system_info.get('hostname', 'Unknown')
        system = system_info.get('os_info', 'Unknown')

        # Обобщаваме информацията за операционната система
        os_type = system_info.get('os_type', 'Unknown')

        print(f"       {colors.console_colors.WARNING}[{index}] IP: {ip}, Hostname: {hostname}, System: {os_type}")


print_hosts()
