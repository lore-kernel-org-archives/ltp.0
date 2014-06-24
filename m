Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WzKwL-0003xa-Tx
	for ltp-list@lists.sourceforge.net; Tue, 24 Jun 2014 07:14:49 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WzKwJ-0004hV-8r
	for ltp-list@lists.sourceforge.net; Tue, 24 Jun 2014 07:14:49 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5O7Ecl2031935
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Jun 2014 15:14:39 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 24 Jun 2014 15:11:39 +0800
Message-ID: <1403593899-17040-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1403593899-17040-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1403593899-17040-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] pan/ltp-pan.c: add statistics about not fully
	tested testcases
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
To: ltp-list@lists.sourceforge.net

Currently numbers of testcases in LTP will return TCONF when they are not
appropriate to run. But when users execute './runltp' to run the default
test suite towards an linux distribution or upstream kernel, if testcases
return TCONF, ultimately they will print TPASS to users, then users will
not know the real LTP test coverage.

Here we change this behaviour and show users testcases which return TCONF,
meaning that these testcases are not fully tested.

Here is a sample:
1. Before this patch, The output will be:
Test Start Time: Tue Jun 24 14:32:15 2014
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
access01                       PASS       0
access02                       PASS       0
access03                       PASS       0
getxattr01                     PASS       0
getxattr02                     PASS       0
access04                       PASS       0
ext4-nsec-timestamps           PASS       0
ext4-uninit-groups             PASS       0
access05                       PASS       0
access06                       PASS       0

-----------------------------------------------
Total Tests: 10
Total Failures: 0
Kernel Version: 3.16.0-rc1+
Machine Architecture: x86_64
Hostname: localhost.localdomain

2. After this patch, the output will be:
Test Start Time: Tue Jun 24 14:28:27 2014
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
access01                       PASS       0
access02                       PASS       0
access03                       PASS       0
getxattr01                     TCONF      32
getxattr02                     TCONF      32
access04                       PASS       0
ext4-nsec-timestamps           TCONF      32
ext4-uninit-groups             TCONF      32
access05                       PASS       0
access06                       PASS       0

-----------------------------------------------
Total Tests: 10
Total Skipped Tests: 4
Total Failures: 0
Kernel Version: 3.16.0-rc1+
Machine Architecture: x86_64
Hostname: localhost.localdomain

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h            | 17 +----------------
 include/tst_result_flag.h | 30 ++++++++++++++++++++++++++++++
 lib/tst_res.c             |  2 +-
 pan/ltp-pan.c             | 29 +++++++++++++++++++++--------
 testcases/lib/test.sh     |  2 +-
 5 files changed, 54 insertions(+), 26 deletions(-)
 create mode 100644 include/tst_result_flag.h

diff --git a/include/test.h b/include/test.h
index 97ce0f0..57e01c2 100644
--- a/include/test.h
+++ b/include/test.h
@@ -47,22 +47,7 @@
 #include "tst_checkpoint.h"
 #include "tst_process_state.h"
 #include "tst_resource.h"
-
-/* Use low 6 bits to encode test type */
-#define TTYPE_MASK 0x3f
-#define TPASS      0    /* Test passed flag */
-#define TFAIL      1    /* Test failed flag */
-#define TBROK      2    /* Test broken flag */
-#define TWARN      4    /* Test warning flag */
-#define TRETR      8    /* Test retire flag */
-#define TINFO      16   /* Test information flag */
-#define TCONF      32   /* Test not appropriate for configuration flag */
-#define TTYPE_RESULT(ttype) ((ttype) & TTYPE_MASK)
-
-#define TERRNO     0x100   /* Append errno information to output */
-#define TTERRNO    0x200   /* Append TEST_ERRNO information to output */
-#define TRERRNO    0x300   /* Capture errno information from TEST_RETURN to
-			      output; useful for pthread-like APIs :). */
+#include "tst_result_flag.h"
 
 /* virt types for tst_is_virt() */
 #define VIRT_XEN	1	/* xen dom0/domU */
diff --git a/include/tst_result_flag.h b/include/tst_result_flag.h
new file mode 100644
index 0000000..7c8be30
--- /dev/null
+++ b/include/tst_result_flag.h
@@ -0,0 +1,30 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#ifndef __TST_RESULT_FLAG_H__
+#define __TST_RESULT_FLAG_H__
+
+/* Use low 6 bits to encode test type */
+#define TTYPE_MASK	0x3f
+#define TPASS	0	/* Test passed flag */
+#define TFAIL	1	/* Test failed flag */
+#define TBROK	2	/* Test broken flag */
+#define TWARN	4	/* Test warning flag */
+#define TRETR	8	/* Test retire flag */
+#define TINFO	16	/* Test information flag */
+#define TCONF	32	/* Test not appropriate for configuration flag */
+#define TTYPE_RESULT(ttype)	((ttype) & TTYPE_MASK)
+
+#define TERRNO	0x100	/* Append errno information to output */
+#define TTERRNO	0x200	/* Append TEST_ERRNO information to output */
+#define TRERRNO	0x300	/* Capture errno information from TEST_RETURN to
+			   output; useful for pthread-like APIs :). */
+
+#endif
diff --git a/lib/tst_res.c b/lib/tst_res.c
index c179e31..31186e0 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -563,7 +563,7 @@ void tst_exit(void)
 	tst_flush();
 
 	/* Mask out TRETR, TINFO, and TCONF results from the exit status. */
