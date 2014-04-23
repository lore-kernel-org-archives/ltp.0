Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WcoFm-0002NW-LY
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 03:53:46 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WcoFh-0006Z3-PS
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 03:53:46 +0000
Message-ID: <1398225176.3850.3.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 23 Apr 2014 11:52:56 +0800
In-Reply-To: <1398225094.3850.1.camel@G08JYZSD130126>
References: <1398159613.2772.7.camel@G08JYZSD130126>
	<1398159660.2772.8.camel@G08JYZSD130126>
	<64087164.7823458.1398172479616.JavaMail.zimbra@redhat.com>
	<1398225094.3850.1.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] sbrk/sbrk02.c: add ENOMEM errno test
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Add ENOMEM errno test for sbrk(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                         |   1 +
 runtest/stress.part3                    |   1 +
 runtest/syscalls                        |   1 +
 testcases/kernel/syscalls/.gitignore    |   1 +
 testcases/kernel/syscalls/sbrk/sbrk02.c | 114 ++++++++++++++++++++++++++++++++
 5 files changed, 118 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sbrk/sbrk02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index ebe171e..26b7753 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -653,6 +653,7 @@ rmdir04 rmdir04
 rmdir05 rmdir05
 
 sbrk01 sbrk01
+sbrk02 sbrk02
 
 sched_get_priority_max01 sched_get_priority_max01
 sched_get_priority_max02 sched_get_priority_max02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index b21e44b..021decf 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -563,6 +563,7 @@ rmdir04 rmdir04
 rmdir05 rmdir05
 
 sbrk01 sbrk01
+sbrk02 sbrk02
 
 sched_get_priority_max01 sched_get_priority_max01
 sched_get_priority_max02 sched_get_priority_max02
diff --git a/runtest/syscalls b/runtest/syscalls
index fb3e59f..3adeb8a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -868,6 +868,7 @@ rt_sigqueueinfo01 rt_sigqueueinfo01
 rt_sigsuspend01 rt_sigsuspend01
 
 sbrk01 sbrk01
+sbrk02 sbrk02
 
 sched_get_priority_max01 sched_get_priority_max01
 sched_get_priority_max02 sched_get_priority_max02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d5c7bac..cd51000 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -706,6 +706,7 @@
 /rt_sigsuspend/rt_sigsuspend01
 /rt_sigtimedwait/rt_sigtimedwait01
 /sbrk/sbrk01
+/sbrk/sbrk02
 /sched_get_priority_max/sched_get_priority_max01
 /sched_get_priority_max/sched_get_priority_max02
 /sched_get_priority_min/sched_get_priority_min01
diff --git a/testcases/kernel/syscalls/sbrk/sbrk02.c b/testcases/kernel/syscalls/sbrk/sbrk02.c
new file mode 100644
index 0000000..8961fa9
--- /dev/null
+++ b/testcases/kernel/syscalls/sbrk/sbrk02.c
@@ -0,0 +1,114 @@
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
+ * DESCRIPTION
+ *	Check sbrk() with error condition that should produce ENOMEM.
+ */
+
+#include <errno.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "sbrk02";
+int TST_TOTAL = 1;
+
+#if !defined(UCLINUX)
+
+static void setup(void);
+static void sbrk_verify(void);
+static void cleanup(void);
+static int exp_enos[] = { ENOMEM, 0 };
+
+static long increment;
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	int i;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++)
+			sbrk_verify();
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
+	for (increment = 16*1024*1024; errno == 0; increment++)
+		sbrk(increment);
+
+	errno = 0;
+
+	TEST_EXP_ENOS(exp_enos);
+}
+
+static void sbrk_verify(void)
+{
+	void *tret;
+
+	tret = sbrk(increment);
+	TEST_ERRNO = errno;
+
+	if (tret != (void *)-1) {
+		tst_resm(TFAIL,
+			 "sbrk(%ld) returned %p, expected (void *)-1, errno=%d",
+			 increment, tret, ENOMEM);
+		return;
+	}
+
+	TEST_ERROR_LOG(TEST_ERRNO);
+
+	if (TEST_ERRNO == ENOMEM) {
+		tst_resm(TPASS | TTERRNO, "sbrk(%ld) failed as expected",
+			 increment);
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "sbrk(%ld) failed unexpectedly; expected: %d - %s",
+			 increment, ENOMEM, strerror(ENOMEM));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
+
+#else
+
+int main(void)
+{
+	tst_resm(TINFO, "test is not available on uClinux");
+	tst_exit();
+}
+
+#endif /* if !defined(UCLINUX) */
-- 
1.8.4.2




------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
