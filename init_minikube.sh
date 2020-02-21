#!/bin/bash
lxc profile create minikube

cat minikube.yaml | lxc profile edit minicube

lxc launch ubuntu:19.10 minikube
lxc profile apply minikube default,minikube

