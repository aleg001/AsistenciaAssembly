/* ***************************************************************** 
   promedio.s
   Subrutina que calcula el promedio de dos numeros
   
   Uso de registros:
   r0: envio de parametros para subrutinas promedio, printf, scanf, puts
   r1: envio de parametros para subrutinas promedio, printf, scanf
   ***************************************************************** */
.text
.align 2

@Subrutina que calcula el promedio de dos numeros y devuelve el promedio 
@Parametros de entrada:
@r0: numero 1
@r1: numero 2
@Parametros de salida
@r0: promedio
.global promedio
promedio:
	add r0,r0,r1
	lsr r0,#1	@division entre 2
	mov pc,lr

.global cuadrado
cuadrado:
	mul r1,r1,r1 
   mul r2,r2,r2 @al cuadrado
   add r0,r1,r2 
   
	mov pc,lr

.global restacuad
restacuad:
   mul r1,r1,r1
   mul r2,r2,r2 @multiplicacion
   sub r0,r1,r2

   mov pc,lr
