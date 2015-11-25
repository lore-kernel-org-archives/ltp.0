From: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Date: Wed, 25 Nov 2015 09:34:12 +0800
Subject: [LTP] [PATCH v3 2/2] fix the redirection order
In-Reply-To: <1448415252-11221-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1448346118-24387-2-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1448415252-11221-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Message-ID: <1448415252-11221-2-git-send-email-weijg.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The 2>&1 has to be after >/dev/null.
PS, this patch fix the problem is as same as b85bb78.

Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/fs/acl/tacl_xattr.sh             |  2 +-
 testcases/kernel/fs/fs-bench/modaltr.sh           |  2 +-
 testcases/kernel/power_management/runpwtests03.sh |  4 +-
 testscripts/autofs1.sh                            | 10 ++---
 testscripts/autofs4.sh                            | 46 +++++++++++------------
 testscripts/exportfs.sh                           | 20 +++++-----
 6 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/testcases/kernel/fs/acl/tacl_xattr.sh b/testcases/kernel/fs/acl/tacl_xattr.sh
index 99f6a95..b42b665 100755
--- a/testcases/kernel/fs/acl/tacl_xattr.sh
+++ b/testcases/kernel/fs/acl/tacl_xattr.sh
@@ -80,7 +80,7 @@ fi
 dd if=/dev/zero of=tacl/blkext2 bs=1k count=10240
 chmod 777 tacl/blkext2
 
-losetup /dev/loop0 tacl/blkext2 2>&1 > /dev/null
+losetup /dev/loop0 tacl/blkext2 >/dev/null 2>&1
 if [ $? != 0 ]
 then
 	echo ""
diff --git a/testcases/kernel/fs/fs-bench/modaltr.sh b/testcases/kernel/fs/fs-bench/modaltr.sh
index 74bf59e..c4ea745 100755
--- a/testcases/kernel/fs/fs-bench/modaltr.sh
+++ b/testcases/kernel/fs/fs-bench/modaltr.sh
@@ -89,7 +89,7 @@ modprobe $LOOP
 	echo "check wheather loopback device option is been compiled in the kernel"
 fi
 mkdir -p $BLOCK_DIR
-mknod $BLOCK_DIR/0 b 31 0 2>&1 > /dev/null
+mknod $BLOCK_DIR/0 b 31 0 >/dev/null 2>&1
 mount -t jffs2 $BLOCK_DIR/0 $MOUNT_DIR
 mount|grep $JFFS2
 	if [ $? -eq 0 ]; then
diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
index 7e9ac4b..d4ea88b 100755
--- a/testcases/kernel/power_management/runpwtests03.sh
+++ b/testcases/kernel/power_management/runpwtests03.sh
@@ -35,7 +35,7 @@ check_cpufreq_sysfs_files() {
 			-name "*" -type f)
 		for files in ${cpufiles}
 		do
-			cat ${files} 2>&1 >/dev/null
+			cat ${files} >/dev/null 2>&1
 			if [ $? -ne 0 ] ; then
 				echo "${0}: FAIL: cat ${files}"
 				RC=1
@@ -83,7 +83,7 @@ change_freq() {
 	(( total_cpus-=1 ))
 
 	if ( echo ${available_govr} | grep -i "userspace" \
-		2>&1 >/dev/null ); then
+		>/dev/null 2>&1 ); then
 		for cpu in $(seq 0 "${total_cpus}" )
 		do
 			echo userspace > \
diff --git a/testscripts/autofs1.sh b/testscripts/autofs1.sh
index 678b56f..324c4db 100755
--- a/testscripts/autofs1.sh
+++ b/testscripts/autofs1.sh
@@ -199,16 +199,16 @@ fi
 
 echo "forcing error paths and conditions..."
 
-mkdir /AUTOFS/MEDIA/mydir 2>&1 > /dev/null
-rm -rf /AUTOFS 2>&1 > /dev/null
+mkdir /AUTOFS/MEDIA/mydir >/dev/null 2>&1
+rm -rf /AUTOFS >/dev/null 2>&1
 
 mkdir /AUTOFS/MEDIA/floppy/test
 cp /etc/auto.master /etc/auto.media /AUTOFS/MEDIA/floppy/test
 sync; sync
 echo "Resuming test, please wait..."
 sleep 60
