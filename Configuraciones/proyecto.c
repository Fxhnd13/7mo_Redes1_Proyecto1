#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

char* ejecutarComando(char[]);
int *separador(char[]);
void regular(int);
int potenciaNueva(int);
char *itoa(int, char*, int);


int main(){
    ejecutarComando("iwconfig wlo1 txpower 0");
    while(1){
        separador(ejecutarComando("iw dev wlo1 station get AC:AF:B9:66:F7:62 | grep signal:"));
        usleep(5*1000000);
    }
}

char *ejecutarComando(char comando[]){
    char *resultado = malloc(2000);
    FILE *fp;
    char path[1065];

    fp = popen(comando,"r");
    if(fp == NULL){
        printf("Fallo correr el comando");
        exit(1);
    }

    while (fgets(path, sizeof(path), fp) != NULL){
        strcat(resultado, path);
    }

    pclose(fp);
    return resultado;
}

int *separador(char resultado[]){
    char delim[] = " ";
    char *ptr = strtok(resultado, delim);
    int i = 0;
    if(ptr != NULL){
        while (ptr != NULL){
            if((i++)==1) regular(atoi(ptr));
            ptr = strtok(NULL, delim);
        }
    }
    return 0;
}

void regular(int db){
    int dbRecibida = db * -1;
    int potencia = potenciaNueva(dbRecibida);
    printf("La señal recibida del dispositivo fue de %d db, se ha modificado la potencia del dispositivo a %d db\n", dbRecibida, potencia);
}

int potenciaNueva(int dbRecibida){
    if(dbRecibida < 55){
        ejecutarComando("iwconfig wlo1 txpower 0");
        return 0;
    }else if(dbRecibida < 60){
        ejecutarComando("iwconfig wlo1 txpower 2");
        return 2;
    }else if(dbRecibida < 65){
        ejecutarComando("iwconfig wlo1 txpower 4");
        return 4;
    }else if(dbRecibida < 70){
        ejecutarComando("iwconfig wlo1 txpower 6");
        return 6;
    }else if(dbRecibida < 75){
        ejecutarComando("iwconfig wlo1 txpower 8");
        return 8;
    }else if(dbRecibida < 80){
        ejecutarComando("iwconfig wlo1 txpower 10");
        return 10;
    }else if(dbRecibida < 85){
        ejecutarComando("iwconfig wlo1 txpower 12");
        return 12;
    }else if(dbRecibida < 90){
        ejecutarComando("iwconfig wlo1 txpower 14");
        return 14;
    }else if(dbRecibida < 95){
        ejecutarComando("iwconfig wlo1 txpower 16");
        return 16;
    }else if(dbRecibida < 100){
        ejecutarComando("iwconfig wlo1 txpower 18");
        return 18;
    }else if(dbRecibida < 105){
        ejecutarComando("iwconfig wlo1 txpower 20");
        return 20;
    }
}