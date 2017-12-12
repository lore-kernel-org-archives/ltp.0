From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 12 Dec 2017 15:47:10 +0530
Subject: [LTP] [PATCH] runltp: skipfile: skipped test cases should be
	visible as TCONF in results
Message-ID: <1513073830-17174-1-git-send-email-naresh.kamboju@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When we skip tests in LTP by using "./runltp -S SKIPFILE", they get removed
from the test list completely, leaving no trace in the results.

This patch will add SKIPFILE listed test cases names to results as TCONF.
when testcase_name listed in SKIPFILE the main alltests will get that
testcase_name followed by exit 32;

Example:
  SKIPFILE the user defined content
  $ cat SKIPFILE
  testcase_name

  $ ./runltp -f syscalls -S SKIPFILE

  The runtime generated alltests file gets as
  $ cat alltests
  testcase_name exit 32;

  The final results file shows as
  $ cat results
  testcase_name TCONF

The good practise with SKIPFILE is,
tests listed in a SKIPFILE should be a single testcase_name per line.
However, test script takes only first column by using awk {print $1}

We can add comments inside SKIPFILE starting with #
The script will ignore line starting with #

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 runltp        | 14 +++++++++-----
 runltplite.sh | 14 +++++++++-----
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/runltp b/runltp
index 8e40d67..10c5960 100755
--- a/runltp
+++ b/runltp
@@ -692,11 +692,15 @@ main()
     fi
 
     # Blacklist or skip tests if a SKIPFILE was specified with -S
-    if [ -n "$SKIPFILE" ]
-    then
-        for file in $( cat $SKIPFILE ); do
-            sed -i "/^$file[ \t]/d" ${TMP}/alltests
-        done
+    if [ -n "${SKIPFILE}" ]; then
+        while read -r test_line; do
+            case "${test_line}" in \#*) continue ;; esac
+            if [ -n "${test_line}" ]; then
+                # test_name is first column of each line in SKIPFILE
+                test_name=$(echo ${test_line} | awk '{print $1}')
+                sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
+            fi
+        done < ${SKIPFILE}
     fi
 
     # check for required users and groups
diff --git a/runltplite.sh b/runltplite.sh
index 9313649..e05fb3f 100755
--- a/runltplite.sh
+++ b/runltplite.sh
@@ -316,11 +316,15 @@ main()
     }
 
     # Blacklist or skip tests if a SKIPFILE was specified with -S
-    if [ -n "$SKIPFILE" ]
-    then
-        for file in $( cat $SKIPFILE ); do
-            sed -i "/^$file[ \t]/d" ${TMP}/alltests
-        done
+    if [ -n "${SKIPFILE}" ]; then
+        while read -r test_line; do
+            case "${test_line}" in \#*) continue ;; esac
+            if [ -n "${test_line}" ]; then
+                # test_name is first column of each line in SKIPFILE
+                test_name=$(echo ${test_line} | awk '{print $1}')
+                sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
+            fi
+        done < ${SKIPFILE}
     fi
 
     # display versions of installed software
-- 
2.7.4

