#! /bin/bash
SSLPATH="/k8s/kubernetes/ssl"
APISERVER="https://10.206.0.12:6443"
cat > kube-scheduler-csr.json << EOF
{
  "CN": "system:kube-scheduler",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "L": "HangZhou",
      "O": "system:kube-scheduler",
      "OU": "openEuler k8s kube scheduler",
      "ST": "BinJiang"
    }
  ]
}
EOF

cfssl gencert -ca=${SSLPATH}/ca.pem -ca-key=${SSLPATH}/ca-key.pem -config=${SSLPATH}/ca-config.json -profile=kubernetes kube-scheduler-csr.json | cfssljson -bare kube-scheduler
#设置集群参数
kubectl config set-cluster kubernetes --certificate-authority=${SSLPATH}/ca.pem --embed-certs=true --server=${APISERVER} --kubeconfig=kube-scheduler.kubeconfig
#设置客户端认证参数
kubectl config set-credentials kube-scheduler --client-certificate=kube-scheduler.pem --client-key=kube-scheduler-key.pem --embed-certs=true --kubeconfig=kube-scheduler.kubeconfig
#设置上下文参数
kubectl config set-context default --cluster=kubernetes --user=kube-scheduler --kubeconfig=kube-scheduler.kubeconfig
#设置当前上下文
kubectl config use-context default --kubeconfig=kube-scheduler.kubeconfig
#创建并复制配置文件至指定文件夹
cp kube-scheduler.kubeconfig /k8s/kubernetes/cfg
