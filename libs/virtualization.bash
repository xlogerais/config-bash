#!/bin/bash

hypervisor_connect() {

  if [ -e "${1}" ]; then echo "Usage : $0 hypervisor_name_or_ip"; return 1; fi
  hypervisor=${1}

  echo
  echo "Trying to start interactive virsh session on ${hypervisor}"
  term_change_title "virsh session for ${USER} on ${hypervisor}"
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system

}

hypervisor_command() {

  if [ -e "${1}" ]; then echo "Usage : $0 hypervisor_name_or_ip"; return 1; fi
  hypervisor=${1}
  shift

  echo
  echo "Trying to exec virsh command ($*) on ${hypervisor}"
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system "$*"

}

vm_create() {

  if [ $# -ne 5 ]; then echo "Usage : $0 hypervisor_name_or_ip vm_name vm_ram_size vm_disk_size vm_mac"; return 1; fi
  hypervisor=${1}
  name=${2}
  ramsize=${3}
  disksize=${4}
  mac=${5}
  #mac=$( grep ${name} ~/repositories/fai/config-dhcp/dhcpd-hosts.conf | sed -e 's/^.*hardware.*ethernet\s*\([0-9a-zA-Z:]*\);.*$/\1/' )

  echo "Creating VM with virt-install"
  virt-install --connect=qemu+ssh://${USER}@${hypervisor}/system \
		           --name=${name}                                    \
			   --description="${name}"                           \
			   --cpu=host                                        \
			   --ram=${ramsize}                                  \
			   --disk=/dev/lvm_guests_system/${name},size=${disksize},bus=virtio,cache=writethrough,io=native \
			   --network=bridge=br192,mac=${mac},model=virtio      \
			   --os-type=linux                                   \
			   --os-variant=debiansqueeze                        \
			   --boot=network,hd,menu=on                         \
			   --pxe                                             \
			   --graphics=vnc \
			   --noautoconsole

  echo "Done"

}

vm_start() {

  if [ $# -ne 2 ]; then echo "Usage : $0 hypervisor_name_or_ip vm_name"; return 1; fi
  hypervisor=${1}
  name=${2}

  echo
  echo "Trying to start ${name} on ${hypervisor} with virsh"
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system start ${name}

}

vm_stop() {

  if [ $# -ne 2 ]; then echo "Usage : $0 hypervisor_name_or_ip vm_name"; return 1; fi
  hypervisor=${1}
  name=${2}

  echo
  echo "Trying to stop ${name} on ${hypervisor} with virsh"
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system shutdown ${name}

}

vm_destroy() {

  if [ $# -ne 2 ]; then echo "Usage : $0 hypervisor_name_or_ip vm_name"; return 1; fi
  hypervisor=${1}
  name=${2}

  echo
  echo "Trying to destroy ${name} on ${hypervisor} with virsh"
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system destroy ${name}

}

vm_connect() {

  if [ $# -ne 2 ]; then echo "Usage : $0 hypervisor_name_or_ip vm_name"; return 1; fi
  hypervisor=${1}
  name=${2}

  echo
  echo "Trying to connect to ${name} on ${hypervisor} with virsh"
  term_change_title "virsh session for ${USER} on ${hypervisor} : ${name} console"
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system ttyconsole ${name}
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system console ${name}

}

#### A tester
vm_change_bridge() {

  if [ $# -ne 4 ]; then echo "Usage : $0 hypervisor_name_or_ip vm_name vm_mac vm_new_bridge"; return 1; fi
  hypervisor=${1}
  name=${2}
  mac=${3}
  bridge=${4}

  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system domiflist ${name}
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system detach-interface --config --domain ${name} --type bridge --mac ${mac}
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system attach-interface --config --domain ${name} --type bridge --mac ${mac} --source ${bridge}
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system domiflist ${name}

}

vm_add_data_disk() {

  if [ $# -ne 2 ]; then echo "Usage : $0 hypervisor_name_or_ip vm_name size"; return 1; fi
  hypervisor=${1}
  name=${2}
  size=${3}

  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system  pool-list
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system  vol-create-as --pool guests_data --name ${name} --capacity ${size} --format raw
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system  attach-disk ${name} /dev/lvm_guests_data/${name} vdb --cache writethrough
  virsh --connect=qemu+ssh://${USER}@${hypervisor}/system  domblklist ${name}

}

vm_create_magick() {

  if [ $# -ne 4 ]; then echo "Usage : $0 hypervisor_name_or_ip vm_name vm_ram_size vm_disk_size"; return 1; fi
  hypervisor=${1}
  name=${2}
  ramsize=${3}
  disksize=${4}
  IFS='.' read -a array <<< "$(ssh admin dig +search +short ${name})"
  ip=$(printf "%3d.%3d.%3d.%3d\n" ${array[0]} ${array[1]} ${array[2]} ${array[3]})
  mac=$(printf "52:54:00:%02X:%02X:%02X\n" ${array[1]} ${array[2]} ${array[3]})


  echo "Creating VM with virt-install"
  echo "  * mac = ${mac}"
  echo "  * ip = ${ip}"
  virt-install --connect=qemu+ssh://${USER}@${hypervisor}/system \
		           --name=${name}                                    \
			   --description="${name}"                           \
			   --cpu=host                                        \
			   --ram=${ramsize}                                  \
			   --disk=/dev/lvm_guests_system/${name},size=${disksize},bus=virtio,cache=writethrough,io=native \
			   --network=bridge=br192,mac=${mac},model=virtio    \
			   --os-type=linux                                   \
			   --os-variant=debianwheezy                         \
			   --boot=network,hd,menu=on                         \
			   --pxe                                             \
			   --graphics=vnc \
			   --noautoconsole

  echo "Done"

}

#### bash completion

_hypervisors() {
	if [ -e ~/.ssh/config ]; then
		configured_hypervisors=$(cat ~/.ssh/config | egrep  -i "^\s*host\s+[a-zA-Z]" | sed -e "s/^host\s*//i" | grep -i hypervisor)
	fi
	if [ -e ~/.ssh/known_hosts ]; then
		known_hypervisors=$(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e 's/,.*//g' | grep -v "\[" | grep -i hypervisor | uniq)
	fi
	echo $configured_hypervisors $known_hypervisors
}

#complete -W "$(cat ~/.ssh/config | egrep  -i "^\s*host\s+[a-zA-Z]" | sed -e "s/^host\s*//i" | grep -i hypervisor)" hypervisor_connect
complete -W "$(_hypervisors)" hypervisor_connect
complete -W "$(_hypervisors)" hypervisor_command
complete -W "$(_hypervisors)" vm_create
complete -W "$(_hypervisors)" vm_start
complete -W "$(_hypervisors)" vm_stop
complete -W "$(_hypervisors)" vm_connect
complete -W "$(_hypervisors)" vm_change_bridge
complete -W "$(_hypervisors)" vm_add_data_disk
complete -W "$(_hypervisors)" vm_create_magick
