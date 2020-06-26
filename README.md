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

![spring-boot logo](./images/spring-boot.png)

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

<!-- TODO Gráfico -->

TODO: Relacionarlo con protocolo http.

## Requerimientos a resolver

## Controller / Endpoints / Rutas

### Método GET

### Método PUT

### Qué otros métodos hay

### Probarlo con un cliente REST

## Manejo de errores y códigos HTTP

## Cómo testear endpoints

## Resumen de la arquitectura

