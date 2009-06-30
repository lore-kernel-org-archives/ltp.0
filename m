Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1MLVSV-0001p4-7Y
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 05:00:43 +0000
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLVRY-0006va-Uy
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 05:00:43 +0000
Message-ID: <4A4998D3.1070105@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 10:17:15 +0530
From: gowrishankar <gomuthuk@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050508060709090901070304"
Subject: [LTP] [PATCH] realtime: use mlockall optionally in realtime tests
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net, Vernon Mauery <vernux@us.ibm.com>, Gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

This is a multi-part message in MIME format.
--------------050508060709090901070304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Subrata,
Please accept the patch below.

Thanks,
Gowri
---

realtime: use mlockall optionally in realtime tests

Below patch adds the support to enable memory lock in realtime testcases
optionally (with -m).

Testing Informations:
   Tested the realtime tests in their default profile and as well
   as using mlock option.

Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Kiran Prakash <kiran@linux.vnet.ibm.com>
Acked-by: Dinakar Guniguntala <dino@in.ibm.com>
Acked-by: Sripathi Kodi <sripathik@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---

--------------050508060709090901070304
Content-Type: text/x-patch;
 name="mlockall.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mlockall.patch"

Index: ltp-full-20090531/testcases/realtime/lib/librttest.c
===================================================================
--- ltp-full-20090531.orig/testcases/realtime/lib/librttest.c	2009-06-22 15:40:31.000000000 +0530
+++ ltp-full-20090531/testcases/realtime/lib/librttest.c	2009-06-29 12:45:27.000000000 +0530
@@ -57,6 +57,7 @@
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
+#include <sys/mman.h>
 #include <fcntl.h>
 #include <math.h>
 
@@ -77,6 +78,7 @@
 	printf("librt standard options:\n");
 	printf("  -b(0,1)	1:enable buffered output, 0:diable buffered output\n");
 	printf("  -p(0,1)	0:don't use pi mutexes, 1:use pi mutexes\n");
+	printf("  -m		use mlockall\n");
 	printf("  -v[0-4]	0:no debug, 1:DBG_ERR, 2:DBG_WARN, 3:DBG_INFO, 4:DBG_DEBUG\n");
 	printf("  -s		Enable saving stats data (default disabled)\n");
 	printf("  -c		Set pass criteria\n");
@@ -103,9 +105,10 @@
 	size_t i;
 	int c;
 	opterr = 0;
+	int mlock = 0;
 	char *all_options;
 
-	if (asprintf(&all_options, ":b:p:v:sc:%s", options) == -1) {
+	if (asprintf(&all_options, ":b:mp:v:sc:%s", options) == -1) {
 		fprintf(stderr, "Failed to allocate string for option string\n");
 		exit(1);
 	}
@@ -135,6 +138,9 @@
 		case 'p':
 			_use_pi = atoi(optarg);
 			break;
+		case 'm':
+			mlock = 1;
+			break;
 		case 'v':
 			_dbg_lvl = atoi(optarg);
 			break;
@@ -161,6 +167,12 @@
 		printf("Priority Inheritance has been disabled for this run.\n");
 	if (use_buffer)
 		buffer_init();
+	if (mlock) {
+		if (mlockall(MCL_CURRENT|MCL_FUTURE)) {
+			perror("failed to lock memory\n");
+			exit(1);
+		}
+	}
 
 	calibrate_busyloop();
 
Index: ltp-full-20090531/testcases/realtime/doc/TODO
===================================================================
--- ltp-full-20090531.orig/testcases/realtime/doc/TODO	2009-06-22 16:30:37.000000000 +0530
+++ ltp-full-20090531/testcases/realtime/doc/TODO	2009-06-22 16:30:48.000000000 +0530
@@ -2,8 +2,6 @@
 o Add libjvmsim support to all tests, e.g. matrix_mult
 o Add help output (-h option) to all tests, e.g. matrix_mult
 o Use librt debug output mechanism in all tests, e.g. matrix_mult
-o Add option to mlock_all() to all tests (probably as part of librt standard
-  options)
 
 o Add/integrate network tests
 o Add/integrate load tests
Index: ltp-full-20090531/testcases/realtime/func/measurement/preempt_timing.c
===================================================================
--- ltp-full-20090531.orig/testcases/realtime/func/measurement/preempt_timing.c	2009-06-22 16:32:41.000000000 +0530
+++ ltp-full-20090531/testcases/realtime/func/measurement/preempt_timing.c	2009-06-22 16:33:01.000000000 +0530
@@ -116,12 +116,6 @@
 		exit(-1);
 	}
 
