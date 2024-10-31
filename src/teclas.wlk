import config.*
import wollok.game.*

class Tecla {
	var property position = game.at(self.random(),12)
	var property esTocada = false
	var property esDouble = false
	method image(){
		if(self.esTocada()) return "images/Tecla-Gris.jpg" 
		else return "images/Tecla.jpg" 
	} 
	//	Genera una posicion distinta en X que la anterior tecla en cason de no ser un Double
	method random(){
		if(config.teclas().isEmpty()){
			return [4, 5, 6, 7].anyOne()
		}else if(config.teclas().last().id()){
			return config.teclas().last().position().x()
		}
		const n = [4, 5, 6, 7]
		n.remove(config.teclas().last().position().x())
		return n.anyOne()
	}
	//	Bajamos la posicion de la tecla
	method cae(){
		position = position.down(1)
		if(position.y() == -1 and !self.esTocada()){
			combo.reinicioCombo()
		}
		if(position.y() == -1){
			self.desaparecer()
		}	
	}
	//	Generamos la velocidad de caida de la tecla 
	method aparecer(){
		game.onTick(velocidad.velocidadNum()/2,"moverTecla"+self.toString(),{=> self.cae()})
	}
	//	Elimino el objeto
	method desaparecer(){
		game.removeTickEvent("moverTecla"+self.toString())
		config.teclas().remove(self)
		game.removeVisual(self)
	}
	
	method id(){
		return false
	}
	
	method aumentoCombo(){
		if(!self.esTocada()){
			combo.aumentoCombo()
		}
	}
}

class Double inherits Tecla{
	override method id(){
		return true
	}
	
	override method aumentoCombo(){
		if(!self.esTocada()){
			combo.aumentoCombo()
			combo.aumentoCombo()
		}
	}
}

//	Clase de los botones
class Boton{
	var property position = game.at(0,0)
	method image(){
		return "images/BOTON2.jpg" //CAMBIAR IMAGEN Y COLOCAR LA DE LOS BOTONES
	} 
	
	method tocar(tecla){
		if(combo.comboNum()%25==0 and combo.comboNum()!==0){
			velocidad.aumentoVelocidad()
		}
		tecla.aumentoCombo()
		tecla.esTocada(true)
	}
}

// Heredo la clase boton para que se pueda esperar un ligero error al momento de presionar la tecla
class BotonFantasma inherits Boton{
	override method image(){
		return "images/BOTON3.jpg"
	}
}
