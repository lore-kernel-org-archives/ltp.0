From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  4 Aug 2021 11:24:07 +0200
Subject: [LTP] [PATCH v8 2/7] test/test_zero_hugepage.sh: Skip test on
 read-only /proc
In-Reply-To: <20210804092407.16015-1-pvorel@suse.cz>
References: <20210804092407.16015-1-pvorel@suse.cz>
Message-ID: <20210804092407.16015-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

or /proc/sys. On GitHub Actions /proc/sys/vm/nr_hugepages is not allowed
to be changed:

./test_zero_hugepage.sh: line 9: can't create /proc/sys/vm/nr_hugepages: Read-only file system
tst_hugepage.c:57: TBROK: Failed to open FILE '/proc/sys/vm/nr_hugepages' for writing: EROFS (30)
tst_sys_conf.c:102: TWARN: Failed to open FILE '/proc/sys/vm/nr_hugepages'

There are several /proc subdirectories mounted as read only:
$ grep '^proc /proc.* proc ro' /proc/mounts
proc /proc/bus proc ro,nosuid,nodev,noexec,relatime 0 0
proc /proc/fs proc ro,nosuid,nodev,noexec,relatime 0 0
proc /proc/irq proc ro,nosuid,nodev,noexec,relatime 0 0
proc /proc/sys proc ro,nosuid,nodev,noexec,relatime 0 0
proc /proc/sysrq-trigger proc ro,nosuid,nodev,noexec,relatime 0 0

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v7->v8:
* check for readonly fs instead TCONF on any error during writing to
/proc/sys/vm/nr_hugepages (Cyril)

 lib/newlib_tests/test_zero_hugepage.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/newlib_tests/test_zero_hugepage.sh b/lib/newlib_tests/test_zero_hugepage.sh
index 10113006b..d270e686c 100755
--- a/lib/newlib_tests/test_zero_hugepage.sh
+++ b/lib/newlib_tests/test_zero_hugepage.sh
@@ -1,11 +1,17 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
 
 echo "Testing .request_hugepages = TST_NO_HUGEPAGES"
 
 orig_value=`cat /proc/sys/vm/nr_hugepages`
 
+if grep -q -E '^proc /proc(/sys)? proc ro' /proc/mounts; then
+	echo "TCONF: /proc or /proc/sys mounted as read-only"
+	exit 32
+fi
+
 echo "128" > /proc/sys/vm/nr_hugepages
 
 ./test_zero_hugepage
-- 
2.32.0

