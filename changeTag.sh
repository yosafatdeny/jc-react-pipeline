#! /bin/bash

sed "s/tagVersion/$1/g" reactapp-deployment > reactapp-config.k8s.yaml