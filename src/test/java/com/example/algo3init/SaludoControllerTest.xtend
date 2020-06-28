package com.example.algo3init

import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.json.AutoConfigureJsonTesters
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.test.context.junit.jupiter.SpringExtension
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders
import org.uqbar.saludador.controller.SaludoController

import static org.junit.jupiter.api.Assertions.assertEquals

@ExtendWith(SpringExtension)
@AutoConfigureJsonTesters
@SpringBootTest(classes=SaludoController)
@AutoConfigureMockMvc
@DisplayName("Dado un controller de saludo")
class SaludoControllerTest {
	
	@Autowired
	MockMvc mockMvc

	@DisplayName("el saludo default es el que tiene el saludador")
	@Test
	def void testSaludoDefault() {
		val responseEntity = mockMvc.perform(MockMvcRequestBuilders.get("/saludoDefault").accept(MediaType.APPLICATION_JSON_VALUE)).andReturn.response
		assertEquals(200, responseEntity.status)
	}
	
}