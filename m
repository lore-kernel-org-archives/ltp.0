From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 28 Jan 2021 18:10:52 +0100
Subject: [LTP] [PATCH] quota_remount_test01: update to new API
Message-ID: <20210128171052.6025-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Update to new API
Add test on quota_v2 driver to avoid the above error:
  quotaon: Quota format not supported in kernel.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 .../fs/quota_remount/quota_remount_test01.sh  | 184 +++++++-----------
 1 file changed, 69 insertions(+), 115 deletions(-)

diff --git a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
index 04b7af922..adcbbe846 100755
--- a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
+++ b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
@@ -1,126 +1,80 @@
 #!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) Jan Kara <jack@suse.cz>, 2008                                ##
-## Copyright (c) International Business Machines  Corp., 2009                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
-#                                                                             ##
-# File :        quota_remount_test01.sh                                       ##
-#                                                                             ##
-# Description:  Test whether kernel properly supports remounting read-only    ##
-#               with quota. This feature was added in kernel 2.6.26. Please   ##
-#               see: http://kernelnewbies.org/Linux_2_6_26, and               ##
-#               http://git.kernel.org/git/?p=linux/kernel/git/torvalds/       ##
-#               linux-2.6.git;a=commit;                                       ##
-#               h=0ff5af8340aa6be44220d7237ef4a654314cf795                    ##
-#               for more info.                                                ##
-#                                                                             ##
-# Author:       Jan Kara <jack@suse.cz>,                                      ##
-#                                                                             ##
-# History:      Sep 18 2008 - Created - Jan Kara <jack@suse.cz>.              ##
-#               Feb 17 2009 - Ported to LTP,                                  ##
-#                             Subrata Modak <subrata@linux.vnet.ibm.com>      ##
-################################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Jan Kara <jack@suse.cz>, 2008
+# Copyright (c) International Business Machines  Corp., 2009
+# Copyright (c) K?ry Maincent <kory.maincent@bootlin.com> 2020
 
-export TCID=quota_remount_test01
-export TST_TOTAL=1
-export TST_COUNT=0
+TST_NEEDS_CMDS="quotacheck quotaon mkfs.ext3"
+TST_NEEDS_DRIVERS="quota_v2"
+TST_NEEDS_TMPDIR=1
+TST_SETUP=do_setup
+TST_CLEANUP=do_clean
+TST_TESTFUNC=do_test
 
-if [ -z $TMPDIR ]
-then
-	TMPDIR=/tmp
-fi
-MNTDIR=$TMPDIR/mnt
+. tst_test.sh
 
-if tst_kvcmp -lt "2.6.25"; then
-        tst_resm TCONF "Remounting with quotas enabled is not supported!"
-        tst_resm TCONF "You should have kernel 2.6.26 and above running....."
-        exit 32
-fi
-
-if [ ! -d /proc/sys/fs/quota ]; then
-        tst_resm TCONF "Quota not supported in kernel!"
-        exit 0
-fi
-
-if ! command -v quotacheck > /dev/null 2>&1; then
-	tst_resm TCONF "'quotacheck' not found"
-	exit 0
-fi
-
-if ! command -v quotaon > /dev/null 2>&1; then
-	tst_resm TCONF "'quotaon' not found"
-	exit 0
-fi
+do_setup()
+{
+	if tst_kvcmp -lt "2.6.25"; then
+	        tst_res TCONF "Remounting with quotas enabled is not supported!"
+	        tst_brk TCONF "You should have kernel 2.6.26 and above running....."
+	fi
+
+	if [ ! -d /proc/sys/fs/quota ]; then
+	        tst_brk TCONF "Quota not supported in kernel!"
+	        exit 0
+	fi
+	MNTDIR=$TMPDIR/mnt
+	IMAGE=ltp-$$-fs-image
+	dd if=/dev/zero of=$IMAGE bs=4096 count=8000 2>/dev/null
+	mkfs.ext3 -q -F -b 4096 $IMAGE
+	mkdir $MNTDIR
+}
 
-die()
+do_clean()
 {
-	echo >&2 $2
 	umount 2>/dev/null $MNTDIR
 	rm 2>/dev/null $IMAGE
-	rmdir 2>/dev/null $MNTDIR
-        tst_resm TFAIL "Quota on Remount Failed"
-	exit $1
 }
 
