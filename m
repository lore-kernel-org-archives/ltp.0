Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1V6AKb-0001l7-7K
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 02:15:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V6AKa-0004u5-5d
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 02:15:33 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r752FOvo003175
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Aug 2013 10:15:24 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Date: Mon, 5 Aug 2013 10:15:23 +0800
Message-Id: <1375668923-15593-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: [LTP] [PATCH] sigaction:16-1: leave it untested on the Linux kernel
	less than 2.6.22
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
To: LTP <ltp-list@lists.sourceforge.net>

As the Linux signal(7) said:
POSIX semaphore interfaces: sem_wait(3) and sem_timedwait(3) (since Linux 2.6.22; beforehand, always failed with EINTR).

So, on linux, we just leave this untested when the kernel version
is less than 2.6.22.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 .../conformance/interfaces/sigaction/16-1.c        |  6 +++
 testcases/open_posix_testsuite/include/kvercmp.h   | 56 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 testcases/open_posix_testsuite/include/kvercmp.h

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
index 530b5b6..8241246 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
@@ -39,6 +39,7 @@
 #include <signal.h>
 #include <errno.h>
 #include <posixtest.h>
+#include "kvercmp.h"
 
 /*
  * Define an array of signals we want to test against.
@@ -215,6 +216,11 @@ int main(void)
 	struct sigaction sa;
 	struct sigaction sa_org;
 
+#ifdef __linux__
+	if (tst_kvercmp(2, 6, 22) < 0)
+		return PTS_UNTESTED;
+#endif
+
 	sa.sa_flags = SA_RESTART;
 	sa.sa_handler = handler;
 
diff --git a/testcases/open_posix_testsuite/include/kvercmp.h b/testcases/open_posix_testsuite/include/kvercmp.h
new file mode 100644
index 0000000..688e34a
--- /dev/null
+++ b/testcases/open_posix_testsuite/include/kvercmp.h
@@ -0,0 +1,56 @@
+/*
+ *   Copyright (c) 2003 International Business Machines  Corp.
+ *   Copyright (c) 2013 Fujitsu Ltd.
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms in version 2 of the GNU General Public License as
+ *   published by the Free Software Foundation.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ */
+
+#ifdef __linux__
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/utsname.h>
+
+static void get_kver(int *k1, int *k2, int *k3)
+{
+	struct utsname uval;
+	char *kver;
+	char *r1, *r2, *r3;
+	extern char *strsep();
+
+	uname(&uval);
+	kver = uval.release;
+	r1 = strsep(&kver, ".");
+	r2 = strsep(&kver, ".");
+	r3 = strsep(&kver, ".");
+
+	*k1 = atoi(r1);
+	*k2 = atoi(r2);
+	*k3 = atoi(r3);
+}
+
+static int tst_kvercmp(int r1, int r2, int r3)
+{
+	int a1, a2, a3;
+	int testver, currver;
+
+	get_kver(&a1, &a2, &a3);
+	testver = (r1 << 16) + (r2 << 8) + r3;
+	currver = (a1 << 16) + (a2 << 8) + a3;
+
+	return currver - testver;
+}
+#endif
-- 
1.8.4.rc0.11.g35f5eaa


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
