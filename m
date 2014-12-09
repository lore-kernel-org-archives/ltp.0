Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XyLqT-0005p3-Td
	for ltp-list@lists.sourceforge.net; Tue, 09 Dec 2014 14:32:57 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XyLqN-0000M3-Jo
	for ltp-list@lists.sourceforge.net; Tue, 09 Dec 2014 14:32:57 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id sB9EWjED001609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Dec 2014 14:32:45 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	sB9EWi96010489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Dec 2014 14:32:45 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sB9EWi20003941
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Dec 2014 14:32:44 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  9 Dec 2014 17:34:32 +0300
Message-Id: <1418135673-31915-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/2] network/vxlan: add support for IPv6
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

Support for VxLAN over IPv6 was added in Linux 3.12

* run tests with'-6' parameter
* add two VxLAN configurations: with unicast and multicast
  destination address; it can be configured through '-d' parameter

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/vxlan/vxlan03.sh   |    9 +++-
 testcases/network/vxlan/vxlan_lib.sh |   73 ++++++++++++++++++++++------------
 2 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/testcases/network/vxlan/vxlan03.sh b/testcases/network/vxlan/vxlan03.sh
index 26f27b5..8ee412d 100755
--- a/testcases/network/vxlan/vxlan03.sh
+++ b/testcases/network/vxlan/vxlan03.sh
@@ -52,14 +52,19 @@ fi
 tst_resm TINFO "networks with the same VNI must work"
 # VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
 res="TPASS"
-vxlan_setup_subnet "0xFFFFFE" "0xFFFFFE"
+
+if [ "$vxlan_dst_addr" != 'uni' -a $vxlan_dst_addr != 'multi' ]; then
+	tst_brkm TBROK "wrong destination address, must be 'uni' or 'multi'"
+fi
+
+vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFE"
 vxlan_compare_netperf || res="TFAIL"
 
 tst_resm $res "done"
 
 tst_resm TINFO "different VNI shall not work together"
 res="TPASS"
-vxlan_setup_subnet "0xFFFFFE" "0xFFFFFD"
+vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFD"
 vxlan_compare_netperf && res="TFAIL"
 
 tst_resm $res "done"
diff --git a/testcases/network/vxlan/vxlan_lib.sh b/testcases/network/vxlan/vxlan_lib.sh
index c339734..f4e97d3 100644
--- a/testcases/network/vxlan/vxlan_lib.sh
+++ b/testcases/network/vxlan/vxlan_lib.sh
@@ -28,14 +28,12 @@
 #          them in cleanup function. See "start_vni" variable which can
 #          solve it.
 
-user_name="root"
-
-ip_local=${IPV4_NETWORK}.${LHOST_IPV4_HOST}
+ip_local=$(tst_ipaddr)
 ip_vxlan_local="192.168.124.1"
 ip6_vxlan_local="fe80::381c:c0ff:fea8:7c01"
 mac_vxlan_local="3A:1C:C0:A8:7C:01"
 
-ip_remote=${IPV4_NETWORK}.${RHOST_IPV4_HOST}
+ip_remote=$(tst_ipaddr rhost)
 ip_vxlan_remote="192.168.124.2"
 ip6_vxlan_remote="fe80::381c:c0ff:fea8:7c02"
 mac_vxlan_remote="3A:1C:C0:A8:7C:02"
@@ -53,7 +51,10 @@ net_load="TFO"
 # will be an error in VXLAN.
 vxlan_threshold=60
 
-while getopts :hsx:i:r:c:R:p:n:l:t: opt; do
+# Destination address, must be unicast or multicast address
+vxlan_dst_addr="uni"
+
+while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
 	case "$opt" in
 	h)
 		echo "Usage:"
@@ -68,6 +69,8 @@ while getopts :hsx:i:r:c:R:p:n:l:t: opt; do
 		echo "n x      VXLAN network 192.168.x"
 		echo "l x      network load: x is PING or TFO(tcp_fastopen)"
 		echo "t x      VXLAN performance threshold, default is 60%"
+		echo "d x      VXLAN destination address, 'uni' or 'multi'"
+		echo "6        run over IPv6"
 		exit 0
 	;;
 	s) TST_USE_SSH=1 ;;
@@ -83,6 +86,9 @@ while getopts :hsx:i:r:c:R:p:n:l:t: opt; do
 	;;
 	l) net_load=$OPTARG ;;
 	t) vxlan_threshold=$OPTARG ;;
+	d) vxlan_dst_addr=$OPTARG ;;
+	6) # skip, test_net library already processed it
+	;;
 	*)
 		tst_brkm TBROK "unknown option: $opt"
 	;;
@@ -109,35 +115,45 @@ safe_run()
 	fi
 }
 
