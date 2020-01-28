From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Jan 2020 17:07:35 +0100
Subject: [LTP] [PATCH 2/2] rpc01.sh: Rewrite into new shell API
In-Reply-To: <20200128160735.26241-1-pvorel@suse.cz>
References: <20200128160735.26241-1-pvorel@suse.cz>
Message-ID: <20200128160735.26241-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Added rpc_lib.sh to share portmap or rpcbind check.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/rpc/basic_tests/Makefile    |  1 +
 .../network/rpc/basic_tests/rpc01/rpc01.sh    | 50 +++++++------------
 testcases/network/rpc/basic_tests/rpc_lib.sh  | 16 ++++++
 .../rpc/basic_tests/rpcinfo/rpcinfo01.sh      | 11 +---
 4 files changed, 36 insertions(+), 42 deletions(-)
 create mode 100644 testcases/network/rpc/basic_tests/rpc_lib.sh

diff --git a/testcases/network/rpc/basic_tests/Makefile b/testcases/network/rpc/basic_tests/Makefile
index 66e9d5675..7862e41e5 100644
--- a/testcases/network/rpc/basic_tests/Makefile
+++ b/testcases/network/rpc/basic_tests/Makefile
@@ -21,6 +21,7 @@
 #
 
 top_srcdir		?= ../../../..
+INSTALL_TARGETS	:= rpc_lib.sh
 
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01.sh b/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
index 7cc69f0fa..b666b1347 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
@@ -1,29 +1,15 @@
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
-
-TCID="rpc01"
-TST_TOTAL=6
-TST_CLEANUP=do_cleanup
+# Copyright (c) International Business Machines Corp., 2000
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
+TST_TESTFUNC=do_test
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
+. rpc_lib.sh
 
-NUMLOOPS=${NUMLOOPS:=3}
-DATAFILES=${DATAFILES:="file.1 file.2"}
+NUMLOOPS=${NUMLOOPS:-3}
+DATAFILES="${DATAFILES:-file.1 file.2}"
 
 do_cleanup()
 {
@@ -32,32 +18,30 @@ do_cleanup()
 
 do_setup()
 {
-	tst_resm TINFO "start rpc_server"
-	rpc_server
+	check_portmap_rpcbind
 
-	tst_resm TINFO "wait for server to be registered"
+	tst_res TINFO "start rpc_server"
+	ROD rpc_server
+
+	tst_res TINFO "wait for server to be registered"
 	for i in $(seq 1 30); do
 		rpcinfo -T udp $(tst_ipaddr) 2000333 10 >/dev/null 2>&1 && break
-		[ "$i" -eq 30 ] && tst_brkm TBROK "server not registered"
+		[ "$i" -eq 30 ] && tst_brk TBROK "server not registered"
 		tst_sleep 100ms
 	done
 }
 
 do_test()
 {
-	local thost="$(tst_ipaddr)"
+	tst_res TINFO "starting client process"
 
-	tst_resm TINFO "starting client process"
 	local cnt=1
 	while [ $cnt -le $NUMLOOPS ]; do
 		for f in $DATAFILES; do
-			EXPECT_RHOST_PASS rpc1 -s $thost -f $LTP_DATAROOT/$f
+			EXPECT_RHOST_PASS rpc1 -s $(tst_ipaddr) -f $TST_DATAROOT/$f
 		done
 		cnt=$(($cnt + 1))
 	done
 }
 
-do_setup
-do_test
-
-tst_exit
+tst_run
diff --git a/testcases/network/rpc/basic_tests/rpc_lib.sh b/testcases/network/rpc/basic_tests/rpc_lib.sh
new file mode 100644
index 000000000..6d53f07da
--- /dev/null
+++ b/testcases/network/rpc/basic_tests/rpc_lib.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+
+. tst_net.sh
+
+check_portmap_rpcbind()
+{
+	tst_res TINFO "Checking for portmap or rpcbind"
+
+	if pgrep portmap > /dev/null; then
+		PORTMAPPER="portmap"
+	else
+		pgrep rpcbind > /dev/null && PORTMAPPER="rpcbind" || \
+			tst_brk TCONF "portmap or rpcbind is not running"
+	fi
+}
diff --git a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
index 2d1d4e7ec..fd33e1533 100755
--- a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
+++ b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
@@ -6,18 +6,11 @@
 TST_TESTFUNC=do_test
 TST_SETUP=do_setup
 TST_NEEDS_TMPDIR=1
-. tst_net.sh
+. rpc_lib.sh
 
 do_setup()
 {
-	tst_res TINFO "Checking for portmap or rpcbind"
-
-	if pgrep portmap > /dev/null; then
-		PORTMAPPER="portmap"
-	else
-		pgrep rpcbind > /dev/null && PORTMAPPER="rpcbind" || \
-			tst_brk TCONF "portmap or rpcbind is not running"
-	fi
+	check_portmap_rpcbind
 
 	# Create file with 1 tcp and 1 udp line. Use for variable assignments.
 	rpcinfo -p $(tst_ipaddr) | grep tcp | sed -n 2p > rpc_out
-- 
2.24.1

