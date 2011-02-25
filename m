Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PsuyJ-0007Dw-CI
	for ltp-list@lists.sourceforge.net; Fri, 25 Feb 2011 10:32:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PsuyH-0003aY-VC
	for ltp-list@lists.sourceforge.net; Fri, 25 Feb 2011 10:32:27 +0000
Date: Fri, 25 Feb 2011 18:36:20 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110225103620.GA10350@hpt.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] thp testcase come from CVE reproducer
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a reproducer of  CVE-2011-0999, which fixed by mainline commit
a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:

"Transparent hugepages can only be created if rmap is fully
functional. So we must prevent hugepages to be created while
is_vma_temporary_stack() is true."

When running in a loop, it can trigger panic like this, if kernel
unpatched:

kernel BUG at mm/huge_memory.c:1260!
invalid opcode: 0000 [#1] SMP
last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cpu_map
....

So I recommend to run it as 'thp01 -I xxx'.

Signed-off-by: Han Pingtian <phan@redhat.com>
---
 runtest/mm                        |    2 +
 testcases/kernel/mem/thp/Makefile |   23 +++++++++
 testcases/kernel/mem/thp/thp01.c  |   99 +++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/thp/Makefile
 create mode 100644 testcases/kernel/mem/thp/thp01.c

diff --git a/runtest/mm b/runtest/mm
index f097256..6b7e003 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -84,3 +84,5 @@ oom01 oom01
 oom02 oom02
 oom03 oom03
 oom04 oom04
+
+thp01 thp01 -I 600
diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp/Makefile
new file mode 100644
index 0000000..dbfbc1b
--- /dev/null
+++ b/testcases/kernel/mem/thp/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or (at
+#  your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful, but
+#  WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+#  02110-1301, USA.
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
new file mode 100644
index 0000000..b667b78
--- /dev/null
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -0,0 +1,99 @@
+/*
+ * This is a reproducer of  CVE-2011-0999, which fixed by mainline commit
+ * a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:
+ *
+ * "Transparent hugepages can only be created if rmap is fully
+ * functional. So we must prevent hugepages to be created while
+ * is_vma_temporary_stack() is true."
+ *
+ * It will cause a panic something like this, if the patch didn't get applied:
+ *
+ * kernel BUG at mm/huge_memory.c:1260!
+ * invalid opcode: 0000 [#1] SMP
+ * last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cpu_map
+ * ....
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+#include "test.h"
+#include "usctest.h"
+#include "config.h"
+
+char *TCID = "thp01";
+int TST_TOTAL = 1;
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+static option_t options[] = {
+	{NULL, NULL, NULL}
+};
+
+static void usage(void)
+{
+    return;
+}
+
+int main(int argc, char **argv) {
+	int i, lc, st;
+	pid_t pid;
+	char *msg;
+	char *c[257];
+	char cc[32*4096];
+	struct rlimit rl = {
+		.rlim_cur =RLIM_INFINITY,
+		.rlim_max=RLIM_INFINITY,
+	};
+
+	msg = parse_opts(argc, argv, options, usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		switch (pid = fork()) {
+			case -1:
+				tst_brkm(TBROK|TERRNO, NULL, "fork");
+			case 0:
+				memset(cc, 'c', 32*4096-1);
+				for (i=0;i<256;i++)
+					c[i] = cc;
+				if (setrlimit(RLIMIT_STACK, &rl) == -1)
+					tst_brkm(TBROK|TERRNO, NULL, "setrlimit");
+				if (execve("/bin/true", c, c) == -1)
+					tst_brkm(TBROK|TERRNO, NULL, "execve");
+			default:
+				if (waitpid(pid, &st, 0) == -1)
+					tst_brkm(TBROK|TERRNO, NULL, "waitpid");
+
+				if (! WIFEXITED(st))
+					tst_brkm(TBROK, NULL, "child exit status is %d", WEXITSTATUS(st));
+
+				tst_resm(TPASS, "thp01 pass");
+		}
+	}
+
+        tst_exit();
+}
-- 
1.7.1

------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
