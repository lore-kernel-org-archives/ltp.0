Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guijianfeng@cn.fujitsu.com>) id 1P97sw-0001xD-K9
	for ltp-list@lists.sourceforge.net; Fri, 22 Oct 2010 03:01:38 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P97su-0007Bk-Vj
	for ltp-list@lists.sourceforge.net; Fri, 22 Oct 2010 03:01:38 +0000
Message-ID: <4CC0FE9C.9040006@cn.fujitsu.com>
Date: Fri, 22 Oct 2010 11:01:48 +0800
From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/3] pitest-3: Use time_t instead of unsigned long /
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

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
 .../functional/threads/pi_test/pitest-3.c          |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
index 0826a55..07b3bb8 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
@@ -210,7 +210,6 @@ void *thread_sample(void *arg)
 
 void *thread_tb1(void *arg)
 {
-	unsigned long timeoutsec; 
 	struct timespec boost_time;
 	double t0, t1;
 	int rc;
@@ -220,8 +219,7 @@ void *thread_tb1(void *arg)
 	DPRINTF(stdout, "#EVENT %f Thread TB1 Started\n", 
 		seconds_read() - base_time);
 
-	timeoutsec = *(unsigned long*) arg;
-	boost_time.tv_sec = time(NULL) + (time_t )timeoutsec;
+	boost_time.tv_sec = time(NULL) + *(unsigned long*) arg;
 	boost_time.tv_nsec = 0;
 
 	t0 = seconds_read();
@@ -240,7 +238,6 @@ void *thread_tb1(void *arg)
 
 void *thread_tb2(void *arg)
 {
-	unsigned long timeoutsec;
 	struct timespec boost_time;
 	double t0, t1;
 	int rc;
@@ -250,8 +247,7 @@ void *thread_tb2(void *arg)
 	DPRINTF(stdout, "#EVENT %f Thread TB2 Started\n", 
 		seconds_read() - base_time);
 
-	timeoutsec = *(unsigned long*) arg;	
-	boost_time.tv_sec = time(NULL) + (time_t)timeoutsec;
+	boost_time.tv_sec = time(NULL) + *(time_t*) arg;
 	boost_time.tv_nsec = 0;
 	t0 = seconds_read();
 	rc = pthread_mutex_timedlock(&mutex2, &boost_time);	
@@ -339,7 +335,7 @@ int main(int argc, char **argv)
 	sleep(base_time + multiplier * 30 - seconds_read());
 
 	/* Start TB1 thread (boosting thread) */
-	int timeout = multiplier * 20;
+	time_t timeout = multiplier * 20;
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
