# ---- Build ----
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY reservation-salles/pom.xml .
RUN mvn -q dependency:go-offline
COPY reservation-salles/src ./src
RUN mvn -q clean package -DskipTests

# ---- Run ----
FROM tomcat:10.1-jre17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war
# Utilise le port fourni par la plateforme (Render/Railway), 8080 par défaut
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
