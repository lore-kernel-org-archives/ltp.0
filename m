Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VjRBv-0006R0-FB
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 10:08:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VjRBs-00077e-74
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 10:08:55 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rALA8fFq013196
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Nov 2013 18:08:44 +0800
Message-ID: <1385028516.1552.2.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Thu, 21 Nov 2013 18:08:36 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] clock_getres/clock_getres01.c: add new clockids
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

add new clockids: CLOCK_MONOTONIC_RAW CLOCK_REALTIME_COARSE
CLOCK_MONOTONIC_COARSE CLOCK_BOOTTIME

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/clock_getres/clock_getres01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index 4df6d87..a53728d 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -75,6 +75,10 @@ static struct test_case {
 	{"THREAD_CPUTIME_ID", CLOCK_THREAD_CPUTIME_ID, NORMAL, 0, 0},
 	{"-1", -1, NORMAL, -1, EINVAL},
 	{"REALTIME", CLOCK_REALTIME, NULL_POINTER, 0, 0},
+	{"CLOCK_MONOTONIC_RAW", CLOCK_MONOTONIC_RAW, NORMAL, 0, 0,},
+	{"CLOCK_REALTIME_COARSE", CLOCK_REALTIME_COARSE, NORMAL, 0, 0,},
+	{"CLOCK_MONOTONIC_COARSE", CLOCK_MONOTONIC_COARSE, NORMAL, 0, 0,},
+	{"CLOCK_BOOTTIME", CLOCK_BOOTTIME, NORMAL, 0, 0,},
 };
 
 static void setup(void);
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
