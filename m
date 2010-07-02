Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OUZh3-0002TD-DO
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:45 +0000
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUZh0-0002Pc-LJ
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:45 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp08.in.ibm.com (8.14.4/8.13.1) with ESMTP id o626O2GF004803
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:54:02 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o626PYCh3535070
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:55:34 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o626PXk0004695
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 16:25:33 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Fri,  2 Jul 2010 11:55:26 +0530
Message-Id: <1278051930-4070-4-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
References: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 3/7] realtime/testpi-4: add test description
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linux Test Project <ltp-list@lists.sourceforge.net>
Cc: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

This patch adds the description to the test testpi-4.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-4.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-4.c b/testcases/realtime/func/pi-tests/testpi-4.c
index 53b47a8..6a90771 100644
--- a/testcases/realtime/func/pi-tests/testpi-4.c
+++ b/testcases/realtime/func/pi-tests/testpi-4.c
@@ -20,8 +20,8 @@
  *      testpi-4.c
  *
  * DESCRIPTION
- *
- *
+ *     This testcase verifies that the SCHED_OTHER thread can preempt
+ *     the SCHED_RR thread via priority inheritance.
  *
  * USAGE:
  *      Use run_auto.sh script in current directory to build and run test.
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
