From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 25 Mar 2020 13:07:00 +0800
Subject: [LTP] [PATCH v2] openposix/twoptimers: handle signal correctly
In-Reply-To: <5E71F152.5010909@cn.fujitsu.com>
References: <5E71F152.5010909@cn.fujitsu.com>
Message-ID: <1585112820-30322-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Usually, when we want to get a signal to handle, we should install
customized signal handler function by using sigation. The other way
is to block this signal and use sigwait() to get the signal from its
pending list. Use sigprocmask(SIGBLOCK, &set, NULL) to make sure we
can get SIGABRT/SIGALRM signal.

Test this case on 2.6.18-398.el5, it doesn't get any signal.
higer versions than this only get SIGABRT signal.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../functional/timers/timers/twoptimers.c     | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c b/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c
index 84bea3f0a..b2657539c 100644
--- a/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c
+++ b/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c
@@ -51,6 +51,10 @@ int main(int argc, char *argv[])
 			return PTS_UNRESOLVED;
 		}
 
+		if (sigprocmask(SIG_BLOCK, &set, NULL) == -1) {
+			perror("sigprocmask() failed\n");
+			return PTS_UNRESOLVED;
+		}
 		ev.sigev_notify = SIGEV_SIGNAL;
 		ev.sigev_signo = SIGABRT;
 		if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
@@ -73,8 +77,10 @@ int main(int argc, char *argv[])
 			perror("sigwait() failed\n");
 			return PTS_UNRESOLVED;
 		}
-		printf("Got it!  Child\n");
-
+		if (sig == SIGABRT)
+			printf("Got it! Child\n");
+		else
+			printf("Got another signal! Child\n");
 		sleep(LONGTIME);
 		return CHILDPASS;
 	} else {
@@ -97,6 +103,11 @@ int main(int argc, char *argv[])
 			return PTS_UNRESOLVED;
 		}
 
+		if (sigprocmask(SIG_BLOCK, &set, NULL) == -1) {
+			perror("sigaprocmask() failed\n");
+			return PTS_UNRESOLVED;
+		}
+
 		ev.sigev_notify = SIGEV_SIGNAL;
 		ev.sigev_signo = SIGALRM;
 		if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
@@ -119,7 +130,10 @@ int main(int argc, char *argv[])
 			perror("sigwait() failed\n");
 			return PTS_UNRESOLVED;
 		}
-		printf("Got it!  Parent\n");
+		if (sig == SIGALRM)
+			printf("Got it! Parent\n");
+		else
+			printf("Got another signal! Parent\n");
 
 		if (wait(&i) == -1) {
 			perror("Error waiting for child to exit\n");
-- 
2.23.0



