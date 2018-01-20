README

The script is used to install  a VM on a server.
Initially, the script will check if the packages: libvirt, qemu-kvm, bridge-utils, virtinst, virt-manager, virt-viewer are installed. If not it will install the packages.

Then it gets the following values from the user:
1. VM Name
2. RAM: The code will check if the value entered by the user is 0 or less than 0. If not, it will repeatedly prompt the user for a positive value
3. Storage: The code will check if the value entered by the user is 0 or less than 0. If not, it will repeatedly prompt the user for a positive value
4. Image location: the absolute path of the image file needs to entered
Number of interfaces: Number of network interfaces that the user wants to add to the Vm while creating
5. A loop will run prompting the user for the network name, 'netnum' times

All the values are inserted in the virt-install command which installs the VM at the end

