Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1MfiPH-0004h3-8t
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 22:52:55 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfiPC-0003v4-IA
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 22:52:55 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7OMBESG011533
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 18:11:14 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7OMCPA4238656
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 18:12:25 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7OMCOuA001343
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 18:12:25 -0400
Message-ID: <4A931047.7030000@us.ibm.com>
Date: Mon, 24 Aug 2009 15:12:23 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH][realtime] Use librttest arg parsing and init_pi_mutex
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
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: gowrishankar.m@in.ibm.com, Paul McKenney <paulmck@linux.vnet.ibm.com>

Use librttest arg parsing and init_pi_mutex

This patch converts pthread_cond_many to use the librttest infrastructure
for argument parsing and mutex initialization.  The default behavior of the
test changes from using a non-pi mutex to a pi mutex.  This is because -p
defaults to 1 in librttest.  We could update run.sh with -p0, but I feel
inside a realtime testsuite this test should be using PI mutexes anyway.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Acked-by: Gowrishankar <gowrishankar.m@in.ibm.com>
CC: Paul McKenney <paulmck@linux.vnet.ibm.com>

Index: realtime/perf/latency/pthread_cond_many.c
===================================================================
--- realtime.orig/perf/latency/pthread_cond_many.c	2009-08-03 14:47:01.000000000 -0700
+++ realtime/perf/latency/pthread_cond_many.c	2009-08-03 14:51:01.000000000 -0700
@@ -24,12 +24,12 @@
  *
  * USAGE:
  *      Use run_auto.sh script in current directory to build and run test.
- *      Use "-j" to enable jvm simulator.
  *
  * AUTHOR
  *      Paul E. McKenney <paulmck@us.ibm.com>
  *
  * HISTORY
+ *      librttest parsing, threading, and mutex initialization - Darren Hart
  *
  *
  *****************************************************************************/
@@ -46,10 +46,12 @@
 #include <librttest.h>
 #include <libstats.h>
 #define PASS_US 100
-pthread_mutex_t child_mutex = PTHREAD_MUTEX_INITIALIZER;
+pthread_mutex_t child_mutex;
 volatile int *child_waiting = NULL;
 double endtime;
 pthread_cond_t *condlist = NULL;
+int iterations = 0;
+int nthreads = 0;
 int realtime = 0;
 int broadcast_flag = 0;
 unsigned long latency = 0;
@@ -242,42 +244,68 @@
 	printf("Standard Deviation: %f\n", stats_stddev(&dat));
 }
 
-void
-usage(char *progname)
+void usage(void)
 {
-	fprintf(stderr,
-		"Usage: %s [--realtime] [--broadcast] iterations nthreads\n",
-		progname);
-	printf("currently options are not supported\n");
-	exit(-1);
+	rt_help();
+	printf("pthread_cond_many specific options:\n");
+	printf("  -r,--realtime   run with realtime priority\n");
+	printf("  -b,--broadcast  use cond_broadcast instead of cond_signal\n");
+	printf("  -iITERATIONS    iterations (required)\n");
+	printf("  -nNTHREADS      number of threads (required)\n");
+	printf("deprecated unnamed arguments:\n");
+	printf("  pthread_cond_many [options] iterations nthreads\n");
+}
+
+int parse_args(int c, char *v)
+{
+	int handled;
+        switch (c) {
+		case 'h':
+			usage();
+			exit(0);
+                case 'a':
+			broadcast_flag = 1;
+                        break;
+		case 'i':
+			iterations = atoi(v);
+			break;
+		case 'n':
+			nthreads = atoi(v);
+			break;
+		case 'r':
+			realtime = 1;
+			break;
+                default:
+                        handled = 0;
+                        break;
+        }
+        return handled;
 }
 
 int
 main(int argc, char *argv[])
 {
-	int i = 1;
-	long iter;
-	long nthreads;
+	struct option longopts[] = {
+		{"broadcast", 0, NULL, 'a'},
+		{"realtime", 0, NULL, 'r'},
+		{NULL, 0, NULL, 0},
+	};
 	setup();
 
-	while (i < argc) {
-		if (strcmp(argv[i], "--realtime") == 0) {
-			realtime = 1;
-			i++;
-		} else if (strcmp(argv[i], "--broadcast") == 0) {
-			broadcast_flag = 1;
-			i++;
-		} else if (argv[i][0] == '-') {
-			usage(argv[0]);
-		} else {
-			break;
-		}
-	}
-	if (argc - i < 2) {
-		usage(argv[0]);
+	init_pi_mutex(&child_mutex);
+	rt_init_long("ahi:n:r", longopts, parse_args, argc, argv);
+
+	/* Legacy command line arguments support, overrides getopt args. */
+	if (optind < argc)
+		iterations = strtol(argv[optind++], NULL, 0);
+	if (optind < argc)
+		nthreads = strtol(argv[optind++], NULL, 0);
+
+	/* Ensure we have the required arguments. */
+	if (iterations == 0 || nthreads == 0) {
+		usage();
+		exit(1);
 	}
-	iter = strtol(argv[i], NULL, 0);
-	nthreads = strtol(argv[i + 1], NULL, 0);
 
 	child_waiting = (int *)malloc(sizeof(*child_waiting) * nthreads);
 	condlist = (pthread_cond_t *)malloc(sizeof(*condlist) * nthreads);
@@ -285,7 +313,7 @@
 		fprintf(stderr, "Out of memory\n");
 		exit(-1);
 	}
-	test_signal(iter, nthreads);
+	test_signal(iterations, nthreads);
 	printf("\nCriteria: latencies < %d us\n", PASS_US);
 	printf("Result: %s\n", fail ? "FAIL" : "PASS");
 	return 0;
Index: realtime/perf/latency/run.sh
===================================================================
--- realtime.orig/perf/latency/run.sh	2009-08-03 14:47:01.000000000 -0700
+++ realtime/perf/latency/run.sh	2009-08-03 14:47:33.000000000 -0700
@@ -35,11 +35,11 @@
 rm -f $nthread.$iter.$nproc.*.out
 
 i=0
-./pthread_cond_many --realtime  --broadcast $iter $nthread > $nthread.$iter.$nproc.$i.out &
+./pthread_cond_many --realtime --broadcast -i $iter -n $nthread > $nthread.$iter.$nproc.$i.out &
 i=1
 while test $i -lt $nproc
 do
-        ./pthread_cond_many --broadcast $iter $nthread > $nthread.$iter.$nproc.$i.out &
+        ./pthread_cond_many --broadcast -i $iter -n $nthread > $nthread.$iter.$nproc.$i.out &
         i=`expr $i + 1`
 done
 wait
-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
