# Haskellate

[![Build Status](https://travis-ci.com/Juancete/chocolateria.svg?token=7kn2iattJERWx3nrSmdM&branch=master)](https://travis-ci.com/Juancete/chocolateria)


### Temas a evaluar
- [ ] Composición 
- [ ] Efecto colateral 
- [ ] Aplicación parcial 
- [ ] Recursividad
- [ ] Orden superior
- [ ] Evaluación diferida
- [ ] Modelado de información
- [ ] Sistema de tipos

Se viene el frío y para pasar esta cuarentena que mejor que hacer un emprendimiento de chocolatería. Como buenos desarolladores funcionales, vamos a modelar nuestro negocio.

## Primera parte

Los chocolates que vamos a hacer pueden tener una combinación de ingredientes que resultará en los distintos sabores que vamos a ofreceer a nuestros clientes. Cada ingrediente aporta un determinado nivel de calorías. Por ejemplo agregar Naranja aporta 20 calorías.

Lo que tenemos que determinar en primer lugar es cuanto nos sale cada chocolate: Los chocolates amargos (que tienen más de un 60% de cacao) se calculan como el gramaje del chocolate multiplicado por el *precio premium*. Por el contrario, si tiene más de 4 ingredientes, el precio es de $8 por la cantidad de ingredientes que tiene. Caso contrario, el costo es de $1,5 por gramo.

El *precio premium* varía si es apto para diabéticos (es decir que el chocolate tiene cero gramos de azucar) en cuyo caso es de $8 por gramo o bien es de $5 por gramo.

### Punto 1
Modelar el chocolate e implementar el cálculo de su precio.

### Punto 2

Necesitamos saber
- Cuando un chocolate es **esBombonAsesino** que ocurre cuando tiene algún ingrediente de más de 200 calorías.
- También querémos saber el **totalDeCalorias** para un chocolate que es la sumatoria de los aportes de cada ingrediente.
- Y por último, dada una caja de chocolates, queremos tomar los chocolates **aptoParaNinios** donde separamos 3 chocolates que no son bombon asesino.

## Segunda Parte

Excelente!! Ahora nos toca pensar que procesos podemos realizar sobre el chocolate. Si bien hay fanáticos del chocolate amargo (como quién les escribe) también podemos realizar modificaciones o agregados:
- Por ejemplo el **frutalizado** permite agregarle un ingrediente determinando la frutas en una cirta cantidad de gramos. Las calorías que representa la fruta son dos por cada gramo. 
- Un clásico es el **dulceDeLeche** que agrega dicho ingrediente el cual siemrpe siempre aprota 220 calorías. Además al nombre del chocolate le agrega al final la palabra *"tentación"*: Por ejemeplo el *"Chocolate con almendras"* pasa a ser *"Chocolate con almendras tentación"*.
- Otro famoso proceoso es la **celiaCrucera** que dad auna cantidad de gramos, aumenta el nivel de azucar del chocolate.
- Por último contamos con la **embriagadora**  que para un determinado grado de alcohol aporta como ingrediente Licor con una caloría por cada grado de alcohol con un tope máximo de 30 calorías. Es decir que si agregamos una bebida con 40 grados, son 30 calorías de licor. En cambio si ponemos una bebida con 20 grados, son 20 calorías aportadas. Además agrega 100 gramos de azucar. 
  
### Punto 3 
Modelar los procesos sobre el chocolate. 

### Punto 4
Implementar la preparación de un chocolate que en base a un chocolate base y una serie de procesos, obtenemos el chocolate resultante. 

## ¡Última parte!
Por otra parte tenemos a las personas, de las cuales se sabe que tienen un límite de daturación para las calorías y además tienen un determinado criterio para rechazar ciertos ingredientes. Por ejemplo a Juan no le gusta la Naranja y a Cecilia no le gusta que tenga algún ingrediente pesado (de más de 200 calorías). Cada persona podría tener un criterio distinto. 

### Punto 5

Resolver la función **hastaAcaLlegue** que dada una persona y una caja de chocolates, devuelve los chocolates que puede comer. La persona come el chocolate mientras no tenga un ingrediente que rechaze por el criterio de la persona o bien porque al comerlo, todavía no llegó a su nivel de saturación de calorías. 