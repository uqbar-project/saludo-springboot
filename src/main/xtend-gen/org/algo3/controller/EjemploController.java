package org.algo3.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SuppressWarnings("all")
public class EjemploController {
  @RequestMapping(value = "/", method = RequestMethod.GET)
  @ResponseBody
  public String saludo() {
    return "Hola mundo!";
  }
}
