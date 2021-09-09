;Franz Lopez Arredondo 2420191051
;Electronica Digital 3
;Laboratorio 2 Parte 5

.MODEL SMALL
.STACK
.DATA
    N1 DB 0                 ; VARIABLE PARA ENTRADA 1
    N2 DB 0                 ; VARIABLE PARA ENTRADA 2
    N3 DB 0                 ; VARIABLE PARA RESULTADO
    M1 DB 10,13,' Ingrese un numero menos a 5  : $'    ; VARIABLE DE MENSAJE 1
    M2 DB 10,13,' Ingrese un numero menos a 5 : $'    ; VARIABLE DE MENSAJE 2
    M3 DB 10,13,' Resultado de la suma        : $'    ; VARIABLE DE MENSAJE RESULTADO
.CODE
MAIN:
    MOV AX, @DATA           ; ACUMULAR DIRECCION DE DATA
    MOV DS, AX              ; MOVER LA DIRECCION A DS
        
    MOV AH, 9               ; SERVICIO DE IMPRESION
    LEA DX, M1              ; OBTIENE LA DIRECCION DE M1
    INT 21H                 ; INTERRUPCION 21H
    MOV AH, 1               ; SERVICIO DE ENTRADA
    INT 21H                 ; INTERRUPCION 21H
    SUB AL, 30H             ; RESTAR 30H/48D 
    MOV N1, AL              ; MOVER ENTRADA A LA VARIABLE N1

    MOV AH, 9               ; BIS
    LEA DX, M2
    INT 21H
    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV N2, AL
    
    MOV AL, N1              ; MOV VARIABLE N1 A AL
    ADD AL, N2              ; SUMAR N1 Y N2
    ADD AL, 30H             ; SUMAR RESULTADO CON 30H/48D
    MOV N3, AL              ; MOVER RESULTADO A N3

    MOV AH, 9
    LEA DX, M3
    INT 21H
    MOV AH, 2               ; SERVICIO QUE EXHIBE RESULTADO
    MOV DL, N3              ; MUEVE RESULTADO A N3
    INT 21H     

    MOV AH, 4cH             ; SERVICIO DE FINALIZACION
    INT 21H
END MAIN
    