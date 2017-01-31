From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Jan 2017 19:35:46 +0100
Subject: [LTP] [PATCH 4/4] network: migrate rpc_test.sh to use test_net.sh
In-Reply-To: <20170131183546.26993-1-pvorel@suse.cz>
References: <20170131183546.26993-1-pvorel@suse.cz>
Message-ID: <20170131183546.26993-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes missing LTPROOT environment variable.

Many tests are failing when using netns.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dctcp/dctcp01.sh          |  1 +
 testcases/network/rpc/rpc-tirpc/rpc_test.sh | 29 ++++++-----------------------
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/testcases/network/dctcp/dctcp01.sh b/testcases/network/dctcp/dctcp01.sh
index 5c401ce82..97154ca8e 100755
--- a/testcases/network/dctcp/dctcp01.sh
+++ b/testcases/network/dctcp/dctcp01.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index 17fc5ed09..30f84c56e 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -17,16 +17,7 @@
 # Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # This is a wrapper script to execute tests from the RPC/TI-RPC tests
-# suite (http://nfsv4.bullopensource.org/doc/rpc_testsuite.php) in LTP
-#
-# This wrapper uses the RHOST environment variable:
-#
-# If the RHOST variable is set, then the rpc server instance (if needed)
-# is started on RHOST, using rsh, and the client program is passed
-# the RHOST value.
-#
-# If the RHOST variable is not set, then the rpc server instance (if needed)
-# is started on the local host, and the client program is passed `hostname`.
+# suite (http://nfsv4.bullopensource.org/doc/rpc_testsuite.php) in LTP.
 
 SERVER_HOST=${RHOST:-`hostname`}
 SERVER=""
@@ -37,20 +28,11 @@ CLEANER=""
 PROGNUMNOSVC=536875000
 SERVER_STARTUP_SLEEP=1
 
-run_cmd()
-{
-	if [ ! -z "$RHOST" ]; then
-		rsh -n "$RHOST" "$1"
-	else
-		$1
-	fi
-}
-
 cleanup()
 {
 	if [ ! -z "$SERVER" ]; then
-		run_cmd "killall -9 $SERVER"
-		run_cmd "$CLEANER $PROGNUMNOSVC"
+		tst_rhost_run -c "killall -9 $SERVER"
+		tst_rhost_run -c "$CLEANER $PROGNUMNOSVC"
 	fi
 }
 
@@ -99,11 +81,12 @@ fi
 TCID="$CLIENT"
 TST_TOTAL=1
 TST_COUNT=1
-. test.sh
 TST_CLEANUP=cleanup
 
+. test_net.sh
+
 if [ ! -z "$SERVER" ]; then
-	run_cmd "$SERVER $PROGNUMNOSVC" &
+	tst_rhost_run -c "$SERVER $PROGNUMNOSVC" &
 	sleep "$SERVER_STARTUP_SLEEP"
 fi
 
-- 
2.11.0

