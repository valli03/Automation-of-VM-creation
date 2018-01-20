#!/bin/bash

#Installing required packages

#checking if libvirt is already installed
if [ $(dpkg-query -W -f='${Status}' libvirt-bin 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install libvirt-bin;
  echo "libvirt-bin installed"
  sudo adduser $USER libvirtd
fi

#checking if qemu-kvm packages exists
if [ $(dpkg-query -W -f='${Status}' qemu-kvm 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install qemu-kvm;
  echo "qemu-kvm installed"
fi

#Installing bridge-utils
if [ $(dpkg-query -W -f='${Status}' bridge-utils 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install bridge-utils;
  echo "bridge utilities installed"
fi

# Installing virtinst
if [ $(dpkg-query -W -f='${Status}' virtinst 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install virtinst;
  echo "virtinst installed"
fi

# check for virt-manager
if [ $(dpkg-query -W -f='${Status}' virt-manager 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install virt-manager;
  echo "virt-manager installed"
fi

# Install virt-viewer
if [ $(dpkg-query -W -f='${Status}' virt-viewer 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install virt-viewer;
  echo "virt-manager installed"
fi

echo "Enter VM Name:"
read name
 
# Getting RAM value
while true; do
 echo "RAM:"
 read RAM

 if [ $RAM -le 0 ]; then
  echo "RAM cannot be less than or equal to 0. Please enter a positive number"
  continue
 else
  break 
 fi
done
 
# Getting storage value
while true; do
 echo "storage:"
 read size

 if [ $size -le 0 ]; then
  echo "size cannot be less than or equal to 0. Please enter a positive number"
  continue
 else
  break
 fi
done
 
echo "image location:"
read loc
 
echo "number of interfaces: "
read netnum

string=""
for (( i=0;i<$netnum;i++ )) 
do
 echo "network name:"
 read net
 string="$string --network network=${net}"
done

sudo virt-install --name ${name} --ram ${RAM} --disk path=/var/lib/libvirt/images/${name}.img,bus=virtio,size=${size} -c ${loc} ${string},model=virtio --noautoconsole -v
echo "VM ${name} Created"

virsh list --all
