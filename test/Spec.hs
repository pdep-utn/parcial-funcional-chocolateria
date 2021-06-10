import Library
import PdePreludat
import Test.Hspec

naranja = ("Naranja",20)
frutilla = ("Frutilla",20)
almendra = ("Almendra", 35)
ddl = ("ddl", 220)
mousse = ("Mousse",20)
praline = ("Praline", 5)
ruhm = ("Licor",30)

chocoDiabeticoPremium = Chocolate{
  nombre = "Castillo",
  porcentajeCacao = 70,
  gramaje = 10,
  porcentajeAzucar =0,
  ingredientes = [naranja]
}
chocoNoDiabeticoPremiumBase = Chocolate{
  nombre = "amargo",
  porcentajeCacao = 70,
  gramaje = 10,
  porcentajeAzucar =10,
  ingredientes = []
}
chocoNoDiabeticoPremium = Chocolate{
  nombre = "amargo Tentacion",
  porcentajeCacao = 70,
  gramaje = 10,
  porcentajeAzucar =10,
  ingredientes = [frutilla, ddl]
}

chocoPauer = Chocolate{
  nombre = "pauer",
  porcentajeCacao = 50,
  gramaje = 10,
  porcentajeAzucar =10,
  ingredientes = [frutilla,mousse,ddl,almendra,praline]
}

chocoLate = Chocolate{
  nombre = "late",
  porcentajeCacao = 40,
  gramaje = 20,
  porcentajeAzucar =15,
  ingredientes = [praline]
}


chocoLinas = Chocolate{
  nombre = "linas",
  porcentajeCacao = 40,
  gramaje = 20,
  porcentajeAzucar =15,
  ingredientes = [praline,mousse]
}

fede = Persona {
  noLeGusta = (=="Frutilla").nombreIngrediente,
  limiteDeSaturacion = 31
}

main :: IO ()
main = hspec $ do
  describe "Tests  Cálculo de precio" $ do
    it "Dado un chocolate con el porcentaje mayor de cacao y es apto para diabéticos entonces el precio es el monto indicado * cantidad de gramos" $ do
      precio chocoDiabeticoPremium `shouldBe` 80
    it "Dado un chocolate con el porcentaje mayor de cacao y no es apto para diabéticos entonces el precio es el monto indicado * cantidad de gramos" $ do
      precio chocoNoDiabeticoPremium `shouldBe` 50
    it "Dado un chocolate con el porcentaje menor de cacao y con muchos ingredientes entonces el precio es el monto indicado * cantidad de ingredientes" $ do
      precio chocoPauer `shouldBe` 40
    it "Dado un chocolate con el porcentaje menor de cacao y con pocos ingredientes entonces el precio es el monto indicado * cantidad de gramos" $ do
      precio chocoLate `shouldBe` 30
  describe "Tests Orden superior" $ do 
    it "Dado un chocolate que tiene al menos un ingrediente con más del tope de calorías, entonces es bombón asesino" $ do 
      chocoPauer `shouldSatisfy` esBombonAsesino
    it "Dado un chocolate que no tiene un ingrediente con más del tope de calorías, entonces no es bombón asesino" $ do 
      chocoLate `shouldNotSatisfy` esBombonAsesino
    it "Dada un chocolate, se calcula el total de calorías en base a los ingrdientes" $ do
      totalCalorias chocoNoDiabeticoPremium `shouldBe` 240
    it "Dada una caja de chocolates que tiene al menos 3 chocolates que no son bombon asesino, entonces son aptos para niños" $ do
      aptosParaNinios [chocoPauer,chocoLate,chocoDiabeticoPremium,chocoNoDiabeticoPremium] `shouldNotContain` [chocoPauer]
  describe "Tests de procesos" $ do
    it "Dado un proceso de frutalizado y un chocolate, entonces se agrega dicho elemento con las calorías correspondientes" $ do 
      (ingredientes.frutalizado "Naranja" 10 ) chocoLate `shouldContain` [("Naranja",20)]
    it "Dado un proceso dulceDeLeche y un chocolate, entonces se agrega dicho elemento con su calorías fijas" $ do
      (ingredientes.dulceDeLeche) chocoLate `shouldContain` [("ddl",220)]
    it "Dado un proceso dulceDeLeche y un chocolate, entonces se agrega al nombre el sufijo correspondiente" $ do
      (nombre.dulceDeLeche) chocoLate `shouldBe` "late Tentacion"
    it "Dado un proceso de celiaCrucera con un porcentaje, entonces se le suma dicha cantidad al nivel de porcentajeAzucar de un chocolate" $ do
      (porcentajeAzucar.celiaCrucera 30) chocoLate `shouldBe` 45
    it "Dada una embriagadora con un grado menor al esperado y un chocolate, entonces se agrega el elemento con las calorías resultantes del cálculo" $ do 
      (ingredientes.embriagadora 20) chocoLate `shouldContain` [("Licor",20)]
    it "Dada una embriagadora con un grado mayor al esperado y un chocolate, entonces se agrega el elemento con las calorías resultantes del cálculo" $ do 
      (ingredientes.embriagadora 50) chocoLate `shouldContain` [("Licor",30)]
    it "Dada una embriagadora con un grado menor al esperado y un chocolate, aumenta el nivel de porcentajeAzucar en un valor fijo" $ do 
       (porcentajeAzucar.embriagadora 20) chocoLate `shouldBe` 35
    it "Dada una receta se prepara el chocolate" $ do 
      chocoNoDiabeticoPremium `shouldBe` prepararChocolate chocoNoDiabeticoPremiumBase [frutalizado "Frutilla" 10, dulceDeLeche]
  describe "Test recursividad" $ do 
    it "Dada una caja de chocolates y una persona entonces para cuando se satura" $ do
      hastaAcaLlegue fede [chocoLate,chocoLinas,chocoDiabeticoPremium, chocoLinas, chocoLinas] `shouldMatchList` [chocoLate,chocoLinas,chocoDiabeticoPremium]
    it "Dada una caja de chocolates y una persona filtra las que no le gusta" $ do
      hastaAcaLlegue fede [chocoPauer,chocoNoDiabeticoPremium, chocoDiabeticoPremium, chocoLate,chocoLinas,chocoNoDiabeticoPremium] `shouldMatchList` [chocoDiabeticoPremium,chocoLate,chocoLinas]