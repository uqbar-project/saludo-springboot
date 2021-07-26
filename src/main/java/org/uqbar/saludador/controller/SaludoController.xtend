package org.uqbar.saludador.controller

import io.swagger.annotations.ApiOperation
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
import org.uqbar.saludador.errors.BusinessException

@RestController
class SaludoController {
	
	Saludador saludador = new Saludador()
	
	@GetMapping(value = "/saludoDefault")
	@ApiOperation("Devuelve un saludo por defecto")
    def darSaludo() {
        this.saludador.buildSaludo()
    }

	@GetMapping(value = "/saludo/{persona}")
	@ApiOperation("Devuelve un saludo personalizado, requiere la persona a saludar")
    def darSaludoCustom(@PathVariable String persona) {
        this.saludador.buildSaludoCustom("Hola " + persona + "!")
    }

	@PutMapping(value = "/saludoDefault")
	@ApiOperation("Actualiza el valor del nuevo saludo por defecto")
    def actualizarSaludo(@RequestBody String nuevoSaludo) {
        this.saludador.cambiarSaludoDefault(nuevoSaludo)
        new ResponseEntity("Se actualizó el saludo correctamente", HttpStatus.OK)
    }

}


class Saludador {
	static int ultimoId = 1
	public static String DODAIN = "dodain"

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

// Excluido de JaCoCo ya que es un Data Class
@Generated
@Data
class Saludo {
	int id
	String mensaje
	LocalDateTime fechaCreacion = LocalDateTime.now
}
