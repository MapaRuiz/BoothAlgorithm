
variableA: 0b0 
Q: 0b10000001 ; Multiplicador
Q_1: 0b0
M: 0b11111101; Multiplicando
count: 0x8

Qcero: 0b00000000
QSHBMAS: 0b00000000

Loop_principal:

		mov ACC, 0b00000001 ;Cargar 0b00000001 en el ACC	
		mov A, ACC      ;Mover ACC a A
		                ;A = 00000001 

		mov ACC, Q   	;Cargar Q en el ACC
		mov DPTR, ACC   ;Apuntar a la dirección de ACC
		mov ACC, [DPTR] ;Mover el contenido del DPTR al ACC
		and ACC, A      ;Añadir A y ACC
		mov A, ACC      ;Mover ACC a A
		                ;A = Q AND BMENOS = QCERO

		mov ACC, Qcero  ;Cargar una variable x en el ACC
		mov DPTR, ACC   ;Apuntar a la dirección de ACC
		mov ACC, A      ;Mover A a ACC
		mov [DPTR], ACC ;Cambiar el contenido del DPTR a ACC
         			;Qcero = El bit menos significativo de Q	

		mov ACC, Q_1    ;Cargar Q_1 en el ACC
		mov DPTR, ACC   ;Apuntar a la dirección de ACC
		mov ACC, [DPTR] ;Mover el contenido del DPTR al ACC
		inv ACC         ;Invertir ACC
		mov A, ACC      ;Mover ACC en A
                		;A = [QMAS] C1

		mov ACC, 0b00000001   ;Cargar 1 en el ACC
		
		add ACC, A      ;Sumar A a ACC
		mov A, ACC      ;Mover ACC en A 
         			;A = [QMAS] C2

		mov ACC, Qcero  ;Cargar Qcero en el ACC
		mov DPTR, ACC   ;Apuntar a la dirección de ACC
		mov ACC, [DPTR] ;Mover el contenido del DPTR al ACC
		add ACC, A      ;Añadir A a ACC
		mov A, ACC      ;Mover ACC en A 
                		;A = QCERO - QMAS

		
		jn Suma         ;JumpNegative hacia Suma

		jz Shift        ;JumpZero hacia Shift

		jmp Resta      ;Jump hacia Resta

Pos_corrida:

		mov ACC, 0b00000001   ;Cargar 1 en el ACC
		
		inv ACC         ;Invertir ACC
		mov A, ACC      ;Mover ACC en A 
		                ;A = [1] C1

		mov ACC, 0b00000001   ;Cargar 1 en el ACC
		
		add ACC, A      ;Sumar A a ACC
		mov A, ACC      ;Mover ACC en A 
		                ;A = [1] C2

		mov ACC, count  ;Cargar count en el ACC
		mov DPTR, ACC   ;Apuntar a la dirección de ACC
		mov ACC, [DPTR] ;Mover el contenido del DPTR al ACC
		add ACC, A      ;Añadir A a ACC    ACC = Count - 1
		mov [DPTR], ACC ;Mover ACC a contenido de DPTR  
		                ;Count = Count - 1

		jz Fin          ;JumpZero hacia Fin

		call Loop_principal     ;Jump devuelta al Loop_principal

Fin:	

		hlt             ;Etiqueta de finalizacion del programa		

Shift:

		mov ACC, 0b00000001 ; Cargar 0b00000001 en el ACC		
		mov A, ACC      ; Mover ACC a A
		                ; A = 00000001 

		mov ACC, variableA    ; Cargar variableA en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		and ACC, A      ; Añadir A a ACC    BMENOS & variableA
		                ; ACC = EL BMENOS DE variableA

		lsh ACC 0x7     ; ShiftLeft - Izquierda
		mov A, ACC      ; Mover ACC en A 
		                ; A = EL BMENOS DE variableA EN LA POS. DE BMAS

		mov ACC, QSHBMAS    ; Cargar una variable x en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, A	; Mover A a ACC	
		mov [DPTR], ACC ; Mover ACC al contenido de DPTR (QSHBMAS)		
		                ; QSHBMAS = BMAS PARA Q EN EL SHIFT 

		mov ACC, 0b10000000 ; Cargar 0b10000000 en el ACC		
		mov A, ACC      ; Mover ACC a A
		                ; A = 10000000 

		mov ACC, variableA    ; Cargar variableA en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		and ACC, A      ; Añadir A a ACC    BMENOS & variableA
		mov A, ACC      ; A = EL BMAS DE variableA
				
		mov ACC, variableA    ; Cargar variableA en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		                ; ACC = variableA

		rsh ACC 0x1     ; ShiftRight - Derecha
		                ; ACC = SHIFT variableA
		add ACC, A	; BMAS DE vA + SHIFT vA
	
		mov [DPTR], ACC ; Mover ACC al contenido de DPTR (variableA)		
		                ; variableA = SHIFT variableA

		mov ACC, 0b00000001 ; Cargar 0b00000001 en el ACC
		mov A, ACC      ; Mover ACC a A
		                ; A = 00000001 

		mov ACC, Q      ; Cargar una variable x en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		and ACC, A      ; Añadir A a ACC    BMENOS & Q
		mov A, ACC      ; Mover ACC en A 
		                ; A = EL BMENOS DE Q

		mov ACC, Q_1    ; Cargar Q_1 en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, A      ; Mover A a ACC	
		mov [DPTR], ACC ; Mover ACC al contenido de DPTR (QMAS)		
		                ; Q_1 = BMENOS DE Q

		mov ACC, Q      ; Cargar Q en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		                ; ACC = Q

		rsh ACC 0x1     ; ShiftRight - Derecha
		mov [DPTR], ACC ; Mover ACC al contenido de DPTR (Q)		
		                ; Q = SHIFT Q

		mov ACC, QSHBMAS 	; Cargar QSHBMAS en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		mov A, ACC      ; Mover ACC en A 
		                ; A = QSHBMAS

		mov ACC, Q      ; Cargar una variable x en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		add ACC, A      ; Añadir A a ACC (Q + QSHBMAS)
		mov [DPTR], ACC ; Mover ACC al contenido de DPTR 
		                ; Q = Q + QSHBMAS

		call Pos_corrida ; Jump a count--

Suma:

		mov ACC, M      ; Cargar M en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		mov A, ACC      ; Mover ACC en A 
		                ; A = M

		mov ACC, variableA    ; Cargar variableA en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		add ACC, A      ; Sumar A a ACC
		mov [DPTR], ACC      ; Mover ACC en A 
		                ; variableA = M + variableA

		call Shift      ; Llamar a la rutina Shift

Resta:

		mov ACC, M      ; Cargar M en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		inv ACC         ; Invertir ACC
		mov A, ACC      ; Mover ACC en A
		                ; A = [M]C1

		mov ACC, 0b00000001   ; Cargar 1 en el ACC
		
		add ACC, A      ; Sumar A a ACC
		mov A, ACC      ; Mover ACC en A 
		                ; A = [M]C2

		mov ACC, variableA    ; Cargar variableA en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		add ACC, A      ; Sumar A a ACC
		mov [DPTR], ACC ; variableA = variableA - M, almacenar en variableA

		call Shift      ; Llamar a la rutina Shift
