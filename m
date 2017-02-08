From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  8 Feb 2017 15:45:00 +0100
Subject: [LTP] [PATCH v2 4/4] network: migrate rpc_test.sh to use test_net.sh
In-Reply-To: <20170208144500.27340-1-pvorel@suse.cz>
References: <20170208144500.27340-1-pvorel@suse.cz>
Message-ID: <20170208144500.27340-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes missing LTPROOT environment variable.

Many tests are failing when using netns.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/rpc/rpc-tirpc/rpc_test.sh | 59 ++++++++++-------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index 17fc5ed09..03fc70d4a 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 #
 # Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -17,18 +18,8 @@
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
 
-SERVER_HOST=${RHOST:-`hostname`}
 SERVER=""
 CLIENT=""
 CLIENT_EXTRA_OPTS=""
@@ -37,38 +28,29 @@ CLEANER=""
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
 
 usage()
 {
-	echo "USAGE: $0 [-s sprog] -c clprog [ -e extra ]"
-	echo ""
-	echo "sprog   - server program binary"
-	echo "clprog  - client program binary"
-	echo "extra   - extra client options"
-	echo ""
-	echo "This scripts connects to the RHOST host by rsh and starts"
-	echo "sprog there. After that it executes clprog passing it the"
-	echo "RHOST value."
-	echo "After the test completes, this script kills sprog on RHOST"
-	echo "and performs a cleaning operation."
-	echo ""
-	echo "If RHOST is not set, the local host is used."
+	cat << EOF
+USAGE: $0 [-s sprog] -c clprog [ -e extra ]
+
+sprog   - server program binary
+clprog  - client program binary
+extra   - extra client options
+
+This scripts connects to the remote host and starts sprog there. After that it
+executes clprog passing it the remote host value.
+
+After the test completes, this script kills sprog on remote and performs a
+cleaning operation.
+EOF
 
 	exit 1
 }
@@ -99,15 +81,16 @@ fi
 TCID="$CLIENT"
 TST_TOTAL=1
 TST_COUNT=1
-. test.sh
 TST_CLEANUP=cleanup
 
+. test_net.sh
+
 if [ ! -z "$SERVER" ]; then
-	run_cmd "$SERVER $PROGNUMNOSVC" &
+	tst_rhost_run -b -c "$SERVER $PROGNUMNOSVC"
 	sleep "$SERVER_STARTUP_SLEEP"
 fi
 
-"$CLIENT" "$SERVER_HOST" "$PROGNUMNOSVC" $CLIENT_EXTRA_OPTS
+"$CLIENT" "$(tst_ipaddr rhost)" "$PROGNUMNOSVC" $CLIENT_EXTRA_OPTS
 ret=$?
 
 if [ "$ret" -eq 0 ]; then
-- 
2.11.0

