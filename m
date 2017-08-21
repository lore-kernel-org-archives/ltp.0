From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Aug 2017 16:11:06 +0200
Subject: [LTP] [PATCH v2 1/1] ltp-pan: Log start of test in kernel log
Message-ID: <20170821141106.30862-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This can be switched by new '-Q' flag or by existing '-q' flag (quiet mode).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Please use v1, if switching by '-q' is enough.
---
 pan/ltp-pan.c | 58 +++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 1614c70ff..509b866d0 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -53,6 +53,7 @@
 
 #include <sys/param.h>
 #include <sys/stat.h>
+#include <stdarg.h>
 #include <sys/times.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -97,7 +98,7 @@ struct orphan_pgrp {
 
 static pid_t run_child(struct coll_entry *colle, struct tag_pgrp *active,
 		       int quiet_mode, int *failcnt, int fmt_print,
-		       FILE * logfile);
+		       FILE * logfile, int no_kmsg);
 static char *slurp(char *file);
 static struct collection *get_collection(char *file, int optind, int argc,
 					 char **argv);
@@ -106,7 +107,7 @@ static int check_pids(struct tag_pgrp *running, int *num_active,
 		      int keep_active, FILE * logfile, FILE * failcmdfile,
 		      FILE *tconfcmdfile, struct orphan_pgrp *orphans,
 		      int fmt_print, int *failcnt, int *tconfcnt,
-		      int quiet_mode);
+		      int quiet_mode, int no_kmsg);
 static void propagate_signal(struct tag_pgrp *running, int keep_active,
 			     struct orphan_pgrp *orphans);
 static void dump_coll(struct collection *coll);
@@ -116,7 +117,7 @@ static void orphans_running(struct orphan_pgrp *orphans);
 static void check_orphans(struct orphan_pgrp *orphans, int sig);
 
 static void copy_buffered_output(struct tag_pgrp *running);
-static void write_test_start(struct tag_pgrp *running);
+static void write_test_start(struct tag_pgrp *running, int no_kmsg);
 static void write_test_end(struct tag_pgrp *running, const char *init_status,
 			   time_t exit_time, char *term_type, int stat_loc,
 			   int term_id, struct tms *tms1, struct tms *tms2);
@@ -180,12 +181,13 @@ int main(int argc, char **argv)
 	int track_exit_stats = 0;	/* exit non-zero if any test exits non-zero */
 	int fmt_print = 0;	/* enables formatted printing of logfiles. */
 	int quiet_mode = 0;	/* supresses test start and test end tags. */
