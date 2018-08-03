# jdbc-example

Simple example of how to use JDBC.

The example use H2 database in memory mode.

## Requeriments

* Git to clone the repository.
* Java 1.8+.
* Maven.

## Instructions

Clone the repository:

```bash
$ git clone --depth 1 https://github.com/lisandrofernandez/jdbc-example.git
```

Get into the project root directory:

```bash
$ cd jdbc-example
```

Open ``src/main/java/org/lisandro/App.java`` file and change ``URL`` variable in
order to point to the script located in the cloned repository. If, for example,
the repository is in user home directory, the variable should be:

```java
private static final String URL = "jdbc:h2:mem:test;INIT=runscript from '~/jdbc-example/src/main/db/init.sql'";
```

Compile with maven:

```bash
$ mvn compile
```

Run with maven:

```bash
$ mvn exec:java -Dexec.mainClass="org.lisandro.App"
```

## Copyright

Copyright &copy; 2018
[Lisandro Fernandez](https://dcc.fceia.unr.edu.ar/~lfernandez/). See LICENSE for
details.
