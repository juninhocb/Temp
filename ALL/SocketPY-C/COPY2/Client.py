
import socket
import sys
import random
from ctypes import *
import obd
import time

#conexao = obd.OBD()

# Instância de variáveis utilizadas no processo
#rpm = obd.commands.RPM              #UNIDADE RPM
#vel = odb.commands.SPEED            #UNIDADE KM/H
#temp = obd.commands.COOLANT_TEMP    #UNIDADE GRAUS CELSIUS
#acel = obd.commands.THROTTLE_POS    #UNIDADE PORCENTAGEM
#dist = obd.commands.DISTANCE_W_MIL  #UNIDADE KILOMETROS
#comb = obd.commands.FUEL_LEVEL      #UNIDADE PORCENTAGEM
#volt = obd.commands.CONTROL_MODULE_VOLTAGE #UNIDADE VOLT
#ambtemp = obd.commands.AMBIANT_AIR_TEMP #UNIDADE GRAUS CELSIUS
#tipocomb = odd.commands.FUEL_TYPE   #UNIDADE STRING
#obd.commands.GET_DTC  #retorna uma tupla

#resp_rpm = connection.query(rpm)    
#resp_vel = connection.query(vel)
#resp_temp = connection.query(temp)
#resp_acel = connection.query(acel)
#resp_dist = connection.query(dist)
#resp_comb = connection.query(comb)
#resp_volt = connection.query(volt)
#resp_ambtemep = connection.query(ambtemp)
#resp_tipocomb = connection.query(tipocomb)

#no teste primário tirar o tipocomb

#print(resp_rpm.value)  #utilizado só para teste
'''
class Dados(Structure):
    _fields_ = [("rpm", c_int),
                ("vel", c_int),
                ("temp", c_float),
                ("acel", c_int),
                ("dist", c_int),
                ("comb", c_int),
                ("volt", c_int),
                ("ambtemp", c_int),
                ("tipocomb", c_string)]

'''

'''
SEND será:

dados_out = Dados(resp_rpm, resp_vel, resp_temp, resp_acel,
            resp_dist, resp_comb, resp_volt, resp_ambtemep)
            
s.send(dados_out)

'''

'''
RECV será:

buff = s.recv(sizeof(dados_out))
dados_in = Dados.from_buffer_copy(buff)
print("Received  rpm =%d, vel=%d, temp=%f, acel=%d, dist=%d, comb=%d, volt=%d, ambtemp=%d" % (dados_in.rpm,
                                               dados_in.vel,
                                               dados_in.temp,
                                               dados_in.acel,
                                               dados_in.dist,
                                               dados_in.comb,
                                               dados_in.volt,
                                               dados_in.ambtemep))

'''

#Estrutura de dados ao qual será enviada ao CSOCK
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
    while(1):
        try:
            for i in range(5):
                print ("")
                dados_out = Dados(1, i, random.uniform(-10, 30))
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
            print ("Volta ao inicio")
            time.sleep(2)

if __name__ == "__main__":
    main()