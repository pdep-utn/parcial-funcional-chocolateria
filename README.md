# Haskellate
 
[![Build Status](https://travis-ci.com/Juancete/chocolateria.svg?token=7kn2iattJERWx3nrSmdM&branch=master)](https://travis-ci.com/Juancete/chocolateria)
 
![Cover](images/chocolate_cocoa_spoon.jpg)
 
### Temas a evaluar
- [ ] Composición
- [ ] Efecto colateral
- [ ] Aplicación parcial
- [ ] Recursividad
- [ ] Orden superior
- [ ] Evaluación diferida
- [ ] Modelado de información
- [ ] Sistema de tipos
 
Se viene el frío y para pasar esta cuarentena que mejor que hacer un emprendimiento de chocolatería. Como buenos desarrolladores funcionales, vamos a modelar nuestro negocio.
 
## Primera parte
 
Los chocolates que vamos a hacer pueden tener una combinación de ingredientes que resultará en los distintos sabores que vamos a ofrecer a nuestros clientes. Cada ingrediente aporta un determinado nivel de calorías. Por ejemplo agregar Naranja aporta 20 calorías.
 
La gente de marketing de la empresa nos sugirió que los chocolates tengan un nombre *fancy* para la venta. Por ejemplo "chocolate Rap a Niu" o "Roca blanca con almendras".
 
Lo que tenemos que determinar en primer lugar es cuánto nos sale cada chocolate: los chocolates amargos (que tienen más de un 60% de cacao) se calculan como el gramaje del chocolate multiplicado por el *precio premium*. Por el contrario, si tiene más de 4 ingredientes, el precio es de $8 por la cantidad de ingredientes que tiene. Caso contrario, el costo es de $1,5 por gramo.
 
El *precio premium* varía si es apto para diabéticos (es decir que el chocolate tiene cero gramos de azúcar) en cuyo caso es de $8 por gramo o bien es de $5 por gramo.
 
## Punto 1 (4 puntos)
Modelar el chocolate e implementar el cálculo de su precio en base a la descripción anterior.
 
## Punto 2 (3 puntos)
 
Necesitamos saber
- Cuando un chocolate **esBombonAsesino** que ocurre cuando tiene algún ingrediente de más de 200 calorías.
- También queremos saber el **totalDeCalorias** para un chocolate que es la sumatoria de los aportes de cada ingrediente.
- Y por último, dada una caja de chocolates, queremos tomar los chocolates **aptoParaNinios** donde separamos 3 chocolates que no son bombón asesino, sin importar cuáles.
 
## Segunda Parte
 
Excelente!! Ahora nos toca pensar qué procesos podemos realizar sobre el chocolate. Si bien hay fanáticos del chocolate amargo (como quien les escribe) también podemos realizar modificaciones o agregados:
- Por ejemplo el **frutalizado** permite agregarle como ingrediente una cierta cantidad de gramos de una fruta. Toda fruta tiene dos calorías por cada gramo.
- Un clásico es el **dulceDeLeche** que agrega dicho ingrediente el cual siempre siempre aporta 220 calorías. Además al nombre del chocolate le agrega al final la palabra *"tentación"*: Por ejemplo el *"Chocolate con almendras"* pasa a ser *"Chocolate con almendras tentación"*.
- Otro famoso proceso es la **celiaCrucera** que dada una cantidad de gramos, aumenta el nivel de azúcar del chocolate.
- Por último contamos con la **embriagadora**  que para un determinado grado de alcohol aporta como ingrediente Licor con una caloría por cada grado de alcohol con un tope máximo de 30 calorías. Es decir que si agregamos una bebida con 40 grados, son 30 calorías de licor. En cambio si ponemos una bebida con 20 grados, son 20 calorías aportadas. Además agrega 100 gramos de azúcar.
 ## Punto 3 (3 puntos)
Modelar cada uno de los procesos sobre el chocolate. Tengamos en cuenta que a futuro podemos implementar nuevos procesos para generar chocolates más novedosos. Evitar la repetición de lógica y código.
 
## Punto 4 (1 punto)
Dar un ejemplo de una receta que conste de los siguientes procesos: agrega 10 gramos d Naranja, dulce de leche y un licor de 32 grados.
 
## Punto 5 (2 puntos)
Implementar la preparación de un chocolate que en base a un chocolate base y una serie de procesos para obtener el chocolate resultante. En este punto **NO se puede utilizar recursividad.**
 
## ¡Última parte!
Por otra parte tenemos a las personas, de las cuales se sabe que tienen un límite de saturación para las calorías y además tienen un determinado criterio para rechazar ciertos ingredientes. Por ejemplo a Juan no le gusta la Naranja y a Cecilia no le gusta los ingredientes pesados (de más de 200 calorías). Cada persona podría tener un criterio distinto.
 
## Punto 6 (2 Puntos)
 
Resolver la función **hastaAcaLlegue** que dada una persona y una caja de chocolates, devuelve los chocolates que puede comer. La persona come el chocolate mientras no tenga un ingrediente que rechace por el criterio de la persona o bien porque al comerlo, todavía no llegó a su nivel de saturación de calorías. Este punto tiene que ser resuelto **utilizando recursividad**.
 
## Punto 7 (1 Punto)
Dada una caja de chocolates infinitos, es posible determinar cuales son los chocolates **aptosParaNinios** y el **totalCalorias**? Justifique su respuesta.
 
## Puntajes
Puntos | Nota
------ | -----
16 | 10
15 | 9
13 - 14 | 8
11 - 12 | 7
10 | 6
9 - 10 | Revisión
< 9 | Desaprobado