# K8S-prometheus-studynote记录k8s部署踩坑及promtheus部署踩坑
## K8S部署

### 部署版本v1.25.xx

正常部署顺序

包含kubelet无法使用docker启动解决方案

kubelet使用containerd部署启动方案

包含二进制部署各个组件配置脚本

## prometheus

prometheus常规部署方案

prometheus高可用

prometheus自动发现

prometheus&alertmanger告警配置

alertmanger告警推送（企业微信webhook&邮件）

## prometheus&K8S

### promethues部署脚本

prometheus-configmap.yaml

prometheus-deployment.yaml

prometheus-service.yaml

prometheus-rbac-setup.yaml

blackbox-exporter.yaml

node-exporter-daemonset.yml

### prometheus完整监控

prometheus-configmap.yaml.all

> 包含各个组件target配置
>
> prometheus自动发现

### cadvsior&kube-state-metrics

prometheus-configmap.yaml

> 包含cadvsior&kube-state-merics实现监控

./kube-state-metrics-2.7.0/examples/standard

> 包含kube-state-merics完整配置文件
>
> 已更改本地镜像地址
>
> 已更改prometheus自动发现
>
> 可直接kubectl apply -f .

## Grafana

含有grafana docker部署方式

含grafana推荐模版--详见具体文档

## ...待更新

others


