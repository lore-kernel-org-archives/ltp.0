Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RstFF-0004OB-IS
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 09:46:21 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RstFB-0002hb-KN
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 09:46:21 +0000
Received: by iaby12 with SMTP id y12so3911799iab.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Feb 2012 01:46:12 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu,  2 Feb 2012 17:37:32 +0800
Message-Id: <1328175453-10106-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <4F2A5185.6060008@casparzhang.com>
References: <4F2A5185.6060008@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH v2 1/2] mm/thp02: new testcase
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


thp02 - detect mremap bug when THP is enabled.

There was a bug in mremap THP support, sometimes crash happened
due to the following reason according to developers:

"alloc_new_pmd was forcing the allocation of a pte before calling
move_huge_page and that resulted in a VM_BUG_ON in move_huge_page
because the pmd wasn't zero."

There are 4 cases to test this bug:

1) old_addr hpage aligned, old_end not hpage aligned, new_addr
   hpage aligned;
2) old_addr hpage aligned, old_end not hpage aligned, new_addr not
   hpage aligned;
3) old_addr not hpage aligned, old_end hpage aligned, new_addr
   hpage aligned;
4) old_addr not hpage aligned, old_end hpage aligned, new_addr not
   hpage aligned.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/thp/Makefile |   20 ++++++
 testcases/kernel/mem/thp/thp02.c  |  136 +++++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/thp/thp02.c


--------------1.7.8.4
Content-Type: text/x-patch; name="0001-mm-thp02-new-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-mm-thp02-new-testcase.patch"

diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp/Makefile
index d43511a..c8ac001 100644
--- a/testcases/kernel/mem/thp/Makefile
+++ b/testcases/kernel/mem/thp/Makefile
@@ -20,4 +20,24 @@
 top_srcdir              ?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
+
+LDLIBS			+= $(NUMA_LIBS) -lmem
+LIBDIR			:= ../lib
+LIB			:= $(LIBDIR)/libmem.a
+FILTER_OUT_DIRS		:= $(LIBDIR)
+LDFLAGS			+= -L$(LIBDIR)
+
+$(LIBDIR):
+	mkdir -p "$@"
+
+$(LIB): $(LIBDIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
+
+MAKE_DEPS		:= $(LIB)
+
+trunk-clean:: | lib-clean
+
+lib-clean:: $(LIBDIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/thp02.c
new file mode 100644
index 0000000..38946ec
--- /dev/null
+++ b/testcases/kernel/mem/thp/thp02.c
@@ -0,0 +1,136 @@
+/*
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
+ *
+ * thp02 - detect mremap bug when THP is enabled.
+ *
+ * There was a bug in mremap THP support, sometimes crash happened
+ * due to the following reason according to developers:
+ *
+ * "alloc_new_pmd was forcing the allocation of a pte before calling
+ * move_huge_page and that resulted in a VM_BUG_ON in move_huge_page
+ * because the pmd wasn't zero."
+ *
+ * There are 4 cases to test this bug:
+ *
+ * 1) old_addr hpage aligned, old_end not hpage aligned, new_addr
+ *    hpage aligned;
+ * 2) old_addr hpage aligned, old_end not hpage aligned, new_addr not
+ *    hpage aligned;
+ * 3) old_addr not hpage aligned, old_end hpage aligned, new_addr
+ *    hpage aligned;
+ * 4) old_addr not hpage aligned, old_end hpage aligned, new_addr not
+ *    hpage aligned.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include "../include/mem.h"
+
+char *TCID = "thp02";
+int TST_TOTAL = 1;
+
+static int ps;
+static long hps, size;
+static void *p, *p2, *p3, *p4;
+
+static void do_mremap(void);
+
+int main(int argc, char **argv)
+{
+	int lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		do_mremap();
+	}
+	tst_resm(TPASS, "Still alive.");
+
+	cleanup();
+	tst_exit();
+
+}
+
+static void do_mremap(void)
+{
+	int i;
+	void *old_addr, *new_addr;
+
+	for (i = 0; i < 4; i++) {
+		if (posix_memalign(&p, hps, size))
+			tst_brkm(TBROK|TERRNO, cleanup, "memalign p");
+		if (posix_memalign(&p2, hps, size))
+			tst_brkm(TBROK|TERRNO, cleanup, "memalign p2");
+		if (posix_memalign(&p3, hps, size))
+			tst_brkm(TBROK|TERRNO, cleanup, "memalign p3");
+
+		memset(p, 0xff, size);
+		memset(p2, 0xff, size);
+		memset(p3, 0x77, size);
+
+		/*
+		 * Will try to do the following 4 mremaps cases:
+		 *   mremap(p, size-ps, size-ps, flag, p3);
+		 *   mremap(p, size-ps, size-ps, flag, p3+ps);
+		 *   mremap(p+ps, size-ps, size-ps, flag, p3);
+		 *   mremap(p+ps, size-ps, size-ps, flag, p3+ps);
+		 */
+		old_addr = p + ps * (i >> 1);
+		new_addr = p3 + ps * (i & 1);
+		tst_resm(TINFO, "mremap %p to %p", old_addr, new_addr);
+
+		p4 = mremap(old_addr, size-ps, size-ps,
+				MREMAP_FIXED|MREMAP_MAYMOVE, new_addr);
+		if (p4 == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, cleanup, "mremap");
+		if (memcmp(p4, p2, size-ps))
+			tst_brkm(TBROK, cleanup, "mremap bug");
+	}
+}
+
+void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+
+	ps   = sysconf(_SC_PAGESIZE);
+	hps  = read_meminfo("Hugepagesize:") * 1024;
+	size = hps * 4;
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+}

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
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



