Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S1zuK-0004Lg-Kk
	for ltp-list@lists.sourceforge.net; Mon, 27 Feb 2012 12:42:24 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S1zuJ-0005C4-Mr
	for ltp-list@lists.sourceforge.net; Mon, 27 Feb 2012 12:42:24 +0000
Received: by pbbrp12 with SMTP id rp12so3167733pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 27 Feb 2012 04:42:17 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Mon, 27 Feb 2012 20:41:23 +0800
Message-Id: <1330346483-12279-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH] mm/oom: add oom control check for memcg
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


upstream commit: 9490ff2 implements OOM notifier using cgroup
notification API, which allows applications to be notified when OOM
happens in memory cgroups. This patch adds oom control checking when
executing oom tests.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 configure.ac                       |    1 +
 testcases/kernel/mem/include/mem.h |    4 +++
 testcases/kernel/mem/lib/mem.c     |   40 +++++++++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0001-mm-oom-add-oom-control-check-for-memcg.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-oom-add-oom-control-check-for-memcg.patch"

diff --git a/configure.ac b/configure.ac
index 1696df0..21b3137 100644
--- a/configure.ac
+++ b/configure.ac
@@ -42,6 +42,7 @@ AC_CHECK_HEADERS([ \
     linux/module.h \
     linux/netlink.h \
     sys/epoll.h \
+    sys/eventfd.h \
     sys/inotify.h \
     sys/jfsdmapi.h \
     sys/prctl.h \
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 4464c29..fe88861 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -25,6 +25,10 @@
 #define PATH_KSM		"/sys/kernel/mm/ksm/"
 #define PATH_SYSVM		"/proc/sys/vm/"
 #define PATH_MEMINFO		"/proc/meminfo"
+#if HAVE_SYS_EVENTFD_H
+#define PATH_OOMCTRL		MEMCG_PATH_NEW "/memory.oom_control"
+#define PATH_EVTCTRL		MEMCG_PATH_NEW "/cgroup.event_control"
+#endif
 
 int opt_num, opt_size, opt_unit;
 char *opt_numstr, *opt_sizestr, *opt_unitstr;
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index a83eef1..876f430 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -1,5 +1,8 @@
 #include "config.h"
 #include <sys/types.h>
+#if HAVE_SYS_EVENTFD_H
+#include <sys/eventfd.h>
+#endif
 #include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
@@ -67,6 +70,28 @@ void oom(int testcase, int mempolicy, int lite)
 	&& HAVE_MPOL_CONSTANTS
 	unsigned long nmask = 2;
 #endif
+#if HAVE_SYS_EVENTFD_H
+	int efd = 0, ofd = 0;
+	char buf[BUFSIZ];
+	uint64_t u;
+#endif
+
+#if HAVE_SYS_EVENTFD_H
+	if (path_exist(PATH_OOMCTRL) && path_exist(PATH_EVTCTRL)) {
+		efd = eventfd(0, 0);
+		if (efd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "eventfd");
+		ofd = open(PATH_OOMCTRL, O_RDWR);
+		if (ofd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"open %s", PATH_OOMCTRL);
+		if (write(ofd, "0", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"write %s", PATH_OOMCTRL);
+		snprintf(buf, BUFSIZ, "%d %d", efd, ofd);
+		write_file(PATH_EVTCTRL, buf);
+	}
+#endif
 
 	switch (pid = fork()) {
 	case -1:
@@ -97,6 +122,19 @@ void oom(int testcase, int mempolicy, int lite)
 			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
 				status);
 	}
+#if HAVE_SYS_EVENTFD_H
+	if (path_exist(PATH_OOMCTRL) && path_exist(PATH_EVTCTRL)) {
+		if (read(efd, &u, sizeof(uint64_t)) != sizeof(uint64_t))
+			tst_resm(TFAIL|TERRNO, "fail to receive oom event.");
+		else
+			tst_resm(TINFO, "memcg oom event received %lu.", u);
+
+		if (efd > 0)
+			close(efd);
+		if (ofd > 0)
+			close(ofd);
+	}
+#endif
 }
 
 void testoom(int mempolicy, int lite, int numa)
@@ -737,7 +775,7 @@ long count_numa(long nodes[])
 
 	nnodes = 0;
 	for (i = 0; i <= MAXNODES; i++)
-		if(path_exist(PATH_SYS_SYSTEM "/node/node%d", i))
+		if (path_exist(PATH_SYS_SYSTEM "/node/node%d", i))
 			nodes[nnodes++] = i;
 
 	return nnodes;

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



