# Tetragon

See [Tetragon](https://github.com/cilium/tetragon) for more details. 

Tetragon is a Security Observability and Runtime enforcement tool. It can be used to analyse network connectivity for a specific process. 

## Usage 

The script in this folder expects only a node name as argument. Optional are policy and grep filter arguments to filter the output. 
If no policy is specified, the script defaults to the policy in this folder. This policy tracks all connections from curl. 
See below for the policy:

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

The below command will run the script with the default policy and filter the output for the curl process. 

```bash
tetragon ip-10-2-0-18.eu-central-2.compute.internal "" "curl"
```

This third argument is supported because Tetragon doesn't support disabling the standard sensor i.e. process events. 



