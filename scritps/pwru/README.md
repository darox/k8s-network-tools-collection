# pwru

See https://github.com/cilium/pwru for more information. 

## Notes

When analysing VXLAN or IPsec encapsulated packets. The following argument can be added to follow the skbs:

```
--filter-track-skb
```

Network namespace filtering can be done with the following argument:

```
--filter-netns <netns>
```

