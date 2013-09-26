Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mashimiao.fnst@cn.fujitsu.com>) id 1VP86C-0003IN-5u
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 09:43:04 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VP869-00029D-Dv
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 09:43:04 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r8Q9grUr009314
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Sep 2013 17:42:53 +0800
Message-ID: <5244016A.4060300@cn.fujitsu.com>
Date: Thu, 26 Sep 2013 17:42:02 +0800
From: MaShimiao <mashimiao.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH v2] setuid/setuid04.c: Fix a double cleanup() error
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

The cleanup() may be called twice by both the parent and child process
in this testcase leading to a failure.

This patch makes sure cleanup() is called only once by parent process.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Signed-off-by: Ma Shimiao <mashimiao.fnst@cn.fujitsu.com>
---
  testcases/kernel/syscalls/setuid/setuid04.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/setuid/setuid04.c
b/testcases/kernel/syscalls/setuid/setuid04.c
index d8e991e..365859b 100644
--- a/testcases/kernel/syscalls/setuid/setuid04.c
+++ b/testcases/kernel/syscalls/setuid/setuid04.c
@@ -88,7 +88,7 @@ static void do_master_child(void)
  	int pid;
  	int status;

-	if (SETUID(cleanup, ltpuser->pw_uid) == -1) {
+	if (SETUID(NULL, ltpuser->pw_uid) == -1) {
  		tst_brkm(TBROK, NULL,
  			 "setuid failed to set the effective uid to %d",
  			 ltpuser->pw_uid);
-- 1.7.1

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
