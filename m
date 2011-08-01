Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QnhBV-0004qy-7a
	for ltp-list@lists.sourceforge.net; Mon, 01 Aug 2011 01:20:45 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QnhBU-0002sh-4a
	for ltp-list@lists.sourceforge.net; Mon, 01 Aug 2011 01:20:45 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p711KcpY032014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Sun, 31 Jul 2011 21:20:38 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Mon,  1 Aug 2011 09:20:01 +0800
Message-Id: <4387b2003cde3c5841dd4bcd9d58560aa891501d.1312147752.git.czhang@redhat.com>
In-Reply-To: <235cb4cd6481ca25245b6b6d5ed988736d8a2991.1312043382.git.czhang@redhat.com>
References: <235cb4cd6481ca25245b6b6d5ed988736d8a2991.1312043382.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.6"
Subject: [LTP] [PATCH v2] [mm] vma01: new testcase
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
--------------1.7.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


vma01 - test not merging a VMA which cloned from parent process

This program is used for testing the following upstream commit:
965f55dea0e331152fa53941a51e4e16f9f06fae

The cloned VMA shares the anon_vma lock with the parent process's
VMA. If we do the merge, more vmas (even the new range is only
for current process) use the perent process's anon_vma lock. This
introduces scalability issues. find_mergeable_anon_vma() already
considers this case.

This test program clones VMA and checks /proc/$pid/maps file, on
an unpatched kernel, there is a single 6*ps VMA for the child
like this:

7fee32989000-7fee3298f000 -w-p 00000000 00:00 0

On a patched kernel, there are two 3*ps VMAs like this:

7f55bbd47000-7f55bbd4a000 -w-p 00000000 00:00 0
7f55bbd4a000-7f55bbd4d000 -w-p 00000000 00:00 0

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/mm                        |    2 +
 testcases/kernel/mem/vma/Makefile |   24 ++++++
 testcases/kernel/mem/vma/vma01.c  |  163 +++++++++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vma/Makefile
 create mode 100644 testcases/kernel/mem/vma/vma01.c


--------------1.7.6
Content-Type: text/x-patch; name="0001-mm-vma01-new-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-mm-vma01-new-testcase.patch"

diff --git a/runtest/mm b/runtest/mm
index df7d0cb..5b08d15 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -80,3 +80,5 @@ oom03 oom03
 oom04 oom04
 
 thp01 thp01 -I 120
+
+vma01 vma01
diff --git a/testcases/kernel/mem/vma/Makefile b/testcases/kernel/mem/vma/Makefile
new file mode 100644
index 0000000..6b347c4
--- /dev/null
+++ b/testcases/kernel/mem/vma/Makefile
@@ -0,0 +1,24 @@
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
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
new file mode 100644
index 0000000..edcd95c
--- /dev/null
+++ b/testcases/kernel/mem/vma/vma01.c
@@ -0,0 +1,163 @@
+/*
+ * vma01 - test not merging a VMA which cloned from parent process
+ *
+ * This program is used for testing the following upstream commit:
+ * 965f55dea0e331152fa53941a51e4e16f9f06fae
+ *
+ * The cloned VMA shares the anon_vma lock with the parent process's
+ * VMA. If we do the merge, more vmas (even the new range is only
+ * for current process) use the perent process's anon_vma lock. This
+ * introduces scalability issues. find_mergeable_anon_vma() already
+ * considers this case.
+ *
+ * This test program clones VMA and checks /proc/$pid/maps file, on
+ * an unpatched kernel, there is a single 6*ps VMA for the child
+ * like this:
+ *
+ * 7fee32989000-7fee3298f000 -w-p 00000000 00:00 0
+ *
+ * On a patched kernel, there are two 3*ps VMAs like this:
+ *
+ * 7f55bbd47000-7f55bbd4a000 -w-p 00000000 00:00 0
+ * 7f55bbd4a000-7f55bbd4d000 -w-p 00000000 00:00 0
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
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "vma01";
+int TST_TOTAL = 1;
+
+static void check_vma(void);
+static void *get_end_addr(void *addr_s, char *mapfile);
+static void setup(void);
+static void cleanup(void);
+
+static unsigned long ps;
+
+int main(int argc, char **argv)
+{
+	char *msg;
+	int lc;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	ps = sysconf(_SC_PAGE_SIZE);
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		check_vma();
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void check_vma(void)
+{
+	pid_t pid;
+	void *t, *u, *v, *x, *y;
+	char mapfile[BUFSIZ];
+
+	t = mmap(NULL, 3*ps, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
+	if (t == MAP_FAILED)
+		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+	tst_resm(TINFO, "t = %p", t);
+	memset(t, 1, ps);
+	v = mmap(NULL, 3*ps, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
+	if (v == MAP_FAILED)
+		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+	tst_resm(TINFO, "v = %p", v);
+	memset(v, 2, ps);
+
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		sprintf(mapfile, "/proc/%u/maps", getpid());
+		memset(t, 2, ps);
+		u = mmap(t + 3*ps, 3*ps, PROT_WRITE,
+			    MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
+		if (u == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, NULL, "mmap");
+		tst_resm(TINFO, "u = %p", u);
+		memset(u, 2, 4096);
+		x = get_end_addr(u, mapfile);
+		if (x == u + 6*ps)
+			tst_resm(TFAIL, "A single 6*ps VMA found.");
+		else if (x == u + 3*ps) {
+			y = get_end_addr(x, mapfile);
+			if (y == x + 3*ps)
+				tst_resm(TPASS, "two 3*ps VMAs found.");
+		} else
+			tst_brkm(TBROK, cleanup, "unexpected VMA found.");
+		exit(0);
+	default:
+		break;
+	}
+
+}
+
+static void *get_end_addr(void *addr_s, char *mapfile)
+{
+	FILE *fp;
+	void *s, *t;
+	char buf[BUFSIZ];
+
+	fp = fopen(mapfile, "r+");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	while (fgets(buf, BUFSIZ, fp) != NULL) {
+		if (sscanf(buf, "%p-%p ", &s, &t) != 2)
+			continue;
+		if (addr_s == s) {
+			tst_resm(TINFO, "s = %p, t = %p", s, t);
+			fclose(fp);
+			return t;
+		}
+	}
+	fclose(fp);
+	tst_brkm(TBROK, cleanup, "no matched s = %p found.", addr_s);
+}
+
+static void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}

--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey

--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.6--



