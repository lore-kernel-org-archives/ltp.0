From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Dec 2016 20:37:26 +0100
Subject: [LTP] [PATCH v2 1/1] network/echo01: fix creating existing directory
Message-ID: <20161205193726.12547-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

$TCtmp directory is created by cmdlib.sh
+ cleanup: dont set $TCtmp (already set in tst_cleanup in cmdlib.sh)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* cleanup: don't set $TCtmp
---
 testcases/network/tcp_cmds/echo/echo01 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/echo/echo01 b/testcases/network/tcp_cmds/echo/echo01
index 9260f21..c111023 100755
--- a/testcases/network/tcp_cmds/echo/echo01
+++ b/testcases/network/tcp_cmds/echo/echo01
@@ -52,7 +52,6 @@ do_setup()
 
     TC=sine
     RHOST=${RHOST:-`hostname`}
-    TCtmp=${TCtmp:-$LTPROOT/testcases/bin/echo$$}
     CLEANUP=${CLEANUP:-ON}
     CREATEFILE=createfile
     ECHOES=echoes${EXEC_SUFFIX}
@@ -75,7 +74,6 @@ do_setup()
 
 do_test()
 {
-    mkdir $TCtmp
     echo  "Creating echo file $ECHOFILE"
     if ! "$LTPROOT/testcases/bin/$CREATEFILE" $ECHOSIZE "$TCtmp/$ECHOFILE"; then
         end_testcase "$ECHOFILE not created"
-- 
2.10.2

