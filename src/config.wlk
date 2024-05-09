import teclas.*
import wollok.game.*

object config {
	var property teclas = []
	var property velocidad = 0
	var property tiempo = 0
	
	method aumentarTiempo(){
		tiempo = tiempo + 1
		if (tiempo == 100){
			velocidad = velocidad + 5
			game.removeTickEvent("GenerarTecla")
			game.onTick(500-velocidad,"GenerarTecla",{=> self.crearTecla()})
		}
	}
	method iniciar(){
		self.configurarGeneracionYVelocidad()
		self.configurarBotones()
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
		keyboard.s().onPressDo({=>if(game.colliders(botonS).isEmpty()) game.say(botonS,"CUACK")else botonS.tocar(game.uniqueCollider(botonS))})
		keyboard.d().onPressDo({=>if(game.colliders(botonD).isEmpty()) game.say(botonD,"CUACK")else botonD.tocar(game.uniqueCollider(botonD))})
		keyboard.k().onPressDo({=>if(game.colliders(botonK).isEmpty()) game.say(botonK,"CUACK")else botonK.tocar(game.uniqueCollider(botonK))})
		keyboard.l().onPressDo({=>if(game.colliders(botonL).isEmpty()) game.say(botonL,"CUACK")else botonL.tocar(game.uniqueCollider(botonL))})
	}
	
	method configurarGeneracionYVelocidad(){
		game.onTick(500,"GenerarTecla",{=> self.crearTecla()})
		game.onTick(10,"AumentarTiempo",{=> self.aumentarTiempo()})
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
