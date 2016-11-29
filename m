From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Nov 2016 11:01:03 +0100
Subject: [LTP] [PATCH 1/1] network/echo01: fix creating existing directory
Message-ID: <20161129100103.15756-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

$TCtmp directory is created by cmdlib.sh

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/tcp_cmds/echo/echo01 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/network/tcp_cmds/echo/echo01 b/testcases/network/tcp_cmds/echo/echo01
index 9260f21..18fef9c 100755
--- a/testcases/network/tcp_cmds/echo/echo01
+++ b/testcases/network/tcp_cmds/echo/echo01
@@ -75,7 +75,6 @@ do_setup()
 
 do_test()
 {
-    mkdir $TCtmp
     echo  "Creating echo file $ECHOFILE"
     if ! "$LTPROOT/testcases/bin/$CREATEFILE" $ECHOSIZE "$TCtmp/$ECHOFILE"; then
         end_testcase "$ECHOFILE not created"
-- 
2.10.2

