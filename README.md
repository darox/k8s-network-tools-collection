# A collection of useful tools for Kubernetes network debugging

This GitHub repository is a collection of tools for debugging network issues in Kubernetes clusters. It includes a variety of utilities that can help developers and system administrators to diagnose and troubleshoot common networking problems that may arise in their 
Kubernetes deployments.

The tools included in this repository are designed to work with Kubernetes clusters of all sizes, from small local clusters to large-scale production environments. They cover a wide range of use cases, such as diagnosing connectivity issues between pods, inspecting network 
traffic, troubleshooting DNS resolution, and more.

By using these tools, you can gain greater insight into the network traffic in your Kubernetes clusters and troubleshoot issues more effectively. Whether you're a beginner or an experienced Kubernetes user, this repository has something to offer for anyone looking to 
improve the networking performance of their Kubernetes deployment.


## Tools

| Name         | OCI IMAGE                        | Link                                                           |
| ------------ | -------------------------------- | -------------------------------------------------------------- |
| flamethrower | ns1labs/flame:latest             | [flamethrower](https://github.com/DNS-OARC/flamethrower)       |
| netshoot     | nicolaka/netshoot:latest         | [netshoot](https://github.com/nicolaka/netshoot)               |
| ncat         | itsthenetwork/alpine-ncat:latest | [ncat](https://hub.docker.com/r/itsthenetwork/alpine-ncat/tags)|
| pwru         | docker.io/cilium/pwru:latest     | [pwru](https://github.com/cilium/pwru)                         |
| tetragon     | quay.io/cilium/tetragon          | [tetragon](https://github.com/cilium/tetragon)                 |

## Scripts

The scripts folder includes some scripts to launch ad-hoc pods for running tools like pwru or tetragon. Store these scripts somewhere on your machine and create an alias under `~/.zshrc` or `~/.bashrc` to make them available in your shell. An example is:
```
alias pwru="~/scripts/pwru.sh"
```                                                                                                                                                 
