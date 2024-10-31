import teclas.*
import wollok.game.*

//	Lista de sonidos
const sonidos = ["sounds/122BPM.mp3","sounds/132BPM.mp3"
	,"sounds/140BPM.mp3","sounds/158BPM.mp3"
	,"sounds/160BPM.mp3","sounds/175BPM.mp3"
	,"sounds/180BPM.mp3","sounds/190BPM.mp3"
	,"sounds/200BPM.mp3","sounds/215BPM.mp3"
	,"sounds/220BPM.mp3","sounds/235BPM.mp3"
	,"sounds/244BPM.mp3","sounds/252BPM.mp3"
	,"sounds/260BPM.mp3","sounds/270BPM.mp3"
	,"sounds/280BPM.mp3"
	]

//	Lista de velocidades
const velocidades = [500,480,450,420,400,370,350,300,270,250,230,200,180,150,130,100,90,80,75]

object menu{
	var property esVisible = true
	method image(){
		return "images/menu.png" //CAMBIAR IMAGEN Y COLOCAR LA DE LOS BOTONES
	} 
}

object gameOverwat{
	method image(){
		return "images/GAMEOVERWAT.png" //CAMBIAR IMAGEN Y COLOCAR LA DE LOS BOTONES
	} 
}

object config {
	var property sonidoFondo = game.sound(sonidos.first())
	var property teclas = []
	var property vidas = []
	var property aux
	
	method iniciar(){
		game.addVisualIn(menu, game.at(0,0))
		keyboard.enter().onPressDo({=>if(menu.esVisible())self.iniciarJuego()})
	}
	
	method iniciarJuego(){
		menu.esVisible(false)
		game.removeVisual(menu)
		self.configurarTiempo()
		self.configurarSonidos()
		self.configurarGeneracion()
		self.configurarBotones()
		self.configurarVidas()
		self.imprimirTextos()
	}
	
	method configurarSonidos() {
		game.schedule(10, { sonidoFondo.play()})
	}
	
	method imprimirTextos(){
		game.addVisual(combo)
		game.addVisual(tiempo)
	}

	method configurarBotones(){
		const botonS = new Boton()
		game.addVisualIn(botonS,game.at(4,2))
		const botonS2 = new BotonFantasma()
		game.addVisualIn(botonS2,game.at(4,3))
		
		const botonD = new Boton()
		game.addVisualIn(botonD,game.at(5,2))
		const botonD2 = new BotonFantasma()
		game.addVisualIn(botonD2,game.at(5,3))
		
		const botonK = new Boton()
		game.addVisualIn(botonK,game.at(6,2))
		const botonK2 = new BotonFantasma()
		game.addVisualIn(botonK2,game.at(6,3))
		
		const botonL = new Boton()
		game.addVisualIn(botonL,game.at(7,2))	
		const botonL2 = new BotonFantasma()
		game.addVisualIn(botonL2,game.at(7,3))
		
		self.configurarTeclas(botonS,botonD,botonK,botonL,botonS2,botonD2,botonK2,botonL2)
	}
	
	method apretoBoton(boton,boton2){
		if(game.colliders(boton).isEmpty() and game.colliders(boton2).isEmpty()){
			combo.reinicioCombo() 
		}else if(game.colliders(boton2).isEmpty()){
			boton.tocar(game.uniqueCollider(boton)) 
		}else{ 
			boton.tocar(game.uniqueCollider(boton2))	
		}
	}
	
	method configurarTeclas(botonS,botonD,botonK,botonL,botonS2,botonD2,botonK2,botonL2) {
		keyboard.s().onPressDo({=>self.apretoBoton(botonS,botonS2)})
		keyboard.d().onPressDo({=>self.apretoBoton(botonD,botonD2)})
		keyboard.k().onPressDo({=>self.apretoBoton(botonK,botonK2)})
		keyboard.l().onPressDo({=>self.apretoBoton(botonL,botonL2)})
	}
	
	method configurarGeneracion(){
		game.schedule(1000, {=> game.onTick(velocidad.velocidadNum(),"GenerarTecla",{=> self.crearTecla()})})
	}
	
