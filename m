From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  8 Feb 2017 15:44:59 +0100
Subject: [LTP] [PATCH v2 3/4] network: Minor doc,
	copyright and whitespace fixes
In-Reply-To: <20170208144500.27340-1-pvorel@suse.cz>
References: <20170208144500.27340-1-pvorel@suse.cz>
Message-ID: <20170208144500.27340-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh |  3 ++-
 testscripts/network.sh    | 18 +++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 37cc93914..64c17e924 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
-# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2016 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2016-2017 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
diff --git a/testscripts/network.sh b/testscripts/network.sh
index fce59f576..ada4dec84 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -26,7 +26,7 @@ usage()
 	echo "  -t    TCP/IP command tests"
 	echo "  -c    TI-RPC tests"
 	echo "  -s    TS-RPC tests"
-	echo "  -a    Application tests (HTTP, SSH, DNS)"
+	echo "  -a    Application stress tests (HTTP, SSH, DNS)"
 	echo "  -e    Interface stress tests"
 	echo "  -b    Stress tests with malformed ICMP packets"
 	echo "  -i    IPsec ICMP stress tests"
@@ -46,11 +46,11 @@ while getopts 6mnrstaebcsiTURMFf:Vvh OPTION
 do
 	case $OPTION in
 	6) TEST_CASES="$TEST_CASES net.ipv6 net.ipv6_lib";;
-	m) TEST_CASES="$TEST_CASES net.multicast" ;;
-	n) TEST_CASES="$TEST_CASES net.nfs" ;;
-	r) TEST_CASES="$TEST_CASES net.rpc" ;;
-	s) TEST_CASES="$TEST_CASES net.sctp" ;;
-	t) TEST_CASES="$TEST_CASES net.tcp_cmds" ;;
+	m) TEST_CASES="$TEST_CASES net.multicast";;
+	n) TEST_CASES="$TEST_CASES net.nfs";;
+	r) TEST_CASES="$TEST_CASES net.rpc";;
+	s) TEST_CASES="$TEST_CASES net.sctp";;
+	t) TEST_CASES="$TEST_CASES net.tcp_cmds";;
 	c) TEST_CASES="$TEST_CASES net.rpc_tests";;
 	s) TEST_CASES="$TEST_CASES net.tirpc_tests";;
 	a) TEST_CASES="$TEST_CASES net_stress.appl";;
@@ -62,10 +62,10 @@ do
 	R) TEST_CASES="$TEST_CASES net_stress.route";;
 	M) TEST_CASES="$TEST_CASES net_stress.multicast";;
 	F) TEST_CASES="$TEST_CASES net.features";;
-	f) TEST_CASES=${OPTARG} ;;
+	f) TEST_CASES=${OPTARG};;
 	V|v) VERBOSE="yes";;
-	h) usage; exit 0 ;;
-	*) echo "Error: invalid option..."; usage; exit 1 ;;
+	h) usage; exit 0;;
+	*) echo "Error: invalid option..."; usage; exit 1;;
 	esac
 done
 
-- 
2.11.0

