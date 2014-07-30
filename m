Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XCLE1-0008WF-31
	for ltp-list@lists.sourceforge.net; Wed, 30 Jul 2014 04:10:49 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XCLDy-0008VV-Ku
	for ltp-list@lists.sourceforge.net; Wed, 30 Jul 2014 04:10:49 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6U4AZXp014362
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Jul 2014 12:10:35 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 30 Jul 2014 12:09:39 +0800
Message-ID: <1406693380-30287-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <53D8631F.1000105@cn.fujitsu.com>
References: <53D8631F.1000105@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] lib/tst_tmpdir.c: use tst_resm() instead of
	tst_brkm() in tmpdir_cleanup()
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

In tst_tmpdir(), it will call tst_brkm() with tmpdir_cleanup() as cleanup func,
but tmpdir_cleanup also() calls tst_brkm(), this will result in stack overflow
finally, and also print too much noise about SIGABRT is caught(see abort() in
tst_brkm_()), fix this.

Steps to reproduce this issue:
1. cd testcases/kernel/syscalls/access
2. mkdir testdir
3. su another_user
4. export TMPDIR=testdir
5. ./access05

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 lib/tst_tmpdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 600d178..8cbd89c 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -236,7 +236,7 @@ void tst_rmdir(void)
  */
 static void tmpdir_cleanup(void)
 {
-	tst_brkm(TWARN, NULL,
+	tst_resm(TWARN,
 		 "%s: no user cleanup function called before exiting",
 		 __func__);
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
