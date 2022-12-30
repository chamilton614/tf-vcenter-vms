#cloud-config
# After a manual ubuntu server install the autoinstall user-data file can be found at /var/log/installer/autoinstall-user-data
autoinstall:
  version: 1
  
  early-commands:
    - systemctl stop ssh # otherwise packer tries to connect and exceed max attempts
    #- hostnamectl set-hostname ubuntu # update hostname even for the installer environment
    #- dhclient # re-register the updated hostname
  
  #apt:
  #  disable_components: []
  #  geoip: true
  #  preserve_sources_list: false
  #  primary:
  #  - arches:
  #    - amd64
  #    - i386
  #    uri: http://us.archive.ubuntu.com/ubuntu
  #  - arches:
  #    - default
  #    uri: http://ports.ubuntu.com/ubuntu-ports
  #drivers:
  #  install: false

  locale: en_US.UTF-8

  #kernel:
  #  package: linux-generic

  keyboard:
    layout: us
    variant: ''

  #network:
  #  ethernets:
  #    ens160:
  #      dhcp4: true
  #  version: 2
  
  ssh:
    install-server: true
    allow-pw: yes
    authorized-keys:
      - ${ssh_public_key}
  
  identity:
    hostname: ubuntu
    username: ubuntu
    password: $6$iIGXbSTjejANoagR$kMbEyNj8qN/qrg9Y5VzUI8w/SylGhVXdLfrQHzuwpjPRc6c09bKEM7QBhZ13LHsfbA4E.WVJlxLilCyAWP6F01 # P@ssw0rd
  
  storage:
    layout:
        name: lvm
  
  packages: 
    - open-vm-tools
    - openssh-server
    - net-tools
    - perl
    - open-iscsi
    - ntp
    - git
    - chrony
    - curl
    - vim
    - ifupdown
    - zip
    - unzip
    - gnupg2
    - software-properties-common
    - apt-transport-https
    - ca-certificates
    - lsb-release
    - python3-pip
    - jq
    - cloud-init

  user-data:
      disable_root: false
  
  #updates: security

  late-commands:
      - echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/ubuntu
  #   - sed -ie 's/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /target/etc/default/grub
  #   - curtin in-target --target=/target -- update-grub2
      - curtin in-target --target=/target -- chmod 440 /etc/sudoers.d/ubuntu