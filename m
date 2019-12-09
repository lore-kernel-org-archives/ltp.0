From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon,  9 Dec 2019 10:36:59 +0100
Subject: [LTP] [PATCH] isofs: Convert to new library
Message-ID: <20191209093659.31996-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/kernel/fs/iso9660/isofs.sh | 193 ++++++++++-----------------
 1 file changed, 71 insertions(+), 122 deletions(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index 5f90354d9..43a079a14 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -1,21 +1,6 @@
 #!/bin/sh
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2003
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Written by Prakash Narayana (prakashn@us.ibm.com)
 # and Michael Reed (mreed10@us.ibm.com)
 #
@@ -24,40 +9,25 @@
 # mounts the ISO9660 file system with different mount options.
 #
 
-TCID=isofs
-TST_TOTAL=77
-. test.sh
+TST_NEEDS_CMDS="mkisofs"
+TST_NEEDS_TMPDIR=1
+TST_TESTFUNC=do_test
 
-NO_CLEANUP=""
+. tst_test.sh
 
-usage()
-{
-	echo "USAGE: $0 <optional> -n -h"
-	exit
-}
-
-cleanup()
-{
-	if [ "$NO_CLEANUP" = "no" ]; then
-		tst_resm TINFO "Temporary directory $PWD was not removed"
-	else
-		tst_rmdir
-	fi
-}
-
-max_depth=3
-max_dirs=4
+MAX_DEPTH=3
+MAX_DIRS=4
 
 gen_fs_tree()
 {
 	local cur_path="$1"
 	local cur_depth="$2"
 
-	if [ "$cur_depth" -gt "$max_depth" ]; then
+	if [ "$cur_depth" -gt "$MAX_DEPTH" ]; then
 		return
 	fi
 
-	for i in $(seq 1 $max_dirs); do
+	for i in $(seq 1 $MAX_DIRS); do
 		local new_path="$cur_path/subdir_$i"
 
 		mkdir -p "$new_path"
@@ -68,94 +38,73 @@ gen_fs_tree()
 	done
 }
 
-while getopts :hnd: arg; do
-	case $arg in
-	h)
-		echo ""
-		echo "n - The directories created will not be removed"
-		echo "h - Help options"
-		echo ""
-		usage
-		echo ""
-		;;
-	n)
-		NO_CLEANUP="no"
-		;;
-	esac
-done
-
-tst_require_root
-
-tst_tmpdir
-TST_CLEANUP=cleanup
-
-MNT_POINT="$PWD/mnt"
-MAKE_FILE_SYS_DIR="$PWD/files"
-
-mkdir -p -m 777 $MNT_POINT
-mkdir -p $MAKE_FILE_SYS_DIR
-
-# Generated directories and files
-mkdir -p $MAKE_FILE_SYS_DIR
-gen_fs_tree "$MAKE_FILE_SYS_DIR" 1
-
-# Make ISO9660 file system with different options.
-# Mount the ISO9660 file system with different mount options.
-
-tst_require_cmds mkisofs
-
-for mkisofs_opt in \
-	" " \
-	"-J" \
-	"-hfs -D" \
-	" -R " \
-	"-R -J" \
-	"-f -l -D -J -allow-leading-dots -R" \
-	"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
-do
-	rm -f isofs.iso
-	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR 2> /dev/null
-	if [ $? -eq 0 ]; then
-		tst_resm TPASS \
-			"mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR"
-	else
-		tst_resm TFAIL \
-			tst_resm TFAIL "mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR"
-		continue
-	fi
+do_test() {
+	local mnt_point="$PWD/mnt"
+	local make_file_sys_dir="$PWD/files"
+
+	mkdir -p -m 777 $mnt_point
+	mkdir -p $make_file_sys_dir
+
+	# Generated directories and files
+	mkdir -p $make_file_sys_dir
+	gen_fs_tree "$make_file_sys_dir" 1
+
+	# Make ISO9660 file system with different options.
+	# Mount the ISO9660 file system with different mount options.
 
-	for mount_opt in \
-		"loop" \
-		"loop,norock" \
-		"loop,nojoliet" \
-		"loop,block=512,unhide" \
-		"loop,block=1024,cruft" \
-		"loop,block=2048,nocompress" \
-		"loop,check=strict,map=off,gid=bin,uid=bin" \
-		"loop,check=strict,map=acorn,gid=bin,uid=bin" \
-		"loop,check=relaxed,map=normal" \
-		"loop,block=512,unhide,session=2"
-		# "loop,sbsector=32"
+	for mkisofs_opt in \
+		" " \
+		"-J" \
+		"-hfs -D" \
+		" -R " \
+		"-R -J" \
+		"-f -l -D -J -allow-leading-dots -R" \
+		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
 	do
-		mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT
-		if [ $? -ne 0 ]; then
+		rm -f isofs.iso
+		mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2> /dev/null
+		if [ $? -eq 0 ]; then
+			tst_res TPASS \
+				"mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir"
+		else
 			tst_resm TFAIL \
-				"mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT"
+				tst_res TFAIL "mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir"
 			continue
 		fi
 
-		ls -lR $MNT_POINT > /dev/null
-		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "ls -lR $MNT_POINT"
-		fi
-
-		umount $MNT_POINT
-		if [ $? -ne 0 ]; then
-			tst_brkm TFAIL "umount $MNT_POINT"
-		fi
-
-		tst_resm TPASS "mount/umount with \"$mount_opt\" options"
+		for mount_opt in \
+			"loop" \
+			"loop,norock" \
+			"loop,nojoliet" \
+			"loop,block=512,unhide" \
+			"loop,block=1024,cruft" \
+			"loop,block=2048,nocompress" \
+			"loop,check=strict,map=off,gid=bin,uid=bin" \
+			"loop,check=strict,map=acorn,gid=bin,uid=bin" \
+			"loop,check=relaxed,map=normal" \
+			"loop,block=512,unhide,session=2"
+			# "loop,sbsector=32"
+		do
+			mount -t iso9660 -o $mount_opt isofs.iso $mnt_point
+			if [ $? -ne 0 ]; then
+				tst_res TFAIL \
+					"mount -t iso9660 -o $mount_opt isofs.iso $mnt_point"
+				continue
+			fi
+
+			ls -lR $mnt_point > /dev/null
+			if [ $? -ne 0 ]; then
+				tst_res TFAIL "ls -lR $mnt_point"
+			fi
+
+			umount $mnt_point
+			if [ $? -ne 0 ]; then
+				tst_brk TFAIL "umount $mnt_point"
+			fi
+
+			tst_res TPASS "mount/umount with \"$mount_opt\" options"
+		done
 	done
-done
+}
 
-tst_exit
+tst_run
-- 
2.20.1

