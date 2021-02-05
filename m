From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  5 Feb 2021 16:10:14 +0100
Subject: [LTP] [PATCH 3/4] net/multicast: Remove duplicity
In-Reply-To: <20210205151015.7465-1-pvorel@suse.cz>
References: <20210205151015.7465-1-pvorel@suse.cz>
Message-ID: <20210205151015.7465-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../multicast/grp-operation/mcast-lib.sh       | 18 +++++++++++++++++-
 .../multicast/query-flood/mcast-queryfld01.sh  | 13 ++-----------
 .../multicast/query-flood/mcast-queryfld02.sh  | 14 ++++----------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
index 851aadd5b..555501df7 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines Corp., 2006
 # Author: Petr Vorel <pvorel@suse.cz>
 #
@@ -141,3 +141,19 @@ do_multicast_test_join_leave()
 
 	tst_res TPASS "test is finished successfully"
 }
+
+do_multicast_test_join_single_socket()
+{
+	local extra="$1"
+	local prefix="$MCAST_IPV4_ADDR_PREFIX"
+	[ "$TST_IPV6" ] && prefix="$MCAST_IPV6_ADDR_PREFIX"
+
+	# Run a multicast join tool
+	local tmpfile=$$
+	EXPECT_PASS $MCAST_LCMD -n 1 -p $prefix \> $tmpfile
+	tst_res TINFO "joined $(grep groups $tmpfile)"
+
+	local params
+	[ "$TST_IPV6" ] && params="-S $(tst_ipaddr) -m"
+	EXPECT_RHOST_PASS $MCAST_RCMD -t $NS_DURATION -r 0 $params $extra
+}
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh
index faa1c08ef..e80026720 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2006 International Business Machines  Corp.
 # Copyright (c) 2020 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 #
 # Verify that the kernel is not crashed when joining a multicast group
@@ -18,18 +19,8 @@ do_test()
 {
 	tst_res TINFO "joining an IPv${TST_IPVER} multicast group on a single socket, then receiving a large number of General Queries in $NS_DURATION seconds"
 
-	local prefix="$MCAST_IPV4_ADDR_PREFIX"
-	[ "$TST_IPV6" ] && prefix="$MCAST_IPV6_ADDR_PREFIX"
-
-	# Run a multicast join tool
-	local tmpfile=$$
-	EXPECT_PASS $MCAST_LCMD -n 1 -p $prefix \> $tmpfile
-	tst_res TINFO "joined $(grep groups $tmpfile)"
-
 	# Send General Query from the remote host
-	local params
-	[ "$TST_IPV6" ] && params="-S $(tst_ipaddr) -m"
-	EXPECT_RHOST_PASS $MCAST_RCMD -t $NS_DURATION -r 0 $params
+	do_multicast_test_join_single_socket
 }
 
 tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh
index 66012a6f3..8773bd86b 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2006 International Business Machines  Corp.
 # Copyright (c) 2020 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 #
 # Verify that the kernel is not crashed when joining a multicast group
@@ -19,18 +20,11 @@ do_test()
 {
 	tst_res TINFO "joining an IPv${TST_IPVER} multicast group on a single socket, then receiving a large number of Multicast Address Specific Query in $NS_DURATION seconds"
 
-	local prefix="$MCAST_IPV4_ADDR_PREFIX"
-	[ "$TST_IPV6" ] && prefix="$MCAST_IPV6_ADDR_PREFIX"
-
-	# Run a multicast join tool
-	local tmpfile=$$
-	EXPECT_PASS $MCAST_LCMD -n 1 -p $prefix \> $tmpfile
-	tst_res TINFO "joined $(grep groups $tmpfile)"
+	local extra="-m $MCAST_IPV4_ADDR"
+	[ "$TST_IPV6" ] && extra="-D $MCAST_IPV6_ADDR"
 
 	# Send IGMP Multicast Address Specific Query from the remote host
-	local params="-m $MCAST_IPV4_ADDR"
-	[ "$TST_IPV6" ] && params="-S $(tst_ipaddr) -m -D $MCAST_IPV6_ADDR"
-	EXPECT_RHOST_PASS $MCAST_RCMD -t $NS_DURATION -r 0 $params
+	do_multicast_test_join_single_socket "$extra"
 }
 
 tst_run
-- 
2.30.0

