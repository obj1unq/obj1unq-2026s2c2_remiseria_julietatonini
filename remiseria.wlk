class Torino {


  var property color 

  var property velocidadMaxima

  var property autonomia 


  method capacidad(){
    return 4
  }


  method tieneTransportador(){
    return false
  }


  method motorRuidoso(){
    return true
  }

}




class Economico {


  const adaptaciones = #{}



  method agregarAdaptación(adaptacion){
    adaptaciones.add(adaptacion)
  }


  method capacidad(){
    return self.capacidadBase() - adaptaciones.sum{adaptacion => adaptacion.espacioQueOcupa()}
  }


  method capacidadBase(){
    return 5
  }


  method velocidadMaxima() {
    return adaptaciones.min{adaptacion => adaptacion.velocidadMaxima()}

  }


  method motorRuidoso(){
    return not (adaptaciones.contains(cañoDeEscapeSilencioso) or adaptaciones.contains(tanqueExtra)) // hago un method para cada uno?
  }


  method tieneTransportador(){
    return adaptaciones.contains(transportador) 
  }
  


  method autonomia() {
    return self.autonomiaBase() - adaptaciones.sum{adaptacion => adaptacion.autonomia()}
    }


  method autonomiaBase(){
    return 200 
  }


    method color(){
      return "beige"
    }
}




object transportador {

  method espacioQueOcupa(){
    if (Economico.adaptaciones.contains(self)){
      return 1
    } else {
      return 0
    }
  }


  method velocidadMaxima(){
    return 90
  }


  method autonomia(){    
    return -20
  }
}




object tanqueExtra {

  method espacioQueOcupa(){
    if (Economico.adaptaciones.contains(self)){
      return 1
    } else {
      return 0
    }
  }


  method velocidadMaxima(){
    return 80
  }


  method autonomia(){
    return 200
  }
}



object cañoDeEscapeSilencioso {

  method espacioQueOcupa(){
    return 0
  }


  method velocidadMaxima(){
    return 115
  }


  method autonomia(){
    return -10
  }

}





object combi {

  const color = "celeste"


  var property interior = interiorEspacioso

  var property motor = motorDeportivo



  method capacidad(){
    return interior.capacidad()
  }


  method tieneTransportador(){
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
        return viajesRealizados.filter({ viaje => viaje.vehiculo() == vehiculo }).sum({ viaje => viaje.distancia() })
    }

}




class Viaje {
    var property reserva

    var property vehiculo


    method distancia(){
      return reserva.distancia()
    }
}