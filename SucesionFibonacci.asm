#calcular los primeros 12 numeros de fibbonacci y pongalos en un arreglo luego imprimase
      .data
fibs: .word   0 : 12        # "array" of 12 words to contain fib valuesde 12 palabras que contiene valores de fibonacci
size: .word  12             # tamaño del "array" 
      .text
      la   $t0, fibs        # carga de dirrecciones  array
      la   $t5, size        # cargar la dirección de la variable de tamaño
      lw   $t5, 0($t5)      # tamaño de la matriz de carga
      li   $t2, 1           # 1 es el primero y t2 es el segundo fibonnaci
      add.d $f0, $f2, $f4
      sw   $t2, 0($t0)      # F[0] = 1
      sw   $t2, 4($t0)      # F[1] = F[0] = 1
      addi $t1, $t5, -2     # Contador de bucle, se ejecutará (tamaño-2) veces
loop: lw   $t3, 0($t0)      # obtener valores desde el array F[n] 
      lw   $t4, 4($t0)      # obtener valores desde array F[n+1]
      add  $t2, $t3, $t4    # $t2 = F[n] + F[n+1]
      sw   $t2, 8($t0)      # almacena F[n+2] = F[n] + F[n+1] en array
      addi $t0, $t0, 4      # incrementar dirrecion de fibonnaci.
      addi $t1, $t1, -1     # decremenatar bucle contador
      bgtz $t1, loop        # repetir si no finaliza aun.
      la   $a0, fibs        # priemr valor en imprimirse (array)
      add  $a1, $zero, $t5  # segundo valor en impriomirse 
      jal  print            # rutina de impresion de llamados. 
      li   $v0, 10          # lamado al sistema para salir
      syscall               # salimos del programa.
		
#########  proceso para imp´rimir los numeros en una linea. 

      .data
space:.asciiz  " "          # insertar espacios entre numeros
head: .asciiz  "los numeros de fibonacci son:\n"
      .text
print:add  $t0, $zero, $a0  # dirreccion inicial de array
      add  $t1, $zero, $a1  # inizializacion de bluce contador del tamaño del array
      la   $a0, head        # cargar la dirección del encabezado de impresión
      li   $v0, 4           # especifica el servicio de cadena de impresión
      syscall               # imprimir encabezado
out:  lw   $a0, 0($t0)      # cargar número de fibonacci para syscall
      li   $v0, 1           # especifique el servicio de impresión de enteros
      syscall               # imprimir el numero de fibonacci
      la   $a0, space       # dirección de carga del espaciador para syscall
      li   $v0, 4           # especifique el servicio de cadena de impresión
      syscall               # cadena de salidad
      addi $t0, $t0, 4      # incremento de dirreccion
      addi $t1, $t1, -1     # decrementar bucle contador
      bgtz $t1, out         # repitase si no finaliza
      jr   $ra              # return