-	exit(T_exitval & ~(TRETR | TINFO | TCONF));
+	exit(T_exitval & ~(TRETR | TINFO));
 }
 
 pid_t tst_fork(void)
diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 9324f47..d6edd3d 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -67,6 +67,7 @@
 
 #include "splitstr.h"
 #include "zoolib.h"
+#include "tst_result_flag.h"
 
 /* One entry in the command line collection.  */
 struct coll_entry {
@@ -104,7 +105,7 @@ static void pids_running(struct tag_pgrp *running, int keep_active);
 static int check_pids(struct tag_pgrp *running, int *num_active,
 		      int keep_active, FILE * logfile, FILE * failcmdfile,
 		      struct orphan_pgrp *orphans, int fmt_print,
-		      int *failcnt, int quiet_mode);
+		      int *failcnt, int *tconfcnt, int quiet_mode);
 static void propagate_signal(struct tag_pgrp *running, int keep_active,
 			     struct orphan_pgrp *orphans);
 static void dump_coll(struct collection *coll);
@@ -160,6 +161,8 @@ int main(int argc, char **argv)
 	int keep_active = 1;
 	int num_active = 0;
 	int failcnt = 0;	/* count of total testcases that failed. */
+	/* count of total testcases that return TCONF */
+	int tconfcnt = 0;
 	int err, i;
 	int starts = -1;
 	int timed = 0;
@@ -563,7 +566,7 @@ int main(int argc, char **argv)
 
 		err = check_pids(running, &num_active, keep_active, logfile,
 				 failcmdfile, orphans, fmt_print, &failcnt,
-				 quiet_mode);
+				 &tconfcnt, quiet_mode);
 		if (Debug & Drunning) {
 			pids_running(running, keep_active);
 			orphans_running(orphans);
@@ -623,6 +626,7 @@ int main(int argc, char **argv)
 		fprintf(logfile,
 			"\n-----------------------------------------------\n");
 		fprintf(logfile, "Total Tests: %d\n", coll->cnt);
+		fprintf(logfile, "Total Skipped Tests: %d\n", tconfcnt);
 		fprintf(logfile, "Total Failures: %d\n", failcnt);
 		fprintf(logfile, "Kernel Version: %s\n", unamebuf.release);
 		fprintf(logfile, "Machine Architecture: %s\n",
@@ -674,7 +678,7 @@ propagate_signal(struct tag_pgrp *running, int keep_active,
 static int
 check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 	   FILE * logfile, FILE * failcmdfile, struct orphan_pgrp *orphans,
-	   int fmt_print, int *failcnt, int quiet_mode)
+	   int fmt_print, int *failcnt, int *tconfcnt, int quiet_mode)
 {
 	int w;
 	pid_t cpid;
@@ -683,6 +687,7 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 	int i;
 	time_t t;
 	char *status;
+	char *result_str;
 	int signaled = 0;
 	struct tms tms1, tms2;
 	clock_t tck;
@@ -730,7 +735,7 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 					"child %d exited with status %d\n",
 					cpid, w);
 			--*num_active;
-			if (w != 0)
+			if (w != 0 && w != TCONF)
 				ret++;
 		} else if (WIFSTOPPED(stat_loc)) {	/* should never happen */
 			w = WSTOPSIG(stat_loc);
@@ -777,13 +782,21 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 							(int)(tms2.tms_cstime -
 							      tms1.tms_cstime));
 					else {
-						if (w != 0)
-							++ * failcnt;
+						if (strcmp(status, "exited") ==
+						    0 && w == TCONF) {
+							++*tconfcnt;
+							result_str = "TCONF";
+						} else if (w != 0) {
+							++*failcnt;
+							result_str = "FAIL";
+						} else {
+							result_str = "PASS";
+						}
+
 						fprintf(logfile,
 							"%-30.30s %-10.10s %-5d\n",
 							running[i].cmd->name,
-							((w !=
-							  0) ? "FAIL" : "PASS"),
+							result_str,
 							w);
 					}
 
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 25248d9..b6eb5e8 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -82,7 +82,7 @@ tst_exit()
 	fi
 
 	# Mask out TRETR, TINFO and TCONF
-	exit $((LTP_RET_VAL & ~(8 | 16 | 32)))
+	exit $((LTP_RET_VAL & ~(8 | 16)))
 }
 
 tst_tmpdir()
-- 
1.8.2.1


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
