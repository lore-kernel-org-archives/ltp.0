Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XWL1H-0005SF-Ec
	for ltp-list@lists.sourceforge.net; Tue, 23 Sep 2014 08:00:19 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XWL1F-0000Kk-Fo
	for ltp-list@lists.sourceforge.net; Tue, 23 Sep 2014 08:00:19 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8N80Fn3012332
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Sep 2014 16:00:15 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 23 Sep 2014 15:59:43 +0800
Message-ID: <1411459183-20272-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] runltp,
	pan/ltp-pan.c: record test cases(not fully tested) into file
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

Since commit 6f6878f4e1406d79cae53564777c5e1245d2a124, we start to
differentiate TCONF from TFAIL, but in pan/ltp-pan.c, we still write
test cases that return TCONF into failcmdfile, this is wrong, fix this.

Meanwhile we add a '-T' option for runltp, to let user record test cases
that return TCONF, namely, by this file, users can know what cases are not
fully tested.

Reported-by: Shuang Qiu <shuang.qiu@oracle.com>
Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 pan/ltp-pan.c | 52 +++++++++++++++++++++++++++++++++++++++++++---------
 runltp        | 42 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 79 insertions(+), 15 deletions(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 957199a..f495ef6 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -104,8 +104,9 @@ static struct collection *get_collection(char *file, int optind, int argc,
 static void pids_running(struct tag_pgrp *running, int keep_active);
 static int check_pids(struct tag_pgrp *running, int *num_active,
 		      int keep_active, FILE * logfile, FILE * failcmdfile,
-		      struct orphan_pgrp *orphans, int fmt_print,
-		      int *failcnt, int *tconfcnt, int quiet_mode);
+		      FILE *tconfcmdfile, struct orphan_pgrp *orphans,
+		      int fmt_print, int *failcnt, int *tconfcnt,
+		      int quiet_mode);
 static void propagate_signal(struct tag_pgrp *running, int keep_active,
 			     struct orphan_pgrp *orphans);
 static void dump_coll(struct collection *coll);
@@ -151,6 +152,7 @@ int main(int argc, char **argv)
 	char *filename = "/dev/null";	/* filename to read test tags from */
 	char *logfilename = NULL;
 	char *failcmdfilename = NULL;
+	char *tconfcmdfilename = NULL;
 	char *outputfilename = NULL;
 	struct collection *coll = NULL;
 	struct tag_pgrp *running;
@@ -158,6 +160,7 @@ int main(int argc, char **argv)
 	struct utsname unamebuf;
 	FILE *logfile = NULL;
 	FILE *failcmdfile = NULL;
+	FILE *tconfcmdfile = NULL;
 	int keep_active = 1;
 	int num_active = 0;
 	int failcnt = 0;  /* count of total testcases that failed. */
@@ -182,7 +185,8 @@ int main(int argc, char **argv)
 	struct sigaction sa;
 
 	while ((c =
-		getopt(argc, argv, "AO:Sa:C:d:ef:hl:n:o:pqr:s:t:x:y")) != -1) {
+		getopt(argc, argv, "AO:Sa:C:T:d:ef:hl:n:o:pqr:s:t:x:y"))
+		       != -1) {
 		switch (c) {
 		case 'A':	/* all-stop flag */
 			has_brakes = 1;
@@ -200,6 +204,13 @@ int main(int argc, char **argv)
 		case 'C':	/* name of the file where all failed commands will be */
 			failcmdfilename = strdup(optarg);
 			break;
+		case 'T':
+			/*
+			 * test cases that are not fully tested will be recorded
+			 * in this file
+			 */
+			tconfcmdfilename = strdup(optarg);
+			break;
 		case 'd':	/* debug options */
 			sscanf(optarg, "%i", &Debug);
 			break;
@@ -442,6 +453,16 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (tconfcmdfilename) {
+		tconfcmdfile = fopen(tconfcmdfilename, "a+");
+		if (!tconfcmdfile) {
+			fprintf(stderr, "pan(%s): Error %s (%d) opening "
+				"tconf cmd file '%s'\n", panname,
+				strerror(errno), errno, tconfcmdfilename);
+			exit(1);
+		}
+	}
+
 	if ((zoofile = zoo_open(zooname)) == NULL) {
 		fprintf(stderr, "pan(%s): %s\n", panname, zoo_error);
 		exit(1);
@@ -564,8 +585,8 @@ int main(int argc, char **argv)
 		}
 
 		err = check_pids(running, &num_active, keep_active, logfile,
-				 failcmdfile, orphans, fmt_print, &failcnt,
-				 &tconfcnt, quiet_mode);
+				 failcmdfile, tconfcmdfile, orphans, fmt_print,
+				 &failcnt, &tconfcnt, quiet_mode);
 		if (Debug & Drunning) {
 			pids_running(running, keep_active);
 			orphans_running(orphans);
@@ -635,6 +656,11 @@ int main(int argc, char **argv)
 	if (logfile && (logfile != stdout))
 		fclose(logfile);
 
+	if (failcmdfile)
+		fclose(failcmdfile);
+
+	if (tconfcmdfile)
+		fclose(tconfcmdfile);
 	exit(exit_stat);
 }
 
@@ -676,8 +702,9 @@ propagate_signal(struct tag_pgrp *running, int keep_active,
 
 static int
 check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
-	   FILE * logfile, FILE * failcmdfile, struct orphan_pgrp *orphans,
-	   int fmt_print, int *failcnt, int *tconfcnt, int quiet_mode)
+	   FILE *logfile, FILE *failcmdfile, FILE *tconfcmdfile,
+	   struct orphan_pgrp *orphans, int fmt_print, int *failcnt,
+	   int *tconfcnt, int quiet_mode)
 {
 	int w;
 	pid_t cpid;
@@ -802,10 +829,17 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 					fflush(logfile);
 				}
 
