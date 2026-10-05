class Torino {

  const capacidad = 4

  const transportador = false

  const motorRuidoso = true

  var property color 

  var property velocidadMaxima

  var property autonomia 


  method capacidad(){
    return capacidad
  }


  method transportador(){
    return transportador
  }


  method motorRuidoso(){
    return motorRuidoso
  }

}




class Economico {


  var property transportador

  var property tanqueExtra
  
  var property cañoDeEscapeSilencioso

  const property color = "beige"

  

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


  method autonomia() {
    var resultado = 200

    if (cañoDeEscapeSilencioso) {
        resultado = resultado - 10
    }

    if (tanqueExtra) {
        resultado = resultado + 200
    }

    if (transportador) {
        resultado = resultado - 20
    }

    return resultado
    }
}





object combi {

  const color = "celeste"


  var property interior = interiorEspacioso

  var property motor = motorDeportivo



  method capacidad(){
    return interior.capacidad()
  }


  method transportador(){
    return interior.transportador()
  }

  
  method velocidadMaxima(){
    return motor.velocidadMaxima()
  }


  method autonomia(){
    return motor.autonomia()
  }


  method motorRuidoso(){
    return motor.esRuidoso()
  }


  method color(){
    return color
  }
}





object interiorEspacioso {

  method capacidad(){
    return 7
  }

  method transportador(){
    return false
  }
}




object interiorAccesible {

  method capacidad(){
    return 5
  }

  method transportador(){
    return true
  }
}




object motorDeportivo {

  method autonomia(){
    return 400
  }


  method velocidadMaxima(){
    return 230
  }


  method esRuidoso(){
    return true
  }
}




object motorUrbano {

  method autonomia(){
    return 1000
  }


  method velocidadMaxima(){
    return 130
  }


  method esRuidoso(){
    return false
  }
}




object reserva {

  var property cantidadPersonas = 0

  var property distancia = 0

  var property tiempo = 0

  const coloresContraindicados = #{}


  var property necesitaTransportador = false

  var property necesitaMotorSilencioso = false



  method puedeRealizarse(vehiculo) {
    return vehiculo.capacidad() >= cantidadPersonas and
           vehiculo.autonomia() >= distancia and
           vehiculo.velocidadMaxima() >= ((distancia / tiempo) + 10) and
           not coloresContraindicados.contains(vehiculo.color()) and
           self.tieneTransportadorSiNecesita(vehiculo) and
           self.tieneMotorSilenciosoSiNecesita(vehiculo)
   }
  

    method tieneTransportadorSiNecesita(vehiculo){
      if (necesitaTransportador){
        return vehiculo.transportador()
      } else {
        return true
      }
    }



    method tieneMotorSilenciosoSiNecesita(vehiculo){
      if (necesitaMotorSilencioso){
        return not vehiculo.motorRuidoso()
      } else {
        return true
      }
    }



    method agregarColorContraindicado(color){
      coloresContraindicados.add(color)
    }


    method coloresContraindicados(){
      return coloresContraindicados
    }
  
}





class Sucursal {
    
    const vehiculos = #{}

    const viajesRealizados = []





    method agregarVehiculo(vehiculo){
        vehiculos.add(vehiculo)
    }


    method quitarVehiculo(vehiculo){
        vehiculos.remove(vehiculo)
    }


    method vehiculos(){
        return vehiculos
    }


    method registrarViaje(reserva, vehiculo) {
      self.validarVehiculo(vehiculo)
      self.validarCumplimientoDeReserva(reserva, vehiculo)
      viajesRealizados.add(new Viaje(reserva = reserva, vehiculo = vehiculo))   // esta bien asi?
}




    method validarVehiculo(vehiculo){
      if (not vehiculos.contains(vehiculo)) {
        self.error("El vehículo no pertenece a la flota")
      }
    }



    method validarCumplimientoDeReserva(reserva, vehiculo){
      if (not reserva.puedeRealizarsePara(vehiculo)) {
        self.error("El vehículo no puede cumplir la reserva")
      }
    }



    method viajesRealizados(){
        return viajesRealizados
    }


    method vehiculosQueCumplenReserva(reserva) {
        return vehiculos.filter({ vehiculo => reserva.puedeRealizarsePara(vehiculo)
    })
    }



    method reservasDe(vehiculo) {
        return viajesRealizados.filter({ viaje => viaje.vehiculo() == vehiculo }).map({ viaje => viaje.reserva() })
    }



    method distanciaRecorridaPor(vehiculo) {
        return viajesRealizados.filter({ viaje => viaje.vehiculo() == vehiculo }).sum({ viaje => viaje.reserva().distancia() })
    }

}




class Viaje {
    var property reserva

    var property vehiculo
}