Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Xj4Ep-00064X-9V
	for ltp-list@lists.sourceforge.net; Tue, 28 Oct 2014 10:42:55 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xj4Eo-0007uj-9m
	for ltp-list@lists.sourceforge.net; Tue, 28 Oct 2014 10:42:55 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s9SAgmUP006501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Oct 2014 10:42:48 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9SAgl48005595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Oct 2014 10:42:48 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9SAgl6m005588
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Oct 2014 10:42:47 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 28 Oct 2014 13:44:36 +0400
Message-Id: <1414489476-29110-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] network/vxlan03.sh: add IPv6 tunneling through IPv4
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/vxlan/vxlan03.sh   |    6 ++--
 testcases/network/vxlan/vxlan_lib.sh |   66 +++++++++++++++++++--------------
 2 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/testcases/network/vxlan/vxlan03.sh b/testcases/network/vxlan/vxlan03.sh
index 7ce496e..26f27b5 100755
--- a/testcases/network/vxlan/vxlan03.sh
+++ b/testcases/network/vxlan/vxlan03.sh
@@ -18,9 +18,9 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
-# Test-case 1: Requires remote host, test will setup virtual sub-net
-#              192.168.124.*/24 between two hosts, then will compare
-#              TCP performance with and without VXLAN (tcp_fastopen test).
+# Test-case 1: It requires remote host. Test will setup IPv4 and IPv6 virtual
+#              sub-nets between two hosts, then will compare TCP performance
+#              with and without VxLAN using ping or tcp_fastopen test.
 #
 # Test-case 2: The same as above but must fail, because VXLAN allows
 #              to communicate only within the same VXLAN segment.
diff --git a/testcases/network/vxlan/vxlan_lib.sh b/testcases/network/vxlan/vxlan_lib.sh
index 6d0a2d0..bef5b14 100644
--- a/testcases/network/vxlan/vxlan_lib.sh
+++ b/testcases/network/vxlan/vxlan_lib.sh
@@ -32,10 +32,12 @@ user_name="root"
 
 ip_local=${IPV4_NETWORK}.${LHOST_IPV4_HOST}
 ip_vxlan_local="192.168.124.1"
+ip6_vxlan_local="fe80::381c:c0ff:fea8:7c01"
 mac_vxlan_local="3A:1C:C0:A8:7C:01"
 
 ip_remote=${IPV4_NETWORK}.${RHOST_IPV4_HOST}
 ip_vxlan_remote="192.168.124.2"
+ip6_vxlan_remote="fe80::381c:c0ff:fea8:7c02"
 mac_vxlan_remote="3A:1C:C0:A8:7C:02"
 
 vxlan_max=5000
@@ -112,22 +114,27 @@ vxlan_setup_subnet()
 	tst_resm TINFO "virtual bridge & VXLAN, connect 2 hosts"
 	local opt="rsc proxy nolearning"
 
-	safe_run "ip link add ltp_vxl0 type vxlan id $1 $opt"
-	safe_run "ip link set ltp_vxl0 address $mac_vxlan_local"
-	safe_run "ip address add ${ip_vxlan_local}/24 dev ltp_vxl0"
-	safe_run "ip link set up ltp_vxl0"
+	safe_run "ip li add ltp_vxl0 type vxlan id $1 $opt"
+	safe_run "ip li set ltp_vxl0 address $mac_vxlan_local"
+	safe_run "ip addr add ${ip_vxlan_local}/24 dev ltp_vxl0"
+	safe_run "ip li set up ltp_vxl0"
 
-	safe_run "arp -s $ip_vxlan_remote $mac_vxlan_remote -i ltp_vxl0"
+	safe_run "ip neigh add $ip_vxlan_remote \
+	          lladdr $mac_vxlan_remote dev ltp_vxl0"
+	safe_run "ip neigh add $ip6_vxlan_remote \
+	          lladdr $mac_vxlan_remote dev ltp_vxl0"
 	safe_run "bridge fdb add to $mac_vxlan_remote dst $ip_remote \
 	          dev ltp_vxl0"
 
