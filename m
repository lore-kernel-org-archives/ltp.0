Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hong.gyu.kim@lge.com>) id 1VYp0j-00050W-14
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 03:21:29 +0000
Received: from lgemrelse7q.lge.com ([156.147.1.151])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VYp0h-0000GI-E3
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 03:21:28 +0000
From: "Honggyu Kim" <hong.gyu.kim@lge.com>
Date: Wed, 23 Oct 2013 12:21:20 +0900
Message-ID: <010c01cecf9e$f1e915d0$d5bb4170$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Language: ko
Subject: [LTP] [PATCH v2] getcontext01: fix to check libc version for ARM
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
To: ltp-list@lists.sourceforge.net

getcontext function is implemented from libc-2.17 in ARM.
Currently, getcontext01 goes to TFAIL because getcontext just 
returns -1 in the previous libc for ARM.
This patch makes getcontext01 as TCONF when libc version is less 
than 2.17.

lib/tst_libcvercmp.c: a new file for libc version comparison
Comparison code for libc version is added as a library.

Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>
---
 include/test.h                                     |    4 ++
 lib/tst_libcvercmp.c                               |   65
++++++++++++++++++++
 .../kernel/syscalls/getcontext/getcontext01.c      |   16 +++++
 3 files changed, 85 insertions(+)
 create mode 100644 lib/tst_libcvercmp.c

diff --git a/include/test.h b/include/test.h
index d9eba31..47765c2 100644
--- a/include/test.h
+++ b/include/test.h
@@ -180,6 +180,10 @@ struct tst_kern_exv {
 
 int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers);
 
+/* lib/tst_libcvercmp.c */
+const char* tst_getlibcver(void);
+int tst_libcvercmp(const char *tst_exv);
+
 /* lib/tst_is_cwd.c */
 int tst_is_cwd_nfs(void);
 int tst_is_cwd_v9fs(void);
diff --git a/lib/tst_libcvercmp.c b/lib/tst_libcvercmp.c
new file mode 100644
index 0000000..2a09ab8
--- /dev/null
+++ b/lib/tst_libcvercmp.c
@@ -0,0 +1,65 @@
+/*
+ *
+ *   Copyright (c) LG Electronics Corp., 2013
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
02110-1301 USA
+ */
+
+/*
+ *
+ *    AUTHOR
+ *    	Honggyu Kim <hong.gyu.kim@lge.com>
+ *
+ *    DESCRIPTION
+ * 	Compare a given libc version against the current libc version.
+ * 	If they are the same - return 0
+ * 	If the argument is > current libc version - return positive int
+ * 	If the argument is < current libc version - return negative int
+ *
+ */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/utsname.h>
+#include <gnu/libc-version.h>
+#include "test.h"
+
+static int tst_libcexvcmp(const char *tst_exv, const char *cur_ver)
+{
+	int c1 = 0, c2 = 0, c3 = 0;
+	int t1 = 0, t2 = 0, t3 = 0;
+	int ret;
+
+	sscanf(cur_ver, "%d.%d.%d", &c1, &c2, &c3);
+	sscanf(tst_exv, "%d.%d.%d", &t1, &t2, &t3);
+
+	if ((ret = c1 - t1))
+		return ret;
+	if ((ret = c2 - t2))
+		return ret;
+	return c3 - t3;
+}
+
+const char* tst_getlibcver(void)
+{
+	return gnu_get_libc_version();
+}
+
+int tst_libcvercmp(const char *tst_exv)
+{
+	const char* cur_ver = tst_getlibcver();
+	return tst_libcexvcmp(tst_exv, cur_ver);
+}
diff --git a/testcases/kernel/syscalls/getcontext/getcontext01.c
b/testcases/kernel/syscalls/getcontext/getcontext01.c
index 03b2df9..bf994c5 100644
--- a/testcases/kernel/syscalls/getcontext/getcontext01.c
+++ b/testcases/kernel/syscalls/getcontext/getcontext01.c
@@ -54,12 +54,28 @@ int TST_TOTAL = 1;
 
 int exp_enos[] = { 0 };		/* must be a 0 terminated list */
 
+#ifdef __arm__
+#define LIBC_VER_GETCONTEXT_ARM_SUPPORT "2.17"
+#endif
+
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
 
 	ucontext_t ptr;
+
+#ifdef __arm__
+	/* Disable test if the version of the libc is less than 2.17 in ARM
*/
+	if ((tst_libcvercmp(LIBC_VER_GETCONTEXT_ARM_SUPPORT)) < 0) {
+		tst_resm(TCONF, "This test can only run with libc that are
");
+		tst_resm(TCONF, "%s and higher (currently libc-%s used)",
+				LIBC_VER_GETCONTEXT_ARM_SUPPORT,
+				tst_getlibcver());
+		tst_exit();
+	}
+#endif
+
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-- 
1.7.9.5



------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
