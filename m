Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guijianfeng@cn.fujitsu.com>) id 1P98TX-0004yd-Jd
	for ltp-list@lists.sourceforge.net; Fri, 22 Oct 2010 03:39:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P98TW-0005Qo-11
	for ltp-list@lists.sourceforge.net; Fri, 22 Oct 2010 03:39:27 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 86D2617096A
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 Oct 2010 11:39:22 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id o9M3ZFlp001189
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Oct 2010 11:35:15 +0800
Received: from [10.167.225.71] (unknown [10.167.225.71])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id E622614C06D
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 Oct 2010 11:40:55 +0800 (CST)
Message-ID: <4CC1077D.4040509@cn.fujitsu.com>
Date: Fri, 22 Oct 2010 11:39:41 +0800
From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] pitest-4: Use time_t instead of unsigned long /
	int.
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

The test was using a mish-mash of unsigned long and int types to pass
data between the thread and evaluate values, so the problem lied in
potential truncation of data.

time_t is a 32-bit type or 64-bit type on some OSes, so it's best to
remain consistent with a single fixed data type instead of moving
between int (which can be 32-bit or 64-bit, depending on the OS and
architecture) and unsigned long (which can be 32-bit or 64-bit,
depending on the OS and architecture).

Signed-off-by: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
---
 .../functional/threads/pi_test/pitest-4.c          |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
index e6bff3f..12c9092 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
@@ -176,7 +176,6 @@ void *thread_sample(void *arg)
 
 void *thread_tb1(void *arg)
 {
-	unsigned long timeoutsec; 
 	struct timespec boost_time;
 	double t0, t1;
 	int rc;
@@ -188,8 +187,7 @@ void *thread_tb1(void *arg)
 
 	pthread_mutex_lock(&mutex2);
  
-	timeoutsec = *(unsigned long*) arg;
-	boost_time.tv_sec = time(NULL) + (time_t)timeoutsec;
+	boost_time.tv_sec = time(NULL) + *(unsigned long*) arg;
 	boost_time.tv_nsec = 0;
 	t0 = seconds_read();
 	rc = pthread_mutex_timedlock(&mutex1, &boost_time);	
@@ -217,7 +215,6 @@ void *thread_tb1(void *arg)
 
 void *thread_tb2(void *arg)
 {
-	unsigned long timeoutsec; 
 	struct timespec boost_time;
 	double t0, t1;
 	int rc;
@@ -227,8 +224,7 @@ void *thread_tb2(void *arg)
 	DPRINTF(stdout, "#EVENT %f Thread TB2 Started\n", 
 		seconds_read() - base_time);
 
-	timeoutsec = *(unsigned long*) arg;
-	boost_time.tv_sec = time(NULL) + (time_t)timeoutsec;
+	boost_time.tv_sec = time(NULL) + *(unsigned long*) arg;
 	boost_time.tv_nsec = 0;
 
 	t0 = seconds_read();
@@ -319,7 +315,7 @@ int main(int argc, char **argv)
 	sleep(base_time + multiplier * 30 - seconds_read());
 
 	/* Start TB1 thread (the lowest priority thread) */
-	int timeout = multiplier * 40;
+	time_t timeout = multiplier * 40;
 	rc = pthread_create(&threadtb1, &threadattr, thread_tb1, 
 			    &timeout);
         if (rc != 0) {
-- 
1.7.0.4


------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
