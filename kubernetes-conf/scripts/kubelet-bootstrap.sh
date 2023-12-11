#!/bin/bash
BOOTSTRAP_TOKEN=$(cat /k8s/kubernetes/cfg/token.csv | cut -d ',' -f 1)
SSLPATH="/k8s/kubernetes/ssl"
APISERVER="https://10.206.0.12:6443"
# 设置集群参数
kubectl config set-cluster kubernetes \
 --certificate-authority=$SSLPATH/ca.pem \
 --embed-certs=true \
 --server=${APISERVER} \
 --kubeconfig=bootstrap.kubeconfig
#--embed-certs=true：表示将ca.pem证书写入到生成的bootstrap.kubeconfig文件中
# 设置客户端认证参数，kubelet 使用 bootstrap token 认证
kubectl config set-credentials kubelet-bootstrap \
 --token=${BOOTSTRAP_TOKEN} \
 --kubeconfig=bootstrap.kubeconfig
# 设置上下文参数
kubectl config set-context default \
 --cluster=kubernetes \
 --user=kubelet-bootstrap \
 --kubeconfig=bootstrap.kubeconfig
# 使用上下文参数生成 bootstrap.kubeconfig 文件
kubectl config use-context default --kubeconfig=bootstrap.kubeconfig
