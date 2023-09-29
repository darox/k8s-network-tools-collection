# pwru

See https://github.com/cilium/pwru for more information. 

## Notes

Please be aware that the following notes mainly relate to the usage of pwru when running Cilium.

When analysing VXLAN or IPsec encapsulated packets. The following argument can be added to follow the skbs:

```
--filter-track-skb
```

Network namespace filtering can be done with the following argument:

```
--filter-netns <netns>
```

With an existing alias of pwru, run the following command to start pwru with a filter on a specific node:

```
pwru aks-main-16287354-vmss000002 "'dst host 1.1.1.1'"
```

If we now do a curl to 1.1.1.1 from a pod on that node, we will see the following output:

```
pod/pwru created
pod/pwru condition met
2023/09/27 15:51:09 Attaching kprobes (via kprobe)...
2023/09/27 15:51:38 Listening for events..
0xffff8b61e9a596e0      0           [curl]             ip_local_out netns=4026532452 mark=0x0 iface=0 proto=0 mtu=0 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]           __ip_local_out netns=4026532452 mark=0x0 iface=0 proto=0 mtu=0 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]                ip_output netns=4026532452 mark=0x0 iface=0 proto=8 mtu=0 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]             nf_hook_slow netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]  apparmor_ipv4_postroute netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]         ip_finish_output netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl] __cgroup_bpf_run_filter_skb netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]       __ip_finish_output netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]        ip_finish_output2 netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]     neigh_resolve_output netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]       __neigh_event_send netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]               eth_header netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]                 skb_push netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=60 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]           dev_queue_xmit netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]         __dev_queue_xmit netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]       qdisc_pkt_len_init netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]      netdev_core_pick_tx netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]        validate_xmit_skb netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]       netif_skb_features netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]  passthru_features_check netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]     skb_network_protocol netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]       validate_xmit_vlan netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]  skb_csum_hwoffload_help netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]       validate_xmit_xfrm netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]      dev_hard_start_xmit netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]        __dev_forward_skb netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]       __dev_forward_skb2 netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]         skb_scrub_packet netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
0xffff8b61e9a596e0      0           [curl]           eth_type_trans netns=4026532452 mark=0x0 iface=122(eth0) proto=8 mtu=1500 len=74 10.240.0.67:45880->1.1.1.1:443(tcp)
```

This is just the first portion of the output up to the point where the packets leave the pod. 

- netns=4026532452 is the network namespace of the pod 
- iface=122(eth0) is the interface of the pod 
    ```
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
        valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host 
        valid_lft forever preferred_lft forever
    122: eth0@if123: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
        link/ether 7a:4d:b2:58:bb:24 brd ff:ff:ff:ff:ff:ff link-netnsid 0
        inet 10.240.0.67/32 scope global eth0
        valid_lft forever preferred_lft forever
        inet6 fe80::784d:b2ff:fe58:bb24/64 scope link 
        valid_lft forever preferred_lft forever
    ```
- iface=0 a the very top of the output means, that the kernel has not yet assigned the interface for the packet. Because the routing decision has not yet been made.

The next portion of the output shows where the packet enters the host network namespace. We now that `4026531840` is the host network namespace by checking the output of:

```
# ls -l /proc/[1-9]*/ns/net
lrwxrwxrwx 1 root root 0 Sep 29 11:24 /proc/1/ns/net -> 'net:[4026531840]'
```

The above command can be executed within the cilium-agent pod. 

```
0xffff8b61b879fee0      1           [curl]                 netif_rx netns=4026531840 mark=0x0 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]        netif_rx_internal netns=4026531840 mark=0x0 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]       enqueue_to_backlog netns=4026531840 mark=0x0 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]      __netif_receive_skb netns=4026531840 mark=0x0 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl] __netif_receive_skb_one_core netns=4026531840 mark=0x0 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]             tcf_classify netns=4026531840 mark=0x0 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]      skb_ensure_writable netns=4026531840 mark=0x0 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=74 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]                   ip_rcv netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]              ip_rcv_core netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]                tcp_wfree netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]             nf_hook_slow netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]              nf_checksum netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]           nf_ip_checksum netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]   __inet_lookup_listener netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]       inet_lhash2_lookup netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]       inet_lhash2_lookup netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]       tcp_v4_early_demux netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]     ip_route_input_noref netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]       ip_route_input_rcu netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]      ip_route_input_slow netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]          __mkroute_input netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]      fib_validate_source netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]    __fib_validate_source netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]               ip_forward netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]         pskb_expand_head netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]         skb_release_data netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl] skb_headers_offset_update netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]             nf_hook_slow netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]        ip_forward_finish netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
0xffff8b61b879fee0      1           [curl]                ip_output netns=4026531840 mark=0x18290f00 iface=123(lxcfe1641b50430) proto=8 mtu=1500 len=60 10.240.0.67:45700->1.1.1.1:443(tcp)
``````

- The function `tcf_classify` is the first occurance where an eBPF program gets triggered. We can use the command `tc` to identify the eBPF program that's executed.
    ```
    # tc filter sh dev lxcfe1641b50430 ingress
    filter protocol all pref 1 bpf chain 0 
    filter protocol all pref 1 bpf chain 0 handle 0x1 bpf_lxc.o:[from-container] direct-action not_in_hw id 16370 tag 830ad784df42d29f jited
    ```
   What corresponds to https://github.com/cilium/cilium/blob/main/bpf/bpf_lxc.c#L1344







