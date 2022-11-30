
from Colors import colors
from Mapping import map_network


def print_hosts():

    lst = map_network.map_network()

    if lst:

        length = len(lst)
        print(f">> {colors.console_colors.OKGREEN}{length} hosts is up")

    else:
        print(f">> All hosts are down")

    for d in lst:

        if lst.index(d) == 0:
            print()

        print(f"       {colors.console_colors.WARNING}[{lst.index(d)}]" + " - " + d)