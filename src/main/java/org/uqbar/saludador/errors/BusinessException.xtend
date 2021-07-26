package org.uqbar.saludador.errors

import org.springframework.web.bind.annotation.ResponseStatus

@ResponseStatus(BAD_REQUEST)
class BusinessException extends RuntimeException {

	new(String msg) {
		super(msg)
	}
}
