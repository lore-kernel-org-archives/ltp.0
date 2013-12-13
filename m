Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VrRMG-0004Dc-KA
	for ltp-list@lists.sourceforge.net; Fri, 13 Dec 2013 11:56:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VrRMF-00056m-Cn
	for ltp-list@lists.sourceforge.net; Fri, 13 Dec 2013 11:56:40 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBDBuWNL012530
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Dec 2013 19:56:32 +0800
Message-ID: <1386935787.1665.2.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Fri, 13 Dec 2013 19:56:27 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH 2/2] getpeername/getpeername01.c: add EINVAL error
 number test
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

Add EINVAL error number test.

Signed-off-by: Zuo Faqi <zuofq.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getpeername/getpeername01.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getpeername/getpeername01.c b/testcases/kernel/syscalls/getpeername/getpeername01.c
index 7aa72cb..7ed90f2 100644
--- a/testcases/kernel/syscalls/getpeername/getpeername01.c
+++ b/testcases/kernel/syscalls/getpeername/getpeername01.c
@@ -39,6 +39,7 @@
 static struct sockaddr_in server_addr;
 static struct sockaddr_in fsin1;
 static socklen_t sinlen;
+static socklen_t invalid_sinlen;
 static int sv[2];
 
 static void setup(void);
@@ -72,12 +73,14 @@ struct test_case_t {
 	 cleanup4, "EFAULT"},
 	{-1, (struct sockaddr *)&fsin1, (socklen_t *)1, -1, EFAULT, setup4,
 	 cleanup4, "EFAULT"},
+	{-1, (struct sockaddr *)&fsin1, &invalid_sinlen, -1, EINVAL, setup4,
+	 cleanup4, "EINVAL"},
 #endif
 };
 
 char *TCID = "getpeername01";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
-static int exp_enos[] = { EBADF, ENOTSOCK, ENOTCONN, EFAULT, 0 };
+static int exp_enos[] = { EBADF, ENOTSOCK, ENOTCONN, EFAULT, EINVAL, 0 };
 
 int main(int argc, char *argv[])
 {
@@ -141,6 +144,7 @@ static void setup(void)
 	server_addr.sin_addr.s_addr = INADDR_ANY;
 
 	sinlen = sizeof(fsin1);
+	invalid_sinlen = -1;
 }
 
 static void cleanup(void)
-- 
1.8.2.1




------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
