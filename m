From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Jan 2020 17:07:34 +0100
Subject: [LTP] [PATCH 1/2] rpcinfo01.sh: Rewrite into new shell API
Message-ID: <20200128160735.26241-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../rpc/basic_tests/rpcinfo/rpcinfo01.sh      | 53 ++++++-------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
index afdfdb351..2d1d4e7ec 100755
--- a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
+++ b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
@@ -1,54 +1,38 @@
 #!/bin/sh
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2000
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
+# Copyright (c) International Business Machines Corp., 2000
 
-TCID="rpcinfo01"
-TST_TOTAL=16
-TST_CLEANUP=tst_rmdir
-
-TST_USE_LEGACY_API=1
+TST_TESTFUNC=do_test
+TST_SETUP=do_setup
+TST_NEEDS_TMPDIR=1
 . tst_net.sh
 
 do_setup()
 {
-	tst_resm TINFO "Checking for portmap or rpcbind"
+	tst_res TINFO "Checking for portmap or rpcbind"
 
 	if pgrep portmap > /dev/null; then
 		PORTMAPPER="portmap"
 	else
 		pgrep rpcbind > /dev/null && PORTMAPPER="rpcbind" || \
-			tst_brkm TCONF "portmap or rpcbind is not running"
+			tst_brk TCONF "portmap or rpcbind is not running"
 	fi
 
-	tst_tmpdir
-
 	# Create file with 1 tcp and 1 udp line. Use for variable assignments.
 	rpcinfo -p $(tst_ipaddr) | grep tcp | sed -n 2p > rpc_out
 	rpcinfo -p $(tst_ipaddr) | grep udp | sed -n 2p >> rpc_out
 
-	wc -l rpc_out | grep "2" > /dev/null || \
-		tst_brkm TBROK "Not enough programs registered on $(tst_ipaddr)"
+	wc -l rpc_out | grep -q "2" || \
+		tst_brk TBROK "Not enough programs registered on $(tst_ipaddr)"
 
 	# Using "rpc_out" file created above, assign variables for rpcinfo opts
-	TPNUM=`grep tcp rpc_out | awk '{print $1}'`
-	TVNUM=`grep tcp rpc_out | awk '{print $2}'`
-	TCPNAME=`grep tcp rpc_out | awk '{print $5}'`
-	UPNUM=`grep udp rpc_out | awk '{print $1}'`
-	UVNUM=`grep udp rpc_out | awk '{print $2}'`
-	UDPNAME=`grep udp rpc_out | awk '{print $5}'`
+	TPNUM=$(grep tcp rpc_out | awk '{print $1}')
+	TVNUM=$(grep tcp rpc_out | awk '{print $2}')
+	TCPNAME=$(grep tcp rpc_out | awk '{print $5}')
+	UPNUM=$(grep udp rpc_out | awk '{print $1}')
+	UVNUM=$(grep udp rpc_out | awk '{print $2}')
+	UDPNAME=$(grep udp rpc_out | awk '{print $5}')
 }
 
 do_test()
@@ -65,7 +49,7 @@ do_test()
 	EXPECT_RHOST_PASS rpcinfo -u $thost portmapper
 	EXPECT_RHOST_PASS rpcinfo -u $thost portmapper 2
 
-	tst_resm TINFO "Test rpcinfo with missing or bad options"
+	tst_res TINFO "Test rpcinfo with missing or bad options"
 	EXPECT_RHOST_FAIL rpcinfo -p bogushost
 	EXPECT_RHOST_FAIL rpcinfo -bogusflag
 	EXPECT_RHOST_FAIL rpcinfo -t $thost
@@ -75,7 +59,4 @@ do_test()
 	EXPECT_RHOST_FAIL rpcinfo -u $thost 100000 5
 }
 
-do_setup
-do_test
-
-tst_exit
+tst_run
-- 
2.24.1

