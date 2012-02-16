Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RxvN4-0005sE-D0
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 07:03:14 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RxvN0-0003yP-6L
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 07:03:14 +0000
Received: by pbcum15 with SMTP id um15so2295793pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Feb 2012 23:03:04 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu, 16 Feb 2012 15:02:24 +0800
Message-Id: <1329375744-20369-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1329372380-18378-1-git-send-email-caspar@casparzhang.com>
References: <1329372380-18378-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH v2] mm/vma04: new testcase
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
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


vma04: corner cases for mbind vma merge issue

There are several corner cases (documented in mm/mmap.c) for mbind
vma merge issue, which makes commit 8aacc9f550 slightly incorrect.
KOSAKI Motohiro made a patch for it (commit e26a511) and composed
a reproducer containing these corner cases. Now I backport it to
LTP.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---

 v1->v2: returns TCONF when ENOSYS returns in invoking mbind()

 runtest/mm                       |    1 +
 testcases/kernel/mem/vma/vma04.c |  339 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 340 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vma/vma04.c


--------------1.7.8.4
Content-Type: text/x-patch; name="0001-mm-vma04-new-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-mm-vma04-new-testcase.patch"

diff --git a/runtest/mm b/runtest/mm
index 26fe534..6ee6762 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -84,5 +84,6 @@ thp02 thp02
 vma01 vma01
 vma02 vma02
 vma03 vma03
+vma04 vma04
 
 zram01 zram01
