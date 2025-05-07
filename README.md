# Karate DSL with Allure Reporting

Karate es un framework de pruebas potente y flexible para API y servicios web, que ha ganado gran popularidad gracias a su sintaxis intuitiva y expresiva basada en Cucumber. Integrar Karate con Allure permite aprovechar las ventajas de ambas herramientas, obteniendo informes detallados y fáciles de leer sobre las pruebas de API ejecutadas con Karate.

En este artículo, exploraremos cómo configurar y utilizar la integración de Karate con Allure Reporting. Además, aprenderemos a personalizar y ampliar los informes según las necesidades de nuestro proyecto.

## Introducción a Allure Karate DSL

Genere hermosos informes HTML utilizando [Allure Report](https://allurereport.org/) y sus pruebas de [Karate DSL](https://karatelabs.github.io/karate/).

![](https://media.licdn.com/dms/image/v2/D4E12AQEor2jBk4rH-A/article-inline_image-shrink_400_744/article-inline_image-shrink_400_744/0/1718425301059?e=1752105600&v=beta&t=Bj3-s4srfhIio6seINvagQyQbyEgr3wUHZQuStfhQIQ)

> [!NOTE]
> Consulte los proyectos de ejemplo en [Allure Karate](https://github.com/allure-examples/allure-karate-example).

## Configuración

Para integrar Allure en un proyecto de Karate existente, necesita:
- Añadir las dependencias de Allure a su proyecto.
- Configurar AspectJ para la compatibilidad con las anotaciones @Step y @Attachment.
- Designar una ubicación para el almacenamiento de los resultados de Allure.

## Agregar dependencias de Allure

```xml
<!-- Define the version of Allure you want to use via the allure.version property -->
<properties>
    <allure.version>2.25.0</allure.version>
</properties>

<!-- Add allure-bom to dependency management to ensure correct versions of all the dependencies are used -->
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>io.qameta.allure</groupId>
            <artifactId>allure-bom</artifactId>
            <version>${allure.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>

<!-- Add necessary Allure dependencies to dependencies section -->
<dependency>
     <groupId>io.qameta.allure</groupId>
     <artifactId>allure-karate</artifactId>
      <scope>test</scope>
</dependency>
```

## Configure AspectJ

Allure utiliza AspectJ para la funcionalidad de las anotaciones @Step y @Attachment. Además, algunas integraciones con frameworks (como [allure-assertj](https://mvnrepository.com/artifact/io.qameta.allure/allure-assertj)) dependen de la integración con AspectJ para funcionar correctamente.

```xml
<!-- Define the version of AspectJ -->
<properties>
    <aspectj.version>1.9.21</aspectj.version>
</properties>

<!-- Add the following options to your maven-surefire-plugin -->
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>3.2.3</version>
    <configuration>
        <argLine>
            -javaagent:"${settings.localRepository}/org/aspectj/aspectjweaver/${aspectj.version}/aspectjweaver-${aspectj.version}.jar"
        </argLine>
    </configuration>
    <dependencies>
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjweaver</artifactId>
            <version>${aspectj.version}</version>
        </dependency>
    </dependencies>
</plugin>
```

## Especificación de la ubicación de los resultados de Allure

Allure, por defecto, guarda los resultados de las pruebas en el directorio raíz del proyecto. Sin embargo, se recomienda almacenarlos en el directorio de salida de la compilación.

Para configurar esto, cree un archivo allure.properties y colóquelo en el directorio de recursos de prueba de su proyecto, que normalmente se encuentra en `src/test/resources`:


```
allure.results.directory=target/allure-results
```

## Ejecutar pruebas

Ejecuta tus pruebas de karate como lo harías habitualmente. Por ejemplo:

```sh
# Para Maven:
mvn verify
```

Tras ejecutar las pruebas, Allure recopilará los datos de ejecución y los almacenará en el directorio allure-results. A continuación, podrá generar un informe HTML a partir de estos resultados utilizando las herramientas de informes de Allure.

## Generar un informe

Finalmente, convierta los resultados de la prueba en un informe HTML. Esto se puede hacer con uno de estos dos comandos:

```
allure serve target/allure-results 
```

Si desea agregar más metadatos, puede usar como referencia el ejemplo de Allure que se encuentra en el paso "Prueba de karate de Allure" o el ejemplo que creé siguiendo los mismos pasos.

También puede usar los metadatos de Cucumber-JVM de la documentación oficial.

He probado otras forma de implementarlo he logrado acortar configuracion del aspectJ