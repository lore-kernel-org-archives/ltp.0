Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1T4R8W-0007iM-6X
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 06:43:24 +0000
Received: from rcsinet15.oracle.com ([148.87.113.117])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T4R8S-0003qK-7O
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 06:43:24 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by rcsinet15.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with
	ESMTP id q7N6hDiD032336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Aug 2012 06:43:14 GMT
Received: from acsmt357.oracle.com (acsmt357.oracle.com [141.146.40.157])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	q7N6hCtx024619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Aug 2012 06:43:13 GMT
Received: from abhmt102.oracle.com (abhmt102.oracle.com [141.146.116.54])
	by acsmt357.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id
	q7N6hCPq009483
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Aug 2012 01:43:12 -0500
From: shuang.qiu@oracle.com
Date: Thu, 23 Aug 2012 14:43:01 +0800
Message-Id: <1345704181-5596-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
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
To: ltp-list@lists.sourceforge.net

From: Shuang Qiu <shuang.qiu@oracle.com>

The value of min_free_kbytes is set too high(half of mem_free) during
testing min_free_kbytes tunable.It often cause the system to become
out-of-memory.Using 20% of mem_free to avoid oom and system hang.
---
 testcases/kernel/mem/tunable/min_free_kbytes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 00ead04..8a03f85 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -128,7 +128,7 @@ static void test_tune(unsigned long overcommit_policy)
 		/* case2 */
 		else {
 			memfree = read_meminfo("MemFree:");
-			tune = memfree / 2;
+			tune = memfree / 5;
 			set_sys_tune("min_free_kbytes", tune, 1);
 		}
 
-- 
1.7.7


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
