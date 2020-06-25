package org.uqbar.saludador.controller

import java.io.Serializable
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.Data
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseBody

@Controller
class SaludoController {
	
	Saludador saludador = new Saludador()
	
	@RequestMapping(value = "/saludoDefault", method = GET)
	@ResponseBody
    def darSaludo() {
        this.saludador.buildSaludo()
    }

	@RequestMapping(value = "/saludo/{persona}", method = GET)
	@ResponseBody
    def darSaludoCustom(@PathVariable String persona) {
        this.saludador.buildSaludoCustom("Hola " + persona + "!")
    }

	@RequestMapping(value = "/saludoDefault", method = PUT)
	@ResponseBody
    def actualizarSaludo(@RequestBody String nuevoSaludo) {
    	// TODO: No se puede saludar a Dodain
        this.saludador.saludoDefault = nuevoSaludo
        new ResponseEntity(HttpStatus.OK)
    }
    
}


class Saludador {
	static int ultimoId = 1
	@Accessors String saludoDefault = "Hola mundo!"
	
	def buildSaludo() {
		buildSaludoCustom(this.saludoDefault)
	}
	
	def buildSaludoCustom(String mensaje) {
		new Saludo(ultimoId++, mensaje)
	}
}

@Data
class Saludo implements Serializable {
	int id
	String saludo
	LocalDateTime fechaCreacion = LocalDateTime.now
}