-	if (mlockall(MCL_CURRENT)) {
-		fprintf(stderr, "Couldn't lock memory\n");
-		exit(1);
-	}
-
-
 	for(j=0; j < INTERVALS; j++){
 		/* Collect samples */
 		for(i = 0; i < ITERATIONS; i++)
Index: ltp-full-20090531/testcases/realtime/func/pi-tests/run_auto.sh
===================================================================
--- ltp-full-20090531.orig/testcases/realtime/func/pi-tests/run_auto.sh	2009-06-25 13:29:35.000000000 +0530
+++ ltp-full-20090531/testcases/realtime/func/pi-tests/run_auto.sh	2009-06-25 13:33:57.000000000 +0530
@@ -12,21 +12,21 @@
 
 # Warning: tests args are now set in profiles
 $SCRIPTS_DIR/run_c_files.sh $profile testpi-0
-$SCRIPTS_DIR/run_c_files.sh $profile testpi-1
 
-LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-1.log"
+export LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-1.log"
+$SCRIPTS_DIR/run_c_files.sh $profile testpi-1
 PYTHONPATH=../../  python parse-testpi1.py $LOG_FILE 2>&1 | tee -a $LOG_FILE
 
+export LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-2.log"
 $SCRIPTS_DIR/run_c_files.sh $profile testpi-2
-LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-2.log"
 PYTHONPATH=../../  python parse-testpi2.py $LOG_FILE 2>&1 | tee -a $LOG_FILE
 
+export LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-4.log"
 $SCRIPTS_DIR/run_c_files.sh $profile testpi-4
-LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-4.log"
 PYTHONPATH=../../  python parse-testpi1.py $LOG_FILE 2>&1 | tee -a $LOG_FILE 
 
 
-
+export LOG_FILE=""
 $SCRIPTS_DIR/run_c_files.sh $profile testpi-5
 $SCRIPTS_DIR/run_c_files.sh $profile testpi-6
 $SCRIPTS_DIR/run_c_files.sh $profile sbrk_mutex
Index: ltp-full-20090531/testcases/realtime/scripts/run_c_files.sh
===================================================================
--- ltp-full-20090531.orig/testcases/realtime/scripts/run_c_files.sh	2009-06-25 13:29:25.000000000 +0530
+++ ltp-full-20090531/testcases/realtime/scripts/run_c_files.sh	2009-06-25 13:36:03.000000000 +0530
@@ -10,7 +10,6 @@
 # pattern "testid testname" and runs the corresponding test with the
 # args defined in the line.
 
-
 [ $# -lt 2 ] && { echo >&2 "$0: too few arguments (at least two)" ; exit 1 ; }
 profile=$1
 shift
@@ -37,7 +36,9 @@
 			shift 2
 			params="$*"
 
-			LOG_FILE="$LOG_DIR/$LOG_FORMAT-${cmd}${params// /}.log"
+			if [ "$LOG_FILE" = "" ]; then
+				LOG_FILE="$LOG_DIR/$LOG_FORMAT-${cmd}${params// /}.log"
+			fi
 			[ ! -d $LOG_DIR ] && mkdir -p $LOG_DIR
 
 			( 

--------------050508060709090901070304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------050508060709090901070304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050508060709090901070304--

