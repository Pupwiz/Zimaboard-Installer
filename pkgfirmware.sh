## debian needs these tools 
DIR="$(pwd -P)"
apt install pax libarchive-tools
cd $DIR/images
mkdir iso
##unpack current iso for mods to initrd
bsdtar -C iso/ -xf debian-11-amd64-DVD-1.iso
cd iso/install.amd
#wget -N -O initrd_orig.gz http://ftp.debian.org/debian/dists/Debian11.5/main/installer-amd64/current/images/netboot/debian-installer/amd64/initrd.gz
#wget http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/unstable/current/firmware.cpio.gz
#cat firmware.cpio.gz initrd_orig.gz > initrd.gz
## steps below to add firmware to bootable iso commented out section 
## unpack pick one's you want repack and add to initrd. The current uncommented installs all current.
## Uning one already modified in the package
#mkdir firmware
#wget -cq http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/unstable/current/firmware.tar.gz
#tar -C firmware -zxf firmware.tar.gz
#pax -x sv4cpio -s'%firmware%/firmware%' -w firmware | gzip -c >firmware.cpio.gz
[ -f initrd.gz.orig ] || cp -p initrd.gz initrd.gz.orig
## remove next step if setting up your own requirements
##[ -f firmware.cpio.gz ] || http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/unstable/current/firmware.tar.gz
## we are using custom firware package already downloaded and modified 
cat initrd.gz.orig $DIR/firmware.cpio.gz > initrd.gz
## uncomment if using custom firware packs 
#rm firmware -r
#rm firmware.tar.gz
#rm firmware.cpio.gz 
## remove backup initrd
rm initrd.gz.orig
### redo md5sum 
md5sum `find ! -name "md5sum.txt" ! -path "./isolinux/*" -follow -type f` > md5sum.txt; cd ..
chmod -R -w iso
## use orginal DVD boot info to make new iso UEFI an legacy boot
dd if=debian-11-amd64-DVD-1.iso bs=1 count=432 of=isohdpfx.bin
## Rebuild the iso with old iso info for booting 
xorriso -as mkisofs -o mediabox-11.2-amd64.iso \
-isohybrid-mbr isohdpfx.bin \
-c isolinux/boot.cat -b isolinux/isolinux.bin \
-no-emul-boot -boot-load-size 4 -boot-info-table ./iso
## cleanup 
rm ./iso -r
rm isohdpfx.bin

