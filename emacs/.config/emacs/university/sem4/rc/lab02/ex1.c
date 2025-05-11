#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <time.h>

#define PORT 1300
#define BUFFER_SIZE 1024


void strdate(char *buffer, int len){
  time_t now = time(NULL);
  struct tm *ptm = localtime(&now);
  
  if (ptm == NULL){
    puts("The localtime() function failed\n");
    return;

  }

  strftime(buffer, len, "%c", ptm);

}


int main(){
  int server_fd, new_socket;
  struct sockaddr_in address;
  int addrlen = sizeof(address);
  char buffer[BUFFER_SIZE] = {0};

  // Criar socket
  if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0){
    perror("!ERROR! Failed to create the socket\n");
    
    exit(EXIT_FAILURE);

  }

  address.sin_family = AF_INET;
  address.sin_addr.s_addr = INADDR_ANY;
  address.sin_port = htons(PORT);

  // Associar socket a um endereço e porta
  if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0){
    perror("!ERROR! Failed to bind\n");

    exit(EXIT_FAILURE);

  }

  // Colocar socket em modo de escuta
  if (listen(server_fd, 3) < 0){
    perror("!ERROR! Failed to listen\n");

    exit(EXIT_FAILURE);

  }

  printf("Server is waiting for conections at port %d...\n", PORT);

  while (1){
    if ((new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen)) < 0){
      perror("!ERROR! Failed to accept conection\n");

      exit(EXIT_FAILURE);

    }

    read(new_socket, buffer, BUFFER_SIZE);
    printf("Message Received: %s\n", buffer);

    strdate(buffer, sizeof(buffer));

    send(new_socket, buffer, strlen(buffer), 0);
    close(new_socket);

  }

  return 0;

}
