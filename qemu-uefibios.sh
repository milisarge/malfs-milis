wget https://excellmedia.dl.sourceforge.net/project/toysbox/bios-efi_GrubRescue/OVMF.fd
qemu-system-x86_64 --enable-kvm -bios OVMF.fd -m 1024 $1
