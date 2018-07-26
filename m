From: Yixin Zhang <yixin.zhang@intel.com>
Date: Thu, 26 Jul 2018 16:34:26 +0800
Subject: [LTP] [PATCH v2 ltp] runltp: fix shellcheck error for sending email
Message-ID: <20180726083426.19026-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

runltp:894:11: error: Couldn't parse this test expression. [SC1073]
runltp:894:13: error: If grouping expressions inside [..], use \( ..\). [SC1026]
runltp:894:15: error: Expected test to end here (don't wrap commands in []/[[]]).
                      Fix any mentioned problems and try again. [SC1072]

Change '-o' to '&&' according to the comment and context.
Then as "$LOGFILE_NAME" is always not empty, remove below "if" statement
and update indentation accordingly:

if [ -z "$HTMLFILE_NAME" ] && [ -z "$OUTPUTFILE_NAME" ] && [ -z "$LOGFILE_NAME" ]; then
  ##User does not have output/logs/html-output, nothing to be mailed in this situation
  echo "Nothing to be mailed here...."

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 runltp | 139 +++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 67 insertions(+), 72 deletions(-)

diff --git a/runltp b/runltp
index 24ea94fe5..3f3aa4f53 100755
--- a/runltp
+++ b/runltp
@@ -890,78 +890,73 @@ main()
 
     fi
 
-    if [ "$ALT_EMAIL_OUT" -eq 1 ] ; then                      ## User wants reports to be e-mailed
-       if [ [ ! "$HTMLFILE_NAME" ] -o [ ! "$OUTPUTFILE_NAME" ] -o [ ! "$LOGFILE_NAME" ] ] ; then
-          ##User does not have output/logs/html-output, nothing to be mailed in this situation
-          echo "Nothing to be mailed here...."
-       else
-           TAR_FILE_NAME=LTP_RUN_$version_date$DEFAULT_FILE_NAME_GENERATION_TIME.tar
-           if [ "$HTMLFILE_NAME" ] ; then                          ## HTML file Exists
-              if [ "$ALT_HTML_OUT" -ne 1 ] ; then                  ## The HTML file path is absolute and not $LTPROOT/output
-                 mkdir -p $LTPROOT/output                          ## We need to create this Directory
-                 cp $HTMLFILE_NAME $LTPROOT/output/
-              fi
-           fi
-           if [ "$OUTPUTFILE_NAME" ] ; then                        ## Output file exists
-              if [ "$ALT_DIR_OUT" -ne 1 ] ; then                   ## The Output file path is absolute and not $LTPROOT/output
-                 mkdir -p $LTPROOT/output                          ## We need to create this Directory
-                 cp $OUTPUTFILE_NAME $LTPROOT/output/
-              fi
-           fi
-           if [ "$LOGFILE_NAME" ] ; then                           ## Log file exists
-              if [ "$ALT_DIR_RES" -ne 1 ] ; then                   ## The Log file path is absolute and not $LTPROOT/results
-                 mkdir -p $LTPROOT/results                         ## We need to create this Directory
-                 cp $LOGFILE_NAME $LTPROOT/results/
-              fi
-           fi
-           if [ -d $LTPROOT/output ] ; then
-              tar -cf  ./$TAR_FILE_NAME $LTPROOT/output
-              if [ $? -eq 0 ]; then
-                 echo "Created TAR File: ./$TAR_FILE_NAME successfully, added $LTPROOT/output"
-              else
-                 echo "Cannot Create TAR File: ./$TAR_FILE_NAME for adding $LTPROOT/output"
-              fi
-           fi
-           if [ -d $LTPROOT/results ] ; then
-              tar -uf ./$TAR_FILE_NAME $LTPROOT/results
-              if [ $? -eq 0 ]; then
-                 echo "Updated TAR File: ./$TAR_FILE_NAME successfully, added $LTPROOT/results"
-              else
-                 echo "Cannot Update TAR File: ./$TAR_FILE_NAME for adding $LTPROOT/results"
-              fi
-           fi
-           if [ -e $LTPROOT/nohup.out ] ; then                     ## If User would have Chosen nohup to do ltprun
-              tar -uf ./$TAR_FILE_NAME $LTPROOT/nohup.out
-              if [ $? -eq 0 ]; then
-                 echo "Updated TAR File: ./$TAR_FILE_NAME successfully, added $LTPROOT/nohup.out"
-              else
-                 echo "Cannot Update TAR File: ./$TAR_FILE_NAME for adding $LTPROOT/nohup.out"
-              fi
-           fi
-           gzip ./$TAR_FILE_NAME                                     ## gzip this guy
-           if [ $? -eq 0 ]; then
-              echo "Gunzipped TAR File: ./$TAR_FILE_NAME"
-           else
-              echo "Cannot Gunzip TAR File: ./$TAR_FILE_NAME"
-           fi
-           if which mutt >/dev/null 2>&1; then
-              echo "Starting mailing reports to: $EMAIL_TO, file: ./$TAR_FILE_NAME.gz"
-              mutt -a ./$TAR_FILE_NAME.gz -s "LTP Reports on $test_start_time" -- $EMAIL_TO < /dev/null
-              if [ $? -eq 0 ]; then
-                 echo "Reports Successfully mailed to: $EMAIL_TO"
-              else
-                 echo "Reports cannot be mailed to: $EMAIL_TO"
-              fi
-           else ## Use our Ageold mail program
-              echo "Starting mailing reports to: $EMAIL_TO, file: ./$TAR_FILE_NAME.gz"
-              uuencode ./$TAR_FILE_NAME.gz $TAR_FILE_NAME.gz | mail  $EMAIL_TO -s "LTP Reports on $test_start_time"
-              if [ $? -eq 0 ]; then
-                 echo "Reports Successfully mailed to: $EMAIL_TO"
-              else
-                 echo "Reports cannot be mailed to: $EMAIL_TO"
-              fi
-           fi
-       fi
+    if [ "$ALT_EMAIL_OUT" -eq 1 ] ; then                    ## User wants reports to be e-mailed
+        TAR_FILE_NAME=LTP_RUN_$version_date$DEFAULT_FILE_NAME_GENERATION_TIME.tar
+        if [ "$HTMLFILE_NAME" ] ; then                      ## HTML file Exists
+            if [ "$ALT_HTML_OUT" -ne 1 ] ; then             ## The HTML file path is absolute and not $LTPROOT/output
+                mkdir -p $LTPROOT/output                    ## We need to create this Directory
+                cp $HTMLFILE_NAME $LTPROOT/output/
+            fi
+        fi
+        if [ "$OUTPUTFILE_NAME" ] ; then                    ## Output file exists
+            if [ "$ALT_DIR_OUT" -ne 1 ] ; then              ## The Output file path is absolute and not $LTPROOT/output
+                mkdir -p $LTPROOT/output                    ## We need to create this Directory
+                cp $OUTPUTFILE_NAME $LTPROOT/output/
+            fi
+        fi
+        if [ "$LOGFILE_NAME" ] ; then                       ## Log file exists
+            if [ "$ALT_DIR_RES" -ne 1 ] ; then              ## The Log file path is absolute and not $LTPROOT/results
+                mkdir -p $LTPROOT/results                   ## We need to create this Directory
+                cp $LOGFILE_NAME $LTPROOT/results/
+            fi
+        fi
+        if [ -d $LTPROOT/output ] ; then
+            tar -cf  ./$TAR_FILE_NAME $LTPROOT/output
+            if [ $? -eq 0 ]; then
+                echo "Created TAR File: ./$TAR_FILE_NAME successfully, added $LTPROOT/output"
+            else
+                echo "Cannot Create TAR File: ./$TAR_FILE_NAME for adding $LTPROOT/output"
+            fi
+        fi
+        if [ -d $LTPROOT/results ] ; then
+            tar -uf ./$TAR_FILE_NAME $LTPROOT/results
+            if [ $? -eq 0 ]; then
+                echo "Updated TAR File: ./$TAR_FILE_NAME successfully, added $LTPROOT/results"
+            else
+                echo "Cannot Update TAR File: ./$TAR_FILE_NAME for adding $LTPROOT/results"
+            fi
+        fi
+        if [ -e $LTPROOT/nohup.out ] ; then                 ## If User would have Chosen nohup to do ltprun
+            tar -uf ./$TAR_FILE_NAME $LTPROOT/nohup.out
+            if [ $? -eq 0 ]; then
+                echo "Updated TAR File: ./$TAR_FILE_NAME successfully, added $LTPROOT/nohup.out"
+            else
+                echo "Cannot Update TAR File: ./$TAR_FILE_NAME for adding $LTPROOT/nohup.out"
+            fi
+        fi
+        gzip ./$TAR_FILE_NAME                               ## gzip this guy
+        if [ $? -eq 0 ]; then
+            echo "Gunzipped TAR File: ./$TAR_FILE_NAME"
+        else
+            echo "Cannot Gunzip TAR File: ./$TAR_FILE_NAME"
+        fi
+        if which mutt >/dev/null 2>&1; then
+            echo "Starting mailing reports to: $EMAIL_TO, file: ./$TAR_FILE_NAME.gz"
+            mutt -a ./$TAR_FILE_NAME.gz -s "LTP Reports on $test_start_time" -- $EMAIL_TO < /dev/null
+            if [ $? -eq 0 ]; then
+                echo "Reports Successfully mailed to: $EMAIL_TO"
+            else
+                echo "Reports cannot be mailed to: $EMAIL_TO"
+            fi
+        else ## Use our Ageold mail program
+            echo "Starting mailing reports to: $EMAIL_TO, file: ./$TAR_FILE_NAME.gz"
+            uuencode ./$TAR_FILE_NAME.gz $TAR_FILE_NAME.gz | mail  $EMAIL_TO -s "LTP Reports on $test_start_time"
+            if [ $? -eq 0 ]; then
+                echo "Reports Successfully mailed to: $EMAIL_TO"
+            else
+                echo "Reports cannot be mailed to: $EMAIL_TO"
+            fi
+        fi
     fi
 
     [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test end time: $(date)" ; }
-- 
2.14.1

