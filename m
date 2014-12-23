Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Y3Ls9-0007QB-ET
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:35:21 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y3Lrt-00013x-53
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:35:21 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sBN9XYJC027054
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Dec 2014 17:33:34 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 23 Dec 2014 17:33:41 +0800
Message-ID: <1419327221-28508-12-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 12/12] smack_set_socket_labels.c: Cleanup
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

* Check whether smackfs is set.

* Use 'test.h' and 'tst_*'.

* Modify Makefile.

* Delete 'message'.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/security/smack/Makefile           |  2 +-
 .../security/smack/smack_set_socket_labels.c       | 45 +++++++++++++---------
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/security/smack/Makefile b/testcases/kernel/security/smack/Makefile
index e114998..6d9abfd 100644
--- a/testcases/kernel/security/smack/Makefile
+++ b/testcases/kernel/security/smack/Makefile
@@ -8,7 +8,7 @@
 
 top_srcdir		?= ../../../..
 
-include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk
 
 INSTALL_TARGETS		:= *.sh
 
diff --git a/testcases/kernel/security/smack/smack_set_socket_labels.c b/testcases/kernel/security/smack/smack_set_socket_labels.c
index 086e4c8..df8c637 100644
--- a/testcases/kernel/security/smack/smack_set_socket_labels.c
+++ b/testcases/kernel/security/smack/smack_set_socket_labels.c
@@ -28,10 +28,16 @@
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
-	char message[256];
 	char *anin = "security.SMACK64IPIN";
 	char *anout = "security.SMACK64IPOUT";
 	char *annot = "security.SMACK64IPNOT";
@@ -40,35 +46,36 @@ int main(int argc, char *argv[])
 	char *avnot = "TheBadValue";
 	int sock;
 	int rc;
+	char buf[256];
 
-	if ((sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0) {
-		sprintf(message, "%s Socket creation failure", argv[0]);
-		perror(message);
-		exit(1);
-	}
+	sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (sock = < 0)
+		tst_brkm(TFAIL, NULL, "%s Socket creation failure", argv[0]);
+
+	flistxattr(sock, buf, 256);
+	if (strstr(buf, "security.SMACK64") == NULL)
+		tst_brkm(TCONF, NULL, "smackfs not set.");
 
 	rc = fsetxattr(sock, anin, avin, strlen(avin) + 1, 0);
 	if (rc < 0) {
-		sprintf(message, "%s fsetxattr of %s to %s failure",
-			argv[0], anin, avin);
-		perror(message);
-		exit(1);
+		tst_brkm(TFAIL, NULL, "%s fsetxattr of %s to %s failure",
+			 argv[0], anin, avin);
 	}
 
 	rc = fsetxattr(sock, anout, avout, strlen(avout) + 1, 0);
 	if (rc < 0) {
-		sprintf(message, "%s fsetxattr of %s to %s failure",
-			argv[0], anout, avout);
-		perror(message);
-		exit(1);
+		tst_brkm(TFAIL, NULL, "%s fsetxattr of %s to %s failure",
+			 argv[0], anout, avout);
 	}
 
 	rc = fsetxattr(sock, annot, avnot, strlen(avnot) + 1, 0);
 	if (rc >= 0) {
-		sprintf(message, "%s fsetxattr of %s to %s succeeded in error",
-			argv[0], anout, avout);
-		perror(message);
-		exit(1);
+		tst_brkm(TFAIL, NULL,
+			 "%s fsetxattr of %s to %s succeeded in error",
+			 argv[0], anout, avout);
 	}
-	exit(0);
+
+	tst_resm(TPASS, "Test %s success.", TCID);
+
+	tst_exit();
 }
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
