Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WI7vS-0007ES-Mt
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 02:39:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WI7vR-0001k9-0e
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 02:39:18 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1P2d9qI011227
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Feb 2014 10:39:09 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 25 Feb 2014 10:37:39 +0800
Message-Id: <1393295859-10240-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] llseek/llseek03.c: cleanup
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

Remove the meaningless code using strcpy in setup() and
fix some output messages.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/llseek/llseek03.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/llseek/llseek03.c b/testcases/kernel/syscalls/llseek/llseek03.c
index 02f5d95..8ab2899 100644
--- a/testcases/kernel/syscalls/llseek/llseek03.c
+++ b/testcases/kernel/syscalls/llseek/llseek03.c
@@ -85,7 +85,6 @@ int main(int ac, char **av)
 static void setup(void)
 {
 	int fd;
-	char write_buf[BUFSIZ];
 	struct stat stat_buf;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
@@ -94,12 +93,10 @@ static void setup(void)
 
 	TEST_PAUSE;
 
-	if (strcpy(write_buf, "abcdefgh") != write_buf)
-		tst_brkm(TBROK | TERRNO, NULL, "strcpy failed");
-
 	fd = SAFE_CREAT(cleanup, TEST_FILE, 0644);
 
-	SAFE_WRITE(cleanup, 1, fd, write_buf, strlen(write_buf));
+	#define STR "abcdefgh"
+	SAFE_WRITE(cleanup, 1, fd, STR, sizeof(STR) - 1);
 
 	SAFE_FSTAT(cleanup, fd, &stat_buf);
 
@@ -137,7 +134,7 @@ static void testfunc_seekcur(void)
 	SAFE_READ(cleanup, 1, fd, read_buf, 3);
 
 	if (strcmp(read_buf, "fgh"))
-		tst_resm(TFAIL, "test SEEK_SET for llseek failed");
+		tst_resm(TFAIL, "Read wrong bytes after llseek");
 	else
 		tst_resm(TPASS, "test SEEK_SET for llseek success");
 
@@ -162,7 +159,7 @@ static void testfunc_seekend(void)
 		goto cleanup_seekend;
 	}
 
-	if (TEST_RETURN != file_size) {
+	if (TEST_RETURN != (long)file_size) {
 		tst_resm(TFAIL, "llseek return a incorrect file offset");
 		goto cleanup_seekend;
 	}
@@ -171,7 +168,7 @@ static void testfunc_seekend(void)
 
 	nread = SAFE_READ(cleanup, 0, fd, read_buf, file_size);
 	if (nread > 0)
-		tst_resm(TFAIL, "test SEEK_END for llseek failed");
+		tst_resm(TFAIL, "Read bytes after llseek to end of file");
 	else
 		tst_resm(TPASS, "test SEEK_END for llseek success");
 
-- 
1.8.2.1


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
