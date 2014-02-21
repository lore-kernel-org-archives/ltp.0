Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WGnFB-0002AG-Ip
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 10:22:09 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGnF9-0008By-GR
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 10:22:09 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1LALxWK001380
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 18:21:59 +0800
From: Gu Xing <gux.fnst@cn.fujitsu.com>
Date: Fri, 21 Feb 2014 18:22:29 +0800
Message-Id: <1392978149-10836-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] mprotect/mprotect04.c: add PROT_NONE,
	PROT_EXEC flag test
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

create a new case to test PROT_NONE, PROT_EXEC flag for mprotect(2)

Signed-off-by: Gu Xing <gux.fnst@cn.fujitsu.com>
---
 runtest/ltplite                                 |   1 +
 runtest/stress.part3                            |   1 +
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/.gitignore            |   1 +
 testcases/kernel/syscalls/mprotect/mprotect04.c | 204 ++++++++++++++++++++++++
 5 files changed, 208 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mprotect/mprotect04.c

diff --git a/runtest/ltplite b/runtest/ltplite
index c6d647d..a9686a0 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -463,6 +463,7 @@ modify_ldt02 modify_ldt02
 mprotect01 mprotect01
 mprotect02 mprotect02
 mprotect03 mprotect03
+mprotect04 mprotect04
 
 mremap01 mremap01
 mremap02 mremap02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index b9b8d7a..6f521cf 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -386,6 +386,7 @@ modify_ldt02 modify_ldt02
 mprotect01 mprotect01
 mprotect02 mprotect02
 mprotect03 mprotect03
+mprotect04 mprotect04
 
 mremap01 mremap01
 mremap02 mremap02
diff --git a/runtest/syscalls b/runtest/syscalls
index 13716d7..d803987 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -606,6 +606,7 @@ move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod 04755
 mprotect01 mprotect01
 mprotect02 mprotect02
 mprotect03 mprotect03
+mprotect04 mprotect04
 
 mq_notify01 mq_notify01
 mq_open01 mq_open01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 42b0eed..7642b11 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -550,6 +550,7 @@
 /mprotect/mprotect01
 /mprotect/mprotect02
 /mprotect/mprotect03
+/mprotect/mprotect04
 /mq_notify/mq_notify01
 /mq_open/mq_open01
 /mq_timedreceive/mq_timedreceive01
diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
new file mode 100644
index 0000000..1390175
--- /dev/null
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -0,0 +1,204 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Gu Xing <gux.fnst@cn.fujitsu.com>
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
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+/*
+ * Description:
+ *   Verify that,
+ *   1) mprotect() succeeds to set a region of memory with no access,
+ *      when 'prot' is set to PROT_NONE. An attempt to access the contents
+ *      of the region gives rise to the signal SIGSEGV.
+ *   2) mprotect() succeeds to set a region of memory to be executed, when
+ *      'prot' is set to PROT_EXEC.
+ */
+
+#include <signal.h>
+#include <setjmp.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <bits/wordsize.h>
+#include <stdlib.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+#define TEST_FILE1 "testfile1"
+
+#if __WORDSIZE == 64
+typedef unsigned long long psint_t;
+#else
+typedef unsigned int psint_t;
+#endif
+
+static void sighandler(int sig);
+
+static void setup(void);
+static void cleanup(void);
+
+static void testfunc_protnone(void);
+
+static void exec_func(void);
+static int (*func)(void);
+static void testfunc_protexec(void);
+
+static void (*testfunc[])(void) = { testfunc_protnone, testfunc_protexec };
+
+char *TCID = "mprotect04";
+int TST_TOTAL = ARRAY_SIZE(testfunc);
+
+static int pass;
+static sigjmp_buf env;
+static int page_sz;
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i;
+	char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void sighandler(int sig)
+{
+	if (sig == SIGSEGV) {
+		pass = 1;
+		siglongjmp(env, 1);
+	} else {
+		tst_brkm(TBROK, cleanup, "received an unexpected signal: %d",
+			 sig);
+	}
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, sighandler, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+}
+
+static void testfunc_protnone(void)
+{
+	int fd;
+	int write_sz;
+	const char buf[] = "abcdefghijklmnopqistuvwxyz";
+	char *addr = MAP_FAILED;
+
+	fd = SAFE_OPEN(cleanup, TEST_FILE1, O_RDWR | O_CREAT, 0777);
+
+	page_sz = getpagesize();
+
+	do {
+		if ((size_t)page_sz > strlen(buf))
+			write_sz = strlen(buf);
+		else
+			write_sz = page_sz;
+
+		page_sz -= SAFE_WRITE(cleanup, 1, fd, buf, write_sz);
+
+	} while (page_sz > 0);
+
+	addr = SAFE_MMAP(cleanup, 0, sizeof(buf), PROT_READ | PROT_WRITE,
+			 MAP_SHARED, fd, 0);
+
+	/* Change the protection to NONE. */
+	TEST(mprotect(addr, sizeof(buf), PROT_NONE));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "mprotect failed");
+		goto cleanup_protnone;
+	}
+
+	if (sigsetjmp(env, 1) == 0)
+		addr[0] = 1;
+
+	if (pass)
+		tst_resm(TPASS, "test PROT_NONE for mprotect success");
+	else
+		tst_resm(TFAIL, "test PROT_NONE for mprotect failed");
+
+	pass = 0;
+
+cleanup_protnone:
+	SAFE_MUNMAP(cleanup, addr, sizeof(buf));
+	addr = MAP_FAILED;
+
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void exec_func(void)
+{
+	return;
+}
+
+static void testfunc_protexec(void)
+{
+	psint_t base_func;
+
+	page_sz = getpagesize();
+
+	func = SAFE_MALLOC(cleanup, page_sz);
+
+	bcopy(exec_func, func, page_sz);
+
+	base_func = (psint_t)func & ~(page_sz - 1);
+
+	/* Change the protection to EXEC. */
+	TEST(mprotect((void *)base_func, page_sz, PROT_EXEC));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "mprotect failed");
+		return;
+	}
+
+	if (sigsetjmp(env, 1) == 0)
+		(*func)();
+
+	if (pass)
+		tst_resm(TFAIL, "test PROT_EXEC for mprotect failed");
+	else
+		tst_resm(TPASS, "test PROT_EXEC for mprotect success");
+
+	pass = 0;
+}
+
+static void cleanup(void)
+{
+	tst_rmdir();
+
+	TEST_CLEANUP;
+}
-- 
1.8.3.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
