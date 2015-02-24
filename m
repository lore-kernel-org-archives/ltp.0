Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YQAEV-0003oH-2s
	for ltp-list@lists.sourceforge.net; Tue, 24 Feb 2015 07:48:43 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YQAES-0001p9-NI
	for ltp-list@lists.sourceforge.net; Tue, 24 Feb 2015 07:48:43 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t1O7le9W026854
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Feb 2015 15:47:41 +0800
Message-ID: <1424764001.2546.15.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 24 Feb 2015 15:46:41 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] gethostbyname_r01: check whether a system is
 vulnerable or not.
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

From c75e5278e03608b96466428b597e3fed14bd9f11 Mon Sep 17 00:00:00 2001
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 24 Feb 2015 15:27:25 +0800
Subject: [PATCH] gethostbyname_r01: check whether a system is vulnerable or
 not.

Qualys security researchers discovered a serious weakness in the Linux glibc
library:
https://www.qualys.com/research/security-advisories/GHOST-CVE-2015-0235.txt

We write this test to check wherher a system is vulnerable or not.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 testcases/kernel/syscalls/gethostbyname_r/Makefile |  19 ++++
 .../syscalls/gethostbyname_r/gethostbyname_r01.c   | 102 +++++++++++++++++++++
 4 files changed, 124 insertions(+)
 create mode 100644 testcases/kernel/syscalls/gethostbyname_r/Makefile
 create mode 100644 testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2d65338..ca32937 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -361,6 +361,8 @@ getgroups01_16 getgroups01_16
 getgroups03 getgroups03
 getgroups03_16 getgroups03_16
 
+gethostbyname_r01 gethostbyname_r01
+
 gethostid01 gethostid01
 
 gethostname01 gethostname01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 98884be..5780e45 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -304,6 +304,7 @@
 /getgroups/getgroups03_16
 /getgroups/getgroups04
 /getgroups/getgroups04_16
+/gethostbyname_r/gethostbyname_r01
 /gethostid/gethostid01
 /gethostname/gethostname01
 /getitimer/getitimer01
diff --git a/testcases/kernel/syscalls/gethostbyname_r/Makefile b/testcases/kernel/syscalls/gethostbyname_r/Makefile
new file mode 100644
index 0000000..2a423d1
--- /dev/null
+++ b/testcases/kernel/syscalls/gethostbyname_r/Makefile
@@ -0,0 +1,19 @@
+#
+#  Copyright (c) 2015 Fujitsu Ltd.
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c b/testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c
new file mode 100644
index 0000000..cb638fb
--- /dev/null
+++ b/testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c
@@ -0,0 +1,102 @@
+/*
+ *   Copyright (c) 2015 Fujitsu Ltd.
+ *   Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
+ */
+
+/*
+ * This is a test for glibc bug:
+ * https://www.qualys.com/research/security-advisories/GHOST-CVE-2015-0235.txt
+ */
+
+#include <netdb.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include "test.h"
+
+#define CANARY "in_the_coal_mine"
+
+static void setup(void);
+static void cleanup(void);
+static void check_vulnerable(void);
+
+static struct {
+	char buffer[1024];
+	char canary[sizeof(CANARY)];
+} temp = {
+	"buffer",
+	CANARY,
+};
+
+char *TCID = "gethostbyname_r01";
+int TST_TOTAL = 1;
+
+int main(int ac, char **av)
+{
+	int lc;
+	const char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		check_vulnerable();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, NULL);
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+}
+
+static void check_vulnerable(void)
+{
+	struct hostent resbuf;
+	struct hostent *result;
+	int herrno;
+	int retval;
+	char name[sizeof(temp.buffer)];
+	size_t len;
+
+	len = sizeof(temp.buffer) - 16 - 2 * sizeof(char *) - 1;
+	memset(name, '0', len);
+	name[len] = '\0';
+
+	retval = gethostbyname_r(name, &resbuf, temp.buffer,
+				 sizeof(temp.buffer), &result, &herrno);
+
+	if (strcmp(temp.canary, CANARY) != 0) {
+		tst_resm(TFAIL, "vulnerable");
+		return;
+	}
+
+	if (retval == ERANGE) {
+		tst_resm(TPASS, "not vulnerable");
+		return;
+	}
+
+	tst_resm(TFAIL, "should not happen");
+}
-- 
1.9.3




------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
