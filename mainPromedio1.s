/* ***************************************************************** 
   promedio.s
   Programa que calcula el promedio de dos numeros,
   uno almacenado en memoria y uno ingresado por el usuario.
   
   Autor: Juana Rivera
   
   Uso de registros:
   r0: envio de parametros para subrutinas promedio, printf, scanf, puts
   r1: envio de parametros para subrutinas promedio, printf, scanf
   ***************************************************************** */

.data
.align 2
datoPromedio:	.word	0 /*Almacena el promedio de los dos numeros*/
formatop:		.asciz	"El promedio de los numeros es: %d  \n"
datoIng:		.word	0 /*Dato ingresado por el usuario*/
dato2:			.word	5

formatos:		.asciz	"%d"
stringIngreso:	.asciz	"Ingrese un numero: "
bienvenida:		.asciz	"Bienvenid@! Este programa calcula el promedio de dos numeros, uno almacenado en memoria y uno ingresado por usted."
error:			.asciz	"Error, el dato ingresado es incorrecto. Intente nuevamente."

.text
.align 2

.global main
.type main,%function
main:
	stmfd sp!,{lr}
	
	@Bienvenida al programa
	ldr r0, =bienvenida
	bl puts

	/*Ingreso de datos del usuario*/
	ingresoDatos:
		ldr r0,=stringIngreso
		bl puts
		ldr r0,=formatos
		ldr r1,=datoIng
		bl scanf

	/*Programacion defensiva
	Revisa que el numero ingresado sea correcto*/
	cmp r0,#0
	bne calculo
	bl getchar	/*para que el programa lea <enter> para continuar*/
	ldr r0,=error
	bl puts
	b ingresoDatos
	
	@Calculo y despliegue del promedio
	calculo:
		ldr r0,=datoIng
		ldr r0,[r0]
		ldr r1,=dato2
		ldr r1,[r1]
		bl promedio    @ LLAMADO A LA SUBRUTINA PROMEDIO
		@en r0 viene el promedio
		mov r1,r0
		ldr r0,=formatop
		bl printf

		bl random
		mov r1,r0
		ldr r0,=formatos
	mov r3,#0
	mov r0,#0
	ldmfd sp!,{lr}
	bx lr

