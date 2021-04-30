/* ***************************************************************** 
   promedio.s
   Programa que calcula el promedio de dos numeros,
   uno almacenado en memoria y uno ingresado por el usuario.
   
   Autor: Juana Rivera
   
   Uso de registros:
   r0: envio de parametros para subrutinas promedio, printf, scanf, puts
   r1: envio de parametros para subrutinas promedio, printf, scanf
   ***************************************************************** */

	/* ADAPTACION DE PROGRAMA PARA
   	   EJERCICIO DE ASISTENCIA.
	Cambios realizados por: Alejandro Gómez */

.data
.align 2
datoPromedio:	.word	0 /*Almacena el promedio de los dos numeros*/
formatop:		.asciz	"El promedio de los numeros es: %d  \n"
datoIng:		.word	0 /*Dato ingresado por el usuario*/
dato2:			.word	0
menuOp:			.word 	0

formatos:		.asciz	"%d"
stringIngreso:	.asciz	"Ingrese un numero: "
bienvenida:		.asciz	"Bienvenid@! Este programa calcula el promedio de dos numeros, uno almacenado en memoria y uno ingresado por usted."
error:			.asciz	"Cuidado mi pana!! El dato ingresado es incorrecto. Intente nuevamente."
Ingreso2:		.asciz "Ingrese segundo numero: "
Menu:			.asciz "1) a*2 + b*2 \n2) a*2 - b*2 \n3) exit "

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

		/* Se agrega opcion para ingreso del segundo valor */
		ldr r0,=Ingreso2
		bl puts
		ldr r0,=formatos 
		ldr r2,=dato2
		bl scanf
	
	b MenuRealizado

	MenuRealizado:

		/* Se define procesos de menu
			
			1) a*2 + b*2
			2) a*2 - b*2
			3) exit program */

		ldr r0,= bienvenida
		bl puts
		ldr r0,= menu
		bl puts
		ldr r0,=stringIngreso
		bl puts
		ldr r0,=formatos
		ldr r1,=menuOp
		bl scanf
		ldr r0,=menuOp
		ldr r3,[r0]
		cmp r3,#2
		beq PrimerCalculo
		blt calculo
		bhi exitP

	/*Programacion defensiva
	Revisa que el numero ingresado sea correcto*/
	cmp r0,#0
	bne calculo
	bl getchar	/*para que el programa lea <enter> para continuar*/
	ldr r0,=error
	bl puts
	b ingresoDatos
	

	cicloMenu:
		ldr r0,=menu


	@Calculo y despliegue de suma de cuadrado
	PrimerCalculo:
		ldr r0,=datoIng
		ldr r0,[r0]
		ldr r1,=dato2
		ldr r1,[r1]
		bl cuadrado    @ LLAMADO A LA SUBRUTINA cuadrado
		@en r0 viene el promedio
		mov r1,r0
		ldr r0,=formatop
		bl printf

		bl random
		mov r1,r0
		ldr r0,=formatos

	@Calculo y despliegue de resta del cuadrado
	calculo:
		ldr r0,=datoIng
		ldr r0,[r0]
		ldr r1,=dato2
		ldr r1,[r1]
		bl restacuad    @ LLAMADO A LA SUBRUTINA cuadrado
		@en r0 viene el promedio
		mov r1,r0
		ldr r0,=formatop
		bl printf

		bl random
		mov r1,r0
		ldr r0,=formatos

	exitP:
		mov r3,#0
		mov r0,#0
		ldmfd sp!,{lr}
		bx lr

