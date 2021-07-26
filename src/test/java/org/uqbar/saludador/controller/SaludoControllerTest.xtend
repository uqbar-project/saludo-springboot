package org.uqbar.saludador.controller

import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.json.AutoConfigureJsonTesters
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.test.annotation.DirtiesContext
import org.springframework.test.annotation.DirtiesContext.ClassMode
import org.springframework.test.context.ContextConfiguration
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders

import static org.junit.jupiter.api.Assertions.assertEquals
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*

@AutoConfigureJsonTesters
@ContextConfiguration(classes=SaludoController)
@WebMvcTest
@DisplayName("Dado un controller de saludo")
@DirtiesContext(classMode = ClassMode.BEFORE_EACH_TEST_METHOD)
class SaludoControllerTest {

	@Autowired
	MockMvc mockMvc

	@DisplayName("el saludo default es el que tiene el saludador")
	@Test
	def void testObtenerSaludoDefault() {
		mockMvc.perform(MockMvcRequestBuilders.get("/saludoDefault"))
			.andExpect(status.isOk)
			.andExpect(jsonPath("$.mensaje").value("Hola mundo!"))
	}

	@DisplayName("actualizar el saludo a un valor inválido produce un error de usuario")
	@Test
	def void testActualizarSaludoDefaultIncorrecto() {
		mockMvc.perform(MockMvcRequestBuilders.put("/saludoDefault").content("dodain"))
			.andExpect(status.isBadRequest)
			.andExpect [ result | assertEquals("No se puede saludar a " + Saludador.DODAIN, result.resolvedException.message) ]
	}

	@DisplayName("actualizar el saludo a un valor válido actualiza correctamente")
	@Test
	def void testActualizarSaludoDefaultOk() {
		val nuevoSaludoDefault = "Hola San Martín!"
		mockMvc.perform(MockMvcRequestBuilders.put("/saludoDefault").content(nuevoSaludoDefault))
			.andExpect(status.isOk)
		mockMvc.perform(MockMvcRequestBuilders.get("/saludoDefault"))
			.andExpect(status.isOk)
			.andExpect(jsonPath("$.mensaje").value(nuevoSaludoDefault))
	}
	
	@DisplayName("el saludo custom produce un saludo específico")
	@Test
	def void testObtenerSaludoCustom() {
		mockMvc.perform(MockMvcRequestBuilders.get("/saludo/manola"))
			.andExpect(status.isOk)
			.andExpect(jsonPath("$.mensaje").value("Hola manola!"))
	}

}
