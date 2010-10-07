Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1P3jgj-0005mJ-RF
	for ltp-list@lists.sourceforge.net; Thu, 07 Oct 2010 06:10:45 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P3jgg-0001rs-MN
	for ltp-list@lists.sourceforge.net; Thu, 07 Oct 2010 06:10:45 +0000
Message-ID: <4CAD6423.1000809@cn.fujitsu.com>
Date: Thu, 07 Oct 2010 14:09:39 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [RFC][PATCH]Report UNRESOLVED if TB2 lock mutex2 success.
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sf.net

When i running open_posix test cases, i get below message:

functional/threads/pi_test/pitest-4: execution: FAILED: Output: 
Main Thread: Creating sample thread
Main Thread: Creating 3 TF threads
Thread Sampler: started
Thread TF index 3: started
Thread TF index 4: started
Thread TF index 2: started
Main Thread: Creating TP thread
Thread TP index 1: started
Main Thread: Creating TL thread
Thread TL index 0: started
# COLUMNS 6 Time TL TP TF0 TF1 TF2 #EVENT 0.000501 Thread TF Started

#EVENT 0.000513 Thread TF Started
0.000600 0 0 0 0 0 
#EVENT 0.000562 Thread TF Started
0.301718 0 0 12 25 12 
0.602722 0 0 25 50 25 

... snip ...

8.428881 0 0 361 713 362 
8.729887 0 0 374 739 375 
#EVENT 9.001983 Thread TP Started
9.030893 0 1 387 763 388 
9.331900 0 9 400 780 401 

... snip ...

18.663090 0 222 800 1358 803 
18.964096 0 230 813 1377 816 
#EVENT 19.003179 Thread TL Started
19.265103 5 235 826 1391 829 
19.566109 9 244 839 1404 842 

... snip ...

37.927483 372 665 1627 2182 1634 
38.228490 380 670 1640 2194 1647 
38.529496 385 67Thread TB2: started
../../../functional/threads/pi_test/pitest-4.c: 237: FAIL: Thread TB2: lock mutex2 returned 0 Success, slept 0.000007

Maybe we need to apply the followed patch.

---------------------------------------------------------------------
TB2 has a higher priority, it may lock mutex2 earlier than TB1, so
pthread_mutex_timedlock can return 0 immediately.

I think that reports UNRESOLVED is better than FAIL.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../functional/threads/pi_test/pitest-4.c          |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
index 5259eb7..e6bff3f 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
@@ -198,6 +198,12 @@ void *thread_tb1(void *arg)
 	DPRINTF(stdout, "#EVENT %f TB1 Waited on mutex1 for %.2f s\n", 
 		t1 - base_time, t1 - t0);
 
+	if (rc == 0) {
+		EPRINTF("UNRESOLVED: Thread TB1: lock mutex1 success, "
+			"slept %f", t1 - t0);
+		exit(UNRESOLVED);
+	}
+
 	if (rc != ETIMEDOUT) {
 		EPRINTF("FAIL: Thread TB1: lock returned %d %s, "
 			"slept %f", rc, strerror(rc), t1 - t0);
@@ -232,6 +238,12 @@ void *thread_tb2(void *arg)
 	DPRINTF(stdout, "#EVENT %f Thread TB2 Waited on mutex2 for %.2f s\n", 
 		t1 - base_time, t1 - t0);
 
+	if (rc == 0) {
+		EPRINTF("UNRESOLVED: Thread TB2: lock mutex2 success, "
+			"slept %f", t1 - t0);
+		exit(UNRESOLVED);
+	}
+
 	if (rc != ETIMEDOUT) {
 		EPRINTF("FAIL: Thread TB2: lock mutex2 returned %d %s, "
 			"slept %f", rc, strerror(rc), t1 - t0);
-- 
1.7.0.4



-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
