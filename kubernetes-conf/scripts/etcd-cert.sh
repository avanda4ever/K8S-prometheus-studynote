#!/bin/bash
#配置证书生成策略，让 CA 软件知道颁发有什么功能的证书，生成用来签发其他组件证书的根证书
cat > ca-config.json <<EOF
{
 "signing": {
   "default": {
     "expiry": "87600h"
   },
   "profiles": {
     "www": {
        "expiry": "87600h",
        "usages": [
           "signing",
           "key encipherment",
           "server auth",
           "client auth"
       ]
     }
   }
 }
}
EOF

#ca-config.json：可以定义多个 profiles，分别指定不同的过期时间、使用场景等参数；
#后续在签名证书时会使用某个 profile；此实例只有一个 www 模板。
#expiry：指定了证书的有效期，87600h 为10年，如果用默认值一年的话，证书到期后集群会立即宕掉
#signing：表示该证书可用于签名其它证书；生成的 ca.pem 证书中 CA=TRUE；
#key encipherment：表示使用非对称密钥加密，如 RSA 加密；
#key encipherment：表示使用非对称密钥加密，如 RSA 加密；
#server auth：表示client可以用该 CA 对 server 提供的证书进行验证；
#client auth：表示server可以用该 CA 对 client 提供的证书进行验证；
#注意标点符号，最后一个字段一般是没有逗号的。
#-----------------------
#生成CA证书和私钥（根证书和私钥）
#特别说明： cfssl和openssl有一些区别，openssl需要先生成私钥，然后用私钥生>成请求文件，最后生成签名的证书和私钥等，但是cfssl可以直接得到请求文件。
cat > ca-csr.json <<EOF
{
   "CN": "etcd",
   "key": {
       "algo": "rsa",
       "size": 2048
   },
   "names": [
       {
           "C": "CN",
           "L": "Beijing",
           "ST": "Beijing"
       }
   ]
}
EOF

#CN：Common Name，浏览器使用该字段验证网站或机构是否合法，一般写的是域名
#key：指定了加密算法，一般使用rsa（size：2048）
#C：Country，国家
#ST：State，州，省
#L：Locality，地区,城市
#O: Organization Name，组织名称，公司名称
#OU: Organization Unit Name，组织单位名称，公司部门

cfssl gencert -initca ca-csr.json | cfssljson -bare ca

#生成的文件：
#ca-key.pem：根证书私钥
#ca.pem：根证书
#ca.csr：根证书签发请求文件

#cfssl gencert -initca <CSRJSON>：使用 CSRJSON 文件生成生成新的证书和私钥>。如果不添加管道符号，会直接把所有证书内容输出到屏幕。
#注意：CSRJSON 文件用的是相对路径，所以 cfssl 的时候需要 csr 文件的路径下>执行，也可以指定为绝对路径。
#cfssljson 将 cfssl 生成的证书（json格式）变为文件承载式证书，-bare 用于命名生成的证书文件。

#-----------------------
#生成 etcd 服务器证书和私钥
cat > server-csr.json <<EOF
{
   "CN": "etcd",
   "hosts": [
   "10.206.0.11",
   "10.206.0.12"
   ],
   "key": {
       "algo": "rsa",
       "size": 2048
   },
   "names": [
       {
           "C": "CN",
           "L": "BeiJing",
           "ST": "BeiJing"
       }
   ]
}
EOF

#hosts：将所有 etcd 集群节点添加到 host 列表，需要指定所有 etcd 集群的节点ip 或主机名不能使用网段，新增 etcd 服务器需要重新签发证书。

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=www server-csr.json | cfssljson -bare server

#生成的文件：
#server.csr：服务器的证书请求文件
#server-key.pem：服务器的私钥
#server.pem：服务器的数字签名证书

#-config：引用证书生成策略文件 ca-config.json
#-profile：指定证书生成策略文件中的的使用场景，比如 ca-config.json 中的 www
