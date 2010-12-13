Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PSDJE-0003X1-5D
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 18:39:40 +0000
Date: Mon, 13 Dec 2010 19:53:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101213185337.GB697@saboteur.suse.cz>
References: <000001cb8f8d$a7cf4310$f76dc930$@co.jp>
	<20101210144930.GA16800@saboteur.suse.cz>
	<AANLkTimmkmk_H+AzYOGau6fr_BHChOCif7n=FOu2F14R@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <AANLkTimmkmk_H+AzYOGau6fr_BHChOCif7n=FOu2F14R@mail.gmail.com>
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


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> > Slightly different patch to fix these tests is attached. The code is a
> > little cleaner but basically does the same.
> >
> > The tests now do
> >
> > * get cputime
> > * set timer
> > * bussy loop while signal is not catched
> > * get cputime
> > * check that two stored cpu times differ approximately by timer interval
> >
> > Also some more problems are fixed.
> 
> Could you please add...
> 
> #ifdef CLOCK_PROCESS_CPUTIME_ID
> /* ... */
> #else
> int
> main(void)
> {
>     printf("CLOCK_PROCESS_CPUTIME_ID not supported\n");
>     return PTS_UNSUPPORTED;
> }
> #endif
> 
> ...? The constant is optional according to POSIX 2008.1:
> 
> "[CPT][Option Start] Process CPU-Time Clocks [Option End]
> The functionality described is optional. The functionality described
> is also an extension to the ISO C standard.
> 
> [TMR][Option Start] Timers [Option End]
> The functionality described is optional. The functionality described
> is also an extension to the ISO C standard.
> 
> Where applicable, functions are marked with the TMR margin legend in
> the SYNOPSIS section. Where additional semantics apply to a function,
> the material is identified by use of the TMR margin legend."
> 

Here you are.

(I also noted that previous patch was by accident using
 CLOCK_PROCESS_CPUTIME_ID to get elapsed time in 11-1.c, this is
 fixed too)

Notable changes:

* changed tests to do a bussy loop waiting as cpu time
  is not counted up in any of the sleep functions

* removed printf() from signal handlers as printf()
  is not async-signal-safe function

* added check for optional CLOCK_PROCESS_CPUTIME_ID

* coding style cleanup

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

--liOOAslEiF7prFVr
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="timer_create_III.patch"

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
index 56ffbbd..3e105f9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
@@ -10,8 +10,6 @@
  * Same test as 1-1.c.
  */
 
-#define _XOPEN_SOURCE 600
-
 #include <time.h>
 #include <signal.h>
 #include <stdio.h>
@@ -21,14 +19,16 @@
 
 #define SIGTOTEST SIGALRM
 #define TIMERSEC 2
-#define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
-void handler(int signo)
+static int endflg = 0;
+
+static void handler(int signo)
 {
-	printf("Caught signal\n");
+	endflg = 1;
 }
 
+#ifdef CLOCK_PROCESS_CPUTIME_ID
 int main(int argc, char *argv[])
 {
 #if _POSIX_CPUTIME == -1
@@ -39,33 +39,33 @@ int main(int argc, char *argv[])
 	struct sigaction act;
 	timer_t tid;
 	struct itimerspec its;
-	struct timespec ts, tsleft;
+	struct timespec tstart, tstop;
 	int rc;
 
 	rc = sysconf(_SC_CPUTIME);
 	printf("sysconf(_SC_CPUTIME) returns: %d\n", rc);
-	if (rc <= 0) {
-		return PTS_UNRESOLVED;	
+
+	if (rc == -1) {
+		printf("_POSIX_CPUTIME unsupported\n");
+		return PTS_UNSUPPORTED;
 	}
-		
+
 	ev.sigev_notify = SIGEV_SIGNAL;
 	ev.sigev_signo = SIGTOTEST;
 
-	act.sa_handler=handler;
-	act.sa_flags=0;
+	act.sa_handler = handler;
+	act.sa_flags = 0;
 
 	its.it_interval.tv_sec = 0;
 	its.it_interval.tv_nsec = 0;
 	its.it_value.tv_sec = TIMERSEC;
 	its.it_value.tv_nsec = 0;
 
-	ts.tv_sec=TIMERSEC+SLEEPDELTA;
-	ts.tv_nsec=0;
-
 	if (sigemptyset(&act.sa_mask) == -1) {
 		perror("Error calling sigemptyset");
 		return PTS_UNRESOLVED;
 	}
+
 	if (sigaction(SIGTOTEST, &act, 0) == -1) {
 		perror("Error calling sigaction");
 		return PTS_UNRESOLVED;
@@ -76,23 +76,34 @@ int main(int argc, char *argv[])
 		return PTS_UNRESOLVED;
 	}
 
+	if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &tstart) != 0) {
+		perror("clock_gettime() failed");
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
+	/*
+	 * We need to bussy loop here as the timer is set to wait for 2 seconds
+	 * of cputime of this process (which doesn't tick in any sleep function)
+	 */
+	while (!endflg);
+
+	if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &tstop) != 0) {
+		perror("clock_gettime() failed");
+		return PTS_UNRESOLVED;
 	}
 
