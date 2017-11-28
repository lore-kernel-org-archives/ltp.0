From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 28 Nov 2017 16:08:24 +0300
Subject: [LTP] [PATCH 2/6] network/virt_lib: use TST_NETLOAD_* parameters
In-Reply-To: <1511874508-12360-1-git-send-email-alexey.kodanev@oracle.com>
References: <1511874508-12360-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1511874508-12360-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |   37 ++++++-----------------------------
 1 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index bbac0dd..ae0b2fd 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2014-2016 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -40,38 +40,17 @@ ip6_virt_remote="$(TST_IPV6=6 tst_ipaddr_un rhost)"
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-80}
 vxlan_dstport=0
 
-clients_num=2
-client_requests=500000
-max_requests=20
-
-while getopts :hsi:r:c:R:p:n:t:d:6 opt; do
+while getopts :hi:d:6 opt; do
 	case "$opt" in
 	h)
 		echo "Usage:"
 		echo "h        help"
-		echo "s        use ssh to run remote cmds"
 		echo "i n      start ID to use"
-		echo "r n      client requests for TCP performance test"
-		echo "c n      clients run concurrently in TCP perf"
-		echo "R n      num of reqs, after which conn.closed in TCP perf"
-		echo "p x      x and x + 1 are ports in TCP perf"
-		echo "n x      virtual network 192.168.x"
-		echo "t x      performance threshold, default is 60%"
 		echo "d x      VxLAN destination address, 'uni' or 'multi'"
 		echo "6        run over IPv6"
 		exit 0
 	;;
-	s) TST_USE_SSH=1 ;;
 	i) start_id=$OPTARG ;;
-	c) clients_num=$OPTARG ;;
-	r) client_requests=$OPTARG ;;
-	R) max_requests=$OPTARG ;;
-	p) srv_port=$OPTARG ;;
-	n)
-		ip_virt_local="192.168.${OPTARG}.1"
-		ip_virt_remote="192.168.${OPTARG}.2"
-	;;
-	t) VIRT_PERF_THRESHOLD=$OPTARG ;;
 	d) vxlan_dst_addr=$OPTARG ;;
 	6) # skip, test_net library already processed it
 	;;
@@ -261,20 +240,18 @@ virt_compare_netperf()
 	local expect_res="${1:-pass}"
 	local opts="$2"
 
-	tst_netload -H $ip_virt_remote -a $clients_num -R $max_requests $opts \
-		-r $client_requests -d res_ipv4 -e $expect_res || ret1="fail"
+	tst_netload -H $ip_virt_remote $opts -d res_ipv4 -e $expect_res || \
+		ret1="fail"
 
-	tst_netload -H ${ip6_virt_remote} -a $clients_num $opts \
-		-R $max_requests -r $client_requests -d res_ipv6 \
-		-e $expect_res || ret2="fail"
+	tst_netload -H ${ip6_virt_remote} $opts -d res_ipv6 -e $expect_res || \
+		ret2="fail"
 
 	[ "$ret1" = "fail" -o "$ret2" = "fail" ] && return
 
 	local vt="$(cat res_ipv4)"
 	local vt6="$(cat res_ipv6)"
 
-	tst_netload -H $ip_remote -a $clients_num -R $max_requests $opts \
-		-r $client_requests -d res_ipv4
+	tst_netload -H $ip_remote $opts -d res_ipv4
 
 	local lt="$(cat res_ipv4)"
 	tst_resm TINFO "time lan($lt) $virt_type IPv4($vt) and IPv6($vt6) ms"
-- 
1.7.1

