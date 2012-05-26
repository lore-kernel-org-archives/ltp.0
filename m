Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SYQnw-00044W-SY
	for ltp-list@lists.sourceforge.net; Sat, 26 May 2012 23:53:52 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SYQnw-0003BO-8D
	for ltp-list@lists.sourceforge.net; Sat, 26 May 2012 23:53:52 +0000
Received: by obhx4 with SMTP id x4so4336781obh.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 26 May 2012 16:53:46 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 26 May 2012 16:53:46 -0700
Message-ID: <CAGH67wR4WAyLTm1CN-nV3hSt_qZ5OGq3ZnqgL2yJ3wX_SyOY7Q@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Fix clock_settime/4-2
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
To: LTP list <ltp-list@lists.sourceforge.net>

1. The threshold was too low; setting it to 10 seconds and adding an
   overlap of 5 seconds ensures that the SIGALRM handler fires.
2. Add a perror call when clock_settime fails.
3. Remove spurious newlines in perror calls.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
---
 .../conformance/interfaces/clock_settime/4-2.c     |   36 +++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-2.c
b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-2.c
index 75756fa..373aefd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-2.c
@@ -28,18 +28,17 @@
 #define TIMEROFFSET 9
 #define CLOCKOFFSET 4

-#define SHORTTIME 1
+#define SHORTTIME 10

 #define SIGTOTEST SIGALRM

+int test_passed;
+
 struct timespec tpreset;

 void handler(int signo)
 {
-       printf("Caught signal\n");
-       printf("Test PASSED\n");
-       setBackTime(tpreset);
-       exit(PTS_PASS);
+       test_passed = 1;
 }

 int main(int argc, char *argv[])
@@ -62,22 +61,22 @@ int main(int argc, char *argv[])
        act.sa_flags=0;

        if (sigemptyset(&act.sa_mask) != 0) {
-               perror("sigemptyset() was not successful\n");
+               perror("sigemptyset() was not successful");
                return PTS_UNRESOLVED;
        }

        if (sigaction(SIGTOTEST, &act, 0) != 0) {
-               perror("sigaction() was not successful\n");
+               perror("sigaction() was not successful");
                return PTS_UNRESOLVED;
        }

        if (clock_gettime(CLOCK_REALTIME, &tpT0) != 0) {
-               perror("clock_gettime() was not successful\n");
+               perror("clock_gettime() was not successful");
                return PTS_UNRESOLVED;
        }

        if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
-               perror("timer_create() did not return success\n");
+               perror("timer_create() did not return success");
                return PTS_UNRESOLVED;
        }

@@ -87,7 +86,7 @@ int main(int argc, char *argv[])
        its.it_value.tv_sec = tpT0.tv_sec + TIMEROFFSET;
        its.it_value.tv_nsec = tpT0.tv_nsec;
        if (timer_settime(tid, flags, &its, NULL) != 0) {
-               perror("timer_settime() did not return success\n");
+               perror("timer_settime() did not return success");
                return PTS_UNRESOLVED;
        }

@@ -95,13 +94,18 @@ int main(int argc, char *argv[])
        tpclock.tv_nsec = its.it_value.tv_nsec;
        getBeforeTime(&tpreset);
        if (clock_settime(CLOCK_REALTIME, &tpclock) != 0) {
-               printf("clock_settime() was not successful\n");
+               perror("clock_settime() was not successful");
                return PTS_UNRESOLVED;
        }

-       sleep(SHORTTIME);
-       printf("timer should have expired _immediately_\n");
-       tpreset.tv_sec += SHORTTIME;
+       sleep(1.5*SHORTTIME);
+       if (test_passed) {
+               printf("Caught signal\n");
+               printf("Test PASSED\n");
+       } else {
+               printf("timer should have expired _immediately_\n");
+               tpreset.tv_sec += SHORTTIME;
+       }
        setBackTime(tpreset);
-       return PTS_FAIL;
-}
\ No newline at end of file
+       exit(test_passed ? PTS_PASS : PTS_FAIL);
+}

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
