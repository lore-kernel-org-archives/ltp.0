Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PdwCh-0005TF-Iq
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 02:49:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdwCe-0005b0-UO
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 02:49:23 +0000
Message-ID: <4D310A5D.6000006@cn.fujitsu.com>
Date: Sat, 15 Jan 2011 10:45:49 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH] Fix bug of the test timer_create.
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

CLOCK_THREAD_CPUTIME_ID and CLOCK_PROCESS_CPUTIME_ID are CPU-time clock,
so when the thread/process invokes nanosleep, these clocks will go sleeping
too.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../conformance/interfaces/timer_create/10-1.c     |   36 +++++++++++++------
 .../conformance/interfaces/timer_create/11-1.c     |   35 +++++++++++++------
 2 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
index 27d5c1c..23a777e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
@@ -24,9 +24,12 @@
 #define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
+int caught = 0;
+
 void handler(int signo)
 {
 	printf("Caught signal\n");
+	caught = 1;
 }
 
 int main(int argc, char *argv[])
@@ -39,8 +42,8 @@ int main(int argc, char *argv[])
 	struct sigaction act;
 	timer_t tid;
 	struct itimerspec its;
-	struct timespec ts, tsleft;
-	int rc;
+	int rc, overrun = 0;
+	time_t stime = 0, etime = 0;
 
 	rc = sysconf(_SC_CPUTIME);
 	printf("sysconf(_SC_CPUTIME) returns: %d\n", rc);
@@ -59,9 +62,6 @@ int main(int argc, char *argv[])
 	its.it_value.tv_sec = TIMERSEC;
 	its.it_value.tv_nsec = 0;
 
-	ts.tv_sec=TIMERSEC+SLEEPDELTA;
-	ts.tv_nsec=0;
-
 	if (sigemptyset(&act.sa_mask) == -1) {
 		perror("Error calling sigemptyset");
 		return PTS_UNRESOLVED;
@@ -76,27 +76,39 @@ int main(int argc, char *argv[])
 		return PTS_UNRESOLVED;
 	}
 
+	if ((time_t)(-1) == time(&stime)) {
+		perror("time() did not return success");
+		return PTS_UNRESOLVED;
+	}
+
 	if (timer_settime(tid, 0, &its, NULL) != 0) {
 		perror("timer_settime() did not return success");
 		return PTS_UNRESOLVED;
 	}
 
-	if (nanosleep(&ts, &tsleft) != -1) {
-		perror("nanosleep() not interrupted");
-		return PTS_FAIL;
+	while(!caught);
+
+	if ((time_t)(-1) == time(&etime)) {
+		perror("time() did not return success");
+		return PTS_UNRESOLVED;
+	}
+
+	if (-1 == (overrun = timer_getoverrun(tid))) {
+		perror("timer_getoverrun() did not return success");
+		return PTS_UNRESOLVED;
 	}
 
-	if (abs(tsleft.tv_sec-SLEEPDELTA) <= ACCEPTABLEDELTA) {
-		printf("Test PASSED");
+	if (etime - stime == TIMERSEC + overrun) {
+		printf("Test PASSED\n");
 		return PTS_PASS;
 	} else {
 		printf("Timer did not last for correct amount of time\n");
 		printf("timer: %d != correct %d\n",
-				(int) ts.tv_sec- (int) tsleft.tv_sec,
+				(int) etime - (int) stime,
 				TIMERSEC);
 		return PTS_FAIL;
 	}
 
 	return PTS_UNRESOLVED;
 #endif
-}
\ No newline at end of file
+}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
index bd59e8f..c34b451 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
@@ -22,9 +22,12 @@
 #define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
+int caught = 0;
+
 void handler(int signo)
 {
 	printf("Caught signal\n");
+	caught = 1;
 }
 
 int main(int argc, char *argv[])
@@ -38,7 +41,8 @@ int main(int argc, char *argv[])
 	struct sigaction act;
 	timer_t tid;
 	struct itimerspec its;
-	struct timespec ts, tsleft;
+	time_t  stime = 0, etime = 0;
+	int overrun = 0;
 
 	if (rc == -1) {
 		printf("_POSIX_THREAD_CPUTIME unsupported\n");
@@ -56,9 +60,6 @@ int main(int argc, char *argv[])
 	its.it_value.tv_sec = TIMERSEC;
 	its.it_value.tv_nsec = 0;
 
-	ts.tv_sec=TIMERSEC+SLEEPDELTA;
-	ts.tv_nsec=0;
-
 	if (sigemptyset(&act.sa_mask) == -1) {
 		perror("Error calling sigemptyset");
 		return PTS_UNRESOLVED;
@@ -73,23 +74,35 @@ int main(int argc, char *argv[])
 		return PTS_UNRESOLVED;
 	}
 
+	if ((time_t)(-1) == time(&stime)) {
+		perror("time() did not return success");
+		return PTS_UNRESOLVED;
+	}
+
 	if (timer_settime(tid, 0, &its, NULL) != 0) {
 		perror("timer_settime() did not return success");
 		return PTS_UNRESOLVED;
 	}
 
-	if (nanosleep(&ts, &tsleft) != -1) {
-		perror("nanosleep() not interrupted");
-		return PTS_FAIL;
+	while(!caught);
+
+	if ((time_t)(-1) == time(&etime)) {
+		perror("time() did not return success");
+		return PTS_UNRESOLVED;
+	}
+
+	if (-1 == (overrun = timer_getoverrun(tid))) {
+		perror("timer_getoverrun() did not return success");
+		return PTS_UNRESOLVED;
 	}
 
-	if (abs(tsleft.tv_sec-SLEEPDELTA) <= ACCEPTABLEDELTA) {
-		printf("Test PASSED");
+	if (etime - stime == TIMERSEC + overrun) {
+		printf("Test PASSED\n");
 		return PTS_PASS;
 	} else {
 		printf("Timer did not last for correct amount of time\n");
 		printf("timer: %d != correct %d\n",
-				(int) ts.tv_sec- (int) tsleft.tv_sec,
+				(int) etime - (int) stime,
 				TIMERSEC);
 		return PTS_FAIL;
 	}
@@ -100,4 +113,4 @@ int main(int argc, char *argv[])
 	return PTS_UNSUPPORTED;
 #endif
 
-}
\ No newline at end of file
+}
-- 
1.7.0.4




-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
