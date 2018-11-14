FROM alpine/git as clone 
WORKDIR /app
RUN git clone https://github.com/fefrik/homework.git

FROM maven:3.5.2-jdk-8-alpine as build 
WORKDIR /app
COPY --from=clone /app/homework /app 
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/homework-1.0.0.jar /app
EXPOSE 8000
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar homework-1.0.0.jar"]
