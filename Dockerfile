# Image provides a container in which to run the example Hello World docker transformer.

FROM alfresco/alfresco-base-java:11.0.1-openjdk-centos-7-6784d76a7b81

ENV JAVA_OPTS=""

# Set default user information
ARG GROUPNAME=Alfresco
ARG GROUPID=1000
ARG USERNAME=transform-helloworld
ARG USERID=33004

COPY target/alfresco-helloworld-transformer-${env.project_version}.jar /usr/bin

RUN ln /usr/bin/alfresco-helloworld-transformer-${env.project_version}.jar /usr/bin/alfresco-helloworld-transformer.jar && \
    yum clean all

RUN groupadd -g ${GROUPID} ${GROUPNAME} && \
    useradd -u ${USERID} -G ${GROUPNAME} ${USERNAME} && \
    chgrp -R ${GROUPNAME} /usr/bin/alfresco-helloworld-transformer.jar

EXPOSE 8090

USER ${USERNAME}

ENTRYPOINT java $JAVA_OPTS -jar /usr/bin/alfresco-helloworld-transformer.jar
