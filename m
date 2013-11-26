Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VlBLH-0001YK-V2
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 05:37:47 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VlBLG-0006fL-9s
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 05:37:47 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAQ5b4hJ030477
	for <ltp-list@lists.sourceforge.net>; Tue, 26 Nov 2013 13:37:32 +0800
Message-ID: <1385443653.14061.1.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Tue, 26 Nov 2013 13:27:33 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] fchownat/fchownat01.c: add new flag
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

add new flag AT_SYMLINK_NOFOLLOW for fchownat(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fchownat/fchownat01.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index b46a721..97bb9da 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -66,6 +66,8 @@ static char pathname[PATH_MAX+1];
 static char testfile[PATH_MAX+1];
 static char testfile2[PATH_MAX+1];
 static char testfile3[PATH_MAX+1];
+static char testfile7[PATH_MAX+1];
+static char testfile7_tmp[PATH_MAX+1];
 static int dirfd;
 static int fd;
 static int no_fd;
@@ -83,6 +85,7 @@ static struct test_case_t {
 	{EBADF, 0, &no_fd, testfile},
 	{EINVAL, 9999, &dirfd, testfile},
 	{0, 0, &cu_fd, testfile},
+	{0, AT_SYMLINK_NOFOLLOW, &dirfd, testfile7},
 };
 
 char *TCID = "fchownat01";
@@ -155,6 +158,13 @@ void setup()
 	no_fd = 100;
 
 	cu_fd = AT_FDCWD;
+
+	sprintf(testfile7, "fchownattestfile7%d.txt", getpid());
+
+	sprintf(testfile7_tmp, "fchownattestdir%d/fchownattestfile7%d.txt",
+		getpid(), getpid());
+
+	SAFE_SYMLINK(cleanup, testfile3, testfile7_tmp);
 }
 
 void cleanup()
@@ -167,6 +177,8 @@ void cleanup()
 
 	SAFE_UNLINK(NULL, testfile3);
 
+	SAFE_UNLINK(NULL, testfile7_tmp);
+
 	rmdir(pathname);
 
 	TEST_CLEANUP;
-- 
1.8.2.1




------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
