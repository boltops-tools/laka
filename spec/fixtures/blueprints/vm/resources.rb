resource("demo-vm", "compute.v1.instance",
  zone: "us-central1-a",
  machineType: "f1-micro",
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
    network: "default",
    accessConfigs: {
      name: "External NAT",
      type: "ONE_TO_ONE_NAT"
    }
  ]
)
