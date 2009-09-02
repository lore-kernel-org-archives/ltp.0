Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zhangxiliang@cn.fujitsu.com>) id 1MikVf-0006VA-Cc
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2009 07:44:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MikVX-0005yn-0c
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2009 07:44:03 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id ED979170028
	for <ltp-list@lists.sourceforge.net>;
	Wed,  2 Sep 2009 15:43:41 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id n827hdcK005137
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Sep 2009 15:43:39 +0800
Received: from [127.0.0.1] (unknown [10.167.141.212])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 7BBD1D4181
	for <ltp-list@lists.sourceforge.net>;
	Wed,  2 Sep 2009 15:43:22 +0800 (CST)
Message-ID: <4A9E236B.6040606@cn.fujitsu.com>
Date: Wed, 02 Sep 2009 15:48:59 +0800
From: Zhang Xiliang <zhangxiliang@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] mbind01: Fix the bug of mind case10
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

I tested ltp mbind01 case and found the case10 failed.

In case10, the expect errno is EFAULT. 

In mbind manual, it says "EFAULT Part or all of the memory range specified by nodemask 
and maxnode points outside your accessible address space. "

So the case should use invalid "nodemask" instead of invalid "p" to test.

Signed-off-by: Zhang Xiliang <zhangxiliang@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mbind/mbind01.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 446fdaf..4afa71b 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -238,8 +238,8 @@ static struct test_case tcase[] = {
         },
         { // case10
                 .ttype          = INVALID_POINTER,
-                .policy         = MPOL_DEFAULT,
-                .from_node      = NONE,
+                .policy         = MPOL_PREFERRED,
+                .from_node      = SELF,
                 .ret            = -1,
                 .err            = EFAULT,
         },
@@ -263,6 +263,7 @@ static int do_test(struct test_case *tc) {
         nodemask_t nodemask, getnodemask;
         unsigned long maxnode = NUMA_NUM_NODES;
         unsigned long len = MEM_LENGTH;
+	unsigned long *invalid_nodemask;
 
         /* We assume that there is only one node(node0). */
         nodemask_zero(&nodemask);
@@ -279,13 +280,15 @@ static int do_test(struct test_case *tc) {
                 tst_exit();
         }
         if(tc->ttype == INVALID_POINTER)
-                p = (char*)0xc0000000;
+		invalid_nodemask = (unsigned long *)0xc0000000;
 /*
          * Execute system call
          */
         errno = 0;
         if (tc->from_node == NONE)
                 TEST(sys_ret = syscall(__NR_mbind, p, len, tc->policy,NULL, 0, tc->flags));
+	else if (tc->ttype == INVALID_POINTER)
+		TEST(sys_ret = syscall(__NR_mbind, p, len, tc->policy, invalid_nodemask, maxnode, tc->flags));
         else
                 TEST(sys_ret = syscall(__NR_mbind, p, len, tc->policy,&nodemask, maxnode, tc->flags));
         sys_errno = errno;


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
