Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1N0SFd-00086T-VA
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 03:52:41 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N0SFU-0008OZ-Mc
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 03:52:41 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 563E7170028
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Oct 2009 11:52:23 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id n9L3phr7009249
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Oct 2009 11:51:43 +0800
Received: from localhost.localdomain (unknown [10.167.141.167])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 8DDF7D4368
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Oct 2009 11:51:34 +0800 (CST)
Message-ID: <4ADE856B.4030509@cn.fujitsu.com>
Date: Wed, 21 Oct 2009 11:52:11 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mem/hugetlb: fix failure of hugemmap03
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

1)    In mmap's manual,
The starting address for the new mapping is specified in addr.

So, if mmap's argument "addr" is reachable, the mmap will
creates a new mapping in the virtual address space of the
call-ing process.
The test hugemmap03 will test that a normal page cannot
 be mapped into a high memory region. This infers that "addr"
should be higher for 64-bit mode.


2)    The test use "-I2" option, and this not only causes TFAIL's
loop, but also causes TPASS's loop.
For TFAIL, loop is deserved, nor for TPASS.

This patch fixed these problems.

Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>

---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
index 892d24b..a07b9aa 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
@@ -55,7 +55,7 @@
 #include "usctest.h"
 
 #define PAGE_SIZE      ((1UL) << 12) 	/* Normal page size */
-#define HIGH_ADDR      (void *)(0x10000000000)
+#define HIGH_ADDR      (void *)(0x1000000000000)
 
 char* TEMPFILE="mmapfile";
 
@@ -130,6 +130,7 @@ main(int ac, char **av)
 			continue;
 		} else {
 			tst_resm(TPASS, "Normal mmap() into high region failed correctly");
+			break;
 		}
 
 		close(fildes);




------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
