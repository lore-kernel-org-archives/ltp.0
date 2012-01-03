Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri2I6-00032g-Ed
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:12:26 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri2I2-0001s2-CR
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:12:26 +0000
Message-ID: <4F02E28F.1080603@imgtec.com>
Date: Tue, 3 Jan 2012 11:12:15 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060307050507020800010007"
Subject: [LTP] [PATCH 11/21] process_stress/process: Fix dprt() function
 definition when DEBUG macro is used
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--------------060307050507020800010007
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch


-- 
markos

--------------060307050507020800010007
Content-Type: text/plain;
	name="0011-process_stress-process-Fix-dprt-function-definition-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0011-process_stress-process-Fix-dprt-function-definition-.pa";
	filename*1="tch"

From ba7dc3499dc3e7389943345a3c042a2b6910b9eb Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Mon, 21 Nov 2011 10:24:12 +0000
Subject: [PATCH 11/21] process_stress/process: Fix dprt() function definition when DEBUG macro is used

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/sched/process_stress/process.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index b7d68b8..a72c1bc 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -68,7 +68,7 @@
 #if defined _LINUX && defined DEBUG
 #define prtln()	printf("At line number: %d\n", __LINE__); \
 		fflush(NULL)
-#define dprt(fmt, args...) printf(fmt, args...)
+#define dprt(fmt, args...) printf(fmt, ## args)
 #else
 #define prtln()
 #define dprt(fmt, args...)
@@ -1210,4 +1210,4 @@ dprt("value of nodesum is initiallized to: %d\n", nodesum);
 	prtln();
 	return 0;
 
-}
\ No newline at end of file
+}
-- 
1.7.1


--------------060307050507020800010007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------060307050507020800010007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060307050507020800010007--


