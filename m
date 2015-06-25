Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Z7y9q-00062U-5I
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 03:48:58 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z7y9k-0003LC-Ji
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 03:48:58 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Thu, 25 Jun 2015 05:54:37 -0600
Message-ID: <1435233277-19842-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] userns01: add capability verification
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
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net

A child process has a full set of permitted and effective capabilities,
even though the program was run from an unprivileged account.

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/containers/userns/Makefile   |  2 +-
 testcases/kernel/containers/userns/userns01.c | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/containers/userns/Makefile b/testcases/kernel/containers/userns/Makefile
index 9f67216..20a0677 100644
--- a/testcases/kernel/containers/userns/Makefile
+++ b/testcases/kernel/containers/userns/Makefile
@@ -21,6 +21,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			:= -lclone -lltp
+LDLIBS			:= -lclone -lltp -lcap
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index 9cada5e..ca4815a 100644
--- a/testcases/kernel/containers/userns/userns01.c
+++ b/testcases/kernel/containers/userns/userns01.c
@@ -15,7 +15,9 @@
  * Verify that:
  *  If a user ID has no mapping inside the namespace, user ID and group
  * ID will be the value defined in the file /proc/sys/kernel/overflowuid(65534)
- * and /proc/sys/kernel/overflowgid(65534).
+ * and /proc/sys/kernel/overflowgid(65534). A child process has a full set
+ * of permitted and effective capabilities, even though the program was
+ * run from an unprivileged account.
  */
 
 #define _GNU_SOURCE
@@ -29,6 +31,7 @@
 #include "test.h"
 #include "libclone.h"
 #include "userns_helper.h"
+#include <sys/capability.h>
 #define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
 #define OVERFLOWGIDPATH "/proc/sys/kernel/overflowgid"
 
@@ -43,21 +46,24 @@ static long overflowgid;
  */
 static int child_fn1(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	int exit_val;
+	int exit_val = 0;
 	int uid, gid;
+	cap_t caps;
 
 	uid = geteuid();
 	gid = getegid();
 
 	tst_resm(TINFO, "USERNS test is running in a new user namespace.");
-	if (uid == overflowuid && gid == overflowgid) {
-		printf("Got expected uid and gid\n");
-		exit_val = 0;
-	} else {
+
+	if (uid != overflowuid || gid != overflowgid) {
 		printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
 		exit_val = 1;
 	}
 
+	caps = cap_get_proc();
+	if (strcmp(cap_to_text(caps, NULL), "=ep") != 0)
+		exit_val = 1;
+
 	return exit_val;
 }
 
-- 
1.9.1


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
