import PdePreludat
import Library
import Test.Hspec

frutilla = ("Frutilla",20)
almendra = ("Almendra", 35)
ddl = ("ddl", 220)
mousse = ("Mousse",20)
praline = ("Praline", 5)


chocoDiabeticoPremium = Chocolate{
  nombre = "Castillo",
  porcentajeCacao = 70,
  gramaje = 10,
  azucar =0,
  ingredientes = [frutilla]
}
chocoNoDiabeticoPremium = Chocolate{
  nombre = "amargo",
  porcentajeCacao = 70,
  gramaje = 10,
  azucar =10,
  ingredientes = [frutilla, mousse]
}

chocoPauer = Chocolate{
  nombre = "normal",
  porcentajeCacao = 50,
  gramaje = 10,
  azucar =10,
  ingredientes = [frutilla,mousse,ddl,almendra,praline]
}

chocoLate = Chocolate{
  nombre = "late",
  porcentajeCacao = 40,
  gramaje = 20,
  azucar =15,
  ingredientes = [praline]
}

main :: IO ()
main = hspec $ do
  describe "Cálculo de precio" $ do
    it "Dado un chocolate con el porcentaje mayor de cacao y es apto para diabéticos entonces el precio es el monto indicado * cantidad de gramos" $ do
      80 `shouldBe` precio chocoDiabeticoPremium
    it "Dado un chocolate con el porcentaje mayor de cacao y no es apto para diabéticos entonces el precio es el monto indicado * cantidad de gramos" $ do
      50 `shouldBe` precio chocoNoDiabeticoPremium
    it "Dado un chocolate con el porcentaje menor de cacao y con muchos ingredientes entonces el precio es el monto indicado * cantidad de ingredientes" $ do
      40 `shouldBe` precio chocoPauer
    it "Dado un chocolate con el porcentaje menor de cacao y con pocos ingredientes entonces el precio es el monto indicado * cantidad de gramos" $ do
      20 `shouldBe` precio chocoLate
  describe "Orden superior" $ do 
    it "Dado un chocolate que tiene al menos un ingrediente con más del tope de calorías, entonces es bombón asesino" $ do 
      chocoPauer `shouldSatisfy` esBombonAsesino
    it "Dado un chocolate que no tiene un ingrediente con más del tope de calorías, entonces no es bombón asesino" $ do 
      chocoNoDiabeticoPremium `shouldNotSatisfy` esBombonAsesino