diff --git a/testcases/kernel/mem/vma/vma04.c b/testcases/kernel/mem/vma/vma04.c
new file mode 100644
index 0000000..0f19f7b
--- /dev/null
+++ b/testcases/kernel/mem/vma/vma04.c
@@ -0,0 +1,339 @@
+/*
+ * Copyright (C) 2012 Linux Test Project
+ *
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
+/*
+ * There are several corner cases (documented in mm/mmap.c) for mbind
+ * vma merge issue, which makes commit 8aacc9f550 slightly incorrect.
+ * KOSAKI Motohiro made a patch for it (commit e26a511) and composed
+ * a reproducer containing these corner cases. Now I backport it to
+ * LTP.
+ *
+ * Author: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
+ * Ported-to-LTP-by: Caspar Zhang <caspar@casparzhang.com>
+ */
+
+#include "config.h"
+#include <sys/types.h>
+#include <sys/mman.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+#if HAVE_NUMAIF_H
+#include <numaif.h>
+#endif
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+char *TCID = "vma04";
+int TST_TOTAL = 5;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
+static unsigned long pagesize;
+static int opt_node;
+static char *opt_nodestr;
+static char retbuf[BUFSIZ];
+static void *mmap_addr;
+static struct bitmask *nmask;
+
+static option_t options[] = {
+	{ "n:", &opt_node,	&opt_nodestr},
+	{ NULL, NULL,		NULL}
+};
+
+static void init(void);
+static void fin(void);
+static void mem_bind(int index, int len);
+static void mem_interleave(int index, int len);
+static void mem_unbind(int index, int len);
+static void assertion(char *expected, char *value, char *name);
+static void get_vmas(char *retbuf, void *addr_s, void *addr_e);
+static void case4(void);
+static void case5(void);
+static void case6(void);
+static void case7(void);
+static void case8(void);
+static void setup(void);
+static void cleanup(void);
+static void usage(void);
+
+int main(int argc, char **argv)
+{
+	int lc, node;
+	char *msg;
+
+	msg = parse_opts(argc, argv, options, usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	nmask = numa_allocate_nodemask();
+	if (opt_node) {
+		node = SAFE_STRTOL(NULL, opt_nodestr, 1, LONG_MAX);
+		numa_bitmask_setbit(nmask, node);
+	} else {
+		numa_bitmask_setbit(nmask, 0);
+	}
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		case4();
+		case5();
+		case6();
+		case7();
+		case8();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+/*
+ *  BBBBBB
+ * AAAAAAAA
+ */
+static void init(void)
+{
+	void *addr;
+
+	addr = SAFE_MMAP(cleanup, NULL, pagesize*8, PROT_NONE,
+		    MAP_ANON|MAP_PRIVATE, 0, 0);
+	SAFE_MMAP(cleanup, addr+pagesize, pagesize*6, PROT_READ|PROT_WRITE,
+		    MAP_ANON|MAP_PRIVATE|MAP_FIXED, 0, 0);
+
+	mmap_addr = addr + pagesize;
+	memset(mmap_addr, 0, pagesize*6);
+}
+
+static void fin(void)
+{
+	void *addr;
+
+	addr = mmap_addr - pagesize;
+	SAFE_MUNMAP(cleanup, addr, pagesize*8);
+
+	memset(retbuf, 0, sizeof(retbuf));
+}
+
+static void mem_bind(int index, int len)
+{
+	if (mbind(mmap_addr+pagesize*index, pagesize*len,
+		    MPOL_BIND, nmask->maskp, nmask->size, 0) != 0) {
+		if (errno != ENOSYS)
+			tst_brkm(TBROK|TERRNO, cleanup, "mbind: bind");
+		else
+			tst_brkm(TCONF, cleanup,
+				    "mbind syscall not implemented "
+				    "on this system.");
+	}
+}
+
+static void mem_interleave(int index, int len)
+{
+	if (mbind(mmap_addr+pagesize*index, pagesize*len,
+		    MPOL_INTERLEAVE, nmask->maskp, nmask->size, 0) != 0) {
+		if (errno != ENOSYS)
+			tst_brkm(TBROK|TERRNO, cleanup, "mbind: interleave");
+		else
+			tst_brkm(TCONF, cleanup,
+				    "mbind syscall not implemented "
+				    "on this system.");
+	}
+}
+
+static void mem_unbind(int index, int len)
+{
+	if (mbind(mmap_addr+pagesize*index, pagesize*len,
+		    MPOL_DEFAULT, NULL, 0, 0) != 0) {
+		if (errno != ENOSYS)
+			tst_brkm(TBROK|TERRNO, cleanup, "mbind: unbind");
+		else
+			tst_brkm(TCONF, cleanup,
+				    "mbind syscall not implemented "
+				    "on this system.");
+	}
+}
+
+static void assertion(char *expected, char *value, char *name)
+{
+	if (strcmp(expected, value) == 0)
+		tst_resm(TPASS, "%s: passed.", name);
+	else
+		tst_resm(TFAIL, "%s: failed. expect '%s', actual '%s'",
+			    name, expected, value);
+}
+
+static void get_vmas(char *retbuf, void *addr_s, void *addr_e)
+{
+	FILE *fp;
+	void *s, *t;
+	char buf[BUFSIZ], tmpstr[BUFSIZ];
+	int  flag;
+
+	retbuf[0] = '\0';
+	flag = 0;
+	fp = fopen("/proc/self/maps", "r");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	while (fgets(buf, BUFSIZ, fp) != NULL) {
+		if (sscanf(buf, "%p-%p ", &s, &t) != 2)
+			continue;
+		if (addr_s <= s && s < addr_e) {
+			if (!flag) {
+				sprintf(tmpstr, "%ld", (t-s)/pagesize);
+				flag = 1;
+			} else {
+				sprintf(tmpstr, ",%ld", (t-s)/pagesize);
+			}
+			strncat(retbuf, tmpstr, 32);
+		}
+	}
+	fclose(fp);
+}
+
+/*
+ *   AAAA
+ * PPPPPPNNNNNN
+ * might become
+ * PPNNNNNNNNNN
+ * case 4 below
+ */
+static void case4(void)
+{
+	init();
+	mem_bind(0, 4);
+	mem_unbind(2, 2);
+	get_vmas(retbuf, mmap_addr, mmap_addr+pagesize*6);
+	assertion("2,4", retbuf, "case4");
+	fin();
+}
+
+/*
+ *       AAAA
+ * PPPPPPNNNNNN
+ * might become
+ * PPPPPPPPPPNN
+ * case 5 below
+ */
+static void case5(void)
+{
+	init();
+	mem_bind(0, 2);
+	mem_bind(2, 2);
+	get_vmas(retbuf, mmap_addr, mmap_addr+pagesize*6);
+	assertion("4,2", retbuf, "case5");
+	fin();
+}
+
+/*
+ *     AAAA
+ * PPPPNNNNXXXX
+ * might become
+ * PPPPPPPPPPPP 6
+ */
+static void case6(void)
+{
+	init();
+	mem_bind(0, 2);
+	mem_bind(4, 2);
+	mem_bind(2, 2);
+	get_vmas(retbuf, mmap_addr, mmap_addr+pagesize*6);
+	assertion("6", retbuf, "case6");
+	fin();
+}
+
+/*
+ *     AAAA
+ * PPPPNNNNXXXX
+ * might become
+ * PPPPPPPPXXXX 7
+ */
+static void case7(void)
+{
+	init();
+	mem_bind(0, 2);
+	mem_interleave(4, 2);
+	mem_bind(2, 2);
+	get_vmas(retbuf, mmap_addr, mmap_addr+pagesize*6);
+	assertion("4,2", retbuf, "case7");
+	fin();
+}
+
+/*
+ *     AAAA
+ * PPPPNNNNXXXX
+ * might become
+ * PPPPNNNNNNNN 8
+ */
+static void case8(void)
+{
+	init();
+	mem_bind(0, 2);
+	mem_interleave(4, 2);
+	mem_interleave(2, 2);
+	get_vmas(retbuf, mmap_addr, mmap_addr+pagesize*6);
+	assertion("2,4", retbuf, "case8");
+	fin();
+}
+
+static void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	pagesize = getpagesize();
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
+
+static void usage(void)
+{
+	printf("  -n      Number of NUMA nodes\n");
+}
+
+#else /* libnuma v1 */
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "XXX: test is only supported on libnuma v2.");
+}
+#endif
+#else /* no NUMA */
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+}
+#endif

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



