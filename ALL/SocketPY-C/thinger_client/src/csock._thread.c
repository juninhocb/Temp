#include <sys/socket.h>
#include <arpa/inet.h> //inet_addr
#include <unistd.h>    //write
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

#define BUFFSIZE 512

#pragma pack(1)

typedef struct payload_t {
    int id;
    int counter;
    float temp;
} payload;

#pragma pack()

struct client_data{
    int sk;
    struct sockaddr_in *client_addr;
};

int createSocket(int port);
void closeSocket(int sock);
void sendMsg(int sock, void* msg, int msgsize);

void * client_handle(void* cd){
    struct client_data *client = (struct client_data *)cd;
    char buff[BUFFSIZE];
    int nread;
    payload *p = (payload*) buff;

    while (1){

        memset(buff, 0, sizeof(buff));

        sleep(1);

        nread=read(client->sk, buff, 512);

        printf("\nReceived %d bytes\n", nread);
        payload *p = (payload*) buff;
        printf("Received contents: id=%d, counter=%d, temp=%f\n",
        p->id, p->counter, p->temp);

        printf("Sending it back.. ");
        sendMsg(client->sk, p, sizeof(payload));
        }


    return NULL;
}


int main()
{
    int PORT = 2300;
    char buff[BUFFSIZE];
    int ssock, csock;
    int nread;
    struct sockaddr_in client;
    int clilen;
    struct client_data *cd;
    pthread_t thr;

    ssock = createSocket(PORT);
    printf("Server listening on port %d\n", PORT);

    csock = accept(ssock, (struct sockaddr *)&client, &clilen);
        if (csock < 0)
        {
            printf("Error: Conexão Fail\n");
        }

        printf("Conexão bem sucedida com %s\n", inet_ntoa(client.sin_addr));
        bzero(buff, BUFFSIZE);


        cd = (struct client_data *)malloc(sizeof(struct client_data));
        cd->client_addr = (struct sockaddr_in*)malloc(sizeof(struct sockaddr_in));
        clilen = sizeof(struct sockaddr_in);

		/* Aguarda a conexão */
        cd->sk = accept(csock, (struct sockaddr*)cd->client_addr, (socklen_t*)&clilen);

        pthread_create(&thr, NULL, client_handle, (void *)cd);
        pthread_detach(thr);

    while(1){

    }
    return 0;
}

int createSocket(int port)
{
    int sock, err;
    struct sockaddr_in server;

    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        printf("ERROR: Socket creation failed\n");
        exit(1);
    }
    printf("Socket created\n");

    bzero((char *) &server, sizeof(server));
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = INADDR_ANY;
    server.sin_port = htons(port);
    if (bind(sock, (struct sockaddr *)&server , sizeof(server)) < 0)
    {
        printf("ERROR: Bind failed\n");
        exit(1);
    }
    printf("Bind done\n");

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
        printf("Can't send message.\n");
        closeSocket(sock);
        exit(1);
    }
    printf("Message sent (%d bytes).\n", msgsize);
    return;
}

