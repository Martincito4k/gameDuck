import wollok.game.*

class Pato {
	var property position
	method image() = "basura3.png"
	method removerPato(){
		game.removeVisual(self)
		personaje.sumarPuntos(10)
	}
}

object personaje{
	var puntos = 0
	
	var property position = game.center()
	
	method position(){
		return position
	}
	
	method image() = "personaje2.png"
	
	method puntos(){
		return puntos
	}
	/*
	method chocar(){
		puntos = puntos - 1
	}
	method avanzar(){
		position = position.up(1)
	}
	
	method retroceder(){
		position = position.down(1)
	}
	
	method derecha(){
		position = position.right(1)
	}
	
	method izquierda(){
		position = position.left(1)
	}
*/
	method sumarPuntos(cantidad){
		puntos = puntos + cantidad
	}

	method disparar(){
		pato.removerPato().at(self)
		self.sumarPuntos(10)
	}
}

object puntaje {
		method position() = game.at(game.width() - 1, game.height() - 1)
		method text() = personaje.puntos().toString()
		method serAgarradaPor(personaje){
			
		}
}
	
object juego {
	method iniciar(){
		
		game.cellSize(200)
		game.height(4)
		game.width(6)
		game.title("Duck Hunt")
		self.agregarVisuales()
		self.configurarTeclas()
		//self.definirColisiones()
		self.incorporarPato()
	}
	
	method incorporarPato(){
		game.onTick(8000, "pato",{self.agregarPato()})
	}
	
	method agregarVisuales(){
		game.boardGround("wallpaper2.jpg")
		game.addVisualCharacter(personaje)
		game.addVisual(puntaje)
	}
	method configurarTeclas(){
		keyboard.space().onPressDo{personaje.disparar()}
		/* keyboard.up().onPressDo{personaje.avanzar()}
		keyboard.down().onPressDo{personaje.retroceder()}
		keyboard.right().onPressDo{personaje.derecha()}
		keyboard.left().onPressDo{personaje.izquierda()}
		keyboard.w().onPressDo{personaje.avanzar()}
		keyboard.s().onPressDo{personaje.retroceder()}
		keyboard.d().onPressDo{personaje.derecha()}
		keyboard.a().onPressDo{personaje.izquierda()}
		*/
		}
	method definirColisiones(){
		game.onCollideDo(personaje,{cosa=>cosa.serAgarradaPor(personaje)})
	}
	
	method agregarPato(){
		game.addVisual(
		new Pato(
			position = self.posicionAleatoria()
		))
	}
	/*
	method removerPato(){
		game.removeVisual()
	}
*/
	
	method posicionAleatoria() = game.at(0.randomUpTo(game.width()), 1.randomUpTo(game.height()))
}

/* 
object background {
	var position = game.at(game.width() - 25, game.height() - 19)
	method position(){
		return position
	}
	method image() = "wallpaper.jpg"
}
*/

//Tengo que cambiar el personaje para implementarlo directamente con addVisualCharacter y que
// lo interprete directamente como pj para asi al utilizar el removeVisual solo puede eliminar al
// pato, no estaria mal que guarde la posicion de cada pato como una lista y que ese elemento no puede
// ser repetido, ademas necesito implementar lo mismo con el pj para reconocer dnd esta para disparar