From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 May 2021 15:50:10 +0200
Subject: [LTP] [PATCH 1/3] tst_net.sh: Move check_portmap_rpcbind() + fixes
Message-ID: <20210525135012.877-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

move from rpc_lib.sh, because it'll be used also in NFS tests.

Fixes:
* check for pgrep
* local and lowercase for variable

And remove rpc_lib.sh, as check_portmap_rpcbind() was the only function
in it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh                       | 18 +++++++++++++++++-
 testcases/network/rpc/basic_tests/Makefile     |  1 -
 .../network/rpc/basic_tests/rpc01/rpc01.sh     |  2 +-
 testcases/network/rpc/basic_tests/rpc_lib.sh   | 15 ---------------
 .../rpc/basic_tests/rpcinfo/rpcinfo01.sh       |  2 +-
 testcases/network/rpc/rpc-tirpc/rpc_test.sh    |  2 +-
 6 files changed, 20 insertions(+), 20 deletions(-)
 delete mode 100644 testcases/network/rpc/basic_tests/rpc_lib.sh

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index fc5719057..d793541e2 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2016-2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2016-2021 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 [ -n "$TST_LIB_NET_LOADED" ] && return 0
@@ -933,6 +933,22 @@ tst_default_max_pkt()
 	echo "$((mtu + mtu / 10))"
 }
 
+check_portmap_rpcbind()
+{
+	local portmapper
+
+	tst_require_cmds pgrep
+
+	if pgrep portmap > /dev/null; then
+		portmapper="portmap"
+	else
+		pgrep rpcbind > /dev/null && portmapper="rpcbind" || \
+			tst_brk TCONF "portmap or rpcbind is not running"
+	fi
+
+	tst_res TINFO "using $portmapper"
+}
+
 # Management Link
 [ -z "$RHOST" ] && TST_USE_NETNS="yes"
 export RHOST="$RHOST"
diff --git a/testcases/network/rpc/basic_tests/Makefile b/testcases/network/rpc/basic_tests/Makefile
index 7862e41e5..66e9d5675 100644
--- a/testcases/network/rpc/basic_tests/Makefile
+++ b/testcases/network/rpc/basic_tests/Makefile
@@ -21,7 +21,6 @@
 #
 
 top_srcdir		?= ../../../..
-INSTALL_TARGETS	:= rpc_lib.sh
 
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01.sh b/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
index 9ca5daae6..7a8ff75e6 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
@@ -7,7 +7,7 @@ TST_TESTFUNC=do_test
 TST_SETUP=do_setup
 TST_CLEANUP=do_cleanup
 TST_NEEDS_CMDS="pkill rpcinfo"
-. rpc_lib.sh
+. tst_net.sh
 
 NUMLOOPS=${NUMLOOPS:-3}
 DATAFILES="${DATAFILES:-file.1 file.2}"
diff --git a/testcases/network/rpc/basic_tests/rpc_lib.sh b/testcases/network/rpc/basic_tests/rpc_lib.sh
deleted file mode 100644
index c7c868709..000000000
--- a/testcases/network/rpc/basic_tests/rpc_lib.sh
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
-
-. tst_net.sh
-
-check_portmap_rpcbind()
-{
-	if pgrep portmap > /dev/null; then
-		PORTMAPPER="portmap"
-	else
-		pgrep rpcbind > /dev/null && PORTMAPPER="rpcbind" || \
-			tst_brk TCONF "portmap or rpcbind is not running"
-	fi
-	tst_res TINFO "using $PORTMAPPER"
-}
diff --git a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
index 811f79ef7..0a371ceac 100755
--- a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
+++ b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
@@ -7,7 +7,7 @@ TST_TESTFUNC=do_test
 TST_SETUP=do_setup
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="rpcinfo wc"
-. rpc_lib.sh
+. tst_net.sh
 
 do_setup()
 {
diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index ffb58769d..48ed97742 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -17,7 +17,7 @@ TST_SETUP=setup
 TST_CLEANUP=cleanup
 TST_PARSE_ARGS=rpc_parse_args
 TST_NEEDS_CMDS="pkill rpcinfo"
-. rpc_lib.sh
+. tst_net.sh
 
 usage()
 {
-- 
2.31.1

