# Primer ejemplo Servicio REST: Saludo con Springboot

## El proyecto

Antes que nada, la idea de este proyecto es que te sirva como base para poder desarrollar el backend en la materia [Algoritmos 3](https://algo3.uqbar-project.org/). Por eso está basado en _Maven_, y el archivo `pom.xml` tiene dependencias a

- Spring Boot
- JUnit 5
- la última versión actual de Xtend
- además de estar basado en la JDK 11

### Pasos para adaptar tu proyecto de Algo2 a Algo3

El proceso más simple para que puedan reutilizar el proyecto de Algo2 en Algo3 es:

- generar una copia de todo el directorio que contiene este proyecto
- eliminar la carpeta `.git` que está oculta
- renombrar en el `pom.xml` los valores para `artifactId`, `name` y `description` para que tengan el nombre de tu proyecto

```xml
	<groupId>org.uqbar</groupId>
	<artifactId>---- nombre del proyecto ----</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<packaging>war</packaging>
	<name>---- nombre del proyecto ----</name>
	<description>---- acá va la description ----</description>
```

- si hay alguna dependencia extra del proyecto de Algo2, los docentes les vamos a avisar, en principio no necesitan ninguna dependencia adicional
- copian del proyecto de Algo2 las carpetas `src/main/java` y `src/test/java` y la ubican en el mismo lugar en el proyecto de Algo3
- luego tendrán que renombrar con un Refactor en Eclipse las clases `SaludadorApplication` y `SaludadorController`

## Qué es Spring Boot

![spring-boot logo](./images/spring-boot-logo.png)

Spring es un framework para desarrollar aplicaciones web que corre sobre una JDK Java. Tiene una amplia gama de configuraciones de lenguaje (Java, Groovy, Kotlin), de herramientas de manejo de dependencias (Maven, Gradle), de servidores Web (Jetty, Tomcat, Undertow) e incluso de formas de persistir la información. Es decir, es una tecnología que permite construir una aplicación comercial desde cero. Como esto puede resultar un poco agobiante, vamos a tomar la variante **Spring Boot**, que tomará algunas decisiones iniciales por nosotros, lo que va a suavizar la curva inicial de aprendizaje de esta tecnología.

## Ejecutando el proyecto

El proyecto tiene un main, en la clase `SaludadorApplication`:

```xtend
@SpringBootApplication class SaludadorApplication {
	def static void main(String[] args) {
		SpringApplication.run(SaludadorApplication, args)
	}
}
```

Cuando levantamos la aplicación, lo que hace Spring es levantar un servidor web que está escuchando pedidos por un socket, el puerto 8080.

![OSI model - http](./images/httpOSImodel.png)

Para profundizar más te recomendamos leer [el artículo introductorio a la Arquitectura Web](http://wiki.uqbar.org/wiki/articles/ui-web-intro-arquitectura.html).

## Requerimientos a resolver

Queremos poder

- recibir un saludo que por defecto sea "Hola mundo!"
- configurar ese saludo
- poder parametrizar el saludo a una persona

## Controller / Endpoints / Rutas

Para resolver estos requerimientos vamos a implementar un **Controller**, la clase encargada de responder los pedidos que van a llegar por el protocolo http (en breve veremos cómo).

### Convention over configuration

Por defecto el controller se ubica en el package `org.uqbar.saludador.controller`, mientras que la clase que apunta a la aplicación principal es `org.uqbar.saludador`. Esto permite que no tengamos que agregar archivos de configuración específicos, **por convención** Spring buscará un paquete `controller` a partir de `org.uqbar.saludador`.

### Saludo default

El primer caso de uso es recibir un saludo que por defecto sea "Hola mundo!". Dado que es un pedido que solo pide información y no produce efecto colateral (no se modifica el estado del sistema), escribiremos un método http GET.

El controller tiene como responsabilidad

- adaptar la información de entrada, generando el grafo de objetos necesario
- delegar a dichos objetos la resolución del requerimiento
- y devolver la información correspondiente a través del protocolo http (en nuestro caso `json`)
- adicionalmente, tiene que ser capaz de rechazar pedidos inválidos, autenticar y manejar errores de programa

Es frecuente que el controller se termine transformando en un objeto con mucha responsabilidad, un **God Object**. En ese caso nos podemos preguntar si no faltan abstracciones que puedan tomar algunas de esas responsabilidades.

Veamos una posible solución:

```xtend
@Controller
class SaludoController {
	
	Saludador saludador = new Saludador()
	
	@RequestMapping(value = "/saludoDefault", method = GET)
	@ResponseBody
    def darSaludo() {
        this.saludador.buildSaludo()
    }

}

class Saludador {
	...

	@Accessors String saludoDefault = "Hola mundo!"
	
	def buildSaludo() {
		buildSaludoCustom(this.saludoDefault)
	}
}

@Data
class Saludo implements Serializable {
	int id
	String saludo
	LocalDateTime fechaCreacion = LocalDateTime.now
}
```

![build saludo](./images/buildSaludoDefault.png)

- el Saludador guarda como estado el saludo default
- el Saludo es un _value object_, que el Controller exporta como resultado convirtiéndolo por default en JSON (publica **todas sus variables de instancia**)

### Mapeo de Rutas

Si vieron la definición del método en el controller

```xtend
	@RequestMapping(value = "/saludoDefault", method = GET)
	@ResponseBody
  def darSaludo() {
```

la annotation `RequestMapping` permite asociarla con una **ruta** de nuestro web server, que se forma con

- nuestra IP (`localhost`)
- el puerto (que por defecto es 8080)
- y la ruta específica `"/saludoDefault"`, vía GET, que se asocia al método darSaludo

Esto permite que levantemos nuestro servidor Jetty con Springboot y desde un navegador probemos:

`http://localhost:8080/saludoDefault`

Eso nos devuelve algo como

```json
{
	"id": 1,
	"saludo":"Hola mundo!",
	"fechaCreacion":"2020-06-26T22:03:31.444752"
}
```

La respuesta se publica en el body del navegador gracias a la annotation `@ResponseBody`.

### Método PUT

### Qué otros métodos hay

### Probarlo con un cliente REST

## Manejo de errores y códigos HTTP

## Cómo testear endpoints

## Resumen de la arquitectura

