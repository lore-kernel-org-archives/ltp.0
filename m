Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZA9Yy-0000j1-Ct
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 04:23:56 +0000
Received: from [119.145.14.65] (helo=szxga02-in.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZA9Yr-00011e-UE
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 04:23:56 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Wed, 1 Jul 2015 12:22:45 +0800
Message-ID: <1435724565-19631-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH V2] userns01: add capability verification
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

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/containers/userns/Makefile   |  2 +-
 testcases/kernel/containers/userns/userns01.c | 31 +++++++++++++++++++++------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/containers/userns/Makefile b/testcases/kernel/containers/userns/Makefile
index 9f67216..8370bff 100644
--- a/testcases/kernel/containers/userns/Makefile
+++ b/testcases/kernel/containers/userns/Makefile
@@ -21,6 +21,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			:= -lclone -lltp
+LDLIBS			:= -lclone -lltp $(CAP_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index 9cada5e..a9012ac 100644
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
@@ -29,6 +31,12 @@
 #include "test.h"
 #include "libclone.h"
 #include "userns_helper.h"
+#include "config.h"
+#if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
+#include <sys/capability.h>
+#endif
+
 #define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
 #define OVERFLOWGIDPATH "/proc/sys/kernel/overflowgid"
 
@@ -43,21 +51,30 @@ static long overflowgid;
  */
 static int child_fn1(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	int exit_val;
+	int exit_val = 0;
 	int uid, gid;
+#ifdef HAVE_LIBCAP
+	cap_t caps, expectedcaps;
+#endif
 
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
 
+#ifdef HAVE_LIBCAP
+	caps = cap_get_proc();
+	expectedcaps = cap_from_text("=ep");
+	if (cap_compare(caps, expectedcaps) != 0)
+		exit_val = 1;
+#else
+	printf("System doesn't support capabilities.\n");
+#endif
 	return exit_val;
 }
 
@@ -96,3 +113,5 @@ int main(int argc, char *argv[])
 	tst_exit();
 }
 
+
+
-- 
1.9.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
