Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PeT1p-0007lp-Jx
	for ltp-list@lists.sourceforge.net; Sun, 16 Jan 2011 13:52:21 +0000
Date: Sun, 16 Jan 2011 15:09:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110116140911.GB12249@saboteur.suse.cz>
References: <000001cb8f8d$a7cf4310$f76dc930$@co.jp>
	<20101210144930.GA16800@saboteur.suse.cz>
	<AANLkTimmkmk_H+AzYOGau6fr_BHChOCif7n=FOu2F14R@mail.gmail.com>
	<20101213185337.GB697@saboteur.suse.cz>
	<20110106152547.GA9358@saboteur.suse.cz>
	<AANLkTi=YcasSVsYCX7gmkt2m7uBDBf3u=XvAAn=x3vSy@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <AANLkTi=YcasSVsYCX7gmkt2m7uBDBf3u=XvAAn=x3vSy@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix "timer_create/10-1" and "timer_create/11-1"
 tests
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, "?$BaD:B ?$B7r, T" <toza@ryobi.co.jp>, Mitani <mitani@ryobi.co.jp>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> > Hi!
> > Garrett could you, pretty please, review/commit the patch.
> 
> Just for future reference:
> 
> 1. All variables static to main are pre-initialized to 0 by default
> according to ANSI-C (see: http://en.wikipedia.org/wiki/.bss ) .
> 2. I removed the printf's for sysconf(_SC_CPUTIME) because it was unnecessary.
> 3. The sysconf call for the CLOCK_THREAD_CPUTIME_ID was wrong.
> 4. sysconf should always return -1 when unsupported, not 0.
> 
> Could you please provide a diff from the version I'm about ready to
> commit so I can determine what needs to be fixed, and why?

The outstanding problems are:

You should not call printf() from signal handler.

Misplaced whitespace after while (!caught_signal) ;

You should get rather difference on cputime timers than on system timers
that count's time rather than proces cpu time.

Patch for latest git attached.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

--YZ5djTAD1cGYuMQK
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="timer_create_fix.patch"

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
index 199c2bb..0cdc456 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
@@ -19,12 +19,12 @@
 
 #define SIGTOTEST SIGALRM
 #define TIMERSEC 2
+#define DELTA 1
 
 int caught_signal;
 
 void handler(int signo)
 {
-	printf("Caught signal\n");
 	caught_signal = 1;
 }
 
@@ -38,9 +38,8 @@ int main(int argc, char *argv[])
 	struct sigaction act;
 	timer_t tid;
 	struct itimerspec its;
-	struct timespec ts, tsleft;
-	time_t start_time, end_time;
-	int overrun_amount, rc;
+	struct timespec start_time, stop_time;
+	int rc;
 
 	rc = sysconf(_SC_CPUTIME);
 	if (rc == -1) {
@@ -69,41 +68,38 @@ int main(int argc, char *argv[])
 		return PTS_UNRESOLVED;
 	}
 
-	if (time(&start_time) == -1) {
-		perror("time failed");
-		return PTS_UNRESOLVED;
-	}
-
 	if (timer_create(CLOCK_PROCESS_CPUTIME_ID, &ev, &tid) != 0) {
 		perror("timer_create did not return success");
 		return PTS_UNRESOLVED;
 	}
-
-	if (timer_settime(tid, 0, &its, NULL) != 0) {
-		perror("timer_settime did not return success");
+	
+	if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start_time) == -1) {
+		perror("clock_gettime failed");
 		return PTS_UNRESOLVED;
 	}
 
-	while (!caught_signal) ;
-
-	if (time(&end_time) == -1) {
-		perror("time failed");
+	if (timer_settime(tid, 0, &its, NULL) != 0) {
+		perror("timer_settime did not return success");
 		return PTS_UNRESOLVED;
 	}
 
-	if ((overrun_amount = timer_getoverrun(tid)) == -1) {
-		perror("timer_getoverrun failed");
+	while (!caught_signal);
+	
+	if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &stop_time) == -1) {
+		perror("clock_gettime failed");
 		return PTS_UNRESOLVED;
 	}
 
-	if ((end_time - start_time) == (TIMERSEC + overrun_amount)) {
+	if (abs((stop_time.tv_sec - start_time.tv_sec) - TIMERSEC) < DELTA) {
 		printf("Test PASSED\n");
 		return PTS_PASS;
 	}
 
 	printf("Timer did not last for correct amount of time\n"
 		"timer: %d != correct %d\n",
-		(int) (end_time - start_time), TIMERSEC + overrun_amount);
+		(int) (stop_time.tv_sec - start_time.tv_sec),
+		TIMERSEC);
+	
 	return PTS_FAIL;
 #endif
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
index 2e0cf09..d193bf5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
@@ -19,12 +19,12 @@
 
 #define SIGTOTEST SIGALRM
 #define TIMERSEC 2
+#define DELTA 1
 
 int caught_signal;
 
 void handler(int signo)
 {
-	printf("Caught signal\n");
 	caught_signal = 1;
 }
 
@@ -38,9 +38,8 @@ int main(int argc, char *argv[])
 	struct sigaction act;
 	timer_t tid;
 	struct itimerspec its;
-	struct timespec ts, tsleft;
-	time_t start_time, end_time;
-	int overrun_amount, rc;
+	struct timespec start_time, stop_time;
+	int rc;
 
 	rc = sysconf(_SC_THREAD_CPUTIME);
 	if (rc == -1) {
@@ -69,41 +68,38 @@ int main(int argc, char *argv[])
 		return PTS_UNRESOLVED;
 	}
 
-	if (time(&start_time) == -1) {
-		perror("time failed");
-		return PTS_UNRESOLVED;
-	}
-
 	if (timer_create(CLOCK_THREAD_CPUTIME_ID, &ev, &tid) != 0) {
 		perror("timer_create did not return success");
 		return PTS_UNRESOLVED;
 	}
-
-	if (timer_settime(tid, 0, &its, NULL) != 0) {
-		perror("timer_settime did not return success");
+	
+	if (clock_gettime(CLOCK_THREAD_CPUTIME_ID, &start_time) == -1) {
+		perror("clock_gettime failed");
 		return PTS_UNRESOLVED;
 	}
 
-	while (!caught_signal) ;
-
-	if (time(&end_time) == -1) {
-		perror("time failed");
+	if (timer_settime(tid, 0, &its, NULL) != 0) {
+		perror("timer_settime did not return success");
 		return PTS_UNRESOLVED;
 	}
 
-	if ((overrun_amount = timer_getoverrun(tid)) == -1) {
-		perror("timer_getoverrun failed");
+	while (!caught_signal);
+	
+	if (clock_gettime(CLOCK_THREAD_CPUTIME_ID, &stop_time) == -1) {
+		perror("clock_gettime failed");
 		return PTS_UNRESOLVED;
 	}
 
-	if ((end_time - start_time) == (TIMERSEC + overrun_amount)) {
+	if (abs((stop_time.tv_sec - start_time.tv_sec) - TIMERSEC) < DELTA) {
 		printf("Test PASSED\n");
 		return PTS_PASS;
 	}
 
 	printf("Timer did not last for correct amount of time\n"
 		"timer: %d != correct %d\n",
-		(int) (end_time - start_time), TIMERSEC + overrun_amount);
+		(int) (stop_time.tv_sec - start_time.tv_sec),
+		TIMERSEC);
+
 	return PTS_FAIL;
 #endif
 }

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--YZ5djTAD1cGYuMQK--