-				if ((failcmdfile != NULL) && (w != 0)) {
-					fprintf(failcmdfile, "%s %s\n",
+				if (w != 0) {
+					if (tconfcmdfile != NULL &&
+					    w == TCONF) {
+						fprintf(tconfcmdfile, "%s %s\n",
+						running[i].cmd->name,
+						running[i].cmd->cmdline);
+					} else if (failcmdfile != NULL) {
+						fprintf(failcmdfile, "%s %s\n",
 						running[i].cmd->name,
 						running[i].cmd->cmdline);
+					}
 				}
 
 				if (running[i].stopping)
diff --git a/runltp b/runltp
index ab0ae33..263c106 100755
--- a/runltp
+++ b/runltp
@@ -108,9 +108,9 @@ usage()
 {
     cat <<-EOF >&2
 
-    usage: ${0##*/} [ -a EMAIL_TO ] [ -c NUM_PROCS ] [ -C FAILCMDFILE ] [ -d TMPDIR ]
-    [ -D NUM_PROCS,NUM_FILES,NUM_BYTES,CLEAN_FLAG ] -e [ -f CMDFILES(,...) ] [ -g HTMLFILE]
-    [ -i NUM_PROCS ] [ -l LOGFILE ] [ -m NUM_PROCS,CHUNKS,BYTES,HANGUP_FLAG ]
+    usage: ${0##*/} [ -a EMAIL_TO ] [ -c NUM_PROCS ] [ -C FAILCMDFILE ] [ -T TCONFCMDFILE ]
+    [ -d TMPDIR ] [ -D NUM_PROCS,NUM_FILES,NUM_BYTES,CLEAN_FLAG ] -e [ -f CMDFILES(,...) ]
+    [ -g HTMLFILE] [ -i NUM_PROCS ] [ -l LOGFILE ] [ -m NUM_PROCS,CHUNKS,BYTES,HANGUP_FLAG ]
     -N -n [ -o OUTPUTFILE ] -p -q [ -r LTPROOT ] [ -s PATTERN ] [ -t DURATION ]
     -v [ -w CMDFILEADDR ] [ -x INSTANCES ] [ -b DEVICE ] [-B LTP_DEV_FS_TYPE]
 	[ -F LOOPS,PERCENTAGE ] [ -z BIG_DEVICE ] [-Z  LTP_BIG_DEV_FS_TYPE]
@@ -120,6 +120,7 @@ usage()
                     [NUM_PROCS = no. of processes creating the CPU Load by spinning over sqrt()
                                  (Defaults to 1 when value)]
     -C FAILCMDFILE  Command file with all failed test cases.
+    -T TCONFCMDFILE Command file with all test cases that are not fully tested.
     -d TMPDIR       Directory where temporary files will be created.
     -D NUM_PROCS,NUM_FILES,NUM_BYTES,CLEAN_FLAG
                     Run LTP under additional background Load on Secondary Storage (Seperate by comma)
@@ -197,6 +198,7 @@ main()
     local DURATION=""
     local CMDFILEADDR=""
     local FAILCMDFILE=""
+    local TCONFCMDFILE=""
     local INJECT_KERNEL_FAULT=""
     local INJECT_KERNEL_FAULT_PERCENTAGE=""
     local INJECT_FAULT_LOOPS_PER_TEST=""
@@ -217,7 +219,7 @@ main()
 
     version_date=$(cat "$LTPROOT/Version")
 
-    while getopts a:c:C:d:D:f:F:ehi:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B:z:Z: arg
+    while getopts a:c:C:T:d:D:f:F:ehi:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B:z:Z: arg
     do  case $arg in
         a)  EMAIL_TO=$OPTARG
             ALT_EMAIL_OUT=1;;
@@ -240,6 +242,15 @@ main()
                 ALT_DIR_OUT=1 ;;
             esac ;;
 
+        T)
+            case $OPTARG in
+            /*)
+                TCONFCMDFILE="-T $OPTARG" ;;
+            *)
+                TCONFCMDFILE="-T $LTPROOT/output/$OPTARG"
+                ALT_DIR_OUT=1 ;;
+            esac ;;
+
         d)  # convert the user path to absolute path.
             export TMPBASE=$(readlink -f ${OPTARG}) ;;
 
@@ -462,6 +473,22 @@ main()
          fi
     fi
 
+    if [ ! "$TCONFCMDFILE" ]; then
+         ALT_DIR_OUT=1
+         if [ ! "$OUTPUTFILE" ]; then
+            if [ ! "$LOGFILE" ]; then
+               TCONF_FILE_NAME="$DEFAULT_FILE_NAME_GENERATION_TIME"
+               TCONFCMDFILE="-T $LTPROOT/output/LTP_RUN_ON-${TCONF_FILE_NAME}.tconf"
+            else
+               TCONF_FILE_NAME=`basename $LOGFILE_NAME`
+               TCONFCMDFILE="-T $LTPROOT/output/LTP_RUN_ON-${TCONF_FILE_NAME}.tconf"
+            fi
+         else
+               TCONF_FILE_NAME=`basename $OUTPUTFILE_NAME`
+               TCONFCMDFILE="-T $LTPROOT/output/LTP_RUN_ON-${TCONF_FILE_NAME}.tconf"
+         fi
+    fi
+
     if [ "$ALT_HTML_OUT" -eq 1 ] ; then                      ## User wants the HTML version of the output
        QUIET_MODE=""                                         ## Suppressing this guy as it will prevent generation of proper output
                                                              ## which the HTML parser will require
@@ -716,7 +743,7 @@ main()
 
     [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(date)" ; }
     PAN_COMMAND="${LTPROOT}/bin/ltp-pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ \
-    -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE"
+    -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE $TCONFCMDFILE"
     echo "COMMAND:    $PAN_COMMAND"
     if [ ! -z "$TAG_RESTRICT_STRING" ] ; then
       echo "INFO: Restricted to $TAG_RESTRICT_STRING"
@@ -735,6 +762,9 @@ main()
     printf "FAILED COMMAND File: "
     echo $FAILCMDFILE | cut -b4-
 
+   printf "TCONF COMMAND File: "
+   echo $TCONFCMDFILE | cut -b4-
+
     if [ "$HTMLFILE" ]; then
        echo "HTML File: $HTMLFILE"
     fi
@@ -808,7 +838,7 @@ main()
 	fi
     # Some tests need to run inside the "bin" directory.
     cd "${LTPROOT}/testcases/bin"
-    "${LTPROOT}/bin/ltp-pan" $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE
+    "${LTPROOT}/bin/ltp-pan" $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE $TCONFCMDFILE
 
     if [ $? -eq 0 ]; then
       echo "INFO: ltp-pan reported all tests PASS"
-- 
1.8.2.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
