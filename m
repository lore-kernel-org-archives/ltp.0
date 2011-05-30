Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QR3kY-0001sE-El
	for ltp-list@lists.sourceforge.net; Mon, 30 May 2011 14:47:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QR3kX-0004RU-F5
	for ltp-list@lists.sourceforge.net; Mon, 30 May 2011 14:47:22 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4UElFcW002071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 30 May 2011 10:47:15 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Mon, 30 May 2011 22:46:56 +0800
Message-Id: <d8bfa2dc5fb2d4a57cb403095e1801ccbb8044b1.1306766788.git.czhang@redhat.com>
In-Reply-To: <20110506134147.GA23206@saboteur.suse.cz>
References: <20110506134147.GA23206@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH v6] mm: thp testcase come from CVE reproducer
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This is a reproducer of CVE-2011-0999, which fixed by mainline commit
a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:

"Transparent hugepages can only be created if rmap is fully functional.
So we must prevent hugepages to be created while
is_vma_temporary_stack() is true."

When running in a loop, it can trigger panic like this, if kernel
unpatched:

kernel BUG at mm/huge_memory.c:1260!
invalid opcode: 0000 [#1] SMP
last sysfs file:
/sys/devices/system/cpu/cpu23/cache/index2/shared_cpu_map
....

So I recommend to run it as 'thp01 -I xxx'.

v5: not using hard depend on /bin/true, use execvp() and "true" instead.
v6: set testing time to 2 min.

Signed-off-by: Pingtian Han <phan@redhat.com>
Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/mm                        |    2 +
 testcases/kernel/mem/thp/Makefile |   23 +++++++
 testcases/kernel/mem/thp/thp01.c  |  124 +++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/thp/Makefile
 create mode 100644 testcases/kernel/mem/thp/thp01.c


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-mm-thp-testcase-come-from-CVE-reproducer.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-thp-testcase-come-from-CVE-reproducer.patch"

diff --git a/runtest/mm b/runtest/mm
index f2d50d6..df7d0cb 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -78,3 +78,5 @@ oom01 oom01
 oom02 oom02
 oom03 oom03
 oom04 oom04
+
+thp01 thp01 -I 120
diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp/Makefile
new file mode 100644
index 0000000..d43511a
--- /dev/null
+++ b/testcases/kernel/mem/thp/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (C) 2011  Red Hat, Inc.
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
index 0000000..6c7cce3
--- /dev/null
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -0,0 +1,124 @@
+/*
+ * This is a reproducer of CVE-2011-0999, which fixed by mainline commit
+ * a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:
+ *
+ * "Transparent hugepages can only be created if rmap is fully
+ * functional. So we must prevent hugepages to be created while
+ * is_vma_temporary_stack() is true."
+ *
+ * It will cause a panic something like this, if the patch didn't get
+ * applied:
+ *
+ * kernel BUG at mm/huge_memory.c:1260!
+ * invalid opcode: 0000 [#1] SMP
+ * last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cpu_map
+ * ....
+ *
+ * Copyright (C) 2011  Red Hat, Inc.
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
+
+#include <sys/types.h>
+#include <sys/resource.h>
+#include <sys/wait.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+#include "config.h"
+
+char *TCID = "thp01";
+int TST_TOTAL = 1;
+
+#define ARRAY_SZ	256
+
+static int ps;
+static long length;
+static char *array[ARRAY_SZ];
+static char *arg;
+static struct rlimit rl = {
+	.rlim_cur = RLIM_INFINITY,
+	.rlim_max = RLIM_INFINITY,
+};
+
+static void setup(void);
+static void cleanup(void);
+
+int main(int argc, char **argv)
+{
+	int i, lc, st;
+	pid_t pid;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		case 0:
+			memset(arg, 'c', length - 1);
+			arg[length - 1] = '\0';
+			for (i = 0; i < ARRAY_SZ - 1; i++)
+				array[i] = arg;
+			array[ARRAY_SZ - 1] = NULL;
+			if (setrlimit(RLIMIT_STACK, &rl) == -1) {
+				perror("setrlimit");
+				exit(1);
+			}
+			if (execvp("true", array) == -1) {
+				perror("execvp");
+				exit(1);
+			}
+		default:
+			if (waitpid(pid, &st, 0) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+			if (!WIFEXITED(st) || WEXITSTATUS(st) != 0)
+				tst_brkm(TBROK, cleanup,
+					"child exited abnormally");
+		}
+	}
+	tst_resm(TPASS, "system didn't crash, pass.");
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	ps = sysconf(_SC_PAGESIZE);
+	length = 32 * ps;
+	arg = malloc(length);
+	if (arg == NULL)
+		tst_brkm(TBROK|TERRNO, NULL, "malloc");
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
vRanger cuts backup time in half-while increasing security.
With the market-leading solution for virtual backup and recovery, 
you get blazing-fast, flexible, and affordable data protection.
Download your free trial now. 
http://p.sf.net/sfu/quest-d2dcopy1
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



