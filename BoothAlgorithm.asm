
variableA: 0b0 
Q: 0b10000001 ; Multiplicador
Q_1: 0b0
M: 0b11111101; Multiplicando
count: 0x8

Bmenos: 0b00000001
Qcero: 0b0
QSHBMAS: 0b0


Loop_principal:

MOV ACC, Bmenos ;Cargar Bmenos en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
MOV A, ACC      ;Mover ACC a A
                ;A = 00000001 

MOV ACC, Q   	;Cargar Q en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
AND ACC, A      ;Añadir A y ACC
MOV A, ACC      ;Mover ACC a A
                ;A = Q AND BMENOS = QCERO

MOV ACC, Qcero  ;Cargar una variable x en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, A      ;Mover A a ACC
MOV [DPTR], ACC ;Cambiar el contenido del DPTR a ACC
                ;Qcero = El BMENOS DE Q	

MOV ACC, Q_1    ;Cargar Q_1 en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
INV ACC         ;Invertir ACC
MOV A, ACC      ;Mover ACC en A
                ;A = [QMAS] C1

MOV ACC, 0x1    ;Cargar 1 en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
ADD ACC, A      ;Sumar A a ACC
MOV A, ACC     ;Mover ACC en A 
                ;A = [QMAS] C2

MOV ACC, Qcero  ;Cargar Qcero en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
ADD ACC, A      ;Añadir A a ACC
MOV A, ACC      ;Mover ACC en A 
                ;A = QCERO - QMAS

JZ Shift        ;JumpZero hacia Shift

JN Suma         ;JumpNegative hacia Suma

JMP Resta       ;Jump hacia Resta

Pos_corrida:

MOV ACC, 0x1    ;Cargar 1 en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
INV ACC         ;Invertir ACC
MOV A, ACC     ;Mover ACC en A 
                ;A = [1] C1

MOV ACC, 0x1    ;Cargar 1 en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
ADD ACC, A      ;Sumar A a ACC
MOV A, ACC     ;Mover ACC en A 
                ;A = [1] C2

MOV ACC, count  ;Cargar count en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
ADD ACC, A      ;Añadir A a ACC    ACC = Count - 1
MOV [DPTR], ACC ;Mover ACC a contenido de DPTR  
                ;Count = Count - 1

JZ Fin          ;JumpZero hacia Fin

JMP Loop_principal     ;Jump devuelta al Loop_principal

Fin:
HLT             ;Etiqueta de finalizacion del programa

Shift:

MOV ACC, Bmenos ;Cargar una variable x en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
MOV A, ACC      ;Mover ACC a A
                ;A = 00000001 

MOV ACC, variableA    ;Cargar variableA en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
AND ACC, A      ;Añadir A a ACC    BMENOS & AMUL
                ;ACC = EL BMENOS DE AMUL

LSH ACC 0x7     ;ShiftLeft - Izquierda
MOV A, ACC      ;Mover ACC en A 
                ;A = EL BMENOS DE AMUL EN LA POS. DE BMAS

MOV ACC, QSHBMAS    ;Cargar una variable x en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, A	;Mover A a ACC	
MOV [DPTR], ACC ;Mover ACC a al contenido de DPTR (QSHBMAS)		
                ;QSHBMAS = SHIFT BMAS PARA Q 

MOV ACC, variableA    ;Cargar variableA en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
                ;ACC = variableA

RSH ACC 0x1     ;ShiftRight - Derecha
                ;ACC = SHIFT AMUL
	
MOV [DPTR], ACC ;Mover ACC a al contenido de DPTR (AMUL)		
                ;AMUL = SHIFT AMUL

MOV ACC, Bmenos ;Cargar Bmenos en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
MOV A, ACC      ;Mover ACC a A
                ;A = 00000001 

MOV ACC, Q      ;Cargar una variable x en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
AND ACC,A       ;Añadir A a ACC    BMENOS & Q
MOV A, ACC      ;Mover ACC en A 
                ;A = EL BMENOS DE Q

MOV ACC, Q_1    ;Cargar Q_1 en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, A       ;Mover A a ACC	
MOV [DPTR], ACC ;Mover ACC a al contenido de DPTR (QMAS)		
                ;QMAS = BMENOS DE Q

MOV ACC, Q    ;Cargar Q en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
                ;ACC = Q

RSH ACC 0X1     ;ShiftRight - Derecha

MOV [DPTR], ACC ;Mover ACC a al contenido de DPTR (Q)		
                ;Q = SHIFT Q

MOV ACC, QSHBMAS 	;Cargar QSHBMAS en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
MOV A, ACC      ;Mover ACC en A 
                ;A = QSHBMAS

MOV ACC, Q      ;Cargar una variable x en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
AND ACC, A      ;Anadir A a ACC (Q & QSHBMAS)
MOV [DPTR], ACC ;Mover ACC a al contenido de DPTR 
                ;Q = Q & QSHBMAS

JMP Pos_corrida ;Jump a count--

Suma:

MOV ACC, M    	;Cargar M en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
MOV A, ACC      ;Mover ACC en A 
                ;A = M

MOV ACC, variableA    ;Cargar variableA en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
ADD ACC, A      ;Sumar A a ACC
MOV [DPTR], ACC ;AMUL = AMUL + M

JMP Shift       ;Jump hacia el Shift

Resta:

MOV ACC, M    	;Cargar M en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
INV ACC         ;Invertir ACC
MOV A, ACC      ;Mover ACC en A
                ;A = [M] C1

MOV ACC, 0x1    ;Cargar 1 en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
ADD ACC, A      ;Sumar A a ACC
MOV A, ACC     ;Mover ACC en A 
                ;A = [M] C2

MOV ACC, variableA    ;Cargar variableA en el ACC
MOV DPTR, ACC   ;Apuntar a la dirección de ACC
MOV ACC, [DPTR] ;Mover el contenido del DPTR al ACC
ADD ACC, A      ;Sumar A a ACC
MOV [DPTR], ACC ;AMUL = AMUL - M

JMP Shift       ;Jump hacia el Shift

