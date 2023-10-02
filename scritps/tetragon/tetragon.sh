#!/usr/bin/env bash

# Check if arguments is either 2 or 3
if [ $# -ne 1 ] && [ $# -ne 2 ] && [ $# -ne 3 ]; then
  echo "Usage: my_script NODE [TETRA_POLICY] [GREP_ARGS]"
  exit 1
fi

NODE="$1"
TETRA_POLICY="$2"
GREP_ARGS="$3"

# On ctrl-c, delete the pod and configmap
trap " kubectl delete --wait=false pod tetragon && kubectl delete cm tetragon-policy" EXIT

# If no policy is provided, the script defaults to the policy.yaml in the same directory.
if [ -z "$TETRA_POLICY" ]; then
  TETRA_POLICY="$(dirname "$0")/policy.yaml"
fi

kubectl create configmap tetragon-policy --from-file=policy.yaml="$TETRA_POLICY"

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: tetragon
spec:
  nodeName: $NODE
  containers:
  - name: tetragon
    image: quay.io/cilium/tetragon:v0.11.0
    securityContext:
      privileged: true
    volumeMounts:
    - name: btf-volume
      mountPath: /var/lib/tetragon/btf
    - name: policy
      mountPath: /etc/tetragon/tetragon.tp.d/policy.yaml
      subPath: policy.yaml
  hostPID: true
  hostIPC: true
  hostNetwork: true
  volumes:
  - name: btf-volume
    hostPath:
      path: /sys/kernel/btf/vmlinux
  - name: policy
    configMap:
      name: tetragon-policy
      items:
      - key: policy.yaml
        path: policy.yaml
EOF

kubectl wait pod tetragon --for condition=Ready --timeout=90s
kubectl exec -it tetragon -- tetra getevents -o compact | grep "$GREP_ARGS"