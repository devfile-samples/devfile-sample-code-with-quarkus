FROM quay.io/wildfly/wildfly-s2i:latest

mvn clean package -Popenshift
mv "target/server/standalone/deployments" "target/deployments"

FROM quay.io/wildfly/wildfly-runtime:latest
COPY --from=0 --chown=jboss:root target/server $JBOSS_HOME
COPY --from=0 --chown=jboss:root target/deployments $JBOSS_HOME/standalone/deployments
