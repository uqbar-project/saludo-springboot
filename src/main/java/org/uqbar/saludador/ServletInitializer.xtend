package org.uqbar.saludador

import org.springframework.boot.builder.SpringApplicationBuilder
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer

class ServletInitializer extends SpringBootServletInitializer {
	override protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(SaludadorApplication)
	}
}
