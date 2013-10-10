Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VU9EY-0002N5-DQ
	for ltp-list@lists.sourceforge.net; Thu, 10 Oct 2013 05:56:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VU9EW-0002OW-Ry
	for ltp-list@lists.sourceforge.net; Thu, 10 Oct 2013 05:56:26 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9A5uC42016410
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Oct 2013 13:56:15 +0800
From: =?gb2312?B?1PjB7rjW?= <zenglg.jy@cn.fujitsu.com>
Date: Thu, 10 Oct 2013 13:56:05 +0800
Message-ID: <00ae01cec57d$6b50bbc0$41f23340$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Language: zh-cn
Subject: [LTP] [PATCH] getrusage/getrusage04.c: Fix factor_nr = 1 ->
	factor_nr = 5
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

To make udelta or sdelta's values isnot great than expected,
we change the factor_nr to 5.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getrusage/getrusage04.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c
b/testcases/kernel/syscalls/getrusage/getrusage04.c
index 96e24a4..41d0052 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -67,7 +67,7 @@ static long BIAS_MAX;
 
 static int opt_factor;
 static char *factor_str;
-static long factor_nr = 1;
+static long factor_nr = 5;
 
 option_t child_options[] = {
 	{"m:", &opt_factor, &factor_str},
-- 
1.7.1




------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
