
variableA: 0b00000000
Q: 0b00000011 ; Multiplicador
Q_1: 0b0
M: 0b11111001; Multiplicando
count: 0x8

Bmenos: 0b00000001
Qcero: 0b00000000
QSHBMAS: 0b00000000


Loop_principal:

		mov ACC, 0b00000001 ;Cargar Bmenos en el ACC	
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
         			;Qcero = El BMENOS DE Q	

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

		0X0B 
		Shift        ;JumpZero hacia Shift

		

		call Resta      ;Jump hacia Resta

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

		mov ACC, 0b00000001 ; Cargar una variable x en el ACC		
		mov A, ACC      ; Mover ACC a A
		                ; A = 00000001 

		mov ACC, variableA    ; Cargar variableA en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		and ACC, A      ; Añadir A a ACC    BMENOS & AMUL
		                ; ACC = EL BMENOS DE AMUL

		lsh ACC 0x7   ; ShiftLeft - Izquierda
		mov A, ACC      ; Mover ACC en A 
		                ; A = EL BMENOS DE AMUL EN LA POS. DE BMAS

		mov ACC, QSHBMAS    ; Cargar una variable x en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, A	; Mover A a ACC	
		mov [DPTR], ACC ; Mover ACC al contenido de DPTR (QSHBMAS)		
		                ; QSHBMAS = SHIFT BMAS PARA Q 

		mov ACC, variableA    ; Cargar variableA en el ACC
		mov DPTR, ACC   ; Apuntar a la dirección de ACC
		mov ACC, [DPTR] ; Mover el contenido del DPTR al ACC
		                ; ACC = variableA

		rsh ACC 0x1    ; ShiftRight - Derecha
		                ; ACC = SHIFT AMUL
	
		mov [DPTR], ACC ; Mover ACC al contenido de DPTR (AMUL)		
		                ; AMUL = SHIFT AMUL

		mov ACC, 0b00000001 ; Cargar Bmenos en el ACC
		
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
		                ; QMAS = BMENOS DE Q

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
		mov A, ACC      ; Mover ACC en A 
		                ; A = A + variableA

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
		mov [DPTR], ACC ; A = A - variableA, almacenar en variableA

		call Shift      ; Llamar a la rutina Shift
