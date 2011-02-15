Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1PpHFW-00039a-HB
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 09:31:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PpHFU-0000g7-Qo
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 09:31:10 +0000
Message-ID: <4D5A47E5.3060108@cn.fujitsu.com>
Date: Tue, 15 Feb 2011 17:31:17 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] unshare01.c: TEST_RETURN is used wrong
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/syscalls/unshare/unshare01.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
index e19d73d..9ae5e8f 100644
--- a/testcases/kernel/syscalls/unshare/unshare01.c
+++ b/testcases/kernel/syscalls/unshare/unshare01.c
@@ -206,7 +206,7 @@ int main(int ac, char **av) {
 			}
 
 			pid1 = fork();
-			if (TEST_RETURN == -1) {
+			if (pid1 == -1) {
 				tst_brkm(TFAIL|TERRNO, cleanup,
 				    "fork failed");
 			} else if (pid1 == 0) {
@@ -249,7 +249,7 @@ int main(int ac, char **av) {
 			if (pid1 == -1) {
 				tst_brkm(TFAIL|TERRNO, cleanup,
 				    "fork() failed.");
-			} else if (TEST_RETURN == 0) {
+			} else if (pid1 == 0) {
 				TEST(unshare(CLONE_NEWNS));
 				if (TEST_RETURN == 0) {
 					printf("unshare call with CLONE_NEWNS "
@@ -299,4 +299,4 @@ int main(void)
 	tst_resm(TCONF, "unshare is undefined.");
 	tst_exit();
 }
-#endif
\ No newline at end of file
+#endif
-- 
1.7.3.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
