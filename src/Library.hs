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
} deriving ( Eq)

instance Show Chocolate where
  show choco = nombre choco

-- Punto 1
cantidadDeIngredientes :: Chocolate -> Number
cantidadDeIngredientes = length.ingredientes

precio choco | ((>60).porcentajeCacao) choco = gramaje choco * precioPorGramoPremium choco
 | ((>4).cantidadDeIngredientes) choco = (8 *).cantidadDeIngredientes $ choco
 | otherwise = gramaje choco * 1.5

precioPorGramoPremium:: Chocolate -> Number
precioPorGramoPremium choco | esAptoDiabeticos choco = 8
 | otherwise = 5

esAptoDiabeticos:: Chocolate -> Bool
esAptoDiabeticos = (==0).azucar


-- Punto 2 
type Caja = [Chocolate]

caloriasIngrediente ::Ingrediente -> Calorias
caloriasIngrediente = snd

nombreIngrediente ::Ingrediente -> String
nombreIngrediente = fst

esBombonAsesino :: Chocolate -> Bool
esBombonAsesino = any ((>200).caloriasIngrediente).ingredientes

totalCalorias :: Chocolate -> Calorias
totalCalorias = sum.map caloriasIngrediente.ingredientes 

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
dulceDeLeche choco = agregarIngrediente ("ddl",220) choco {
  nombre = nombre choco ++ " Tentacion"
}

celiaCrucera :: Number -> Proceso
celiaCrucera gramos chocolate = chocolate {
  azucar = azucar chocolate + gramos
} 

embriagadora :: Number -> Proceso
embriagadora grados = celiaCrucera 100 .agregarIngrediente ("Licor", min 30 grados)

-- Punto 4
type Receta = [Proceso]

recetaPunto4 :: Receta
recetaPunto4 = [frutalizado "naranja" 10, dulceDeLeche, embriagadora 32]

-- Punto 5
prepararChocolate:: Chocolate -> Receta -> Chocolate
prepararChocolate = foldr ($)

--Punto 6
data Persona = Persona {
  noLeGusta:: Ingrediente -> Bool,
  limiteDeSaturacion:: Calorias
}

hastaAcaLlegue:: Persona -> [Chocolate] -> [Chocolate]
hastaAcaLlegue _ [] = [] 
hastaAcaLlegue persona (chocolate:chocolates) | any (noLeGusta persona).ingredientes $ chocolate = hastaAcaLlegue persona chocolates
 | (<=0).limiteDeSaturacion.come persona $ chocolate = []
 | otherwise = chocolate:hastaAcaLlegue (come persona chocolate) chocolates

come :: Persona -> Chocolate -> Persona 
come persona choco = persona {limiteDeSaturacion = limiteDeSaturacion persona - totalCalorias choco }

-- Punto 7
-- aptosParaNinios puede terminar porque toma los 3 primeros bombones, mientras cumpla está todo bien
-- totalCalorias no converge porque queremos obtener la sumatoria de la lista infinita