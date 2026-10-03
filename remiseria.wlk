class Torino {

  const capacidad = 4

  const transportaSillaDeRuedas = false

  const motorRuidoso = true

  var property color 

  var property velocidadMaxima

  var property autonomia 

}




class Economicos {

  const color = "beige"

  

  method capacidad(){
    if (transportador and tanqueExtra) {
      return 3
    } else if (transportador or tanqueExtra) {
      return 4
    } else {
      return 5
    }
  }


  method velocidadMaxima(){
    if (tanqueExtra) {
      return 80
    } else if (transportador) {
      return 90
    } else if (cañoDeEscapeSilencioso) {
      return 115
    } else {
      return 120
    }
  }



  method motorRuidoso(){
    return not (cañoDeEscapeSilencioso or tanqueExtra) 
  }


  method autonomia(){
    if ()
  }
}



