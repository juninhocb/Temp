#include "thinger/thinger.h"
#include <sys/socket.h>
#include <arpa/inet.h> //inet_addr
#include <unistd.h>    //write
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DEBUG true
#define USER_ID             "juninhocb"
#define DEVICE_ID           "Raspberry"
#define DEVICE_CREDENTIAL   "Teste12345"

#pragma pack(1)

typedef struct payload_t {
    int rpm = 0;
    int vel = 0;
    float temp = 0;
} payload;

#pragma pack()

int createSocket(int port)
{
    int sock, err;
    struct sockaddr_in server;

    thinger_device thing(USER_ID, DEVICE_ID, DEVICE_CREDENTIAL);

    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        printf("ERROR: Socket não criado\n");
        exit(1);
    }
    printf("Socket criado\n");

    bzero((char *) &server, sizeof(server));
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = INADDR_ANY;
    server.sin_port = htons(port);
    if (bind(sock, (struct sockaddr *)&server , sizeof(server)) < 0)
    {
        printf("ERROR: Bind não funcionou\n");
        exit(1);
    }
    printf("Bind feito com sucesso!\n");

    listen(sock , 3);

    return sock;
}

void closeSocket(int sock)
{
    close(sock);
    return;
}

void sendMsg(int sock, void* msg, int msgsize)
{
    if (write(sock, msg, msgsize) < 0)
    {
        printf("Não enviou a mensagem.\n");
        exit(1);
    }
    printf("Mensagem enviada (%d bytes).\n", msgsize);
    return;
}

int main(int argc, char *argv[])
{

    int PORT = 2300;
    int BUFFSIZE = 512;
    char buff[BUFFSIZE];
    int ssock, csock;
    int nread;
    struct sockaddr_in client;
    int clilen = sizeof(client);
    payload *p = (payload*) buff;

    ssock = createSocket(PORT);
    printf("Servidor está funcionando na porta: %d\n", PORT);
    thinger_device thing(USER_ID, DEVICE_ID, DEVICE_CREDENTIAL);


    while (1)
    {
        csock = accept(ssock, (struct sockaddr *)&client, &clilen);
        if (csock < 0)
        {
            printf("Error: Conexão Fail\n");
            continue;
        }

        printf("Conexão bem sucedida com %s\n", inet_ntoa(client.sin_addr));
        bzero(buff, BUFFSIZE);

        thing["Velocidade"] >> outputValue(p->vel);

        thing["RPM"] >> outputValue(p->rpm);

        thing["Temperatura"] >> outputValue(p->temp);

        thing.start();

        while ((nread=read(csock, buff, BUFFSIZE)) > 0)
        {
            printf("\nRecebido %d bytes\n", nread);
            printf("Conteúdo recebido: velocidade=%d, rpm=%d, temp=%f\n",
                    p->vel, p->rpm, p->temp);

            /*
            printf("Contéudo recebido: rpm=%d, vel=%d, temp=%f, acel=%d, dist=%d, comb=%d, volt=%d, ambtemp=%d\n",
            p->rpm, p->vel, p->temp, p->acel, p->dist, p->comb, p->volt, p->ambtemp);


            */
            printf("Evnia os dados de volta.. ");
            sendMsg(csock, p, sizeof(payload));

            thing["Velocidade"] >> outputValue(p->vel);

            thing["RPM"] >> outputValue(p->rpm);

            thing["Temperatura"] >> outputValue(p->temp);

             thing.start();

        }

    closeSocket(ssock);
    printf("sair");
    return 0;
}
