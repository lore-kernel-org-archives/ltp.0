Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WGROX-0000s8-K3
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 11:02:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGROV-0007F3-Ed
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 11:02:21 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1KB27GW014491
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Feb 2014 19:02:08 +0800
Message-ID: <1392894122.2053.11.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 20 Feb 2014 19:02:02 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] modify_ldt/modify_ldt03.c: add a new test
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Add func=0 argument test for modify_ldt(2).

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                                    |   1 +
 runtest/stress.part3                               |   1 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/modify_ldt/modify_ldt03.c      | 110 +++++++++++++++++++++
 5 files changed, 114 insertions(+)
 create mode 100644 testcases/kernel/syscalls/modify_ldt/modify_ldt03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 4b5300d..c7a5fd0 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -448,6 +448,7 @@ mmap09 mmap09
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
+modify_ldt03 modify_ldt03
 
 #
 # These tests require an unmounted block device
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index bb4807c..d9a846a 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -381,6 +381,7 @@ mmap09 mmap09
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
+modify_ldt03 modify_ldt03
 
 mprotect01 mprotect01
 mprotect02 mprotect02
diff --git a/runtest/syscalls b/runtest/syscalls
index afa7976..a6b265c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -576,6 +576,7 @@ mmap14 mmap14
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
+modify_ldt03 modify_ldt03
 
 #
 # These tests require an unmounted block device
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 1caf8e3..f7bd5b1 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -520,6 +520,7 @@
 /mmap/mmap14
 /modify_ldt/modify_ldt01
 /modify_ldt/modify_ldt02
+/modify_ldt/modify_ldt03
 /mount/mount01
 /mount/mount02
 /mount/mount03
diff --git a/testcases/kernel/syscalls/modify_ldt/modify_ldt03.c b/testcases/kernel/syscalls/modify_ldt/modify_ldt03.c
new file mode 100644
index 0000000..7dce116
--- /dev/null
+++ b/testcases/kernel/syscalls/modify_ldt/modify_ldt03.c
@@ -0,0 +1,110 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ */
+/*
+ * DESCRIPTION
+ *	Basic test for modify_ldt(2) using func=0 argument.
+ */
+
+#include "config.h"
+#include "test.h"
+#include "usctest.h"
+
+TCID_DEFINE(modify_ldt03);
+int TST_TOTAL = 1;
+
+#if defined(__i386__) && defined(HAVE_MODIFY_LDT)
+
+#ifdef HAVE_ASM_LDT_H
+#include <asm/ldt.h>
+#endif
+extern int modify_ldt(int, void *, unsigned long);
+
+#include <asm/unistd.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include "safe_macros.h"
+
+static unsigned long bytecount = 10;
+static void *ptr;
+static void cleanup(void);
+static void setup(void);
+
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		tst_count = 0;
+
+		TEST(modify_ldt(0, ptr, bytecount));
+
+		if (TEST_RETURN < 0) {
+			tst_resm(TFAIL | TTERRNO,
+				 "modify_ldt() failed with errno: %s",
+				 strerror(TEST_ERRNO));
+		} else {
+			tst_resm(TPASS, "modify_ldt() tested success");
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	ptr = SAFE_MALLOC(cleanup, bytecount);
+}
+
+static void cleanup(void)
+{
+	free(ptr);
+
+	TEST_CLEANUP;
+}
+
+#elif HAVE_MODIFY_LDT
+
+int main(void)
+{
+	tst_resm(TCONF,
+		 "modify_ldt is available but not tested on the platform than "
+		 "__i386__");
+	tst_exit();
+}
+
+#else /* if defined(__i386__) */
+
+int main(void)
+{
+	tst_resm(TINFO, "modify_ldt03 test only for ix86");
+	tst_exit();
+}
+
+#endif /* if defined(__i386__) */
-- 
1.8.4.2




------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
