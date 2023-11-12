
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
AND ACC, A      ;Añadir A a ACC    BMENOS & Q
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
ADD ACC, A      ;Anadir A a ACC (Q + QSHBMAS)
MOV [DPTR], ACC ;Mover ACC a al contenido de DPTR 
                ;Q = Q + QSHBMAS

JMP Pos_corrida ;Jump a count--

