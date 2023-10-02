# Tetragon

See [Tetragon](https://github.com/cilium/tetragon) for more details. 

Tetragon is a Security Observability and Runtime enforcement tool. It can be used to analyse network connectivity for a specific process. 

## Usage 

The script in this folder expects a node name and a policy as arguments. The included policy in this folder tracks all connections executed by the `curl` command. 

```yaml
apiVersion: cilium.io/v1alpha1
kind: TracingPolicy
metadata:
  name: "track-all-curl-connections"
spec:
  kprobes:
  - call: "tcp_connect"
    syscall: false
    args:
    - index: 0
      type: "sock"
    selectors:
    - matchBinaries:
      - operator: "In"
        values:
        - "/usr/bin/curl"
```

In the console we will see:
```bash
🚀 process  /usr/bin/curl https://1.1.1.1                                 
🔌 connect  /usr/bin/curl tcp 10.201.2.249:59378 -> 1.1.1.1:443           
💥 exit     /usr/bin/curl https://1.1.1.1 0 
```

The script optionally takes a third argument to specify a filter for grep to filter the output. 

```bash
bash tetragon.sh ip-10-2-0-18.eu-central-2.compute.internal policy.yaml
```

This third argument is supported because Tetragon doesn't support disabling the standard sensor i.e. process events. 



