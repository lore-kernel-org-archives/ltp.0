Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1MT5ip-0002JJ-94
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 03:08:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MT5ig-0002WN-St
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 03:08:55 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 5A43917013F
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 11:30:06 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id n6L3g2jd018474
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 11:42:02 +0800
Received: from [127.0.0.1] (unknown [10.167.141.76])
	by fnst.cn.fujitsu.com (Postfix) with ESMTP id E29F8D4016
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 11:09:51 +0800 (CST)
Message-ID: <4A6530E2.80406@cn.fujitsu.com>
Date: Tue, 21 Jul 2009 11:07:14 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Fix the failure of get_mempolicy01 test case
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

Test case get_mempolicy01 failure because of the the nodemask
is not used when from_node is NONE type. If the from_node is
NONE, nodemask_equal() is not need.

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 2201bf4..aa0b14b 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -337,7 +337,7 @@ static int do_test(struct test_case *tc)
         // When policy equals MPOL_DEFAULT, then get_mempolicy not return node
         if (tc->policy == MPOL_DEFAULT)
                 nodemask_zero(&nodemask);
-        cmp_ok = tc->policy == policy && nodemask_equal(&nodemask,&getnodemask);
+        cmp_ok = tc->policy == policy && (tc->from_node == NONE || nodemask_equal(&nodemask,&getnodemask));
         if (opt_debug) {
                 nodemask_dump("nodemask Expect:", &nodemask);
                 nodemask_dump("nodemask Result:", &getnodemask);




------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
