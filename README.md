# Práctica de Generador de Código Intermedio

> Sentencias de control

1. Suponga la siguiente gramática que representa la sintaxis de un lenguaje que solo permite que sus programas tengan sentencias de selección.

start → programa

programa → programa sent

programa → sent

sent → sel | asig

asig → ID := exp

sel → IF cond THEN programa ENDIF

sel → IF cond THEN programa ELSE programa ENDIF

cond → IF < CTE

exp → exp + term

exp → term

term → term * factor

term → factor

factor → CTE

factor → ID

a) Representar la siguiente sentencia en polaca inversa de manera que toda la semántica sea resuelta en la notación intermedia

```
IF a < 3 THEN
  b:= c+1
  a:= 28
ELSE
  IF b < 245 THEN
    a:= c + 67 * b
  ENDIF
ENDIF
```

b) Escribir las acciones semánticas en cada regla para generar código en polaca inversa para cualquier sentencia con el formato indicado.

c) Testear con las acciones escritas en el punto b), el resultado del punto a)

2. Suponga la gramática del ejercicio anterior

a) Representar el siguiente programa en tercetos de manera que toda la semántica sea resuelta en la notación intermedia

```
IF a < 3 THEN
  b:= c+1
  a:= 28
ELSE
  IF b < 245 THEN
    a:= c+ 67 * b
  ENDIF
ENDIF
```

b) Escribir las acciones semánticas en cada regla para generar código en tercetos para cualquier sentencia con el formato indicado.

c) Testear con las acciones escritas en el punto b), el resultado del punto a)

3. Suponga la gramática de un lenguaje que solo soporta sentencias de ciclos (del tipo FOR) y sentencias de asignación

start → programa

programa → programa sent

programa → sent

sent → ciclo | asig

asig → ID := exp

ciclo → FOR inicio { programa } FOREND

inicio → ID = CTE TO CTE

exp → exp + term

exp → term

term → term * factor

term → factor

factor → CTE

factor → ID

a) Representar el siguiente programa en tercetos de manera que toda la semántica sea resuelta en la notación intermedia

```
c:=0
FOR i:=1 TO 20
{
a:= c+ 67 * b
b:=b+1
c:=c+1
}
FOREND
```

b) Escribir las acciones semánticas en cada regla para generar código en tercetos para cualquier sentencia con el formato indicado.

c) Testear con las acciones escritas en el punto b), el resultado del punto a)

4. Suponga la siguiente gramática que representa la sintaxis de un lenguaje que solo permite que sus programas tengan sentencias de ciclos del tipo “while”.

start → programa

programa → programa sent

programa → sent

sent → asig | ciclo

ciclo → WHILE cond programa END

cond → exp <= exp

asig → id := exp

exp → exp + term

exp → exp - term

exp → term

term → term * factor

term → factor

factor → CTE

factor → ID

a) Representar la siguiente sentencia en polaca inversa de manera que toda la semántica sea resuelta en la notación intermedia

```
WHILE a*3 <= b
  a:= a+2
  b:= 5
  WHILE b <= 5
    a:= a+1
  END
END
```

b) Escribir las acciones semánticas en cada regla para generar código en árbol sintáctico para cualquier sentencia con el formato indicado.

c) Testear con las acciones escritas en el punto b), el resultado del punto a)