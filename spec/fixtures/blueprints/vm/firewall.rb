resource(env("name"), 'compute.v1.firewall',
  network: ref(properties("network")),
  sourceRanges: ["0.0.0.0/0"],
  allowed: [
    IPProtocol: "TCP",
    ports: ["80"]
  ]
)
