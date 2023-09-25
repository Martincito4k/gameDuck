import wollok.game.*

object personaje{
	var puntos = 0
	
	var position = game.center()
	method position(){
		return position
	}
	method image() = "personaje.png"
	method puntos(){
		return puntos
	}
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
	
	method sumarPuntows(cantidad){
		puntos = puntos + cantidad
	}
}

class Auto {
	var property position
	var nro
	method image() = "auto" + nro + ".png"
	method serAgarradaPor(personaje){
		game.removeVisual(self)
		personaje.sumarPuntos(nro)
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
		
		game.height(20)
		game.width(35)
		game.title("Duck Hunt")
		self.agregarVisuales()
		self.configurarTeclas()
		self.definirColisiones()
		self.incorporarObstaculos()
	}
	
	method incorporarObstaculos(){
		game.onTick(2000, "obstaculo",{self.agregarObstaculo()})
	}
	method agregarVisuales(){
		game.boardGround("wallpaper.jpg")
		game.addVisual(personaje)
		10.times({x => self.agregarAuto(x)})
		game.addVisual(puntaje)
	}
	method configurarTeclas(){
		keyboard.up().onPressDo{personaje.avanzar()}
		keyboard.down().onPressDo{personaje.retroceder()}
		keyboard.right().onPressDo{personaje.derecha()}
		keyboard.left().onPressDo{personaje.izquierda()}
		}
	method definirColisiones(){
		game.onCollideDo(personaje,{cosa=>cosa.serAgarradaPor(personaje)})
	}
	method agregarAuto(valor){
		game.addVisual(
			new Auto(
				position= game.at(valor,10),
				 nro = valor % 5 + 1
			)
		)
	}
	method agregarObstaculo(){
		game.addVisual(
		new Obstaculo(
			color=["Rojo", "Verde", "Azul"].anyOne(),
			position = self.posicionAleatoria()
		))
	}
	method posicionAleatoria() = game.at(1.randomUpTo(game.width()) - 2, 1.randomUpTo(game.height()) - 2)
}
class Obstaculo {
	var property position
	var color
	method image() = "basura.png"
	method serAgarradaPor(personaje){
		personaje.chocar()
	}
}
object background {
	var position = game.at(game.width() - 25, game.height() - 19)
	method position(){
		return position
	}
	method image() = "wallpaper.jpg"
}