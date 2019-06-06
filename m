From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 6 Jun 2019 18:45:30 +0800
Subject: [LTP] [PATCH v2] sysctl/sysctl02: Add new regression test for
	overflow file-max
In-Reply-To: <1559817080-2991-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1559817080-2991-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1559817930-2299-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On upstream kernel, before commit[1], the max value in proc_get_long based on
the number of chars(21). It rejects values such as 184467440737095516160 (21 chars)
but accepts values such as 18446744073709551616 (20 chars). But we should reject all
because both are overflows. After this commit,the permitted max value is 2^64-1.

Before commit[2], when writing echo 18446744073709551616 > /proc/sys/fs/file-max
/proc/sys/fs/file-max will overflow and be set to 0.  It may crash the system. This
commit sets the max and min value for file-max. After this commit,the permitted max
value is 2^63-1.

Unfortunately, commit[2] introduced a new bug because the minimum value points at
the global 'zero' variable which is an int. It may crash system. This bug has been fixed
bt commit[3].

I will set 2^64 ,2^64-1,2^63 and 0 to file-max in case and test it.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f2923c4f73f21cfd714d12a2d48de8c21f11cfe
[2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=32a5ad9c22852e6bd9e74bdec5934ef9d1480bc5
[3]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9002b21465fa4d829edfc94a5a441005cffaa972

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/commands                      |  1 +
 testcases/commands/sysctl/sysctl02.sh | 88 +++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100755 testcases/commands/sysctl/sysctl02.sh

diff --git a/runtest/commands b/runtest/commands
index ac15e8b23..1870c4209 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -40,3 +40,4 @@ keyctl01_sh keyctl01.sh
 gdb01_sh gdb01.sh
 unshare01_sh unshare01.sh
 sysctl01_sh sysctl01.sh
+sysctl02_sh sysctl02.sh
diff --git a/testcases/commands/sysctl/sysctl02.sh b/testcases/commands/sysctl/sysctl02.sh
new file mode 100755
index 000000000..9ca9d0609
--- /dev/null
+++ b/testcases/commands/sysctl/sysctl02.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+# Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
+#
+# Description:
+# This is a regression test for handling overflow for file-max.
+#
+# when writing 2^64 to /proc/sys/fs/file-max. It will overflow
+# and be set to 0. It crash system quickly.
+#
+# The kernel bug has been fixed in kernel:
+# '7f2923c4f' (sysctl: handle overflow in proc_get_long)
+# the permitted max value is  2^64-1.
+# '32a5ad9c2' (sysctl: handle overflow for file-max)
+# the permitted max value is 2^63-1
+#
+# After merged this patchset, if we exceed the max value, it will
+# keep old value. Unfortunately, it introudced a new bug when set it
+# to 0 and it will lead to system crash.
+# This bug has been fixed by commit 9002b2146
+# (kernel/sysctl.c: fix out-of-bounds access when setting file-max)
+
+TST_TESTFUNC=do_test
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+TST_CNT=4
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="sysctl"
+dir="/proc/sys/fs/"
+name="file-max"
+orig_value=200000
+check1=18446744073709551616
+check2=18446744073709551615
+check3=9223372036854775808
+check4=0
+
+. tst_test.sh
+
+setup()
+{
+	[ ! -f "$dir""$name" ] && tst_brk TCONF \
+		"$name was not supported"
+	orig_value=$(cat "$dir""$name")
+}
+
+do_test()
+{
+	case $1 in
+	1)sysctl_test_overflow ${check1};;
+	2)sysctl_test_overflow ${check2};;
+	3)sysctl_test_overflow ${check3};;
+	4)sysctl_test_zero ${check4};;
+	esac
+}
+
+sysctl_test_overflow()
+{
+	local old_value=$(cat "$dir""$name")
+
+	sysctl -w "fs.file-max"=$1 >/dev/null 2>&1
+
+	local test_value=$(cat "$dir""$name")
+
+	echo ${test_value} |grep -q ${old_value}
+	if [ $? -eq 0 ]; then
+		tst_res TPASS "file-max overflow, reject it and keep old value."
+	else
+		tst_res TFAIL "file-max overflow and set it to ${test_value}."
+	fi
+	cleanup
+}
+
+sysctl_test_zero()
+{
+	sysctl -w "fs.file-max"=$1 >/dev/null 2>&1
+	tst_res TINFO "if it doesn't report TPASS after 60s sleep, system crashes"
+	sleep 60
+	tst_res TPASS "file-max is set 0 and doesn't crash"
+}
+
+cleanup()
+{
+	sysctl -w "fs.""$name"=${orig_value} >/dev/null 2>&1
+}
+
+tst_run
-- 
2.18.1



