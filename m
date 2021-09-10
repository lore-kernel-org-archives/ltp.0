From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Sep 2021 15:08:19 +0200
Subject: [LTP] [PATCH v2 6/7] sched/process.c: Remove non-Linux code
In-Reply-To: <20210910130820.21141-1-pvorel@suse.cz>
References: <20210910130820.21141-1-pvorel@suse.cz>
Message-ID: <20210910130820.21141-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

as we don't care about other platforms.
Also remove -D_LINUX definition from Makefile.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/sched/process_stress/Makefile      |  2 -
 .../kernel/sched/process_stress/process.c     | 67 +------------------
 2 files changed, 2 insertions(+), 67 deletions(-)

diff --git a/testcases/kernel/sched/process_stress/Makefile b/testcases/kernel/sched/process_stress/Makefile
index 011017c65..48c825bd9 100644
--- a/testcases/kernel/sched/process_stress/Makefile
+++ b/testcases/kernel/sched/process_stress/Makefile
@@ -24,6 +24,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CPPFLAGS		+= -D_LINUX
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index 1fd520eee..b66908e7a 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -27,16 +27,9 @@
 #include <string.h>
 #include <time.h>
 #include <unistd.h>
-
-#ifndef _LINUX
-			/* LINUX INCLUDES */
-#include <sys/mode.h>
-#include <sys/timers.h>
-#else
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/ipc.h>
-#endif
 #include <sys/msg.h>
 #include <sys/resource.h>
 #include <sys/select.h>
@@ -53,17 +46,14 @@
 #define MAXBVAL 70
 #define MAXDVAL 11
 
-#ifdef _LINUX
-			/* LINUX #defnes */
 #ifndef TRUE
 #define TRUE 1
 #endif
 #ifndef FALSE
 #define FALSE 0
 #endif
-#endif
 
-#if defined _LINUX && defined DEBUG
+#ifdef DEBUG
 #define prtln()	printf("At line number: %d\n", __LINE__); \
 		fflush(NULL)
 #define dprt(fmt, args...) printf(fmt, ## args)
@@ -78,9 +68,7 @@
 #define    DVAL  (*edat[DNDX].eval.vint)	/* depth of process tree */
 #define    TVAL  (*edat[TNDX].eval.vint)	/* timer value */
 
-#ifdef _LINUX
 typedef long mtyp_t;
-#endif
 
 /* structure of information stored about each process in shared memory */
 typedef struct proc_info {
@@ -346,9 +334,6 @@ void nextofkin(int sig, int code, struct sigcontext *scp)
 		severe("msgsnd failed: %d msgid %d mtyp %d mtext %d\n",
 		       errno, msgerr, 3, mtext);
 	}
-#ifndef _LINUX
-	reltimerid(timer);
-#endif
 	exit(1);
 }
 
@@ -799,25 +784,14 @@ void set_signals(void *sighandler())
 
 	action.sa_handler = (void *)sighandler;
 
-#ifdef _LINUX
 	sigfillset(&action.sa_mask);
-#else
-	SIGINITSET(action.sa_mask);
-#endif
 	action.sa_flags = 0;
 
 	/* Set the signal handler up */
-#ifdef _LINUX
 	sigaddset(&action.sa_mask, SIGTERM);
-#else
-	SIGADDSET(action.sa_mask, SIGTERM);
-#endif
+
 	for (i = 0; siginfo[i].signum != -1; i++) {
-#ifdef _LINUX
 		sigaddset(&action.sa_mask, siginfo[i].signum);
-#else
-		SIGADDSET(action.sa_mask, siginfo[i].signum);
-#endif
 		rc = sigaction(siginfo[i].signum, &action, NULL);
 		if (rc == -1) {
 			sprintf(tmpstr, "sigaction: %s\n", siginfo[i].signame);
@@ -833,36 +807,6 @@ void set_signals(void *sighandler())
 /*
 * Get and set a timer for current process.
 */
-#ifndef _LINUX
-void set_timer(void)
-{
-	struct itimerstruc_t itimer, old_itimer;
-
-	if ((timer = gettimerid(TIMERID_REAL, DELIVERY_SIGNALS)) == -1) {
-		perror("gettimerid");
-		fprintf(stderr, " SEVERE : Could not get timer id, errno=%d.",
-			errno);
-		exit(1);
-	}
-
-	/*
-	 * Start the timer.
-	 */
-	itimer.it_interval.tv_nsec = 0;
-	itimer.it_interval.tv_sec = 0;
-	itimer.it_value.tv_nsec = 0;
-	itimer.it_value.tv_sec = (time_t) (TVAL * 60.0);
-	if (incinterval(timer, &itimer, &old_itimer) == -1) {
-		perror("incinterval");
-		fprintf(stderr,
-			" SEVERE : Could not set timer interval, errno=%d.",
-			errno);
-		(void)reltimerid(timer);
-		exit(1);
-	}
-}
-#else
-
 void set_timer(void)
 {
 	struct itimerval itimer;
@@ -881,7 +825,6 @@ void set_timer(void)
 		exit(1);
 	}
 }
-#endif
 
 /*
  * parse_args
@@ -1157,11 +1100,7 @@ void doit(void)
 #endif
 		/* set the process group so we can terminate all children */
 		set_signals((void *)nextofkin);	/* set up signal handlers and initialize pgrp */
-#ifndef _LINUX
-		procgrp = setpgrp(0, 0);
-#else
 		procgrp = setpgrp();
-#endif
 		if (AUSDEBUG) {
 			fprintf(stderr, "process group: %d\n", procgrp);
 			fflush(stderr);
@@ -1239,7 +1178,6 @@ int main(int argc, char *argv[])
 	parse_args(argc, argv);	/* Get all command line arguments */
 	dprt("value of BVAL = %d, value of DVAL = %d\n", BVAL, DVAL);
 	nodesum = sumit(BVAL, DVAL);
-#ifdef _LINUX
 	if (nodesum > 250) {
 		printf("total number of process to be created "
 		       "nodesum (%d) is greater\n than the allowed "
@@ -1247,7 +1185,6 @@ int main(int argc, char *argv[])
 		printf("reseting the value of nodesum to SEMMSL\n");
 		nodesum = 250;
 	}
-#endif
 
 	dprt("value of nodesum is initiallized to: %d\n", nodesum);
 
-- 
2.33.0

