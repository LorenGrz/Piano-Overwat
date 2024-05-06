import config.*
import wollok.game.*

class Tecla {
	var property position = game.at(self.random(),9)
	
	method random(){
		return new Range(start = 1, end = 4).anyOne()
	}
	
	method limpioObj(){
	}
	
	method esTocada(){
	}
}

object botonS {
	method tocar(){
		
	}
}

object botonD {
	method tocar(){
	
	}
}

object botonK {
	method tocar(){
	
	}
}

object botonL {
	method tocar(){
	
	}
}