locals {
  # User/name password per Base Box reqs
  username = "packer"
  password = "packer"
  sudo_cmd = "echo '${local.password}' | sudo -S -E"
}

source "virtualbox-iso" "vbox" {
  ### VM Options ###
  disk_size = 40000
  guest_additions_mode = "disable"
  guest_os_type = "Ubuntu_64"
  hard_drive_discard = true
  hard_drive_interface = "sata"
  sata_port_count = 2
  hard_drive_nonrotational = true
  iso_interface = "sata"
  vm_name = "Ubuntu"
  cpus = 2
  memory = 4096
  ### ISO Options ###
  iso_url = "https://releases.ubuntu.com/20.04/ubuntu-20.04-live-server-amd64.iso"
  iso_checksum_type = "sha256"
  iso_checksum_url = "https://releases.ubuntu.com/20.04/SHA256SUMS"
  ### HTTP Server Options ###
  http_directory = "http"
  ### Export Options ###
  format = "ovf"
  ### Run Options ###
  headless = true
  ### Shutdown Options ###
  shutdown_command = "${local.sudo_cmd} shutdown -P now"
  ### Communicator Options ###
  communicator = "ssh"
  ssh_username = "${local.username}"
  ssh_password = "${local.password}"
  ssh_timeout = "90m"
  #pause_before_connecting = "10m"
  ### Boot Options ###
  boot_wait = "7s"
  # References for boot command and preseed options
  # https://wiki.ubuntu.com/UbiquityAutomation
  # https://wiki.ubuntu.com/Enterprise/WorkstationAutoinstallPreseed
  boot_command = [
    "<esc><wait>",
    "<esc><wait>",
    "<esc><wait>",
    "<enter>",
    ## Boot into Casper ##
    "/casper/vmlinuz<wait>",
    " boot=casper",
    " initrd=/casper/initrd",
    ## Get an IP from DHCP ##
    " ip=dhcp",
    ## Automatic install ##
    " auto",
    " noprompt",
    " automatic-ubiquity",
    ## Set up clock/timezone ##
    " time/zone=US/Central",
    ## Set up user ##
    " passwd/root-login=true", # Per base box requirements
    " passwd/root-password=${local.password}", # Per base box requirements
    " passwd/root-password-again=${local.password}", # Per base box requirements
    " user-setup/allow-password-weak=true", # Default Vagrant password is weak
    " passwd/user-fullname=${local.username}", 
    " passwd/username=${local.username}",
    " passwd/user-password=${local.password}", 
    " passwd/user-password-again=${local.password}",
    " url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
    " --- <wait>",
    "<enter><wait>"
  ]
}

# A build starts sources and runs provisioning steps on those sources.
build {
  sources = [
    "source.virtualbox-iso.vbox"
  ]
}
