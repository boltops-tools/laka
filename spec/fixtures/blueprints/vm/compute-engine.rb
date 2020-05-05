@network_name = "demo-network"

resource("vm-1", "vm",
  machineType: "f1-micro",
  zone: "us-central1-f",
  network: @network_name,
)
resource("vm-2", "vm",
  machineType: "g1-small",
  zone: "us-central1-f",
  network: @network_name,
)
resource(@network_name, "network")
resource("#{@network_name}-firewall", "firewall",
  network: @network_name
)
