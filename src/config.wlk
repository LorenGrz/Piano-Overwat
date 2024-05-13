import teclas.*
import wollok.game.*
object combo{
	var property comboNum = 0
	method text() = "Combo: " + comboNum.toString()
	method position () = game.at(1,11)
	method textColor() = "#000000"
	method reinicioCombo(){ 
		game.say(self,"CUACK")
		comboNum = 0
	}
}

object tiempo{
	var property tiempoNum = 0
	method text() = "Tiempo: " + tiempoNum.toString()
	method aumentarTiempo(){
		tiempoNum = tiempoNum + 1
		if (tiempoNum == 10){
			velocidad.aumentoVelocidad()
		}
	}
	method textColor() = "#000000"
	method position()= game.at(10,11)
}

object velocidad{
	var property velocidadNum = 0
	method aumentoVelocidad(){
		velocidadNum = velocidadNum + 5
		game.removeTickEvent("GenerarTecla")
		game.onTick(500-velocidadNum,"GenerarTecla",{=> config.crearTecla()})
	}
	
}

object config {
	var property teclas = []

	method iniciar(){
		self.configurarGeneracionYVelocidad()
		self.configurarBotones()
		self.imprimirTextos()
//		self.configurarSonidos()
	}
	
//	method configurarSonidos() {
//		const sonidoFondo = game.sound("funkyTown.mp3")
//		sonidoFondo.play()
//	}
	
	method imprimirTextos(){
		game.addVisual(combo)
		game.addVisual(tiempo)
	}
	
	method configurarBotones(){
		const botonS = new Boton()
		game.addVisualIn(botonS,game.at(4,2))
		const botonD = new Boton()
		game.addVisualIn(botonD,game.at(5,2))
		const botonK = new Boton()
		game.addVisualIn(botonK,game.at(6,2))
		const botonL = new Boton()
		game.addVisualIn(botonL,game.at(7,2))
		self.configurarTeclas(botonS,botonD,botonK,botonL)
	}
	
	method configurarTeclas(botonS,botonD,botonK,botonL) {
		keyboard.s().onPressDo({=>if(game.colliders(botonS).isEmpty()) combo.reinicioCombo() else botonS.tocar(game.uniqueCollider(botonS))})
		keyboard.d().onPressDo({=>if(game.colliders(botonD).isEmpty()) combo.reinicioCombo() else botonD.tocar(game.uniqueCollider(botonD))})
		keyboard.k().onPressDo({=>if(game.colliders(botonK).isEmpty()) combo.reinicioCombo() else botonK.tocar(game.uniqueCollider(botonK))})
		keyboard.l().onPressDo({=>if(game.colliders(botonL).isEmpty()) combo.reinicioCombo() else botonL.tocar(game.uniqueCollider(botonL))})
	}
	
	method configurarGeneracionYVelocidad(){
		game.onTick(500,"GenerarTecla",{=> self.crearTecla()})
		game.onTick(100,"AumentarTiempo",{=> tiempo.aumentarTiempo()})
	}
	
	method configurarTecla(tecla){
		teclas.add(tecla)
		game.addVisual(tecla)
		tecla.aparecer()
	}
	
	method crearTecla(){
		const nuevo = new Tecla()
		self.configurarTecla(nuevo)
	}
}
