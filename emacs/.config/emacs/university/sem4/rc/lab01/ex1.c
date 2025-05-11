#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define PORT 1300
#define BUFFER_SIZE 1024


int main(){
  int sock;
  struct sockaddr_in server_addr;
  char buffer[BUFFER_SIZE] = "Hey, Server!";

  // Criar socket
  if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0){
    perror("!ERROR! Failed to create socket");

    exit(EXIT_FAILURE);

  }

  server_addr.sin_family = AF_INET;

}