-	tst_rhost_run -s -c "ip link add ltp_vxl0 type vxlan id $2 $opt"
-	tst_rhost_run -s -c "ip link set ltp_vxl0 address $mac_vxlan_remote"
-	tst_rhost_run -s -c "ip address add ${ip_vxlan_remote}/24 dev ltp_vxl0"
-	tst_rhost_run -s -c "ip link set up ltp_vxl0"
+	tst_rhost_run -s -c "ip li add ltp_vxl0 type vxlan id $2 $opt"
+	tst_rhost_run -s -c "ip li set ltp_vxl0 address $mac_vxlan_remote"
+	tst_rhost_run -s -c "ip addr add ${ip_vxlan_remote}/24 dev ltp_vxl0"
+	tst_rhost_run -s -c "ip li set up ltp_vxl0"
 
-	tst_rhost_run -s -c "arp -s $ip_vxlan_local $mac_vxlan_local \
-	                     -i ltp_vxl0"
+	tst_rhost_run -s -c "ip neigh add $ip_vxlan_local \
+	                     lladdr $mac_vxlan_local dev ltp_vxl0"
+	tst_rhost_run -s -c "ip neigh add $ip6_vxlan_local \
+	                     lladdr $mac_vxlan_local dev ltp_vxl0"
 	tst_rhost_run -s -c "bridge fdb add to $mac_vxlan_local dst $ip_local \
 	                     dev ltp_vxl0"
 }
@@ -140,18 +147,21 @@ netload_test()
 
 	case "$net_load" in
 	PING)
-		tst_resm TINFO "run ping test with rhost '$ip_addr'..."
+		local ipv6=
+		echo "$ip_addr" | grep ":" > /dev/null
+		[ $? -eq 0 ] && ipv6=6
+		tst_resm TINFO "run ping${ipv6} test with rhost '$ip_addr'..."
 		local res=
-		res=$(ping -f -c $client_requests $ip_addr -w 600 2>&1)
+		res=$(ping${ipv6} -f -c $client_requests $ip_addr -w 600 2>&1)
 		[ $? -ne 0 ] && return 1
 		echo $res | sed -nE 's/.*time ([0-9]+)ms.*/\1/p' > $rfile
 	;;
 	TFO)
-		tst_resm TINFO "run tcp_fastopen test with rhost '$ip_addr'"
 		local port=
-		port=$(tst_rhost_run -c 'tst_get_unused_port ipv4 stream')
+		port=$(tst_rhost_run -c 'tst_get_unused_port ipv6 stream')
 		[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
 
+		tst_resm TINFO "run tcp_fastopen with '$ip_addr', port '$port'"
 		tst_rhost_run -s -b -c "tcp_fastopen -R $max_requests -g $port"
 
 		sleep 5
@@ -175,28 +185,28 @@ netload_test()
 vxlan_compare_netperf()
 {
 	local ret=0
-	local res_file="${TMPDIR}/vxlan_result"
-
-	netload_test $ip_vxlan_remote $res_file || ret=1
+	netload_test $ip_vxlan_remote res_ipv4 || ret=1
+	netload_test ${ip6_vxlan_remote}%ltp_vxl0 res_ipv6 || ret=1
 
 	safe_run "ip link delete ltp_vxl0"
 	tst_rhost_run -s -c "ip link delete ltp_vxl0"
 	[ "$ret" -eq 1 ] && return 1
-	local vt="$(cat $res_file)"
+	local vt="$(cat res_ipv4)"
+	local vt6="$(cat res_ipv6)"
 
-	netload_test $ip_remote $res_file || return 1
+	netload_test $ip_remote res_ipv4 || return 1
 
-	local lt="$(cat $res_file)"
-	tst_resm TINFO "time lan($lt) vxlan($vt) ms"
+	local lt="$(cat res_ipv4)"
+	tst_resm TINFO "time lan($lt) vxlan IPv4($vt) and IPv6($vt6) ms"
 
 	per=$(( $vt * 100 / $lt - 100 ))
+	per6=$(( $vt6 * 100 / $lt - 100 ))
 
-	if [ "$per" -lt "$vxlan_threshold" ]; then
-		tst_resm TINFO "vxlan slower by $per %"
-	else
-		tst_resm TINFO "vxlan too slow: by $per %"
-		ret=1
-	fi
+	tst_resm TINFO "IPv4 VxLAN over IPv4 slower by $per %"
+	tst_resm TINFO "IPv6 VxLAN over IPv4 slower by $per6 %"
+
+	[ "$per" -ge "$vxlan_threshold" -o "$per6" -ge "$vxlan_threshold" ] \
+		&& ret=1
 
 	return $ret
 }
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
