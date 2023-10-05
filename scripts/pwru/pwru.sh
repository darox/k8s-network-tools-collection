#!/usr/bin/env bash

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  echo "Usage: my_script NODE [PWRU_ARGS]"
  exit 1
fi

NODE="$1"
PWRU_ARGS="$2"

trap " kubectl delete --wait=false pod pwru " EXIT

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: pwru
spec:
  nodeSelector:
    kubernetes.io/hostname: ${NODE}
  containers:
  - image: docker.io/cilium/pwru:latest
    name: pwru
    volumeMounts:
    - mountPath: /sys/kernel/debug
      name: sys-kernel-debug
    securityContext:
      privileged: true
    command: ["/bin/sh"]
    args: ["-c", "pwru --output-meta --output-tuple ${PWRU_ARGS}"]
  volumes:
  - name: sys-kernel-debug
    hostPath:
      path: /sys/kernel/debug
      type: DirectoryOrCreate
  hostNetwork: true
  hostPID: true
EOF

kubectl wait pod pwru --for condition=Ready --timeout=90s
kubectl logs -f pwru
