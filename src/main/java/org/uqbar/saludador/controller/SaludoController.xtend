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
import org.springframework.web.server.ResponseStatusException

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
    	try {
	        this.saludador.cambiarSaludoDefault(nuevoSaludo)
	        new ResponseEntity(HttpStatus.OK)
    	} catch (BusinessException e) {
    		throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
    	}
    }
    
}


class Saludador {
	static int ultimoId = 1
	static String DODAIN = "dodain"

	@Accessors String saludoDefault = "Hola mundo!"
	
	def buildSaludo() {
		buildSaludoCustom(this.saludoDefault)
	}
	
	def buildSaludoCustom(String mensaje) {
		new Saludo(ultimoId++, mensaje)
	}
	
	def cambiarSaludoDefault(String nuevoSaludo) {
		if (nuevoSaludo.equalsIgnoreCase(DODAIN)) {
			throw new BusinessException("No se puede saludar a " + DODAIN)
		}
	}
}

@Data
class Saludo implements Serializable {
	int id
	String saludo
	LocalDateTime fechaCreacion = LocalDateTime.now
}

class BusinessException extends RuntimeException {
	
	new(String msg) {
		super(msg)
	}

}