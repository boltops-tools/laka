resource(env("name"), "compute.v1.instance",
  zone: properties("zone"),
  machineType: properties("machineType"),
  disks: [
    deviceName: "boot",
    type: "PERSISTENT",
    boot: true,
    autoDelete: true,
    initializeParams: {
      sourceImage: "debian-9"
    }
  ],
  scheduling: {
    preemptible: true,
    automaticRestart: false,
  },
  networkInterfaces: [
    network: ref(properties("default")),
    accessConfigs: [
      name: "External NAT",
      type: "ONE_TO_ONE_NAT"
    ]
  ]
)
