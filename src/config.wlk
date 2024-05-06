import teclas.*
import wollok.game.*

object config {
	var property velocidad = 250

	method iniciar(){
		self.configurarTeclas()
		self.configurarGeneracionYVelocidad()
	}
	
	method configurarTeclas() {
		keyboard.s().onPressDo({botonS.tocar()})
		keyboard.d().onPressDo({botonD.tocar()})
		keyboard.k().onPressDo({botonK.tocar()})
		keyboard.l().onPressDo({botonL.tocar()})
	}
	
	method configurarGeneracionYVelocidad(){
		game.onTick(velocidad,"GenerarTecla",{=>game.addVisual(new Tecla())})
	}
}