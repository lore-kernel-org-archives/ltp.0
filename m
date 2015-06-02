Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1YzbXz-0004jb-Sh
	for ltp-list@lists.sourceforge.net; Tue, 02 Jun 2015 02:03:19 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YzbXx-0005rO-4i
	for ltp-list@lists.sourceforge.net; Tue, 02 Jun 2015 02:03:19 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Tue, 2 Jun 2015 04:03:33 -0600
Message-ID: <1433239413-6032-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Use the value of /proc/sys/kernel/overflowgid as
	overflowgid.
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
 testcases/kernel/containers/userns/userns01.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index 8c45774..15cde43 100644
--- a/testcases/kernel/containers/userns/userns01.c
+++ b/testcases/kernel/containers/userns/userns01.c
@@ -14,7 +14,8 @@
 /*
  * Verify that:
  *  If a user ID has no mapping inside the namespace, user ID and group
- * ID will be the value defined in the file /proc/sys/kernel/overflowuid, 65534.
+ * ID will be the value defined in the file /proc/sys/kernel/overflowuid(65534)
+ * and /proc/sys/kernel/overflowgid(65534).
  */
 
 #define _GNU_SOURCE
@@ -29,12 +30,14 @@
 #include "libclone.h"
 #include "userns_helper.h"
 #define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
+#define OVERFLOWGIDPATH "/proc/sys/kernel/overflowgid"
 
 char *TCID = "user_namespace1";
 int TST_TOTAL = 1;
 
 char fullpath[BUFSIZ];
 long overflowuid;
+long overflowgid;
 
 /*
  * child_fn1() - Inside a new user namespace
@@ -48,7 +51,7 @@ static int child_fn1(void *arg)
 	gid = getegid();
 
 	tst_resm(TINFO, "USERNS test is running in a new user namespace.");
-	if (uid == overflowuid && gid == overflowuid) {
+	if (uid == overflowuid && gid == overflowgid) {
 		printf("Got expected uid and gid\n");
 		exit_val = 0;
 	} else {
@@ -63,6 +66,7 @@ static void setup(void)
 {
 	check_newuser();
 	SAFE_FILE_SCANF(NULL, OVERFLOWUIDPATH, "%ld", &overflowuid);
+	SAFE_FILE_SCANF(NULL, OVERFLOWGIDPATH, "%ld", &overflowgid);
 }
 
 int main(int argc, char *argv[])
-- 
1.9.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
