Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PBHko-00032A-J8
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 01:58:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PBHkm-0000HQ-8r
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 01:58:10 +0000
Message-ID: <4CC8D859.4010701@cn.fujitsu.com>
Date: Thu, 28 Oct 2010 09:56:41 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH]Some building error at pi_test cases.
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
Cc: ltp-list@lists.sourceforge.net

Commit 5f2ba92bdbef089bad74906fd8a86b54617f7878 make some building error.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../functional/threads/pi_test/pitest-2.c          |    2 +-
 .../functional/threads/pi_test/pitest-3.c          |    4 ++--
 .../functional/threads/pi_test/pitest-4.c          |    4 ++--
 .../functional/threads/pi_test/pitest-6.c          |    4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
index 62f1f45..0a96377 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
@@ -235,7 +235,7 @@ void *thread_tb2(void *arg)
 	DPRINTF(stdout, "#EVENT %f TB2 Thread Started\n",
 		seconds_read() - base_time); 
 	
-	boost_time.tv_sec = time(NULL) + *(time_t*)timeoutsec;
+	boost_time.tv_sec = time(NULL) + *(time_t*)arg;
 	boost_time.tv_nsec = 0;
 
 	t0 = seconds_read();
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
index fe0c886..58d7a4a 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
@@ -219,7 +219,7 @@ void *thread_tb1(void *arg)
 	DPRINTF(stdout, "#EVENT %f Thread TB1 Started\n", 
 		seconds_read() - base_time);
 
-	boost_time.tv_sec = time(NULL) + *(time_t *)timeoutsec;
+	boost_time.tv_sec = time(NULL) + *(time_t *)arg;
 	boost_time.tv_nsec = 0;
 
 	t0 = seconds_read();
@@ -247,7 +247,7 @@ void *thread_tb2(void *arg)
 	DPRINTF(stdout, "#EVENT %f Thread TB2 Started\n", 
 		seconds_read() - base_time);
 
-	boost_time.tv_sec = time(NULL) + *(time_t *)timeoutsec;
+	boost_time.tv_sec = time(NULL) + *(time_t *)arg;
 	boost_time.tv_nsec = 0;
 	t0 = seconds_read();
 	rc = pthread_mutex_timedlock(&mutex2, &boost_time);	
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
index a042dbf..077f966 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
@@ -187,7 +187,7 @@ void *thread_tb1(void *arg)
 
 	pthread_mutex_lock(&mutex2);
  
-	boost_time.tv_sec = time(NULL) + *(time_t *)timeoutsec;
+	boost_time.tv_sec = time(NULL) + *(time_t *)arg;
 	boost_time.tv_nsec = 0;
 	t0 = seconds_read();
 	rc = pthread_mutex_timedlock(&mutex1, &boost_time);	
@@ -218,7 +218,7 @@ void *thread_tb2(void *arg)
 	DPRINTF(stdout, "#EVENT %f Thread TB2 Started\n", 
 		seconds_read() - base_time);
 
-	boost_time.tv_sec = time(NULL) + *(time_t *)timeoutsec;
+	boost_time.tv_sec = time(NULL) + *(time_t *)arg;
 	boost_time.tv_nsec = 0;
 
 	t0 = seconds_read();
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
index 6ebb003..2f2272b 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
@@ -204,9 +204,9 @@ void *thread_tb(void *arg)
 	DPRINTF(stderr,"Thread TB: started\n");
 	
 	DPRINTF(stdout, "#EVENT %f TB Started, waiting for mutex for %lu s\n", 
-		seconds_read() - base_time, timeoutsec);
+		seconds_read() - base_time, *(unsigned long*)arg);
 
-	boost_time.tv_sec = time(NULL) + *(time_t *)timeoutsec;
+	boost_time.tv_sec = time(NULL) + *(time_t *)arg;
 	boost_time.tv_nsec = 0;
 
 	t0 = seconds_read();
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
