From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Aug 2017 15:33:47 +0200
Subject: [LTP] [PATCH v3 2/3] runltp: Add -Q switch passed to ltp-pan +
	cleanup
In-Reply-To: <20170822133348.5377-1-pvorel@suse.cz>
References: <20170822133348.5377-1-pvorel@suse.cz>
Message-ID: <20170822133348.5377-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runltp | 65 +++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/runltp b/runltp
index f519d56fa..8e40d6742 100755
--- a/runltp
+++ b/runltp
@@ -110,7 +110,7 @@ usage()
     usage: ${0##*/} [ -a EMAIL_TO ] [ -c NUM_PROCS ] [ -C FAILCMDFILE ] [ -T TCONFCMDFILE ]
     [ -d TMPDIR ] [ -D NUM_PROCS,NUM_FILES,NUM_BYTES,CLEAN_FLAG ] -e [ -f CMDFILES(,...) ]
     [ -g HTMLFILE] [ -i NUM_PROCS ] [ -l LOGFILE ] [ -m NUM_PROCS,CHUNKS,BYTES,HANGUP_FLAG ]
-    -N -n [ -o OUTPUTFILE ] -p -q [ -r LTPROOT ] [ -s PATTERN ] [ -t DURATION ]
+    -N -n [ -o OUTPUTFILE ] -p -q -Q [ -r LTPROOT ] [ -s PATTERN ] [ -t DURATION ]
     -v [ -w CMDFILEADDR ] [ -x INSTANCES ] [ -b DEVICE ] [-B LTP_DEV_FS_TYPE]
 	[ -F LOOPS,PERCENTAGE ] [ -z BIG_DEVICE ] [-Z  LTP_BIG_DEV_FS_TYPE]
 
@@ -151,7 +151,9 @@ usage()
     -n              Run LTP with network traffic in background.
     -o OUTPUTFILE   Redirect test output to a file.
     -p              Human readable format logfiles.
-    -q              Print less verbose output to screen.
+    -q              Print less verbose output to screen. This implies
+                    not logging start of the test in kernel log.
+    -Q              Don't log start of test in kernel log.
     -r LTPROOT      Fully qualified path where testsuite is installed.
     -R              Randomize test order.
     -s PATTERN      Only run test cases which match PATTERN.
@@ -182,8 +184,8 @@ exit 0
 
 main()
 {
-    local CMDFILES=""
-    local PRETTY_PRT=""
+    local CMDFILES=
+    local PRETTY_PRT=
     local ALT_DIR_OUT=0
     local ALT_DIR_RES=0
     local ALT_HTML_OUT=0
@@ -191,36 +193,37 @@ main()
     local ALT_DMESG_OUT=0
     local RUN_NETEST=0
     local RUN_REPEATED=0
-    local QUIET_MODE=""
+    local QUIET_MODE=
+    local NO_KMSG=
     local NETPIPE=0
     local GENLOAD=0
     local MEMSIZE=0
-    local DURATION=""
-    local CMDFILEADDR=""
-    local FAILCMDFILE=""
-    local TCONFCMDFILE=""
-    local INJECT_KERNEL_FAULT=""
-    local INJECT_KERNEL_FAULT_PERCENTAGE=""
-    local INJECT_FAULT_LOOPS_PER_TEST=""
-    local VALGRIND_CHECK=""
-    local VALGRIND_CHECK_TYPE=""
-    local LOGFILE_NAME=""
-    local LOGFILE=""
-    local OUTPUTFILE_NAME=""
-    local OUTPUTFILE=""
-    local HTMLFILE_NAME=""
-    local HTMLFILE=""
-    local DMESG_DIR=""
-    local EMAIL_TO=""
-    local TAG_RESTRICT_STRING=""
-    local PAN_COMMAND=""
+    local DURATION=
+    local CMDFILEADDR=
+    local FAILCMDFILE=
+    local TCONFCMDFILE=
+    local INJECT_KERNEL_FAULT=
+    local INJECT_KERNEL_FAULT_PERCENTAGE=
+    local INJECT_FAULT_LOOPS_PER_TEST=
+    local VALGRIND_CHECK=
+    local VALGRIND_CHECK_TYPE=
+    local LOGFILE_NAME=
+    local LOGFILE=
+    local OUTPUTFILE_NAME=
+    local OUTPUTFILE=
+    local HTMLFILE_NAME=
+    local HTMLFILE=
+    local DMESG_DIR=
+    local EMAIL_TO=
+    local TAG_RESTRICT_STRING=
+    local PAN_COMMAND=
     local RANDOMRUN=0
     local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%m_%d-%Hh_%Mm_%Ss"`
     local scenfile=
 
     version_date=$(cat "$LTPROOT/Version")
 
-    while getopts a:c:C:T:d:D:f:F:ehi:I:K:g:l:m:M:No:pqr:Rs:S:t:T:w:x:b:B:z:Z: arg
+    while getopts a:b:B:c:C:T:d:D:ef:F:g:hi:I:K:l:m:M:No:pqQr:Rs:S:t:T:w:x:z:Z: arg
     do  case $arg in
         a)  EMAIL_TO=$OPTARG
             ALT_EMAIL_OUT=1;;
@@ -402,9 +405,11 @@ main()
                 ALT_DIR_OUT=1 ;;
             esac ;;
 
-        p)  PRETTY_PRT=" -p ";;
+        p)  PRETTY_PRT="-p";;
 
-        q)  QUIET_MODE=" -q ";;
+        q)  QUIET_MODE="-q";;
+
+        Q)  NO_KMSG="-Q";;
 
         r)  LTPROOT=$OPTARG;;
 
@@ -451,7 +456,7 @@ main()
        LOGFILE_NAME="$DEFAULT_FILE_NAME_GENERATION_TIME"
        LOGFILE="-l $LTPROOT/results/LTP_RUN_ON-$LOGFILE_NAME.log"
        ALT_DIR_RES=1
-       PRETTY_PRT=" -p "
+       PRETTY_PRT="-p"
     fi
 
     ## It would be nice if a Failed File is compulsorily created (gives User better Idea of Tests that failed)
@@ -745,7 +750,7 @@ main()
     fi
 
     [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(date)" ; }
-    PAN_COMMAND="${LTPROOT}/bin/ltp-pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ \
+    PAN_COMMAND="${LTPROOT}/bin/ltp-pan $QUIET_MODE $NO_KMSG -e -S $INSTANCES $DURATION -a $$ \
     -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE $TCONFCMDFILE"
     echo "COMMAND:    $PAN_COMMAND"
     if [ ! -z "$TAG_RESTRICT_STRING" ] ; then
@@ -841,7 +846,7 @@ main()
 	fi
     # Some tests need to run inside the "bin" directory.
     cd "${LTPROOT}/testcases/bin"
-    "${LTPROOT}/bin/ltp-pan" $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE $TCONFCMDFILE
+    "${LTPROOT}/bin/ltp-pan" $QUIET_MODE $NO_KMSG -e -S $INSTANCES $DURATION -a $$ -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE $TCONFCMDFILE
 
     if [ $? -eq 0 ]; then
       echo "INFO: ltp-pan reported all tests PASS"
-- 
2.14.0

