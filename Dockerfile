#
#
#
FROM java:7-jdk

ENV WORK_HOME /usr/local/apiman
RUN mkdir -p "$WORK_HOME"
WORKDIR $WORK_HOME

#ENV get-new-jar 11

RUN curl -S -L "http://eformat.co.nz/apiman/apiman-distro-wildfly8-1.1.8.Final-overlay.zip" -o apiman-distro-wildfly8-1.1.7.Final-overlay.zip
RUN curl -S -L "http://eformat.co.nz/apiman/wildfly-8.2.0.Final.zip" -o wildfly-8.2.0.Final.zip

RUN unzip wildfly-8.2.0.Final.zip
RUN unzip -o apiman-distro-wildfly8-1.1.7.Final-overlay.zip -d wildfly-8.2.0.Final

RUN chmod +x /usr/local/apiman/wildfly-8.2.0.Final/bin/standalone.sh

RUN echo "apiman-gateway.public-endpoint=https://api.cloudapps.ose.eformat.co.nz/api-gateway/" >> /usr/local/apiman/wildfly-8.2.0.Final/standalone/configuration/apiman.properties

#RUN echo "apiman-gateway.connector-factory.tls.allowAnyHost=true" >> /usr/local/apiman/wildfly-8.2.0.Final/standalone/configuration/apiman.properties

#RUN echo "apiman-gateway.connector-factory.tls.allowSelfSigned=true" >> /usr/local/apiman/wildfly-8.2.0.Final/standalone/configuration/apiman.properties


EXPOSE 8080
EXPOSE 8443

CMD ["/usr/local/apiman/wildfly-8.2.0.Final/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "standalone-apiman.xml"]
