From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Jun 2019 14:52:33 +0200
Subject: [LTP] [PATCH v3] sysctl/sysctl02: Add new regression test for
 overflow file-max
In-Reply-To: <1560156706-13617-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190606114134.GB13068@rei.lan>
 <1560156706-13617-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190620125233.GC31382@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> On upstream kernel, before commit[1], the max value in proc_get_long based on
> the number of chars(21). It rejects values such as 184467440737095516160 (21 chars)
> but accepts values such as 18446744073709551616 (20 chars). But we should reject all
> because both are overflows. After this commit,the permitted max value is 2^64-1.

> Before commit[2], when writing echo 18446744073709551616 > /proc/sys/fs/file-max
> /proc/sys/fs/file-max will overflow and be set to 0.  It may crash the system. This
> commit sets the max and min value for file-max. After this commit,the permitted max
> value is 2^63-1.

> Unfortunately, commit[2] introduced the minimum value points at the global 'zero'
> variable which is an int. This results in a KASAN splat when accessed as a long by
> proc_doulongvec_minmax on 64-bit architectures. This bug has been fixed by commit[3].

> I will set 2^64 ,2^64-1,2^63 and 0 to file-max in case and test it.

> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f2923c4f73f21cfd714d12a2d48de8c21f11cfe
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=32a5ad9c22852e6bd9e74bdec5934ef9d1480bc5
> [3]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9002b21465fa4d829edfc94a5a441005cffaa972


Merged with adjusted commit message and following diff.
Due que big changes I put my copyright there as well.

Thanks for your patch!

Kind regards,
Petr

diff --git testcases/commands/sysctl/sysctl02.sh testcases/commands/sysctl/sysctl02.sh
index 22dd0a429..8a434183e 100755
--- testcases/commands/sysctl/sysctl02.sh
+++ testcases/commands/sysctl/sysctl02.sh
@@ -1,26 +1,18 @@
 #!/bin/sh
-
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
 # Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
 #
-# Description:
-# This is a regression test for handling overflow for file-max.
-#
-# when writing 2^64 to /proc/sys/fs/file-max. It will overflow
-# and be set to 0. It crash system quickly.
+# Test for these regressions causing buffer overflow when writing into
+# /proc/sys/fs/file-max:
+# 7f2923c4f73f ("sysctl: handle overflow in proc_get_long")
+# 32a5ad9c2285 ("sysctl: handle overflow for file-max")
 #
-# The kernel bug has been fixed in kernel:
-# '7f2923c4f' (sysctl: handle overflow in proc_get_long)
-# the permitted max value is  2^64-1.
-# '32a5ad9c2' (sysctl: handle overflow for file-max)
-# the permitted max value is 2^63-1
+# This bug has been fixed in 9002b21465fa ("kernel/sysctl.c: fix
+# out-of-bounds access when setting file-max")
 #
-# After merged this patchset, if we exceed the max value, it will
-# keep old value. Unfortunately, it introudced a new bug when set it
-# to 0 and it will lead to system crash.
-# This bug has been fixed by commit 9002b2146
-# (kernel/sysctl.c: fix out-of-bounds access when setting file-max)
+# We test in sysctl02.sh setting 2^64, 2^64-1, 2^63 and 0.
 
 TST_TESTFUNC=do_test
 TST_SETUP=setup
@@ -28,60 +20,52 @@ TST_CLEANUP=cleanup
 TST_CNT=4
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sysctl"
-dir="/proc/sys/fs/"
+sys_name="fs.file-max"
+sys_file="/proc/sys/fs/file-max"
 syms_file="/proc/kallsyms"
-name="file-max"
-orig_value=200000
 
 . tst_test.sh
 
 setup()
 {
-	[ ! -f "$dir""$name" ] && tst_brk TCONF \
-		"$name was not supported"
-	orig_value=$(cat "$dir""$name")
+	[ ! -f "$sys_file" ] && tst_brk TCONF "$sys_file not enabled"
+	orig_value=$(cat "$sys_file")
 }
 
 do_test()
 {
 	case $1 in
-	1)sysctl_test_overflow 18446744073709551616;;
-	2)sysctl_test_overflow 18446744073709551615;;
-	3)sysctl_test_overflow 9223372036854775808;;
-	4)sysctl_test_zero;;
+	1) sysctl_test_overflow 18446744073709551616 ;;
+	2) sysctl_test_overflow 18446744073709551615 ;;
+	3) sysctl_test_overflow 9223372036854775808 ;;
+	4) sysctl_test_zero ;;
 	esac
 }
 
 sysctl_test_overflow()
 {
-	local old_value=$(cat "$dir""$name")
-
-	sysctl -w "fs.file-max"=$1 >/dev/null 2>&1
+	local old_value="$(cat $sys_file)"
+	sysctl -w -q $sys_name=$1 2>/dev/null
+	local test_value="$(cat $sys_file)"
 
-	local test_value=$(cat "$dir""$name")
-
-	echo ${test_value} |grep -q ${old_value}
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "file-max overflow, reject it and keep old value."
+	if echo $test_value | grep -q $old_value; then
+		tst_res TPASS "$sys_file overflows, reject it and keep old value"
 	else
-		tst_res TFAIL "file-max overflow and set it to ${test_value}."
+		tst_res TFAIL "$sys_file overflows and set to $test_value"
 	fi
 	cleanup
 }
 
 sysctl_test_zero()
 {
-	sysctl -w "fs.file-max"=0 >/dev/null 2>&1
-	[ ! -f "$syms_file" ] && tst_brk TCONF \
-		"$syms_file was not supported"
-	cat $syms_file  |grep kasan_report >/dev/null 2>&1
-	if [ $? -eq 0 ]; then
-		dmesg | grep "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax" >/dev/null
-		if [ $? -eq 0 ]; then
-			tst_res TFAIL "file-max is set 0 and trigger a KASAN error"
+	[ ! -f "$syms_file" ] && tst_brk TCONF "$syms_file not enabled"
+	ROD sysctl -w -q $sys_name=0
+
+	if grep -q kasan_report $syms_file; then
+		if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
+			tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
 		else
-			tst_res TPASS \
-				"file-max is set 0 and doesn't trigger a KASAN error"
+			tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
 		fi
 	else
 		tst_res TCONF "kernel doesn't support KASAN"
@@ -90,7 +74,7 @@ sysctl_test_zero()
 
 cleanup()
 {
-	sysctl -w "fs.""$name"=${orig_value} >/dev/null 2>&1
+	[ -n "$orig_value" ] && sysctl -w -q $sys_name=$orig_value
 }
 
 tst_run
