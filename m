Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WdHAO-0004oD-1j
	for ltp-list@lists.sourceforge.net; Thu, 24 Apr 2014 10:46:08 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WdHAM-0001fr-C8
	for ltp-list@lists.sourceforge.net; Thu, 24 Apr 2014 10:46:08 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3OAjvMX032525
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Apr 2014 18:45:59 +0800
Message-ID: <1398336339.2318.5.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 24 Apr 2014 18:45:39 +0800
In-Reply-To: <1398336249.2318.3.camel@G08JYZSD130126>
References: <1398336249.2318.3.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] setegid/setegid02.c: add EPERM errno test
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

Add EPERM errno test for setegid(2).

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                               |  1 +
 runtest/stress.part3                          |  1 +
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/.gitignore          |  1 +
 testcases/kernel/syscalls/setegid/setegid02.c | 99 +++++++++++++++++++++++++++
 5 files changed, 103 insertions(+)
 create mode 100644 testcases/kernel/syscalls/setegid/setegid02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index ebe171e..597304d 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -733,6 +733,7 @@ setgid02 setgid02
 setgid03 setgid03
 
 setegid01 setegid01
+setegid02 setegid02
 
 setgroups01 setgroups01
 setgroups02 setgroups02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index b21e44b..c52755e 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -637,6 +637,7 @@ setgid02 setgid02
 setgid03 setgid03
 
 setegid01 setegid01
+setegid02 setegid02
 
 setgroups01 setgroups01
 setgroups02 setgroups02
diff --git a/runtest/syscalls b/runtest/syscalls
index fb3e59f..75ff60b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -974,6 +974,7 @@ setgid03 setgid03
 setgid03_16 setgid03_16
 
 setegid01 setegid01
+setegid02 setegid02
 
 sgetmask01 sgetmask01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d5c7bac..4a7cbc7 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -756,6 +756,7 @@
 /setdomainname/setdomainname02
 /setdomainname/setdomainname03
 /setegid/setegid01
+/setegid/setegid02
 /setfsgid/setfsgid01
 /setfsgid/setfsgid01_16
 /setfsgid/setfsgid02
diff --git a/testcases/kernel/syscalls/setegid/setegid02.c b/testcases/kernel/syscalls/setegid/setegid02.c
new file mode 100644
index 0000000..08a287f
--- /dev/null
+++ b/testcases/kernel/syscalls/setegid/setegid02.c
@@ -0,0 +1,99 @@
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
+ *	The calling process is not privileged and euid is not appropriate,
+ *	EPERM should return.
+ */
+
+#include <errno.h>
+#include <pwd.h>
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+char *TCID = "setegid02";
+int TST_TOTAL = 1;
+
+static int exp_enos[] = { EPERM, 0 };
+static void setup(void);
+static void setegid_verify(void);
+static void cleanup(void);
+
+static struct passwd *ltpuser;
+
+int main(int argc, char *argv[])
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
+		tst_count = 0;
+		setegid_verify();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+
+	TEST_EXP_ENOS(exp_enos);
+}
+
+static void setegid_verify(void)
+{
+	TEST(setegid(ltpuser->pw_gid));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "setegid(%d) succeeded unexpectedly",
+			 ltpuser->pw_gid);
+		return;
+	}
+
+	if (TEST_ERRNO == EPERM) {
+		tst_resm(TPASS | TTERRNO, "setegid failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "setegid failed unexpectedly; expected: %d - %s",
+			 EPERM, strerror(EPERM));
+	}
+}
+
+static void cleanup(void)
+{
+	if (seteuid(0) < 0)
+		tst_resm(TWARN | TERRNO, "seteuid failed");
+
+	TEST_CLEANUP;
+}
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
