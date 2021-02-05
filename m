From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 5 Feb 2021 12:00:24 +0100
Subject: [LTP] [PATCH] quota_remount_test01: update to new API
In-Reply-To: <YBQdn3S9sPJT/wea@pevik>
References: <20210128171052.6025-1-kory.maincent@bootlin.com>
 <YBQdn3S9sPJT/wea@pevik>
Message-ID: <YB0lSFi5LVAo6TPb@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

FYI patch merged with additional cleanup.
Kory, thanks for your work!

Kind regards,
Petr

diff --git testcases/kernel/fs/quota_remount/quota_remount_test01.sh testcases/kernel/fs/quota_remount/quota_remount_test01.sh
index adcbbe846..a67e13903 100755
--- testcases/kernel/fs/quota_remount/quota_remount_test01.sh
+++ testcases/kernel/fs/quota_remount/quota_remount_test01.sh
@@ -2,79 +2,79 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) Jan Kara <jack@suse.cz>, 2008
 # Copyright (c) International Business Machines  Corp., 2009
-# Copyright (c) K?ry Maincent <kory.maincent@bootlin.com> 2020
+# Copyright (c) K?ry Maincent <kory.maincent@bootlin.com> 2021
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
 
-TST_NEEDS_CMDS="quotacheck quotaon mkfs.ext3"
+TST_NEEDS_CMDS="dd mkfs.ext3 mount quota quotacheck quotaon sed tail"
 TST_NEEDS_DRIVERS="quota_v2"
+TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_SETUP=do_setup
 TST_CLEANUP=do_clean
 TST_TESTFUNC=do_test
+TST_MIN_KVER="2.6.26"
 
 . tst_test.sh
 
 do_setup()
 {
-	if tst_kvcmp -lt "2.6.25"; then
-	        tst_res TCONF "Remounting with quotas enabled is not supported!"
-	        tst_brk TCONF "You should have kernel 2.6.26 and above running....."
-	fi
-
 	if [ ! -d /proc/sys/fs/quota ]; then
-	        tst_brk TCONF "Quota not supported in kernel!"
-	        exit 0
+		tst_brk TCONF "quota not supported in kernel"
 	fi
-	MNTDIR=$TMPDIR/mnt
-	IMAGE=ltp-$$-fs-image
-	dd if=/dev/zero of=$IMAGE bs=4096 count=8000 2>/dev/null
-	mkfs.ext3 -q -F -b 4096 $IMAGE
+
+	MNTDIR="mnt.$$"
+	IMAGE="ltp-$$-fs-image"
+	ROD dd if=/dev/zero of=$IMAGE bs=4096 count=8000 2>/dev/null
+	ROD mkfs.ext3 -q -F -b 4096 $IMAGE
 	mkdir $MNTDIR
 }
 
 do_clean()
 {
-	umount 2>/dev/null $MNTDIR
-	rm 2>/dev/null $IMAGE
+	[ "$mounted" ] || return
+	tst_umount $MNTDIR
+	mounted=
+}
+
+get_blocks()
+{
+	quota -f $MNTDIR -v -w | tail -n 1 | sed -e 's/ *[^ ]* *\([0-9]*\) .*/\1/'
 }
 
 do_test()
 {
-	EXPECT_PASS mount -t ext3 -o loop,usrquota,grpquota $IMAGE $MNTDIR
-	tst_res TINFO "Successfully mounted the File System"
+	tst_res TINFO "testing quota on remount"
+
+	local blocks newblocks
+
+	ROD mount -t ext3 -o loop,usrquota,grpquota $IMAGE $MNTDIR
+	mounted=1
 
 	# some distros (CentOS 6.x, for example) doesn't permit creating
 	# of quota files in a directory with SELinux file_t type
-	if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
-		chcon -t tmp_t $MNTDIR || tst_brk TFAIL "Could not change SELinux file type"
-		tst_res TINFO "Successfully changed SELinux file type"
+	if tst_selinux_enabled &&
+		tst_cmd_available chcon && ! chcon -t tmp_t $MNTDIR; then
+			tst_brk TCONF "could not change SELinux file type"
 	fi
 
-	EXPECT_PASS quotacheck -cug $MNTDIR
-	tst_res TINFO "Successfully Created Quota Files"
+	ROD quotacheck -cug $MNTDIR
+	ROD quotaon -ug $MNTDIR
+	ROD echo "blah" />$MNTDIR/file
 
-	EXPECT_PASS quotaon -ug $MNTDIR
-	tst_res TINFO "Successfully Turned on Quota"
+	blocks=$(get_blocks)
+	ROD mount -o remount,ro $MNTDIR
+	ROD mount -o remount,rw $MNTDIR
 
-	EXPECT_PASS echo "blah" />$MNTDIR/file
-	tst_res TINFO "Successfully wrote to the filesystem"
+	ROD rm $MNTDIR/file
+	newblocks=$(get_blocks)
 
-	# Get current quota usage
-	BLOCKS=`quota  -f $MNTDIR -v -w | tail -n 1 | sed -e 's/ *[^ ]* *\([0-9]*\) .*/\1/'`
-	EXPECT_PASS mount -o remount,ro $MNTDIR
-	tst_res TINFO "Successfully Remounted Read-Only FS"
+	if [ $blocks -eq $newblocks ]; then
+	   tst_brk TFAIL "usage did not change after remount"
+	fi
 
-	EXPECT_PASS mount -o remount,rw $MNTDIR
-	tst_res TINFO "Successfully Remounted Read-Write FS"
+	tst_res TPASS "quota on remount passed"
 
-	rm $MNTDIR/file
-	# Get quota usage after removing the file
-	NEWBLOCKS=`quota  -f $MNTDIR -v -w | tail -n 1 | sed -e 's/ *[^ ]* *\([0-9]*\) .*/\1/'`
-	# Has quota usage changed properly?
-	if [ $BLOCKS -eq $NEWBLOCKS ]; then
-	   tst_brk TWARN "Usage did not change after remount"
-	fi
-	tst_res TINFO "Usage successfully Changed after Remount"
-	tst_res TPASS "Quota on Remount Successfull"
+	do_clean
 }
 
 tst_run
