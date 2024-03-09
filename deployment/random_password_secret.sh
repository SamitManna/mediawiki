#!/bin/bash
secret_file="kustomize-mediawiki/base/secret.yaml"
random_password=$(pwgen -1 16)
base64_encoded_password=$(echo -n "$random_password" | base64)
sed -i "s|root-password:.*|root-password: $base64_encoded_password|g" "$secret_file"