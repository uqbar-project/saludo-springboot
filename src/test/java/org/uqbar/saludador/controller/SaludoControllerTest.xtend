package org.uqbar.saludador.controller

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.DeserializationFeature
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializationFeature
import java.util.Map
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.json.AutoConfigureJsonTesters
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.mock.web.MockHttpServletResponse
import org.springframework.test.annotation.DirtiesContext
import org.springframework.test.annotation.DirtiesContext.ClassMode
import org.springframework.test.context.ContextConfiguration
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders

import static org.junit.jupiter.api.Assertions.assertEquals

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
		val responseEntity = mockMvc.perform(MockMvcRequestBuilders.get("/saludoDefault")).andReturn.response
		assertEquals(200, responseEntity.status)
		assertEquals(responseEntity.getField("saludo"), "Hola mundo!")
	}

	@DisplayName("actualizar el saludo a un valor inválido produce un error de usuario")
	@Test
	def void testActualizarSaludoDefaultIncorrecto() {
		val responseEntity = mockMvc.perform(MockMvcRequestBuilders.put("/saludoDefault").content("dodain")).andReturn.response
		assertEquals(400, responseEntity.status)
	}

	@DisplayName("actualizar el saludo a un valor válido actualiza correctamente")
	@Test
	def void testActualizarSaludoDefaultOk() {
		val nuevoSaludoDefault = "Hola San Martín!"
		val responseEntityPut = mockMvc.perform(MockMvcRequestBuilders.put("/saludoDefault").content(nuevoSaludoDefault)).andReturn.response
		assertEquals(200, responseEntityPut.status)
		val responseEntityGet = mockMvc.perform(MockMvcRequestBuilders.get("/saludoDefault")).andReturn.response
		responseEntityGet.characterEncoding = "UTF-8"
		assertEquals(200, responseEntityGet.status)
		assertEquals(responseEntityGet.getField("saludo"), nuevoSaludoDefault)
	}
	
	@DisplayName("el saludo custom produce un saludo específico")
	@Test
	def void testObtenerSaludoCustom() {
		val responseEntity = mockMvc.perform(MockMvcRequestBuilders.get("/saludo/manola")).andReturn.response
		assertEquals(200, responseEntity.status)
		assertEquals(responseEntity.getField("saludo"), "Hola manola!")
	}

	/**
	 * *******************************************************************************
	 * Helpers
 	 * *******************************************************************************
	 */
	static def getField(MockHttpServletResponse responseEntity, String fieldName) {
		mapper.readValue(responseEntity.contentAsString, new TypeReference<Map<String, Object>>() {
		}).get(fieldName)
	}

	static def mapper() {
		new ObjectMapper => [
			configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
			configure(SerializationFeature.INDENT_OUTPUT, true)
		]
	}
}
