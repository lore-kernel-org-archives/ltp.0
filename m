From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Aug 2017 18:44:29 +0200
Subject: [LTP] [RFC PATCH v8 03/11] network/stress: Simplify
	make_background_tcp_traffic usage
In-Reply-To: <20170818164437.13556-1-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
Message-ID: <20170818164437.13556-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/interface/if-addr-adddel    | 6 +-----
 testcases/network/stress/interface/if-addr-addlarge  | 6 +-----
 testcases/network/stress/interface/if-mtu-change     | 7 ++-----
 testcases/network/stress/interface/if-route-adddel   | 7 ++-----
 testcases/network/stress/interface/if-route-addlarge | 6 +-----
 testcases/network/stress/ns-tools/test_net_stress.sh | 2 ++
 6 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
index 42c2d5afa..3b1ab50bb 100644
--- a/testcases/network/stress/interface/if-addr-adddel
+++ b/testcases/network/stress/interface/if-addr-adddel
@@ -53,10 +53,9 @@ test_body()
 		return
 	fi
 
-	make_background_tcp_traffic
-
 	local cnt=1
 	while [ $cnt -le $NS_TIMES ]; do
+		make_background_tcp_traffic
 
 		case $cmd_type in
 		if_cmd)
@@ -85,9 +84,6 @@ test_body()
 
 		cnt=$(($cnt + 1))
 
-		# Check the background TCP traffic
-		pgrep -x netstress > /dev/null || make_background_tcp_traffic
-
 		case $cmd_type in
 		if_cmd)
 			if [ "$TST_IPV6" ]; then
diff --git a/testcases/network/stress/interface/if-addr-addlarge b/testcases/network/stress/interface/if-addr-addlarge
index e667d9138..c3cdb8fa9 100644
--- a/testcases/network/stress/interface/if-addr-addlarge
+++ b/testcases/network/stress/interface/if-addr-addlarge
@@ -47,8 +47,6 @@ test_body()
 		return
 	fi
 
-	make_background_tcp_traffic
-
 	local x=1
 	local y=1
 	local cnt=1
@@ -61,6 +59,7 @@ test_body()
 	fi
 
 	while [ $cnt -le $IP_TOTAL ]; do
+		make_background_tcp_traffic
 
 		if [ "$TST_IPV6" ]; then
 			local hex_x=$(printf '%x' $x)
@@ -95,9 +94,6 @@ test_body()
 
 		check_connectivity_interval $cnt || return
 
-		# Check the background TCP traffic
-		pgrep -x netstress > /dev/null || make_background_tcp_traffic
-
 		case $cmd_type in
 		if_cmd)
 			if [ "$TST_IPV6" ]; then
diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
index 5900f546a..62837ae74 100644
--- a/testcases/network/stress/interface/if-mtu-change
+++ b/testcases/network/stress/interface/if-mtu-change
@@ -65,8 +65,6 @@ test_body()
 	tst_resm TINFO "'$cmd_name changes MTU $MTU_CHANGE_TIMES times" \
 	               "every $CHANGE_INTERVAL seconds"
 
-	make_background_tcp_traffic
-
 	mtu_array_len=$(echo $CHANGE_VALUES | wc -w)
 	local cnt=0
 	while [ $cnt -lt $MTU_CHANGE_TIMES ]; do
@@ -76,6 +74,8 @@ test_body()
 		mtu=$(echo $CHANGE_VALUES | cut -d ' ' -f $field)
 		[ $cnt -eq $MTU_CHANGE_TIMES ] && mtu="$saved_mtu"
 
+		make_background_tcp_traffic
+
 		tst_resm TINFO "set MTU to $mtu $cnt/$MTU_CHANGE_TIMES"
 		local ret=0
 		case $cmd_type in
@@ -95,9 +95,6 @@ test_body()
 		tst_sleep $CHANGE_INTERVAL
 
 		EXPECT_PASS tst_ping $(tst_ipaddr) $(tst_ipaddr rhost) "1 1000 65507"
-
-		# Check the background TCP traffic
-		pgrep -x netstress > /dev/null || make_background_tcp_traffic
 	done
 }
 
diff --git a/testcases/network/stress/interface/if-route-adddel b/testcases/network/stress/interface/if-route-adddel
index 700e852a8..5189ea597 100644
--- a/testcases/network/stress/interface/if-route-adddel
+++ b/testcases/network/stress/interface/if-route-adddel
@@ -57,10 +57,10 @@ test_body()
 		return
 	fi
 
-	make_background_tcp_traffic
-
 	local cnt=1
 	while [ $cnt -le $NS_TIMES ]; do
+		make_background_tcp_traffic
+
 		case $cmd_type in
 		rt_cmd) route -A $inet add ${new_rt}${opt_rt} dev $iface ;;
 		ip_cmd) ip route add ${new_rt}${opt_rt} dev $iface ;;
@@ -81,9 +81,6 @@ test_body()
 
 		check_connectivity_interval $cnt || return
 
-		# Check the background TCP traffic
-		pgrep -x netstress > /dev/null || make_background_tcp_traffic
-
 		cnt=$(($cnt + 1))
 	done
 
diff --git a/testcases/network/stress/interface/if-route-addlarge b/testcases/network/stress/interface/if-route-addlarge
index 3337b7225..b7e6952c2 100644
--- a/testcases/network/stress/interface/if-route-addlarge
+++ b/testcases/network/stress/interface/if-route-addlarge
@@ -54,8 +54,6 @@ test_body()
 		return
 	fi
 
-	make_background_tcp_traffic
-
 	local x=1
 	local y=1
 	local cnt=1
@@ -68,6 +66,7 @@ test_body()
 	fi
 
 	while [ $cnt -le $ROUTE_TOTAL ]; do
+		make_background_tcp_traffic
 
 		if [ "$TST_IPV6" ]; then
 			local hex_x=$(printf '%x' $x)
@@ -88,9 +87,6 @@ test_body()
 
 		check_connectivity_interval $cnt || return
 
-		# Check the background TCP traffic
-		pgrep -x netstress > /dev/null || make_background_tcp_traffic
-
 		cnt=$(($cnt + 1))
 		y=$(($y + 1))
 		if [ $y -gt $xymax ]; then
diff --git a/testcases/network/stress/ns-tools/test_net_stress.sh b/testcases/network/stress/ns-tools/test_net_stress.sh
index 6173cc9bc..d7d082599 100644
--- a/testcases/network/stress/ns-tools/test_net_stress.sh
+++ b/testcases/network/stress/ns-tools/test_net_stress.sh
@@ -149,6 +149,8 @@ check_connectivity_interval()
 # IP: server IP; Default value is $(tst_ipaddr).
 make_background_tcp_traffic()
 {
+	pgrep -x netstress > /dev/null && return
+
 	local ip="${1:-$(tst_ipaddr)}"
 	local port=$(tst_get_unused_port ipv${ipver} stream)
 
-- 
2.13.2

