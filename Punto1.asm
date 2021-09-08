;Laboratorio 2-punto 1
;FRANZ LOPEZ ARREDONDO 2420191051
        .MODEL  SMALL
        .CODE
        ORG     100H
BEGIN:  JMP     SHORT MAIN
CTR     DB      48   ;Desde donde inicia el codigo " numeros"
COL     DB      24   ; ajuste horizontal 
ROW     DB      08   ; ajuste vertical 
MODE    DB      ?             
VCX     DW      10 
;               Procedimiento principal: 
;               ------------------------

MAIN    PROC    NEAR
        CALL    B10MODE
        CALL    C10CLR         
A20:
        CALL    D10SET  
        CMP     CTR,3AH  ; limite de presentacion de caracteres 
        JE      A30
        CALL    E10DISP
        INC     CTR
        ADD     COL,02
        CMP     COL,44
        JNE     A20
        INC     ROW
        MOV     COL,24 
        JMP     A20   
A30:         
        MOV     CTR,30H 
        MOV     CX,VCX 
        DEC     VCX
        LOOP    A20
        CALL    F10READ
        CALL    G10MODE
        MOV     AX,4C00H
        INT     21H
MAIN    ENDP
;               Obtener y designar el modo de video
;               -----------------------------------
B10MODE PROC    NEAR
        MOV     AH,0FH
        INT     10H
        MOV     MODE,AL
        MOV     AH,00H
        MOV     AL,03
        INT     10H
        RET
B10MODE ENDP
;               Limpia la pantalla y crea una ventana
;               -------------------------------------
C10CLR  PROC    NEAR
        MOV     AH,08H
        INT     10H
        MOV     BH,AH
        MOV     AX,0600H
        MOV     CX,0000
        MOV     DX,184FH
        INT     10H
        MOV     AX,0610H
        MOV     BH,10H     ; cambio de color fondo;letras
        MOV     CX,0718H   ; cambio de tamaño de fondo 
        MOV     DX,1130H   ; cambio de tamaño de fondo 
        INT     10H
        RET
C10CLR  ENDP
;               Coloca el cursor en el renglon y columna:
;               -----------------------------------------
D10SET  PROC    NEAR
        MOV     AH,02H
        MOV     BH,00
        MOV     DH,ROW
        MOV     DL,COL
        INT     10H
        RET
D10SET  ENDP
;               Despliega caracteres ASCII:
;               ---------------------------
E10DISP PROC    NEAR
        MOV     AH,0AH
        MOV     AL,CTR
        MOV     BH,00
        MOV     CX,01
        INT     10H 
        RET
E10DISP ENDP
;               Obliga a detenerse, obtiene un caracter del teclado
;               ---------------------------------------------------
F10READ PROC    NEAR
        MOV     AH,10H
        INT     16H
        RET
F10READ ENDP    
        
;               Restaura el modo de video original
;               ----------------------------------
G10MODE PROC    NEAR
        MOV     AH,00H
        MOV     AL,MODE
        INT     10H
        RET
G10MODE ENDP
        END     BEGIN
