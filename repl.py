from jupyter_client.blocking.client import BlockingKernelClient
import os
import sys


import ipykernel_launcher

def main():
    if len(sys.argv) == 2:
        conn_file = sys.argv[1]
    else:
        dir_path = os.path.dirname(os.path.realpath(__file__))
        conn_file = os.path.join(dir_path, "socks", "conn.json")
    
    client = BlockingKernelClient()
    client.load_connection_file(conn_file)
    client.start_channels()
    while True:
        command = input("\n> ")
        client.execute_interactive(command)
        if command == "quit":
            break

if __name__ == '__main__':
    main()
