package com.example.algo3init

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.DeserializationFeature
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializationFeature
import java.util.Map
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.json.AutoConfigureJsonTesters
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.mock.web.MockHttpServletResponse
import org.springframework.test.context.ContextConfiguration
import org.springframework.test.context.junit.jupiter.SpringExtension
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders
import org.uqbar.saludador.controller.SaludoController

import static org.junit.jupiter.api.Assertions.assertEquals

@ExtendWith(SpringExtension)
@AutoConfigureJsonTesters
@ContextConfiguration(classes=SaludoController)
@WebMvcTest
@DisplayName("Dado un controller de saludo")
class SaludoControllerTest {

	@Autowired
	MockMvc mockMvc

	@DisplayName("el saludo default es el que tiene el saludador")
	@Test
	def void testSaludoDefault() {
		val responseEntity = mockMvc.perform(MockMvcRequestBuilders.get("/saludoDefault")).andReturn.response
		assertEquals(200, responseEntity.status)
		assertEquals(responseEntity.getField("saludo"), "Hola mundo!")
	}

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
