Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WShJs-00070B-Vq
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 06:28:13 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WShJr-00075R-5d
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 06:28:12 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2Q6RxBc017942
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 14:27:59 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 26 Mar 2014 14:25:42 +0800
Message-Id: <1395815142-3990-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] fork/fork14.c: cleanup
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
To: ltp-list@lists.sourceforge.net

If mmap() in fork_test() fails too many times, make this test return
TCONF, because in this condition, we are almost impossible to get an
vm_area_struct sized 16TB, that is though this bug may exist, the
overflow would not occur.

According to this url:
http://lkml.iu.edu//hypermail/linux/kernel/1204.3/00416.html, which
also attached a reproducer program, make some code logic adjustments.
If at the beginning, as the program continues to mmap, the fork will
fail. And it continues to mmap, if at some point, fork() returns
success, then we can say the overflow occurs.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fork/fork14.c | 61 +++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
index 413f577..0d43506 100644
--- a/testcases/kernel/syscalls/fork/fork14.c
+++ b/testcases/kernel/syscalls/fork/fork14.c
@@ -35,6 +35,7 @@
 #include <unistd.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 char *TCID = "fork14";
 int TST_TOTAL = 1;
@@ -45,13 +46,15 @@ int TST_TOTAL = 1;
 #define LARGE		(16 * 1024)
 #define EXTENT		(16 * 1024 + 10)
 
+static char **pointer_vec;
+
 static void setup(void);
 static void cleanup(void);
 static int  fork_test(void);
 
 int main(int ac, char **av)
 {
-	int lc, ret;
+	int lc, reproduced;
 	char *msg;
 
 	msg = parse_opts(ac, av, NULL, NULL);
@@ -68,8 +71,8 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		ret = fork_test();
-		if (ret == 0)
+		reproduced = fork_test();
+		if (reproduced == 0)
 			tst_resm(TPASS, "fork failed as expected.");
 	}
 	cleanup();
@@ -80,6 +83,8 @@ static void setup(void)
 {
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
+
+	pointer_vec = SAFE_MALLOC(cleanup, EXTENT * sizeof(char *));
 }
 
 static void cleanup(void)
@@ -89,27 +94,53 @@ static void cleanup(void)
 
 static int fork_test(void)
 {
-	int i, ret = 0;
+	int i, j, prev_failed = 0, fails = 0;
+	int reproduced = 0;
+	void *addr;
 
 	for (i = 0; i < EXTENT; i++) {
-		mmap(NULL, 1 * GB, PROT_READ | PROT_WRITE,
-		     MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-		switch (fork()) {
+		addr = mmap(NULL, 1 * GB, PROT_READ | PROT_WRITE,
+			    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+		if (addr == MAP_FAILED) {
+			pointer_vec[i] = 0;
+			fails++;
+			/*
+			 * EXTENT is "16*1024+10", if fails count exceeds 10,
+			 * we are almost impossible to get an vm_area_struct
+			 * sized 16TB
+			 */
+			if (fails == 11) {
+				tst_brkm(TCONF, cleanup, "mmap() fails too many"
+					 "times, so we are almost impossible to"
+					 " get an vm_area_struct sized 16TB.");
+			}
+		} else {
+			pointer_vec[i] = addr;
+		}
+
+		switch (tst_fork()) {
 		case -1:
-			break;
+			prev_failed = 1;
+		break;
 		case 0:
 			exit(0);
 		default:
 			if (waitpid(-1, NULL, 0) == -1)
-				tst_brkm(TBROK|TERRNO,
-					cleanup, "waitpid");
+				tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
 
-			if (i >= LARGE) {
-				tst_brkm(TFAIL, NULL,
-					"Fork succeeds incorrectly");
-				ret++;
+			if (prev_failed > 0 && i >= LARGE) {
+				tst_resm(TFAIL, "Fork succeeds incorrectly");
+				reproduced = 1;
+				goto clear_memory_map;
 			}
 		}
 	}
-	return ret;
+
+clear_memory_map:
+	for (j = 0; j <= i; j++) {
+		if (pointer_vec[j])
+			SAFE_MUNMAP(cleanup, pointer_vec[j], 1 * GB);
+	}
+
+	return reproduced;
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
