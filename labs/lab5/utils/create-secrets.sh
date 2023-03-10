echo "Creating Credentials secret..."

oc process -f artemis-secret.yaml \
-p USERNAME=admin \
-p PASSWORD=password1! \
-p TRUSTSTORE_PASSWORD=password1! \
-p BROKER_URL=amqps://rhte-artemis-one-way-ssl-0-svc.amq.svc.cluster.local:5673 \
| oc create -f - -o yaml --dry-run=client | kubeseal --controller-namespace sealed-secrets --controller-name sealed-secrets-controller --format yaml > sealed-amq-secret.yaml

echo "Creating truststore secret"
 oc create secret generic client-truststore --from-file=client.ts -o yaml --dry-run=client | kubeseal --controller-namespace sealed-secrets --controller-name sealed-secrets-controller --format yaml > truststore-secret.yaml
