Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VWlOc-0001Qe-JK
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 11:05:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VWlOb-0001NH-8p
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 11:05:38 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9HB5Vee020629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Oct 2013 07:05:31 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id r9HB5Uj7014903
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Oct 2013 07:05:30 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 17 Oct 2013 13:05:25 +0200
Message-Id: <c4b2fd5ad2a7f04ee4979d3a9d6aa967006af688.1382007845.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/2] lib: add tst_is_virt()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

The initial version supports only generic check for xen dom0/domU,
but should allow to easily extend it for other types of checks,
(e.g. KVM guest) if needed later.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/test.h |    5 +++++
 lib/tst_virt.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 lib/tst_virt.c

diff --git a/include/test.h b/include/test.h
index d9eba31..94fc721 100644
--- a/include/test.h
+++ b/include/test.h
@@ -63,6 +63,9 @@
 #define TRERRNO    0x300   /* Capture errno information from TEST_RETURN to
 			      output; useful for pthread-like APIs :). */
 
+/* virt types for tst_is_virt() */
+#define VIRT_XEN	1	/* xen dom0/domU */
+
 /*
  * Ensure that NUMSIGS is defined.
  * It should be defined in signal.h or sys/signal.h on
@@ -189,6 +192,8 @@ int tst_is_cwd_ramfs(void);
 /* lib/tst_cwd_has_free.c */
 int tst_cwd_has_free(int required_kib);
 
+int tst_is_virt(int virt_type);
+
 /* lib/self_exec.c */
 void maybe_run_child(void (*child)(), char *fmt, ...);
 int self_exec(char *argv0, char *fmt, ...);
diff --git a/lib/tst_virt.c b/lib/tst_virt.c
new file mode 100644
index 0000000..8f906d7
--- /dev/null
+++ b/lib/tst_virt.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2013 Linux Test Project
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
+
+#include <unistd.h>
+#include "test.h"
+
+static int is_xen()
+{
+	char hypervisor_type[3];
+
+	if (access("/proc/xen", F_OK) == 0)
+		return 1;
+
+	if (access("/sys/hypervisor/type", F_OK) == 0) {
+		SAFE_FILE_SCANF(NULL, "/sys/hypervisor/type", "%3s",
+			hypervisor_type);
+		return strncmp("xen", hypervisor_type,
+			sizeof(hypervisor_type)) == 0;
+	}
+
+	return 0;
+}
+
+int tst_is_virt(int virt_type)
+{
+	switch (virt_type) {
+	case VIRT_XEN:
+		return is_xen();
+	}
+	tst_brkm(TBROK, NULL, "invalid virt_type flag: %d", virt_type);
+	return 0;
+}
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
