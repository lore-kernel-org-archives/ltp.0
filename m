Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XkAbK-000599-AR
	for ltp-list@lists.sourceforge.net; Fri, 31 Oct 2014 11:42:42 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XkAbI-0004PJ-AD
	for ltp-list@lists.sourceforge.net; Fri, 31 Oct 2014 11:42:42 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s9VBgPKE026452
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Oct 2014 19:42:25 +0800
Message-ID: <1414755673.17402.8.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 31 Oct 2014 19:41:13 +0800
In-Reply-To: <1414755631.17402.7.camel@G08JYZSD130126.localdomain>
References: <1414755631.17402.7.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/3] smack_set_socket_labels.c: Cleanup
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

From 1733e06a8dca828cdd578db589387b83606df7fd Mon Sep 17 00:00:00 2001
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 31 Oct 2014 19:05:19 +0800
Subject: [PATCH] smack_set_socket_labels.c: Cleanup

* Check whether smackfs is set.

* Use 'tst_*'.

* Modify Makefile.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/security/smack/Makefile           |  1 +
 .../security/smack/smack_set_socket_labels.c       | 29 +++++++++++++++-------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/security/smack/Makefile b/testcases/kernel/security/smack/Makefile
index e114998..02f3ec4 100644
--- a/testcases/kernel/security/smack/Makefile
+++ b/testcases/kernel/security/smack/Makefile
@@ -9,6 +9,7 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk
 
 INSTALL_TARGETS		:= *.sh
 
diff --git a/testcases/kernel/security/smack/smack_set_socket_labels.c b/testcases/kernel/security/smack/smack_set_socket_labels.c
index 086e4c8..172ceb2 100644
--- a/testcases/kernel/security/smack/smack_set_socket_labels.c
+++ b/testcases/kernel/security/smack/smack_set_socket_labels.c
@@ -28,6 +28,13 @@
 #endif
 
 #include <sys/xattr.h>
+#include <sys/vfs.h>
+
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "smack_set_socket_labels";
+int TST_TOTAL = 1;
 
 int main(int argc, char *argv[])
 {
@@ -40,35 +47,39 @@ int main(int argc, char *argv[])
 	char *avnot = "TheBadValue";
 	int sock;
 	int rc;
+	char buf[256];
 
 	if ((sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0) {
 		sprintf(message, "%s Socket creation failure", argv[0]);
-		perror(message);
-		exit(1);
+		tst_brkm(TFAIL, NULL, "%s", message);
 	}
 
+	flistxattr(sock, buf, 256);
+	if (strstr(buf, "security.SMACK64") == NULL)
+		tst_brkm(TCONF, NULL, "smackfs not set.");
+
 	rc = fsetxattr(sock, anin, avin, strlen(avin) + 1, 0);
 	if (rc < 0) {
 		sprintf(message, "%s fsetxattr of %s to %s failure",
 			argv[0], anin, avin);
-		perror(message);
-		exit(1);
+		tst_brkm(TFAIL, NULL, "%s", message);
 	}
 
 	rc = fsetxattr(sock, anout, avout, strlen(avout) + 1, 0);
 	if (rc < 0) {
 		sprintf(message, "%s fsetxattr of %s to %s failure",
 			argv[0], anout, avout);
-		perror(message);
-		exit(1);
+		tst_brkm(TFAIL, NULL, "%s", message);
 	}
 
 	rc = fsetxattr(sock, annot, avnot, strlen(avnot) + 1, 0);
 	if (rc >= 0) {
 		sprintf(message, "%s fsetxattr of %s to %s succeeded in error",
 			argv[0], anout, avout);
-		perror(message);
-		exit(1);
+		tst_brkm(TFAIL, NULL, "%s", message);
 	}
-	exit(0);
+
+	tst_resm(TPASS, "Test %s success.", TCID);
+
+	tst_exit();
 }
-- 
1.8.3.1




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
