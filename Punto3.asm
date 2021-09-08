;FRANZ LOPEZ ARREDONDO 2420191051
;Laboratorio 2 parte 3
;Electronica Digital III
            .MODEL  SMALL               ;Define el tamano el codigo
            .STACK  64
;--------------------------------------------------
            .DATA                       ;Espacio de almacenamiento de datos
NAMEPAR     LABEL   BYTE
MAXNLEN     DB      10
NAMELEN     DB      ?
NAMEFLD     DB      10  DUP(' ')        ;Duplica en memoria 15 lo que esta dentro de las comillas
SALIDA      DB      30  DUP(' ')
CANTIDAD    DB      ?
VAR_CX      DB      ?
     
PROMPT      DB      'Escriba:     ',  '$'     ;Guarda en memoria, el signo pesos es un delimitador
PREGUNTA    DB      'Desea repetir? Si, escriba 1, no, escriba 2:   ', '$'
;--------------------------------------------------
            .CODE
BEGIN       PROC    FAR
            MOV     AX,@data
            MOV     DS,AX
            MOV     ES,AX
            CALL    Q10CLR
A20LOOP:
            CALL    Q10CLR
            MOV     DX,0000
            CALL    Q20CURS
            CALL    B10PRMP
            CALL    D10INPT
            CALL    Q10CLR
            CMP     NAMELEN,00          ;Pregunta si entraron datos por teclado
            JE      A30                 ;Si el tamano de NAMELEN=0 salta a A30
            CALL    E10CODE
            CALL    F10CENT
            CALL    OTRAVEZ
            CALL    D10INPT
            CALL    ANALISIS
            JMP     A20LOOP
A30:
            MOV     AX,4C00H
            INT     21H
BEGIN       ENDP
;                   Exhibe indicador:
;--------------------------------------------------
B10PRMP     PROC    NEAR
            MOV     AH,09H              ;Despliega en pantalla PROMPT
            LEA     DX,PROMPT
            INT     21H
            RET
B10PRMP     ENDP
;                   Acepta entrada de nombre:
;--------------------------------------------------
D10INPT     PROC    NEAR
            MOV     AH,0AH              ;Peticion de entrada por teclado              
            LEA     DX,NAMEPAR          
            INT     21H
            RET
D10INPT     ENDP
;                   Fijar campana y delimitador '$':
;--------------------------------------------------
E10CODE     PROC    NEAR
            MOV     BH,00
            MOV     BL,NAMELEN
            MOV     CANTIDAD,00
            ADD     CANTIDAD,BL
            ADD     CANTIDAD,BL
            ADD     CANTIDAD,BL
            DEC     CANTIDAD
            DEC     CANTIDAD
            MOV     VAR_CX,BL
            MOV     CH,00
            LEA     SI,NAMEFLD
            LEA     DI,SALIDA    
            CALL    CAMBIO
            MOV     BH,00
            MOV     BL,CANTIDAD
            MOV     SALIDA[BX],07
            MOV     SALIDA[BX+1],'$'
            RET
E10CODE     ENDP
;                   Centrar y exhibir nombre:
;--------------------------------------------------
F10CENT     PROC    NEAR
            MOV     DH,NAMELEN              ;Para centrarlo en vertical
            SHR     DH,1
            NEG     DH
            ADD     DH,12
            MOV     DL,40
            CALL    Q20CURS
            MOV     AH,09H
            LEA     DX,SALIDA
            INT     21H
            RET
F10CENT     ENDP
;                   Despejar pantalla
;--------------------------------------------------
Q10CLR      PROC    NEAR
            MOV     AX,0600H
            MOV     BH,04
            MOV     CX,0000
            MOV     DX,184FH
            INT     10H
            RET
Q10CLR      ENDP
;                   Fijar hilera/columna de cursor
;--------------------------------------------------
Q20CURS     PROC    NEAR
            MOV     AH,02H
            MOV     BH,00
            INT     10H
            RET
Q20CURS     ENDP
;                   Cambio
;--------------------------------------------------
CAMBIO      PROC    NEAR
            MOV     AL,[SI]     
            MOV     [DI],AL     
            INC     SI          
            INC     DI          
            MOV     [DI],0AH
            INC     DI
            MOV     [DI],08H
            INC     DI
            MOV     CL,VAR_CX
            DEC     VAR_CX
            LOOP    CAMBIO
            RET
CAMBIO      ENDP
;                   Pregunta
;--------------------------------------------------                
OTRAVEZ     PROC    NEAR
            MOV     DX,0000H
            CALL    Q20CURS
            MOV     AH,09H              ;Despliega en pantalla PREGUNTA
            LEA     DX,PREGUNTA
            INT     21H
            RET
OTRAVEZ     ENDP
;                   Peticion respuesta
;--------------------------------------------------
PETICION    PROC    NEAR
            MOV     AH,0AH              ;Peticion de entrada por teclado                        
            INT     21H
            RET
PETICION    ENDP
;                   Analisis
;--------------------------------------------------
ANALISIS    PROC    NEAR
            CMP     NAMEFLD,31H
            JE      A20LOOP
            CMP     NAMEFLD,32H
            JE      A30
            JMP     A30
ANALISIS    ENDP
            END     BEGIN 
            