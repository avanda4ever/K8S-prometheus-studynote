# K8S-prometheus-studynote

# 记录k8s部署踩坑及promtheus部署踩坑

**所有文档中配置文件均可在对应文件路径中获取，也可根据文档指引配置**

---

## K8S部署篇

### 部署版本v1.25.16

正常部署顺序（手撸二进制）

- 包含二进制部署各个组件配置脚本

- 包含kubelet无法使用docker启动解决方案
- kubelet使用containerd部署启动方案
- 部署stroageclass，包含处理1.24+以上selfLink导致pvc处于pending


## 监控爬坑计划（prometheus部分）

包含但不限于如下，随时更新：

- prometheus常规部署方案

- prometheus高可用

- prometheus自动发现

- prometheus&alertmanger告警配置

- alertmanger告警推送（企业微信webhook&邮件）


## 监控爬坑计划（prometheus&K8S部分）

文档包含但不限于，详细见文档：

### promethues部署

- prometheus-configmap.yaml

- prometheus-deployment.yaml

- prometheus-service.yaml

- prometheus-rbac-setup.yaml

- blackbox-exporter.yaml

- node-exporter-daemonset.yml

### prometheus 服务发现

> 原理及配置

### prometheus完整监控

> 涉及所有常用组件，配置文件可在物料包中获取

- prometheus-configmap.yaml.all


> 包含各个组件target配置
>
> prometheus自动发现

### cadvsior&kube-state-metrics

> 包含监控targets到configmap，及文档

- prometheus-configmap.yaml


> 包含cadvsior&kube-state-merics实现监控

- pormetheus/kube-state-metrics-2.7.0/examples/standard


> 包含kube-state-merics完整配置文件
>
> 已更改本地镜像地址
>
> 已更改prometheus自动发现
>
> 可直接kubectl apply -f .

### Alertmanager&rules

> 部署顺序及一些问题记录，配置文件可直接物料包中获取

- alertmanager-configmap.yaml

> 企业微信机器人webhook

- alertmanager-configmap.yaml.email

> 邮箱

- alertmanager-deployment.yaml

> alertmanager

- alertmanager-ger-tem-configmap.yaml

> 邮件模版

- webhook-adapter-deployment.yaml

> 第三方weebhook插件

## Grafana

- 含有grafana docker部署方式

- 含grafana推荐模版--详见具体文档

- 含grafana-deployment部署


## ...待更新

others

## 配置文件及脚本文件

### kube-kuberbnetes-conf

包含手撸K8S配置文件，及cert生成脚本，kubeconfig文件生成脚本等，可配合文档使用

随时更新。。。

## prometheus

包含prometheus&K8S相关全部yaml

随时更新。。。

## grafana

grafana配置文件及模版json

## images

忽略，部署过程截图



