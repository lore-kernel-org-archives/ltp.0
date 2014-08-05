Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XEg04-0005zN-Bo
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 14:46:04 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XEg03-0000ed-1y
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 14:46:04 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s75EjuOD000471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Aug 2014 10:45:56 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  5 Aug 2014 16:45:53 +0200
Message-Id: <c0760953d5915e17e43a5e899bad7f5d0a7fde80.1407249825.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] madvise05: new testcase for Oops in madvise_willneed
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

This is a regression test for madvise(2) system call. It tests
kernel for NULL ptr deref Oops fixed by:
  commit ee53664bda169f519ce3c6a22d378f0b946c8178
  Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
  Date:   Fri Dec 20 15:10:03 2013 +0200
    mm: Fix NULL pointer dereference in madvise(MADV_WILLNEED) support

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/syscalls                              |    1 +
 testcases/kernel/syscalls/.gitignore          |    1 +
 testcases/kernel/syscalls/madvise/madvise05.c |   81 +++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 5e6e0f4..142c350 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -715,6 +715,7 @@ madvise01 madvise01
 madvise02 madvise02
 madvise03 madvise03
 madvise04 madvise04
+madvise05 madvise05
 
 newuname01 newuname01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index fb2425e..fd52217 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -479,6 +479,7 @@
 /madvise/madvise02
 /madvise/madvise03
 /madvise/madvise04
+/madvise/madvise05
 /mallopt/mallopt01
 /mbind/mbind01
 /memcmp/memcmp01
diff --git a/testcases/kernel/syscalls/madvise/madvise05.c b/testcases/kernel/syscalls/madvise/madvise05.c
new file mode 100644
index 0000000..043eb4d
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise05.c
@@ -0,0 +1,81 @@
+/*
+ *  Copyright (c) Linux Test Project, 2014
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU Library General Public License for more details.
+ */
+/*
+ * This is a regression test for madvise(2) system call. It tests kernel
+ * for NULL ptr deref Oops fixed by:
+ *   commit ee53664bda169f519ce3c6a22d378f0b946c8178
+ *   Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
+ *   Date:   Fri Dec 20 15:10:03 2013 +0200
+ *     mm: Fix NULL pointer dereference in madvise(MADV_WILLNEED) support
+ *
+ * On buggy kernel with CONFIG_DEBUG_LOCK_ALLOC=y this testcase should
+ * produce Oops and/or be killed. On fixed/good kernel this testcase
+ * runs to completion (retcode is 0)
+ */
+
+#include <sys/mman.h>
+#include <errno.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+#define ALLOC_SIZE (32 * 1024 * 1024)
+
+static void setup(void);
+static void cleanup(void);
+
+char *TCID = "madvise05";
+int TST_TOTAL = 1;
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	const char *msg = NULL;
+	void *p;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		p = SAFE_MMAP(cleanup, NULL, ALLOC_SIZE, PROT_READ,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
+		TEST(mprotect(p, ALLOC_SIZE, PROT_NONE));
+		if (TEST_RETURN == -1)
+			tst_brkm(TBROK | TTERRNO, cleanup, "mprotect failed");
+		TEST(madvise(p, ALLOC_SIZE, MADV_WILLNEED));
+		if (TEST_RETURN == -1)
+			tst_brkm(TBROK | TTERRNO, cleanup, "madvise failed");
+		SAFE_MUNMAP(cleanup, p, ALLOC_SIZE);
+	}
+
+	tst_resm(TPASS, "issue has not been reproduced");
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
-- 
1.7.1


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
