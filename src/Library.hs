module Library where
import PdePreludat

type Nombre = String
type Calorias = Number
type Porcentaje = Number 

type Ingrediente = (Nombre, Calorias)

data Chocolate = Chocolate {
  nombre :: String,
  porcentajeCacao :: Porcentaje,
  gramaje:: Number,
  azucar ::Number,
  ingredientes :: [Ingrediente]
} deriving (Show)

-- Punto 1
cantidadDeIngredientes :: Chocolate -> Number
cantidadDeIngredientes = length.ingredientes

precio choco | ((>60).porcentajeCacao) choco = gramaje choco * precioPorGramoPremium choco
 | ((>4).cantidadDeIngredientes) choco = (8 *).cantidadDeIngredientes $ choco
 | otherwise = gramaje choco * 1

precioPorGramoPremium:: Chocolate -> Number
precioPorGramoPremium choco | esAptoDiabeticos choco = 8
 | otherwise = 5

esAptoDiabeticos:: Chocolate -> Bool
esAptoDiabeticos = (==0).azucar


-- Punto 2 
type Caja = [Chocolate]

calorias ::Ingrediente -> Calorias
calorias (_,calorias) = calorias

esBombonAsesino :: Chocolate -> Bool
esBombonAsesino = any ((>200).calorias).ingredientes

totalCalorias :: Chocolate -> Calorias
totalCalorias = sum.map calorias.ingredientes 

aptosParaNinios :: Caja -> Caja
aptosParaNinios = take 3.filter (not.esBombonAsesino)


--Punto 3
agregarIngrediente :: Ingrediente -> Proceso
agregarIngrediente ingrediente chocolate = chocolate {
  ingredientes = ingrediente:ingredientes chocolate
}

type Proceso = Chocolate -> Chocolate

frutalizado :: String -> Number -> Proceso
frutalizado fruta gramos = agregarIngrediente  (fruta, gramos * 2)


dulceDeLeche :: Proceso
dulceDeLeche choco = agregarIngrediente ("ddl",120) choco {
  nombre = nombre choco ++ " Tentacion"
}

azucarera :: Number -> Proceso
azucarera gramos chocolate = chocolate {
  azucar = azucar chocolate + gramos
} 

embriagadora :: Number -> Proceso
embriagadora grados = azucarera 100 .agregarIngrediente ("Licor", min 30 grados)

-- Punto 4
type Receta = [Proceso]

prepararChocolate:: Chocolate -> Receta -> Chocolate
prepararChocolate = foldr ($)

--Punto 5
data Persona = Persona {
  noLeGusta:: Chocolate -> Bool,
  limiteDeSaturacion:: Calorias
}

hastaAcaLlegue:: Persona -> [Chocolate] -> [Chocolate]
hastaAcaLlegue _ [] = [] 
hastaAcaLlegue persona (chocolate:chocolates) | noLeGusta persona chocolate = hastaAcaLlegue persona chocolates
 | (<=0).limiteDeSaturacion.come persona $ chocolate = []
 | otherwise = chocolate:hastaAcaLlegue persona chocolates

come :: Persona -> Chocolate -> Persona 
come persona choco = persona {limiteDeSaturacion = limiteDeSaturacion persona - totalCalorias choco }

-- Punto 6