-vxlan_setup_subnet()
+vxlan_setup_subnet_uni()
 {
-	tst_resm TINFO "virtual bridge & VXLAN, connect 2 hosts"
-	local opt="rsc proxy nolearning"
-	local neigh_opt="nud permanent"
+	[ "$(ip li add type vxlan help 2>&1 | grep remote)" ] || \
+		tst_brkm TCONF "iproute doesn't support 'remote' option"
+
+	local opt="remote $(tst_ipaddr rhost)"
+
+	tst_resm TINFO "setup VxLANv$ipver with unicast address: '$opt'"
 
 	safe_run "ip li add ltp_vxl0 type vxlan id $1 $opt"
 	safe_run "ip li set ltp_vxl0 address $mac_vxlan_local"
 	safe_run "ip addr add ${ip_vxlan_local}/24 dev ltp_vxl0"
 	safe_run "ip li set up ltp_vxl0"
 
-	safe_run "ip neigh add $ip_vxlan_remote \
-	          lladdr $mac_vxlan_remote $neigh_opt dev ltp_vxl0"
-	safe_run "ip neigh add $ip6_vxlan_remote \
-	          lladdr $mac_vxlan_remote $neigh_opt dev ltp_vxl0"
-	safe_run "bridge fdb add to $mac_vxlan_remote dst $ip_remote \
-	          dev ltp_vxl0"
+	opt="remote $(tst_ipaddr)"
 
 	tst_rhost_run -s -c "ip li add ltp_vxl0 type vxlan id $2 $opt"
 	tst_rhost_run -s -c "ip li set ltp_vxl0 address $mac_vxlan_remote"
 	tst_rhost_run -s -c "ip addr add ${ip_vxlan_remote}/24 dev ltp_vxl0"
 	tst_rhost_run -s -c "ip li set up ltp_vxl0"
+}
+
+vxlan_setup_subnet_multi()
+{
+	local opt=
+	[ "$TST_IPV6" ] && opt="group ff05::111" || opt="group 239.1.1.1"
+
+	tst_resm TINFO "setup VxLANv$ipver with multicast address: '$opt'"
 
-	tst_rhost_run -s -c "ip neigh add $ip_vxlan_local \
-	                     lladdr $mac_vxlan_local $neigh_opt dev ltp_vxl0"
-	tst_rhost_run -s -c "ip neigh add $ip6_vxlan_local \
-	                     lladdr $mac_vxlan_local $neigh_opt dev ltp_vxl0"
-	tst_rhost_run -s -c "bridge fdb add to $mac_vxlan_local dst $ip_local \
-	                     dev ltp_vxl0"
+	safe_run "ip li add ltp_vxl0 type vxlan id $1 $opt dev $(tst_iface)"
+	safe_run "ip li set ltp_vxl0 address $mac_vxlan_local"
+	safe_run "ip addr add ${ip_vxlan_local}/24 dev ltp_vxl0"
+	safe_run "ip li set up ltp_vxl0"
+
+	tst_rhost_run -s -c "ip li add ltp_vxl0 type vxlan id $2 $opt \
+	                     dev $(tst_iface rhost)"
+	tst_rhost_run -s -c "ip li set ltp_vxl0 address $mac_vxlan_remote"
+	tst_rhost_run -s -c "ip addr add ${ip_vxlan_remote}/24 dev ltp_vxl0"
+	tst_rhost_run -s -c "ip li set up ltp_vxl0"
 }
 
 netload_test()
@@ -169,7 +185,7 @@ netload_test()
 
 		# run local tcp client
 		tcp_fastopen -a $clients_num -r $client_requests -l \
-			-H $ip_addr -g $port -d $rfile > /dev/null 2>&1 || ret=1
+			-H $ip_addr -g $port -d $rfile > /dev/null || ret=1
 
 		if [ $ret -eq 0 -a ! -f $rfile ]; then
 			tst_brkm TBROK "can't read $rfile"
@@ -203,8 +219,8 @@ vxlan_compare_netperf()
 	per=$(( $vt * 100 / $lt - 100 ))
 	per6=$(( $vt6 * 100 / $lt - 100 ))
 
-	tst_resm TINFO "IPv4 VxLAN over IPv4 slower by $per %"
-	tst_resm TINFO "IPv6 VxLAN over IPv4 slower by $per6 %"
+	tst_resm TINFO "IPv4 VxLAN over IPv$ipver slower by $per %"
+	tst_resm TINFO "IPv6 VxLAN over IPv$ipver slower by $per6 %"
 
 	[ "$per" -ge "$vxlan_threshold" -o "$per6" -ge "$vxlan_threshold" ] \
 		&& ret=1
@@ -214,11 +230,16 @@ vxlan_compare_netperf()
 
 tst_require_root
 
-tst_kvercmp 3 8 0
-if [ $? -eq 0 ]; then
+tst_kvercmp 3 8 0 && \
 	tst_brkm TCONF "test must be run with kernel 3.8 or newer"
+
+if [ "$TST_IPV6" ]; then
+	tst_kvercmp 3 12 0 && \
+		tst_brkm TCONF "test must be run with kernel 3.12 or newer"
 fi
 
+ipver=${TST_IPV6:-'4'}
+
 tst_check_cmds "ip"
 
 ip link add ltp_vxl type vxlan id $start_vni > /dev/null 2>&1
-- 
1.7.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
