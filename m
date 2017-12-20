From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Dec 2017 18:33:57 +0530
Subject: [LTP] [PATCH] runltp: skipfile: skipped test cases should be
	visible as TCONF in results
Message-ID: <1513775037-30519-1-git-send-email-naresh.kamboju@linaro.org>
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
 runltp        | 8 ++++----
 runltplite.sh | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/runltp b/runltp
index 8e40d67..302c4a7 100755
--- a/runltp
+++ b/runltp
@@ -692,10 +692,10 @@ main()
     fi
 
     # Blacklist or skip tests if a SKIPFILE was specified with -S
-    if [ -n "$SKIPFILE" ]
-    then
-        for file in $( cat $SKIPFILE ); do
-            sed -i "/^$file[ \t]/d" ${TMP}/alltests
+    if [ -n "${SKIPFILE}" ]; then
+        for test_name in $(awk '{print $1}' "${SKIPFILE}"); do
+            case "${test_name}" in \#*) continue;; esac
+            sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
         done
     fi
 
diff --git a/runltplite.sh b/runltplite.sh
index 9313649..17be009 100755
--- a/runltplite.sh
+++ b/runltplite.sh
@@ -316,10 +316,10 @@ main()
     }
 
     # Blacklist or skip tests if a SKIPFILE was specified with -S
-    if [ -n "$SKIPFILE" ]
-    then
-        for file in $( cat $SKIPFILE ); do
-            sed -i "/^$file[ \t]/d" ${TMP}/alltests
+    if [ -n "${SKIPFILE}" ]; then
+        for test_name in $(awk '{print $1}' "${SKIPFILE}"); do
+            case "${test_name}" in \#*) continue;; esac
+            sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
         done
     fi
 
-- 
2.7.4

