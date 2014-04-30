Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1WfOP6-0007ga-Tv
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 06:54:04 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WfOP6-0003Ss-52
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 06:54:04 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3U6rv9k021253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 06:53:58 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3U6ruMh029240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 06:53:57 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3U6ru4J026771
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 06:53:56 GMT
From: shuang.qiu@oracle.com
Date: Wed, 30 Apr 2014 14:53:45 +0800
Message-Id: <1398840825-9252-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] syscalls/clone08: Skip test_clone_stopped from kernel
	2.6.38
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

According to CLONE manual page "This flag was deprecated from Linux
2.6.25 onward, and was removed altogether in Linux 2.6.38." skip
test_clone_stopped test from kernel 2.6.38.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/syscalls/clone/clone08.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index 14ebf60..6857ab1 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -238,6 +238,11 @@ static void test_clone_stopped(int t)
 	int flag;
 	pid_t child;
 
+	if (tst_kvercmp(2, 6, 38) >= 0) {
+		tst_resm(TINFO, "CLONE_STOPPED skipped for kernels >= 2.6.38");
+		return;
+		}
+
 	stopped_flag = 0;
 	child = clone_child(&test_cases[t], 1);
 
-- 
1.7.7


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
