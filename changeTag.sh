#! /bin/bash

sed "s/tagVersion/$1/g" reactapp-deployment.yaml > reactapp-config.k8s.yaml