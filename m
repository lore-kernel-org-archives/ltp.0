Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zhangxiliang@cn.fujitsu.com>) id 1MiiZX-0001Po-3p
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2009 05:39:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MiiZP-0007XP-Of
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2009 05:39:50 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 6450417011C
	for <ltp-list@lists.sourceforge.net>;
	Wed,  2 Sep 2009 13:39:39 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id n825dbfK000627
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Sep 2009 13:39:37 +0800
Received: from [127.0.0.1] (unknown [10.167.141.212])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 6B8B4D416D
	for <ltp-list@lists.sourceforge.net>;
	Wed,  2 Sep 2009 13:39:19 +0800 (CST)
Message-ID: <4A9E0655.4030703@cn.fujitsu.com>
Date: Wed, 02 Sep 2009 13:44:53 +0800
From: Zhang Xiliang <zhangxiliang@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH 2/2] mbind01: Fix the bug of mind case06
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

I tested ltp mbind case and found the case06 failed.

In mbind manual, it says "If the nodemask and maxnode arguments specify the empty set, 
then the memory is allocated on the node of the CPU that triggered the allocation."

In case06, when tc->policy is MPOL_PREFERRED and tc->from_node is NONE, the getnodemask 
which is get by get_mempolicy() refer to the node of the CPU that triggered the allocation.
But the nodemask is zero.(It is not used by mbind(), mbind() used "NULL".)

So in this case, the cmp_ok should only compare the policy.

Signed-off-by: Zhang Xiliang <zhangxiliang@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mbind/mbind01.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 94c2dd0..446fdaf 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -305,7 +305,10 @@ static int do_test(struct test_case *tc) {
 // When policy equals MPOL_DEFAULT, then get_mempolicy not return node
         if (tc->policy == MPOL_DEFAULT)
 		nodemask_zero(&nodemask);
-	cmp_ok = ((tc->policy == policy) && nodemask_equal(&nodemask,&getnodemask));
+	if ((tc->policy == MPOL_PREFERRED) && (tc->from_node == NONE))
+		cmp_ok = (tc->policy == policy);
+	else
+		cmp_ok = ((tc->policy == policy) && nodemask_equal(&nodemask,&getnodemask));
         if (opt_debug) {
 		nodemask_dump("nodemask Expect:", &nodemask);
 		nodemask_dump("nodemask Result:", &getnodemask);



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
