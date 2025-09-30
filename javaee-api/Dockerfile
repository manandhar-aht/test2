# Multi-stage build for JavaEE REST API with WildFly
FROM maven:3.8.6-openjdk-11 AS builder

# Set working directory
WORKDIR /app

# Copy Maven configuration
COPY pom.xml .

# Download dependencies (for better layer caching)
RUN mvn dependency:go-offline -B

# Copy source code
COPY src/ ./src/

# Build the WAR file
RUN mvn clean package -DskipTests

# Runtime stage with WildFly
FROM openjdk:11-jre-slim

# Switch to root for installation
USER root

# Install wget and other tools
RUN apt-get update && apt-get install -y wget curl unzip procps && rm -rf /var/lib/apt/lists/*

# Create jboss user
RUN groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /bin/bash -c "JBoss user" jboss

# Set JBOSS_HOME
ENV JBOSS_HOME /opt/jboss/wildfly
ENV PATH $JBOSS_HOME/bin:$PATH

# Download and install WildFly
RUN cd /tmp && \
    wget https://github.com/wildfly/wildfly/releases/download/26.1.3.Final/wildfly-26.1.3.Final.tar.gz && \
    tar xf wildfly-26.1.3.Final.tar.gz && \
    mv wildfly-26.1.3.Final $JBOSS_HOME && \
    rm wildfly-26.1.3.Final.tar.gz && \
    chown -R jboss:0 ${JBOSS_HOME} && \
    chmod -R g+rw ${JBOSS_HOME}

# Create PostgreSQL module directory
RUN mkdir -p $JBOSS_HOME/modules/org/postgresql/main

# Copy PostgreSQL JDBC driver from Maven build
COPY --from=builder /root/.m2/repository/org/postgresql/postgresql/42.6.0/postgresql-42.6.0.jar $JBOSS_HOME/modules/org/postgresql/main/

# Copy PostgreSQL module configuration
COPY modules/org/postgresql/main/module.xml $JBOSS_HOME/modules/org/postgresql/main/

# Copy original standalone configuration and modify it
COPY standalone-original.xml $JBOSS_HOME/standalone/configuration/standalone.xml

# Copy the built WAR file
COPY --from=builder /app/target/water-infrastructure-api-1.0.0.war $JBOSS_HOME/standalone/deployments/api.war

# Configure datasource using sed to modify the original config
RUN sed -i 's|<datasource jndi-name="java:jboss/datasources/ExampleDS"|<datasource jndi-name="java:jboss/datasources/WaterResourcesDS" pool-name="WaterResourcesDS" enabled="true" use-java-context="true"><connection-url>jdbc:postgresql://postgres:5432/geodb</connection-url><driver>postgresql</driver><security><user-name>geouser</user-name><password>geopass</password></security><validation><valid-connection-checker class-name="org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker"/><background-validation>true</background-validation><exception-sorter class-name="org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter"/></validation></datasource><datasource jndi-name="java:jboss/datasources/ExampleDS"|' $JBOSS_HOME/standalone/configuration/standalone.xml && \
    sed -i 's|<driver name="h2" module="com.h2database.h2">|<driver name="postgresql" module="org.postgresql"><xa-datasource-class>org.postgresql.xa.PGXADataSource</xa-datasource-class></driver><driver name="h2" module="com.h2database.h2">|' $JBOSS_HOME/standalone/configuration/standalone.xml

# Set ownership
RUN chown -R jboss:0 $JBOSS_HOME && chmod -R g+rw $JBOSS_HOME

# Switch to jboss user
USER jboss

# Expose ports (8080 for HTTP, 9990 for management)
EXPOSE 8080 9990

# Start WildFly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]