-mkdir /AUTOFS/MEDIA/mydir 2>&1 > /dev/null
-rm -rf /AUTOFS            2>&1 > /dev/null
+mkdir /AUTOFS/MEDIA/mydir >/dev/null 2>&1
+rm -rf /AUTOFS >/dev/null 2>&1
 
 
 ##############################################################
@@ -234,7 +234,7 @@ sleep 60
 
 if [ -e  /AUTOFS/DISK/disk/test ]; then
   cd /AUTOFS/DISK/disk/test
-  umount /AUTOFS/DISK/disk/ 2>&1 > /dev/null
+  umount /AUTOFS/DISK/disk/ >/dev/null 2>&1
   if [ $? = 0 ]
     then
 	/etc/init.d/autofs stop
diff --git a/testscripts/autofs4.sh b/testscripts/autofs4.sh
index 68589b5..00119a6 100755
--- a/testscripts/autofs4.sh
+++ b/testscripts/autofs4.sh
@@ -68,17 +68,17 @@ else
 		echo "FAILED: Usage $0 <block special disk_partition>"
 		exit 1
 	fi
-	mkfs -t ext2 $disk_partition 2>&1 > /dev/null
+	mkfs -t ext2 $disk_partition >/dev/null 2>&1
 fi
 
-rpm -q -a | grep autofs 2>&1 > /dev/null
+rpm -q -a | grep autofs >/dev/null 2>&1
 if [ $? != 0 ]
 then
 	echo "FAILED: autofs package is not installed"
 	exit 1
 fi
 
-grep autofs /proc/filesystems 2>&1 > /dev/null
+grep autofs /proc/filesystems >/dev/null 2>&1
 if [ $? != 0 ]
 then
 	echo "FAILED: autofs module is not built into the kernel or loaded"
@@ -100,7 +100,7 @@ floppy_dev=`grep floppy /etc/fstab | awk '{print $1}'`
 
 if [ $floppy_dev != "" ]
 then
-	/sbin/mkfs -t ext2 $floppy_dev 2>&1 > /dev/null
+	/sbin/mkfs -t ext2 $floppy_dev >/dev/null 2>&1
 	if [ $? != 0 ]
 	then
 		echo "FAILED: mkfs -t ext2 $floppy_dev failed"
@@ -126,7 +126,7 @@ echo "floppy	-fstype=ext2					:$floppy_dev" > /etc/auto.media
 #
 ##############################################################
 
-/etc/init.d/autofs start 2>&1 > /dev/null
+/etc/init.d/autofs start >/dev/null 2>&1
 if [ $? != 0 ]
 then
 	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
@@ -136,21 +136,21 @@ fi
 echo "Resuming test, please wait..."
 sleep 15
 
-/etc/init.d/autofs stop 2>&1 > /dev/null
+/etc/init.d/autofs stop >/dev/null 2>&1
 if [ $? != 0 ]
 then
 	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
 	echo "FAILED: "/etc/init.d/autofs stop""
 	exit 1
 else
-	/etc/init.d/autofs start 2>&1 > /dev/null
+	/etc/init.d/autofs start >/dev/null 2>&1
 fi
 sleep 15
 
-/etc/init.d/autofs restart 2>&1 > /dev/null
+/etc/init.d/autofs restart >/dev/null 2>&1
 if [ $? != 0 ]
 then
-	/etc/init.d/autofs stop 2>&1 > /dev/null
+	/etc/init.d/autofs stop >/dev/null 2>&1
 	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
 	echo "FAILED: "/etc/init.d/autofs restart""
 	exit 1
@@ -158,19 +158,19 @@ fi
 echo "Resuming test, please wait..."
 sleep 15
 
-/etc/init.d/autofs status 2>&1 > /dev/null
+/etc/init.d/autofs status >/dev/null 2>&1
 if [ $? != 0 ]
 then
