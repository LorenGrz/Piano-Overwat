import config.*
import wollok.game.*

class Tecla {
	var property position = game.at(self.random(),12)
	var property esTocada = false
	method image(){
		/*if(esTocada()) return "Tecla-Gris.jpg" else*/return "Tecla.jpg" 
	} 
	
	method random(){
		if(config.teclas().isEmpty()){
			return [4, 5, 6, 7].anyOne()
		}
		const n = [4, 5, 6, 7]
		n.remove(config.teclas().last().position().x())
		return n.anyOne()
	}
	
	method cae(){
		position = position.down(1)
		if(position.y() == -1){
			self.desaparecer()
		}
	}
	method aparecer(){
		game.onTick(250-config.velocidad()*2,"moverTecla"+self.toString(),{=> self.cae()})
	}
	method desaparecer(){
		game.removeTickEvent("moverTecla"+self.toString())
		config.teclas().remove(self)
		game.removeVisual(self)
	}
}
class Boton{
	var property position = game.at(0,0)
	method image(){
		return "Tecla.jpg" //CAMBIAR IMAGEN Y COLOCAR LA DE LOS BOTONES
	} 
	method tocar(tecla){
		tecla.esTocada(true)
		game.removeVisual(tecla)//Temporal
	}
}