-	if (abs(tsleft.tv_sec-SLEEPDELTA) <= ACCEPTABLEDELTA) {
-		printf("Test PASSED");
+	if (abs(tstop.tv_sec - tstart.tv_sec - TIMERSEC) <= ACCEPTABLEDELTA) {
+		printf("Test PASSED\n");
 		return PTS_PASS;
 	} else {
 		printf("Timer did not last for correct amount of time\n");
 		printf("timer: %d != correct %d\n", 
-				(int) ts.tv_sec- (int) tsleft.tv_sec,
+				(int) tstop.tv_sec - tstart.tv_sec,
 				TIMERSEC);
 		return PTS_FAIL;
 	}
@@ -100,3 +111,10 @@ int main(int argc, char *argv[])
 	return PTS_UNRESOLVED;
 #endif
 }
+#else
+int main(void)
+{
+	printf("CLOCK_PROCESS_CPUTIME_ID not supported\n");
+	return PTS_UNSUPPORTED;
+}
+#endif
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
index 83e87e4..0f7704f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
@@ -19,26 +19,30 @@
 
 #define SIGTOTEST SIGALRM
 #define TIMERSEC 2
-#define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
-void handler(int signo)
+static int endflg = 0;
+
+static void handler(int signo)
 {
-	printf("Caught signal\n");
+	endflg = 1;
 }
 
 int main(int argc, char *argv[])
 {
-	int rc;
-	rc = sysconf(_SC_THREAD_CPUTIME);
-	printf("rc = %d\n", rc);
-
-#if _POSIX_THREAD_CPUTIME != -1
+#if _POSIX_THREAD_CPUTIME == -1
+	printf("_POSIX_THREAD_CPUTIME unsupported\n");
+	return PTS_UNSUPPORTED;
+#else
 	struct sigevent ev;
 	struct sigaction act;
 	timer_t tid;
 	struct itimerspec its;
-	struct timespec ts, tsleft;
+	struct timespec tstart, tstop;
+	int rc;
+
+	rc = sysconf(_SC_THREAD_CPUTIME);
+	printf("sysconf(_SC_THREAD_CPUTIME) returns: %d\n", rc);
 
 	if (rc == -1) {
 		printf("_POSIX_THREAD_CPUTIME unsupported\n");
@@ -48,21 +52,19 @@ int main(int argc, char *argv[])
 	ev.sigev_notify = SIGEV_SIGNAL;
 	ev.sigev_signo = SIGTOTEST;
 
-	act.sa_handler=handler;
-	act.sa_flags=0;
+	act.sa_handler = handler;
+	act.sa_flags = 0;
 
 	its.it_interval.tv_sec = 0;
 	its.it_interval.tv_nsec = 0;
 	its.it_value.tv_sec = TIMERSEC;
 	its.it_value.tv_nsec = 0;
 
-	ts.tv_sec=TIMERSEC+SLEEPDELTA;
-	ts.tv_nsec=0;
-
 	if (sigemptyset(&act.sa_mask) == -1) {
 		perror("Error calling sigemptyset");
 		return PTS_UNRESOLVED;
 	}
+
 	if (sigaction(SIGTOTEST, &act, 0) == -1) {
 		perror("Error calling sigaction");
 		return PTS_UNRESOLVED;
@@ -73,31 +75,38 @@ int main(int argc, char *argv[])
 		return PTS_UNRESOLVED;
 	}
 
+	if (clock_gettime(CLOCK_THREAD_CPUTIME_ID, &tstart) != 0) {
+		perror("clock_gettime() failed");
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
+	/*
+	 * We need to bussy loop here as the timer is set to wait for 2 seconds
+	 * of cputime of this process (which doesn't tick in any sleep function)
+	 */
+	while (!endflg);
+
+	if (clock_gettime(CLOCK_THREAD_CPUTIME_ID, &tstop) != 0) {
+		perror("clock_gettime() failed");
+		return PTS_UNRESOLVED;
 	}
 
-	if (abs(tsleft.tv_sec-SLEEPDELTA) <= ACCEPTABLEDELTA) {
-		printf("Test PASSED");
+	if (abs(tstop.tv_sec - tstart.tv_sec - TIMERSEC) <= ACCEPTABLEDELTA) {
+		printf("Test PASSED\n");
 		return PTS_PASS;
 	} else {
 		printf("Timer did not last for correct amount of time\n");
 		printf("timer: %d != correct %d\n", 
-				(int) ts.tv_sec- (int) tsleft.tv_sec,
+				(int) tstop.tv_sec - tstart.tv_sec,
 				TIMERSEC);
 		return PTS_FAIL;
 	}
 
 	return PTS_UNRESOLVED;
-#else
-	printf("_POSIX_THREAD_CPUTIME unsupported\n");
-	return PTS_UNSUPPORTED;
 #endif
-
 }

--liOOAslEiF7prFVr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
--liOOAslEiF7prFVr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--liOOAslEiF7prFVr--