-	/etc/init.d/autofs stop 2>&1 > /dev/null
+	/etc/init.d/autofs stop >/dev/null 2>&1
 	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
 	echo "FAILED: "/etc/init.d/autofs status""
 	exit 1
 fi
 
-/etc/init.d/autofs reload 2>&1 > /dev/null
+/etc/init.d/autofs reload >/dev/null 2>&1
 if [ $? != 0 ]
 then
-	/etc/init.d/autofs stop 2>&1 > /dev/null
+	/etc/init.d/autofs stop >/dev/null 2>&1
 	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
 	echo "FAILED: "/etc/init.d/autofs reload""
 	exit 1
@@ -188,16 +188,16 @@ fi
 #
 ##############################################################
 
-mkdir /AUTOFS/MEDIA/mydir 2>&1 > /dev/null
-rm -rf /AUTOFS 2>&1 > /dev/null
+mkdir /AUTOFS/MEDIA/mydir >/dev/null 2>&1
+rm -rf /AUTOFS >/dev/null 2>&1
 
 mkdir /AUTOFS/MEDIA/floppy/test
 cp /etc/auto.master /etc/auto.media /AUTOFS/MEDIA/floppy/test
 sync; sync
 echo "Resuming test, please wait..."
 sleep 60
-mkdir /AUTOFS/MEDIA/mydir 2>&1 > /dev/null
-rm -rf /AUTOFS 2>&1 > /dev/null
+mkdir /AUTOFS/MEDIA/mydir >/dev/null 2>&1
+rm -rf /AUTOFS >/dev/null 2>&1
 
 
 ##############################################################
@@ -208,7 +208,7 @@ rm -rf /AUTOFS 2>&1 > /dev/null
 
 echo "/AUTOFS/DISK	/etc/auto.disk		" >> /etc/auto.master
 echo "disk		-fstype=ext2					:$disk_partition " > /etc/auto.disk
-/etc/init.d/autofs reload 2>&1 > /dev/null
+/etc/init.d/autofs reload >/dev/null 2>&1
 echo "Resuming test, please wait..."
 sleep 30
 
@@ -219,20 +219,20 @@ echo "Resuming test, please wait..."
 sleep 60
 
 cd /AUTOFS/DISK/disk/test
-umount /AUTOFS/DISK/disk/ 2>&1 > /dev/null
+umount /AUTOFS/DISK/disk/ >/dev/null 2>&1
 if [ $? = 0 ]
 then
-	/etc/init.d/autofs stop 2>&1 > /dev/null
+	/etc/init.d/autofs stop >/dev/null 2>&1
 	rm -rf /etc/auto.master /etc/auto.media /etc/auto.disk /AUTOFS
 	echo "FAILED: unmounted a busy file system!"
 	exit 1
 fi
 cd
 
-umount /AUTOFS/DISK/disk/ 2>&1 > /dev/null
+umount /AUTOFS/DISK/disk/ >/dev/null 2>&1
 if [ $? != 0 ]
 then
-	/etc/init.d/autofs stop 2>&1 > /dev/null
+	/etc/init.d/autofs stop >/dev/null 2>&1
 	rm -rf /etc/auto.master /etc/auto.media /etc/auto.disk /AUTOFS
 	echo "FAILED: Could not unmount automounted file system"
 	exit 1
@@ -253,7 +253,7 @@ umount /mnt
 #
 #######################################################
 
-/etc/init.d/autofs stop 2>&1 > /dev/null
+/etc/init.d/autofs stop >/dev/null 2>&1
 rm -rf /etc/auto.master /etc/auto.media /etc/auto.disk /AUTOFS
 echo "PASSED: $0 passed!"
 exit 0
diff --git a/testscripts/exportfs.sh b/testscripts/exportfs.sh
index f5d5294..8afe017 100755
--- a/testscripts/exportfs.sh
+++ b/testscripts/exportfs.sh
@@ -98,27 +98,27 @@ fi
 # Add code here.
 
 
