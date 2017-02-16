From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Feb 2017 23:37:21 +0100
Subject: [LTP] [PATCH v3 4/4] network: migrate rpc_test.sh to use test_net.sh
In-Reply-To: <20170216223721.11493-1-pvorel@suse.cz>
References: <20170216223721.11493-1-pvorel@suse.cz>
Message-ID: <20170216223721.11493-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes missing LTPROOT environment variable.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I got these errors:
* -c (TI-RPC tests)
rpc_clnt_broadcast 1 TBROK: 'rpc_clnt_broadcast 10.0.0.2 536875000 ' failed on '': 'RPC: Timed out
rpc_svc_destroy 1 TBROK: 'rpc_svc_destroy 10.0.0.2 536875000 ' failed on '': 'rpc_svc_destroy: svc_fd_create: could not retrieve local addr
rpc_svcfd_create 1 TBROK: 'rpc_svcfd_create 10.0.0.2 536875000 ' failed on '': 'rpc_svcfd_create: svc_fd_create: could not retrieve local addr
rpc_xprt_register 1 TBROK: 'rpc_xprt_register 10.0.0.2 536875000 ' failed on '': 'rpc_xprt_register: svc_fd_create: could not retrieve local addr
rpc_xprt_unregister 1 TBROK: 'rpc_xprt_unregister 10.0.0.2 536875000 ' failed on '': 'rpc_xprt_unregister: svc_fd_create: could not retrieve local addr

* -d (TS-RPC tests)
tirpc_authdes_create 1 TBROK: 'tirpc_authdes_create 10.0.0.2 536875000 ' failed on '': '1'
tirpc_authdes_seccreate 1 TBROK: 'tirpc_authdes_seccreate 10.0.0.2 536875000 ' failed on '': '1'

I tested it with libtirpc3 1.0.1-3 from Tumbleweed and with libtirpc1 0.2.5-1.1 on Debian
testing.
---
 testcases/network/rpc/rpc-tirpc/rpc_test.sh | 66 ++++++++++-------------------
 1 file changed, 22 insertions(+), 44 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index 17fc5ed09..e265725f0 100755
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
+		killall -9 $SERVER
+		$CLEANER $PROGNUMNOSVC
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
@@ -99,21 +81,17 @@ fi
 TCID="$CLIENT"
 TST_TOTAL=1
 TST_COUNT=1
-. test.sh
 TST_CLEANUP=cleanup
 
+. test_net.sh
+
 if [ ! -z "$SERVER" ]; then
-	run_cmd "$SERVER $PROGNUMNOSVC" &
+	$SERVER $PROGNUMNOSVC &
 	sleep "$SERVER_STARTUP_SLEEP"
 fi
 
-"$CLIENT" "$SERVER_HOST" "$PROGNUMNOSVC" $CLIENT_EXTRA_OPTS
-ret=$?
+tst_rhost_run -sc "$CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS"
 
-if [ "$ret" -eq 0 ]; then
-	tst_resm TPASS "Test passed"
-else
-	tst_resm TFAIL "Test failed"
-fi
+tst_resm TPASS "Test passed"
 
 tst_exit
-- 
2.11.0