+	int no_kmsg = 0;	/* don't log into /dev/kmsg */
 	int c;
 	pid_t cpid;
 	struct sigaction sa;
 
 	while ((c =
-		getopt(argc, argv, "AO:Sa:C:T:d:ef:hl:n:o:pqr:s:t:x:y"))
+		getopt(argc, argv, "AO:Sa:C:QT:d:ef:hl:n:o:pqr:s:t:x:y"))
 		       != -1) {
 		switch (c) {
 		case 'A':	/* all-stop flag */
@@ -204,6 +206,9 @@ int main(int argc, char **argv)
 		case 'C':	/* name of the file where all failed commands will be */
 			failcmdfilename = strdup(optarg);
 			break;
+		case 'Q':
+			no_kmsg = 1;
+			break;
 		case 'T':
 			/*
 			 * test cases that are not fully tested will be recorded
@@ -222,7 +227,7 @@ int main(int argc, char **argv)
 			break;
 		case 'h':	/* help */
 			fprintf(stdout,
-				"Usage: pan -n name [ -SyAehpq ] [ -s starts ]"
+				"Usage: pan -n name [ -SyAQehpq ] [ -s starts ]"
 				" [-t time[s|m|h|d] [ -x nactive ] [ -l logfile ]\n\t"
 				"[ -a active-file ] [ -f command-file ] "
 				"[ -C fail-command-file ] "
@@ -537,7 +542,7 @@ int main(int argc, char **argv)
 
 			cpid =
 			    run_child(coll->ary[c], running + i, quiet_mode,
-				      &failcnt, fmt_print, logfile);
+				      &failcnt, fmt_print, logfile, no_kmsg);
 			if (cpid != -1)
 				++num_active;
 			if ((cpid != -1 || sequential) && starts > 0)
@@ -586,7 +591,7 @@ int main(int argc, char **argv)
 
 		err = check_pids(running, &num_active, keep_active, logfile,
 				 failcmdfile, tconfcmdfile, orphans, fmt_print,
-				 &failcnt, &tconfcnt, quiet_mode);
+				 &failcnt, &tconfcnt, quiet_mode, no_kmsg);
 		if (Debug & Drunning) {
 			pids_running(running, keep_active);
 			orphans_running(orphans);
@@ -704,7 +709,7 @@ static int
 check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 	   FILE *logfile, FILE *failcmdfile, FILE *tconfcmdfile,
 	   struct orphan_pgrp *orphans, int fmt_print, int *failcnt,
-	   int *tconfcnt, int quiet_mode)
+	   int *tconfcnt, int quiet_mode, int no_kmsg)
 {
 	int w;
 	pid_t cpid;
@@ -847,7 +852,7 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 
 				if (test_out_dir) {
 					if (!quiet_mode)
-						write_test_start(running + i);
+						write_test_start(running + i, no_kmsg);
 					copy_buffered_output(running + i);
 					unlink(running[i].output);
 				}
@@ -893,7 +898,7 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 
 static pid_t
 run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
-	  int *failcnt, int fmt_print, FILE * logfile)
+	  int *failcnt, int fmt_print, FILE * logfile, int no_kmsg)
 {
 	ssize_t errlen;
 	int cpid;
@@ -945,9 +950,8 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
 	time(&active->mystime);
 	active->cmd = colle;
 
-	if (!test_out_dir)
-		if (!quiet_mode)
-			write_test_start(active);
+	if (!test_out_dir && !quiet_mode)
+		write_test_start(active, no_kmsg);
 
 	fflush(NULL);
 
@@ -1109,7 +1113,6 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
 		}
 
 		if (!quiet_mode) {
-			//write_test_start(active, errbuf);
 			write_test_end(active, errbuf, end_time, termtype,
 				       status, termid, &notime, &notime);
 		}
@@ -1352,7 +1355,24 @@ static void copy_buffered_output(struct tag_pgrp *running)
 	}
 }
 
-static void write_test_start(struct tag_pgrp *running)
+static void write_kmsg(const char *fmt, ...)
+{
+	FILE *kmsg;
+	va_list ap;
+
+	if ((kmsg = fopen("/dev/kmsg", "r+")) == NULL) {
+		fprintf(stderr, "Error %s: (%d) opening /dev/kmsg\n",
+				strerror(errno), errno);
+		exit(1);
+	}
+
+	va_start(ap, fmt);
+	vfprintf(kmsg, fmt, ap);
+	va_end(ap);
+	fclose(kmsg);
+}
+
+static void write_test_start(struct tag_pgrp *running, int no_kmsg)
 {
 	if (!strcmp(reporttype, "rts")) {
 
@@ -1362,6 +1382,14 @@ static void write_test_start(struct tag_pgrp *running)
 		     running->cmd->cmdline, "", "exit", "<<<test_output>>>");
 	}
 	fflush(stdout);
+	if (no_kmsg)
+		return;
+
+	if (strcmp(running->cmd->name, running->cmd->cmdline))
+		write_kmsg("LTP: starting %s (%s)\n", running->cmd->name,
+			   running->cmd->cmdline);
+	else
+		write_kmsg("LTP: starting %s\n", running->cmd->name);
 }
 
 static void
-- 
2.14.0

