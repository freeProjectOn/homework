FROM alpine/git as clone 
WORKDIR /app
RUN git clone https://github.com/fefrik/homework.git

FROM jamesdbloom/docker-java8-maven as build 
WORKDIR /app
COPY --from=clone /app/homework /app 
RUN mvn install

FROM anapsix/alpine-java
WORKDIR /app
COPY --from=build /app/target/homework-1.0.0.jar /app
EXPOSE 8000
ENTRYPOINT ["java", "-jar", "homework-1.0.0.jar"]
