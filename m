From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri, 20 Apr 2018 11:18:55 +0800
Subject: [LTP] [PATCH ltp 6/6] network/tcp_cmds/rcp/rcp01: Fix shellcheck
	issue SC2157/SC2069
In-Reply-To: <20180420031855.22657-1-yixin.zhang@intel.com>
References: <20180420031855.22657-1-yixin.zhang@intel.com>
Message-ID: <20180420031855.22657-6-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

error: Argument to implicit -n is always true due to literal strings. [SC2157]
error: The order of the 2>&1 and the redirect matters. The 2>&1 has to be last. [SC2069]

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/network/tcp_cmds/rcp/rcp01 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/tcp_cmds/rcp/rcp01 b/testcases/network/tcp_cmds/rcp/rcp01
index 1f54471cd..4eaeca175 100755
--- a/testcases/network/tcp_cmds/rcp/rcp01
+++ b/testcases/network/tcp_cmds/rcp/rcp01
@@ -55,7 +55,7 @@ do_setup()
 
     exists awk rcp rsh sum
 
-    if ! rsh -n -l root $RHOST mkdir -p $TCtmp 2>&1 1>/dev/null; then
+    if ! rsh -n -l root $RHOST mkdir -p $TCtmp >/dev/null 2>&1; then
         end_testcase "Remote mkdir failed"
     fi
 
@@ -83,7 +83,7 @@ do_test()
         rsh -n -l root $RHOST "rm -f $TCtmp/$j"
         sleep $SLEEPTIME
 
-        if [ "$SUM1 = $SUM2" ]; then
+        if [ "$SUM1" = "$SUM2" ]; then
             tst_resm TINFO "rcp $TCdat/$j $RHOST:$TCtmp/$j successful"
         else
             end_testcase "FAILED: wrong sum in transfer to $RHOST"
@@ -96,7 +96,7 @@ do_test()
     for j in $FILES; do
 
         tst_resm TINFO "remote copying $RHOST:$TCdat/$j to $TCtmp/$j"
-        if ! rcp $RHOST:$TCdat/$j $TCtmp/$j 2>&1 1>/dev/null; then
+        if ! rcp $RHOST:$TCdat/$j $TCtmp/$j >/dev/null 2>&1; then
             tst_resm TFAIL "Failed to rcp file."; continue
         fi
 
-- 
2.14.1

