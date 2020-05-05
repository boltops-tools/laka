resource(env("name"), "compute.v1.network",
  routingConfig: {routingMode: "REGIONAL"},
  autoCreateSubnetworks: true,
)
