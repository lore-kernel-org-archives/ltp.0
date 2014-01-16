Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1W3kAQ-0008Ck-Vi
	for ltp-list@lists.sourceforge.net; Thu, 16 Jan 2014 10:27:19 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W3kAP-0000uS-2H
	for ltp-list@lists.sourceforge.net; Thu, 16 Jan 2014 10:27:18 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0GAR80j022676
	for <ltp-list@lists.sourceforge.net>; Thu, 16 Jan 2014 18:27:08 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 16 Jan 2014 18:26:04 +0800
Message-Id: <1389867964-8072-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] madvise/madvise02.c: extend EINVAL test for
	MADV_MERGEABLE and MADV_UNMERGEABLE advice
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/madvise/madvise02.c | 38 ++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index e7f4656..08ed717 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -27,6 +27,8 @@
  *  2. advice is not a valid value
  *  3. application is attempting to release
  *     locked or shared pages (with MADV_DONTNEED)
+ *  4. MADV_MERGEABLE or MADV_UNMERGEABLE was specified in advice,
+ *     but kernel was not configured with CONFIG_KSM
  *
  * (B) Test Case for ENOMEM
  *  4. addresses in the specified range are not currently mapped
@@ -52,9 +54,14 @@
 #include "usctest.h"
 
 #define MM_RLIMIT_RSS 5
+/*
+ * when kernel is 2.6.32 or newer and /sys/kernel/mm/ksm is exist,
+ * we think kernel was configured with CONFIG_KSM.
+ */
+#define KSM_SYS_DIR	"/sys/kernel/mm/ksm"
 
 char *TCID = "madvise02";
-int TST_TOTAL = 7;
+int TST_TOTAL = 8;
 
 static void setup(void);
 static void cleanup(void);
@@ -128,11 +135,34 @@ int main(int argc, char *argv[])
 		TEST(madvise(file, stat.st_size, MADV_DONTNEED));
 		check_and_print(EINVAL);
 
-		if (munmap(file, stat.st_size) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
 #endif /* if !defined(UCLINUX) */
 
+#if defined(MADV_MERGEABLE) && defined(MADV_UNMERGEABLE)
 		/* Test Case 4 */
+		if (tst_kvercmp(2, 6, 32) < 0) {
+			tst_resm(TCONF, "kernel samepage merging (KSM) needs "
+				 "2.6.32 or higher, skip EINVAL test for "
+				 "MADV_MERGEABLE and MADV_UNMERGEABLE.");
+		} else {
+			if (access(KSM_SYS_DIR, F_OK) < 0) {
+				tst_resm(TINFO, "kernel was not configured "
+					 "with CONFIG_KSM");
+
+				TEST(madvise(file, stat.st_size,
+				     MADV_MERGEABLE));
+				check_and_print(EINVAL);
+
+				TEST(madvise(file, stat.st_size,
+				     MADV_UNMERGEABLE));
+				check_and_print(EINVAL);
+			}
+		}
+#endif
+
+		if (munmap(file, stat.st_size) == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
+
+		/* Test Case 5 */
 
 		/* We cannot be sure, which region is mapped, which is
 		 * not, at runtime.
@@ -169,7 +199,7 @@ int main(int argc, char *argv[])
 		TEST(madvise(low, len, MADV_NORMAL));
 		check_and_print(ENOMEM);
 
-		/* Test Case 5 */
+		/* Test Case 6 */
 		/* Unmap the file map from low */
 		if (munmap(low, stat.st_size / 2) < 0)
 			tst_brkm(TBROK | TERRNO, cleanup,
-- 
1.8.2.1


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
