FROM openjdk:8
ADD target/Audit-Authentication.jar Audit-Authentication.jar
EXPOSE 8090
ENTRYPOINT ["java","-jar","/Audit-Authentication.jar"]