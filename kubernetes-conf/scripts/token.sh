#! /bin/bash
urandom=$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ')

cat > /k8s/kubernetes/cfg/token.csv << EOF
${urandom},kubelet-bootstrap,10001,"system:node-bootstrapper"
EOF
