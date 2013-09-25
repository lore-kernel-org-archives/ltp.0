Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mashimiao.fnst@cn.fujitsu.com>) id 1VOl5p-0003ms-AP
	for ltp-list@lists.sourceforge.net; Wed, 25 Sep 2013 09:09:09 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VOl5n-00025R-Fc
	for ltp-list@lists.sourceforge.net; Wed, 25 Sep 2013 09:09:09 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r8P98xmf015674
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Sep 2013 17:08:59 +0800
Message-ID: <5242A7F9.2030105@cn.fujitsu.com>
Date: Wed, 25 Sep 2013 17:08:09 +0800
From: MaShimiao <mashimiao.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] setuid/setuid04.c: Fix a double cleanup() error
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
Cc: zenglg.jy@cn.fujitsu.com

On some systems which do not support 16-bit version syscall,
the cleanup() will be called twice in this case leading to
a case failure.

This patch makes sure calling tst_rmdir() only when the temp dir
still exists.

Signed-off-by: Ma Shimiao <mashimiao.fnst@cn.fujitsu.com>
Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
  testcases/kernel/syscalls/setuid/setuid04.c |    6 +++++-
  1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/setuid/setuid04.c b/testcases/kernel/syscalls/setuid/setuid04.c
index d8e991e..4f2cabd 100644
--- a/testcases/kernel/syscalls/setuid/setuid04.c
+++ b/testcases/kernel/syscalls/setuid/setuid04.c
@@ -175,7 +175,11 @@ static void setup(void)
  
  static void cleanup(void)
  {
+	char *tmpdir;
  	close(fd);
-	tst_rmdir();
+	tmpdir = get_tst_tmpdir();
+	if (!access(tmpdir, F_OK))
+		tst_rmdir();
+	free(tmpdir);
  	TEST_CLEANUP;
  }
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
