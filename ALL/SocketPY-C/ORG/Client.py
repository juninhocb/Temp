
import socket
import sys
import random
from ctypes import *
from modelo import *

class Dados(Structure):
    _fields_ = [("id", c_int),
                ("counter", c_int),
                ("temp", c_float)]

def main():
    server_addr = ('localhost', 2300)
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    if not (s):
        print("Erro ao se conectar")

    try:
        s.connect(server_addr)
        print ("Connected to %s" % repr(server_addr))
    except:
        print ("ERROR: Connection to %s refused" % repr(server_addr))
        sys.exit(1)

    try:
        for i in range(5):
            print ("")
            x = Chama()
            dados_out = Dados(1, i, x.x)
            print ("Sending id=%d, counter=%d, temp=%f" % (dados_out.id,
                                                        dados_out.counter,
                                                        dados_out.temp))
            nsent = s.send(dados_out)
            # Alternative: s.sendall(...): coontinues to send data until either
            # all data has been sent or an error occurs. No return value.
            print ("Sent %d bytes" % nsent)

            buff = s.recv(sizeof(dados_out))
            dados_in = Dados.from_buffer_copy(buff)
            print ("Received id=%d, counter=%d, temp=%f" % (dados_in.id,
                                                        dados_in.counter,
                                                        dados_in.temp))
    finally:
        print ("Closing socket")
        s.close()

if __name__ == "__main__":
    main()