	method configurarMusica(){
		sonidos.remove(sonidos.first())
		if(sonidos.isEmpty()){
			sonidos.addAll(["sounds/122BPM.mp3","sounds/132BPM.mp3"
			,"sounds/140BPM.mp3","sounds/158BPM.mp3"
			,"sounds/160BPM.mp3","sounds/175BPM.mp3"
			,"sounds/180BPM.mp3","sounds/190BPM.mp3"
			,"sounds/200BPM.mp3","sounds/215BPM.mp3"
			,"sounds/220BPM.mp3","sounds/235BPM.mp3"
			,"sounds/244BPM.mp3","sounds/252BPM.mp3"
			,"sounds/260BPM.mp3","sounds/270BPM.mp3"
			,"sounds/280BPM.mp3"
			])
		}
		sonidoFondo = game.sound(sonidos.first())
		game.schedule(500, {sonidoFondo.play()})
		game.schedule(501, {sonidoFondo.shouldLoop(true)})
	}
	
	method configurarTiempo(){
		game.schedule(10, {=>game.onTick(100,"AumentarTiempo",{=> tiempo.aumentarTiempo()})})
	}
	
	method configurarTecla(tecla){
		teclas.add(tecla)
		game.addVisual(tecla)
		tecla.aparecer()
	}
	
	method crearTecla(){
		if([0,0,0,0,1,0,0,0,0,0].anyOne() == 1){
			const nuevo = new Double()
			self.configurarTecla(nuevo)
		}else{
			const nuevo = new Tecla()
			self.configurarTecla(nuevo)
		}
	}
	
	method configurarVidas(){
		var vida = new Vida()
		vidas.add(vida)
		game.addVisualIn(vida,game.at(0,13))
		vida = new Vida()
		vidas.add(vida)
		game.addVisualIn(vida,game.at(1,13))
		vida = new Vida()
		vidas.add(vida)
		game.addVisualIn(vida,game.at(2,13))
		vida = new Vida()
		vidas.add(vida)
		game.addVisualIn(vida,game.at(0,12))
		vida = new Vida()
		vidas.add(vida)
		game.addVisualIn(vida,game.at(1,12))
		vida = new Vida()
		vidas.add(vida)
		game.addVisualIn(vida,game.at(2,12))
	}
	
	method matarVida(){
		aux = vidas.filter({vida => vida.estoyVivo()})
		if(!aux.isEmpty() and aux.size() > 0){
			aux.last().muere()
		}
		if(aux.isEmpty()){
			self.sonidoFondo().stop()
			game.removeTickEvent("GenerarTecla")
			teclas.forEach{tecla => tecla.desaparecer()}
			game.clear()
			game.addVisualIn(gameOverwat, game.at(0,0))
			game.schedule(3000, {=>game.stop()})
		}
		aux=vidas.filter({vida => vida.estoyVivo()})
		// actualizo el aux para tener las vidas actuales post matarVida() y no tener que esperar al siguiente filter
	}

	method curarVida(){
		aux=vidas.filter({vida => !vida.estoyVivo()})
		if(!aux.isEmpty() and aux.size() > 0){
			aux.first().revive()
		}
		
	}
}

object combo{
	var property comboNum = 0
	method text() = "COMBO: " + comboNum.toString()
	method position () = game.at(10,11)
	method textColor() = "#000000"
	method reinicioCombo(){ 
		comboNum = 0
		config.matarVida()
	}
	method aumentoCombo(){
		comboNum = comboNum + 1
		if(comboNum%5==0 and comboNum !=0){
			config.curarVida()
		}
		
	}
}

object tiempo{
	var property tiempoNum = 0
	method text() = "TIEMPO: " + tiempoNum.toString()
	method aumentarTiempo(){
		tiempoNum = tiempoNum + 1
	}
	method textColor() = "#000000"
	method position()= game.at(10,12)
}

object velocidad{
	var property velocidadNum = 600
	
	method aumentoVelocidad(){
		velocidades.remove(velocidades.first())
		if(velocidades.isEmpty()){
			velocidades.addAll([500,480,450,420,400,370,350,300,270,250,230,200,180,150,130,100,90,80,75])
		}
		velocidadNum = velocidades.first()
		game.removeTickEvent("GenerarTecla")
		game.schedule(5000, {=>config.sonidoFondo().stop()})
		game.schedule(5000, {=>config.configurarGeneracion()})
		game.schedule(5000, {=>config.configurarMusica()})
	}
}

//	Clase de las vidas
class Vida{
	var property estoyVivo = true
	method image() = if(estoyVivo) "images/Heart.png" else "images/HeartGray.png"

	method muere(){
		estoyVivo = false
	}
	
	method revive(){
		estoyVivo = true
	}
}

