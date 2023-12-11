#!/bin/bash
CFGPATH="/data/prometheus/cfg"
echo "apply and rebulid"
sleep 1
kubectl apply -f ${CFGPATH}/prometheus-configmap.yaml
kubectl get pods | grep prome | awk {'print$1'} | xargs kubectl delete pods
while true; do
    status=$(kubectl get pods | grep prome | awk '{print $3}')
    if [ "${status}" == "Running" ]; then
        echo "Pod status Running"
        kubectl get pods
        break  # 退出循环，因为状态为 Running
    elif
    	 [ "${status}" == "CrashLoopBackOff" ]; then
    	 echo "Pod status is ERROR"
       kubectl get pods | grep prom | awk {'print$1'} | xargs kubectl logs | grep 'error'
       break
    else
        echo "Pod status is not Running. Waiting..."
        sleep 5  # 等待5秒，可以根据需要调整等待时间
    fi
done
