# K8S-prometheus-studynote

# 记录k8s部署踩坑及promtheus部署踩坑

## 配置文件及脚本

### kube-kuberbnetes-conf

包含手撸K8S配置文件，及cert生成脚本，kubeconfig文件生成脚本等，可配合文档使用

随时更新。。。

## prometheus

包含prometheus&K8S全部yaml

随时更新。。。

## images

忽略，部署过程截图

## K8S部署篇

### 部署版本v1.25.xx

正常部署顺序（手撸二进制）

- 包含kubelet无法使用docker启动解决方案

- kubelet使用containerd部署启动方案

- 包含二进制部署各个组件配置脚本


## 监控爬坑计划（prometheus）

包含但不限于如下，随时更新：

- prometheus常规部署方案

- prometheus高可用

- prometheus自动发现

- prometheus&alertmanger告警配置

- alertmanger告警推送（企业微信webhook&邮件）


## 监控爬坑计划（prometheus&K8S）

包含但不限于：

### promethues部署

- prometheus-configmap.yaml

- prometheus-deployment.yaml

- prometheus-service.yaml

- prometheus-rbac-setup.yaml

- blackbox-exporter.yaml

- node-exporter-daemonset.yml


### prometheus完整监控

- prometheus-configmap.yaml.all


> 包含各个组件target配置
>
> prometheus自动发现

### cadvsior&kube-state-metrics

- prometheus-configmap.yaml


> 包含cadvsior&kube-state-merics实现监控

- ./kube-state-metrics-2.7.0/examples/standard


> 包含kube-state-merics完整配置文件
>
> 已更改本地镜像地址
>
> 已更改prometheus自动发现
>
> 可直接kubectl apply -f .

## Grafana

- 含有grafana docker部署方式

- 含grafana推荐模版--详见具体文档


## ...待更新

others



