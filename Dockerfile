FROM tomcat

COPY target/flipkart.war /usr/local/tomcat/webapps/flipkart.war

# local application port

# execute it