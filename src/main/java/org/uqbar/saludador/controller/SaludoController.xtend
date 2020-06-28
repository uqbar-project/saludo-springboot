package org.uqbar.saludador.controller

import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.Data
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException

@RestController
class SaludoController {
	
	Saludador saludador = new Saludador()
	
	@GetMapping(value = "/saludoDefault")
    def darSaludo() {
        this.saludador.buildSaludo()
    }

	@GetMapping(value = "/saludo/{persona}")
    def darSaludoCustom(@PathVariable String persona) {
        this.saludador.buildSaludoCustom("Hola " + persona + "!")
    }

	@PutMapping(value = "/saludoDefault")
    def actualizarSaludo(@RequestBody String nuevoSaludo) {
    	try {
	        this.saludador.cambiarSaludoDefault(nuevoSaludo)
	        new ResponseEntity("Se actualizó el saludo correctamente", HttpStatus.OK)
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
		this.saludoDefault = nuevoSaludo
	}
}

@Data
class Saludo {
	int id
	String saludo
	LocalDateTime fechaCreacion = LocalDateTime.now
}

class BusinessException extends RuntimeException {
	
	new(String msg) {
		super(msg)
	}

}