-ping -c 2 -w 15 $NFS_SERVER 2>&1 >/dev/null
+ping -c 2 -w 15 $NFS_SERVER >/dev/null 2>&1
 if [ $? != 0 ]
 then
 	echo "FAILED: ping $NFS_SERVER failed"
 	exit 1
 fi
 
-rsh -n -l root $NFS_SERVER "ls -l /etc" 2>&1 >/dev/null
+rsh -n -l root $NFS_SERVER "ls -l /etc" >/dev/null 2>&1
 if [ $? != 0 ]
 then
 	echo "FAILED: rsh -n -l root $NFS_SERVER "ls -l /etc" failed"
 	exit 1
 fi
 
-rsh -n -l root $NFS_SERVER "rpm -q -a | grep $FS_TYPE" | grep $FS_TYPE 2>&1 > /dev/null
+rsh -n -l root $NFS_SERVER "rpm -q -a | grep $FS_TYPE" | grep $FS_TYPE >/dev/null 2>&1
 if [ $? != 0 ]
 then
-	rsh -n -l root $NFS_SERVER "grep $FS_TYPE /etc/filesystems" | grep $FS_TYPE 2>&1 > /dev/null
+	rsh -n -l root $NFS_SERVER "grep $FS_TYPE /etc/filesystems" | grep $FS_TYPE >/dev/null 2>&1
 	if [ $? != 0 ]
 	then
-		rsh -n -l root $NFS_SERVER "grep $FS_TYPE /proc/filesystems" | grep $FS_TYPE 2>&1 > /dev/null
+		rsh -n -l root $NFS_SERVER "grep $FS_TYPE /proc/filesystems" | grep $FS_TYPE >/dev/null 2>&1
 		if [ $? != 0 ]
 		then
 			echo "FAILED: $FS_TYPE package is not installed or loaded on $NFS_SERVER"
@@ -129,17 +129,17 @@ fi
 
 if [ "$FS_TYPE" = "reiserfs" ]
 then
-#	rsh -n -l root $NFS_SERVER "/sbin/mkfs -t $FS_TYPE --format 3.6 -f $REM_DISK_PART 2>&1 > /dev/null"
-	rsh -n -l root $NFS_SERVER "/sbin/mkfs -t $FS_TYPE -f $REM_DISK_PART --format 3.6 2>&1 > /dev/null"
-	echo "/sbin/mkfs -t $FS_TYPE --format 3.6 -f $REM_DISK_PART 2>&1 > /dev/null"
+#	rsh -n -l root $NFS_SERVER "/sbin/mkfs -t $FS_TYPE --format 3.6 -f $REM_DISK_PART >/dev/null 2>&1"
+	rsh -n -l root $NFS_SERVER "/sbin/mkfs -t $FS_TYPE -f $REM_DISK_PART --format 3.6 >/dev/null 2>&1"
+	echo "/sbin/mkfs -t $FS_TYPE --format 3.6 -f $REM_DISK_PART >/dev/null 2>&1"
 else
-#	rsh -n -l root $NFS_SERVER "/sbin/mkfs -t $FS_TYPE $REM_DISK_PART 2>&1 > /dev/null"
+#	rsh -n -l root $NFS_SERVER "/sbin/mkfs -t $FS_TYPE $REM_DISK_PART >/dev/null 2>&1"
 	QUIETFLAG=
 	if [ "$FS_TYPE" = "jfs" ]
 	then
 		QUIETFLAG="-q"
 	fi
-	rsh -n -l root $NFS_SERVER "/sbin/mkfs -t $FS_TYPE $QUIETFLAG $REM_DISK_PART 2>&1 > /dev/null"
+	rsh -n -l root $NFS_SERVER "/sbin/mkfs -t $FS_TYPE $QUIETFLAG $REM_DISK_PART >/dev/null 2>&1"
 	if [ $? != 0 ]
 	then
 		echo "FAILED: Could not /sbin/mkfs -t $FS_TYPE $REM_DISK_PART on $NFS_SERVER"
-- 
1.9.3



