From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  5 Feb 2021 15:20:51 +0100
Subject: [LTP] [PATCH 2/2] if-mtu-change.sh: Lower CHANGE_INTERVAL for netns
In-Reply-To: <20210205142051.32055-1-pvorel@suse.cz>
References: <20210205142051.32055-1-pvorel@suse.cz>
Message-ID: <20210205142051.32055-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to make testing faster.

NOTE: the default sleep 5s is needed for ssh based testing to prevent
link-flap errors on the switch. It can be lower down by user.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../network/stress/interface/if-mtu-change.sh      | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/network/stress/interface/if-mtu-change.sh b/testcases/network/stress/interface/if-mtu-change.sh
index d2816606b..49ac5e3fc 100755
--- a/testcases/network/stress/interface/if-mtu-change.sh
+++ b/testcases/network/stress/interface/if-mtu-change.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2017-2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
@@ -12,9 +12,13 @@ TST_CLEANUP="do_cleanup"
 
 # The interval of the mtu change [second]
 CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
-
 TST_TIMEOUT=$(((CHANGE_INTERVAL + 30) * MTU_CHANGE_TIMES))
 
+if tst_net_use_netns; then
+	CHANGE_INTERVAL="100ms"
+	TST_TIMEOUT=$((30 * MTU_CHANGE_TIMES))
+fi
+
 # The array of the value which MTU is changed into sequentially
 # 552 - net.ipv4.route.min_pmtu
 CHANGE_VALUES="784 1142 552 1500 552 1500 552 748 552 1142 1500"
@@ -65,6 +69,7 @@ find_ipv4_max_packet_size()
 
 do_setup()
 {
+
 	[ "$TST_IPV6" ] && CHANGE_VALUES=$CHANGE6_VALUES
 	if_setup
 	saved_mtu="$(cat /sys/class/net/$(tst_iface)/mtu)"
@@ -83,9 +88,10 @@ do_cleanup()
 test_body()
 {
 	local cmd="$CMD"
+	local msg="'$cmd' changes MTU $MTU_CHANGE_TIMES times every $CHANGE_INTERVAL"
 
-	tst_res TINFO "'$cmd' changes MTU $MTU_CHANGE_TIMES times" \
-	               "every $CHANGE_INTERVAL seconds"
+	tst_is_int $CHANGE_INTERVAL && msg="$msg seconds"
+	tst_res TINFO "$msg"
 
 	mtu_array_len=$(echo $CHANGE_VALUES | wc -w)
 	local cnt=0
-- 
2.30.0

