Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NAECw-0004n0-Vz
	for ltp-list@lists.sourceforge.net; Tue, 17 Nov 2009 02:54:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NAECp-0003tt-15
	for ltp-list@lists.sourceforge.net; Tue, 17 Nov 2009 02:54:18 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id DB40317011C
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Nov 2009 10:54:04 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id nAH2r4hq000337
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Nov 2009 10:53:04 +0800
Received: from localhost.localdomain (unknown [10.167.141.167])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 5BE16D443B
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Nov 2009 10:53:49 +0800 (CST)
Message-ID: <4B02107B.10604@cn.fujitsu.com>
Date: Tue, 17 Nov 2009 10:54:51 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mem/hugeshmget: fix failure of hugeshmget01
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

During hugeshmget01 testcase, we got the following:
hugeshmget01    1  TFAIL  :  seqment size is not correct
hugeshmget01    1  TFAIL  :  hugeshmget01 call failed - errno = 17 :
File exists
                ......

In shmget call,
"buf.shm_segsz" had been set to "huge_pages_shm_to_be_allocated", 
but the code still used old macro "HUGE_SHM_SIZE", and this 
leaded to error "seqment size is not correct".

So do the following change:
1) s/HUGE_SHM_SIZE/huge_pages_shm_to_be_allocated
2) Delete unused macro "HUGE_SHM_SIZE" defination

This patch fixed the failure.


Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
---
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |    2 +-
 testcases/kernel/mem/hugetlb/lib/ipcshm.h          |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 0486dc3..10f29d3 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -109,7 +109,7 @@ int main(int ac, char **av)
 					continue;
 				}
 				/* check the seqment size */
-				if (buf.shm_segsz != HUGE_SHM_SIZE) {
+				if (buf.shm_segsz != huge_pages_shm_to_be_allocated) {
 					tst_resm(TFAIL, "seqment size is not "
 						 "correct");
 					continue;
diff --git a/testcases/kernel/mem/hugetlb/lib/ipcshm.h b/testcases/kernel/mem/hugetlb/lib/ipcshm.h
index 5b92530..caac9af 100644
--- a/testcases/kernel/mem/hugetlb/lib/ipcshm.h
+++ b/testcases/kernel/mem/hugetlb/lib/ipcshm.h
@@ -42,7 +42,6 @@ void setup(void);
 #define SHM_HUGETLB   04000    /* segment is mapped via hugetlb */
 #endif
 
-#define HUGE_SHM_SIZE	(256UL*1024UL*1024UL)	/* a resonable size for a large page segment */
 
 #define MODE_MASK	0x01FF			/* to get the lower nine permission bits */
 						/* from shmid_ds.ipc_perm.mode		 */
-- 
1.6.2.2

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