-cd $TMPDIR || die 2 "Cannot cd to $TMPDIR"
-IMAGE=ltp-$$-fs-image
-dd if=/dev/zero of=$IMAGE bs=4096 count=8000 2>/dev/null || die 2 "Cannot create filesystem image"
-mkfs.ext3 -q -F -b 4096 $IMAGE || die 2 "Could not create the filesystem"
-mkdir $MNTDIR || die 2 "Could not create the mountpoint"
-mount -t ext3 -o loop,usrquota,grpquota $IMAGE $MNTDIR || die 2 "Could not mount the filesystem"
-tst_resm TINFO "Successfully mounted the File System"
-
-# some distros (CentOS 6.x, for example) doesn't permit creating
-# of quota files in a directory with SELinux file_t type
-if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
-	chcon -t tmp_t $MNTDIR || die 2 "Could not change SELinux file type"
-	tst_resm TINFO "Successfully changed SELinux file type"
-fi
-
-quotacheck -cug $MNTDIR || die 2 "Could not create quota files"
-tst_resm TINFO "Successfully Created Quota Files"
-
-quotaon -ug $MNTDIR || die 2 "Could not turn quota on"
-tst_resm TINFO "Successfully Turned on Quota"
-
-echo "blah" >$MNTDIR/file || die 2 "Could not write to the filesystem"
-tst_resm TINFO "Successfully wrote to the filesystem"
-
-# Get current quota usage
-BLOCKS=`quota  -f $MNTDIR -v -w | tail -n 1 | sed -e 's/ *[^ ]* *\([0-9]*\) .*/\1/'`
-mount -o remount,ro $MNTDIR || die 1 "Could not remount read-only"
-tst_resm TINFO "Successfully Remounted Read-Only FS"
-
-mount -o remount,rw $MNTDIR || die 2 "Could not remount read-write"
-tst_resm TINFO "Successfully Remounted Read-Write FS"
-
-rm $MNTDIR/file
-# Get quota usage after removing the file
-NEWBLOCKS=`quota  -f $MNTDIR -v -w | tail -n 1 | sed -e 's/ *[^ ]* *\([0-9]*\) .*/\1/'`
-# Has quota usage changed properly?
-if [ $BLOCKS -eq $NEWBLOCKS ]; then
-  die 1 "Usage did not change after remount"
-fi
-tst_resm TINFO "Usage successfully Changed after Remount"
-tst_resm TPASS "Quota on Remount Successfull"
+do_test()
+{
+	EXPECT_PASS mount -t ext3 -o loop,usrquota,grpquota $IMAGE $MNTDIR
+	tst_res TINFO "Successfully mounted the File System"
+
+	# some distros (CentOS 6.x, for example) doesn't permit creating
+	# of quota files in a directory with SELinux file_t type
+	if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
+		chcon -t tmp_t $MNTDIR || tst_brk TFAIL "Could not change SELinux file type"
+		tst_res TINFO "Successfully changed SELinux file type"
+	fi
+
+	EXPECT_PASS quotacheck -cug $MNTDIR
+	tst_res TINFO "Successfully Created Quota Files"
+
+	EXPECT_PASS quotaon -ug $MNTDIR
+	tst_res TINFO "Successfully Turned on Quota"
+
+	EXPECT_PASS echo "blah" />$MNTDIR/file
+	tst_res TINFO "Successfully wrote to the filesystem"
+
+	# Get current quota usage
+	BLOCKS=`quota  -f $MNTDIR -v -w | tail -n 1 | sed -e 's/ *[^ ]* *\([0-9]*\) .*/\1/'`
+	EXPECT_PASS mount -o remount,ro $MNTDIR
+	tst_res TINFO "Successfully Remounted Read-Only FS"
+
+	EXPECT_PASS mount -o remount,rw $MNTDIR
+	tst_res TINFO "Successfully Remounted Read-Write FS"
+
+	rm $MNTDIR/file
+	# Get quota usage after removing the file
+	NEWBLOCKS=`quota  -f $MNTDIR -v -w | tail -n 1 | sed -e 's/ *[^ ]* *\([0-9]*\) .*/\1/'`
+	# Has quota usage changed properly?
+	if [ $BLOCKS -eq $NEWBLOCKS ]; then
+	   tst_brk TWARN "Usage did not change after remount"
+	fi
+	tst_res TINFO "Usage successfully Changed after Remount"
+	tst_res TPASS "Quota on Remount Successfull"
+}
 
-umount $MNTDIR || die 2 "Could not umount $MNTDIR"
-rmdir $MNTDIR ||  die 2 "Could not remove $MNTDIR"
-rm $IMAGE
-exit 0
+tst_run
-- 
2.17.1

