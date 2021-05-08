From: Cao jin <caojin@uniontech.com>
Date: Sat,  8 May 2021 14:15:54 +0800
Subject: [LTP] [PATCH] runltp: Miscellaneous cleanups
Message-ID: <20210508061554.30645-1-caojin@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. typofix: then --> than
2. Drop useless HTML file name creating code, as g: mandatorily requires
   argument.
3. Make direcotry create symmetrical. There is no need to always see:

        INFO: creating $LTPROOT/results directory

   except the real creation of it. Also indent the code.

4. fix a variable misnomer

Signed-off-by: Cao jin <caojin@uniontech.com>
---
 runltp | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/runltp b/runltp
index 7cd0c159f..29779b853 100755
--- a/runltp
+++ b/runltp
@@ -300,7 +300,7 @@ main()
             version_of_ltp
 	    ;;
         f)  # Execute user defined set of testcases.
-            # Can be more then one file, just separate it with ',', like:
+            # Can be more than one file, just separate it with ',', like:
             # -f nfs,commands,/tmp/testfile
             CMDFILES=$OPTARG;;
 	F)	INJECT_KERNEL_FAULT=1
@@ -502,10 +502,6 @@ main()
           OUTPUTFILE_NAME="$DEFAULT_FILE_NAME_GENERATION_TIME"
           OUTPUTFILE="-o $LTPROOT/output/LTP_RUN_ON-$OUTPUTFILE_NAME.output"
           ALT_DIR_OUT=1
-          if [ ! "$HTMLFILE" ] ; then                        ## User has not mentioned HTML File name, We need to create one
-             HTMLFILE_NAME=`basename $OUTPUTFILE_NAME`
-             HTMLFILE="$LTPROOT/output/$HTMLFILE_NAME.html"
-          fi
        fi
     fi
 
@@ -522,16 +518,17 @@ main()
             }
         }
     }
+
     # If we need, create the results directory
     [ "$ALT_DIR_RES" -eq 1 ] && \
     {
-        echo "INFO: creating $LTPROOT/results directory"
         [ ! -d $LTPROOT/results ] && \
         {
-           mkdir -p $LTPROOT/results || \
-           {
-               echo "ERROR: failed to create $LTPROOT/results"
-               exit 1
+            echo "INFO: creating $LTPROOT/results directory"
+            mkdir -p $LTPROOT/results || \
+            {
+                echo "ERROR: failed to create $LTPROOT/results"
+                exit 1
             }
         }
     }
@@ -840,12 +837,12 @@ EOF
        export LTP_VERSION=$version_date
        export TEST_START_TIME="$test_start_time"
        export TEST_END_TIME="$(date)"
-       OUTPUT_DIRECTORY=`echo $OUTPUTFILE | cut -c4-`
+       OUTPUT_FILE=`echo $OUTPUTFILE | cut -c4-`
        LOGS_DIRECTORY="$LTPROOT/results"
        export TEST_OUTPUT_DIRECTORY="$LTPROOT/output"
        export TEST_LOGS_DIRECTORY=$LOGS_DIRECTORY
        echo "Generating HTML Output.....!!"
-       ( perl $LTPROOT/bin/genhtml.pl $LTPROOT/bin/html_report_header.txt test_start test_end test_output execution_status $OUTPUT_DIRECTORY  > $HTMLFILE; )
+       ( perl $LTPROOT/bin/genhtml.pl $LTPROOT/bin/html_report_header.txt test_start test_end test_output execution_status $OUTPUT_FILE  > $HTMLFILE; )
        echo "Generated HTML Output.....!!"
        echo "Location: $HTMLFILE";
 
-- 
2.20.1



