Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Wxt8U-0001OX-HI
	for ltp-list@lists.sourceforge.net; Fri, 20 Jun 2014 07:21:22 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wxt8T-0006EW-1P
	for ltp-list@lists.sourceforge.net; Fri, 20 Jun 2014 07:21:22 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5K7LDgv003240
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Jun 2014 15:21:13 +0800
Message-ID: <1403248838.26126.1.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 20 Jun 2014 15:20:38 +0800
In-Reply-To: <1403248796.26126.0.camel@G08JYZSD130126>
References: <1403248796.26126.0.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] wait/wait01.c: Add ECHILD test
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

Add ECHILD test for wait(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                         |  1 +
 runtest/stress.part3                    |  1 +
 runtest/syscalls                        |  1 +
 testcases/kernel/syscalls/.gitignore    |  1 +
 testcases/kernel/syscalls/wait/wait01.c | 85 +++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/syscalls/wait/wait01.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 939ea35..37e3119 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -979,6 +979,7 @@ vfork02 vfork02
 vhangup01 vhangup01
 vhangup02 vhangup02
 
+wait01 wait01
 wait02 wait02
 
 wait401 wait401
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 2b05363..254f77d 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -857,6 +857,7 @@ vfork02 vfork02
 vhangup01 vhangup01
 vhangup02 vhangup02
 
+wait01 wait01
 wait02 wait02
 
 wait401 wait401
diff --git a/runtest/syscalls b/runtest/syscalls
index adefa49..fd22b3c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1325,6 +1325,7 @@ vhangup02 vhangup02
 #vmsplice test cases
 vmsplice01 vmsplice01
 
+wait01 wait01
 wait02 wait02
 
 wait401 wait401
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 252e3c8..7fbe226 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1005,6 +1005,7 @@
 /vhangup/vhangup01
 /vhangup/vhangup02
 /vmsplice/vmsplice01
+/wait/wait01
 /wait/wait02
 /wait4/wait401
 /wait4/wait402
diff --git a/testcases/kernel/syscalls/wait/wait01.c b/testcases/kernel/syscalls/wait/wait01.c
new file mode 100644
index 0000000..69d91ae
--- /dev/null
+++ b/testcases/kernel/syscalls/wait/wait01.c
@@ -0,0 +1,85 @@
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
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+/*
+ * Test Description:
+ *  Verify that,
+ *	The calling process does not have any unwaited-for children,
+ *	ECHILD would return.
+ */
+
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "wait01";
+int TST_TOTAL = 1;
+static void setup(void);
+static void wait_verify(void);
+static void cleanup(void);
+
+int main(int argc, char **argv)
+{
+	int lc;
+	const char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		wait_verify();
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
+}
+
+static void wait_verify(void)
+{
+	TEST(wait(NULL));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL | TTERRNO, "wait failed unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == ECHILD) {
+		tst_resm(TPASS | TTERRNO, "wait failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "wait failed unexpectedly; expected: %d - %s",
+			 ECHILD, strerror(ECHILD));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
-- 
1.9.3




------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
