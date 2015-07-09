Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zd-0003ef-BT
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:45 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zb-0006u8-Bc
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:45 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696ibN4019676
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t696ibtv004361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:37 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696iaDK004984
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:36 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:26 +0300
Message-Id: <1436424468-11756-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 01/23] network/vxlan: make names more abstract,
	use 'virt'
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

* rename vxlan -> virt, ltp_vxl0 -> ltp_v0
* move some vxlan specific comments and params to vxlan test

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/vxlan/vxlan01.sh   |   25 +++--
 testcases/network/vxlan/vxlan02.sh   |   21 +++--
 testcases/network/vxlan/vxlan03.sh   |   23 ++++-
 testcases/network/vxlan/vxlan_lib.sh |  171 +++++++++++++++++-----------------
 4 files changed, 129 insertions(+), 111 deletions(-)

diff --git a/testcases/network/vxlan/vxlan01.sh b/testcases/network/vxlan/vxlan01.sh
index 574e9c0..85a57ea 100755
--- a/testcases/network/vxlan/vxlan01.sh
+++ b/testcases/network/vxlan/vxlan01.sh
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -13,8 +12,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
@@ -23,23 +21,28 @@
 
 TCID=vxlan01
 TST_TOTAL=1
+
+virt_type="vxlan"
+start_id=16700000
+virt_max=5000
+
 . test_net.sh
 . vxlan_lib.sh
 
-max=$(( $start_vni + $vxlan_max ))
-tst_resm TINFO "create $vxlan_max VXLANs, then delete them"
+max=$(( $start_id + $virt_max ))
+tst_resm TINFO "create $virt_max VXLANs, then delete them"
 opt="group 239.1.1.1"
 
-vnis=$(seq $start_vni $max)
+vnis=$(seq $start_id $max)
 
 for i in $vnis; do
-	ROD_SILENT "ip link add ltp_vxl${i} type vxlan id $i $opt"
-	ROD_SILENT "ip link set ltp_vxl${i} up"
+	ROD_SILENT "ip link add ltp_v${i} type vxlan id $i $opt"
+	ROD_SILENT "ip link set ltp_v${i} up"
 done
 
 for i in $vnis; do
-	ROD_SILENT "ip link set ltp_vxl${i} down"
-	ROD_SILENT "ip link delete ltp_vxl${i}"
+	ROD_SILENT "ip link set ltp_v${i} down"
+	ROD_SILENT "ip link delete ltp_v${i}"
 done
 
 tst_resm TPASS "done"
diff --git a/testcases/network/vxlan/vxlan02.sh b/testcases/network/vxlan/vxlan02.sh
index 6220a0d..ca82c58 100755
--- a/testcases/network/vxlan/vxlan02.sh
+++ b/testcases/network/vxlan/vxlan02.sh
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -13,8 +12,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
@@ -24,16 +22,21 @@
 
 TCID=vxlan02
 TST_TOTAL=1
+
+virt_type="vxlan"
+start_id=16700000
+virt_max=5000
+
 . test_net.sh
 . vxlan_lib.sh
 
 opt="group 239.1.1.1"
-tst_resm TINFO "create, delete ltp_vxl1 $vxlan_max times"
+tst_resm TINFO "create, delete ltp_v0 $virt_max times"
 
-for i in $(seq 0 $vxlan_max); do
-	ROD_SILENT "ip link add ltp_vxl1 type vxlan id $start_vni $opt"
-	ROD_SILENT "ip link set ltp_vxl1 up"
-	ROD_SILENT "ip link delete ltp_vxl1"
+for i in $(seq 0 $virt_max); do
+	ROD_SILENT "ip link add ltp_v0 type vxlan id $start_id $opt"
+	ROD_SILENT "ip link set ltp_v0 up"
+	ROD_SILENT "ip link delete ltp_v0"
 done
 tst_resm TPASS "done"
 
diff --git a/testcases/network/vxlan/vxlan03.sh b/testcases/network/vxlan/vxlan03.sh
index 8ee412d..7e8ffd1 100755
--- a/testcases/network/vxlan/vxlan03.sh
+++ b/testcases/network/vxlan/vxlan03.sh
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -13,8 +12,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
@@ -27,13 +25,26 @@
 
 TCID=vxlan03
 TST_TOTAL=2
+
+virt_type="vxlan"
+start_id=16700000
+
+# In average cases (with small packets less then 150 bytes) vxlan slower
+# by 10-30%. If hosts are too close to each one, e.g. connected to the same
+# switch the performance can be slower by 50%. Set 60% as default, the above
+# will be an error in VXLAN.
+virt_threshold=60
+
+# Destination address, can be unicast or multicast address
+vxlan_dst_addr="uni"
+
 . test_net.sh
 . vxlan_lib.sh
 
 cleanup()
 {
-	cleanup_vxlans
-	tst_rhost_run -c "ip link delete ltp_vxl0"
+	cleanup_vifaces
+	tst_rhost_run -c "ip link delete ltp_v0"
 	if [ "$net_load" = "TFO" ]; then
 		tst_rhost_run -c "pkill -9 tcp_fastopen\$"
 		pkill -9 "tcp_fastopen\$"
diff --git a/testcases/network/vxlan/vxlan_lib.sh b/testcases/network/vxlan/vxlan_lib.sh
index f9cd49f..d6ae77c 100644
--- a/testcases/network/vxlan/vxlan_lib.sh
+++ b/testcases/network/vxlan/vxlan_lib.sh
@@ -1,5 +1,4 @@
 #!/bin/sh
-
 # Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
@@ -13,46 +12,37 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
-# Virtual eXtensible Local Area Network (VXLAN) provides L2 networks
+# VxLAN
+# -----
+# Virtual eXtensible Local Area Network (VxLAN) provides L2 networks
 # over existed L3 networks. It is using UDP (port 8472) to encapsulate
 # data packets. More information:
 # http://tools.ietf.org/html/draft-mahalingam-dutt-dcops-vxlan-08
 #
-# Warning: Test assumes that machines don't have any existed VXLANs.
-#          If machine has VXLANs, the test might fail or eventually delete
+# Warning: Test assumes that machines don't have any existed VxLANs.
+#          If machine has VxLANs, the test might fail or eventually delete
 #          them in cleanup function. See "start_vni" variable which can
 #          solve it.
 
 ip_local=$(tst_ipaddr)
-ip_vxlan_local="192.168.124.1"
-ip6_vxlan_local="fe80::381c:c0ff:fea8:7c01"
-mac_vxlan_local="3A:1C:C0:A8:7C:01"
+ip_virt_local="192.168.124.1"
+ip6_virt_local="fe80::381c:c0ff:fea8:7c01"
+mac_virt_local="3A:1C:C0:A8:7C:01"
 
 ip_remote=$(tst_ipaddr rhost)
-ip_vxlan_remote="192.168.124.2"
-ip6_vxlan_remote="fe80::381c:c0ff:fea8:7c02"
-mac_vxlan_remote="3A:1C:C0:A8:7C:02"
+ip_virt_remote="192.168.124.2"
+ip6_virt_remote="fe80::381c:c0ff:fea8:7c02"
+mac_virt_remote="3A:1C:C0:A8:7C:02"
 
-vxlan_max=5000
-start_vni=16700000
 clients_num=2
 client_requests=500000
 max_requests=3
 net_load="TFO"
-
-# In average cases (with small packets less then 150 bytes) vxlan slower
-# by 10-30%. If hosts are too close to each one, e.g. connected to the same
-# switch the performance can be slower by 50%. Set 60% as default, the above
-# will be an error in VXLAN.
-vxlan_threshold=60
-
-# Destination address, can be unicast or multicast address
-vxlan_dst_addr="uni"
+virt_threshold=30
 
 while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
 	case "$opt" in
@@ -60,32 +50,32 @@ while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
 		echo "Usage:"
 		echo "h        help"
 		echo "s        use ssh to run remote cmds"
-		echo "x n      n is a number of VXLANs for tc1 and tc2"
-		echo "i n      start VNI to use"
+		echo "x n      n is a number of interfaces for tc1 and tc2"
+		echo "i n      start ID to use"
 		echo "r n      client requests for TCP performance test"
 		echo "c n      clients run concurrently in TCP perf"
 		echo "R n      num of reqs, after which conn.closed in TCP perf"
 		echo "p x      x and x + 1 are ports in TCP perf"
-		echo "n x      VXLAN network 192.168.x"
+		echo "n x      virtual network 192.168.x"
 		echo "l x      network load: x is PING or TFO(tcp_fastopen)"
-		echo "t x      VXLAN performance threshold, default is 60%"
-		echo "d x      VXLAN destination address, 'uni' or 'multi'"
+		echo "t x      performance threshold, default is 60%"
+		echo "d x      VxLAN destination address, 'uni' or 'multi'"
 		echo "6        run over IPv6"
 		exit 0
 	;;
 	s) TST_USE_SSH=1 ;;
-	x) vxlan_max=$OPTARG ;;
-	i) start_vni=$OPTARG ;;
+	x) virt_max=$OPTARG ;;
+	i) start_id=$OPTARG ;;
 	c) clients_num=$OPTARG ;;
 	r) client_requests=$OPTARG ;;
 	R) max_requests=$OPTARG ;;
 	p) srv_port=$OPTARG ;;
 	n)
-		ip_vxlan_local="192.168.${OPTARG}.1"
-		ip_vxlan_remote="192.168.${OPTARG}.2"
+		ip_virt_local="192.168.${OPTARG}.1"
+		ip_virt_remote="192.168.${OPTARG}.2"
 	;;
 	l) net_load=$OPTARG ;;
-	t) vxlan_threshold=$OPTARG ;;
+	t) virt_threshold=$OPTARG ;;
 	d) vxlan_dst_addr=$OPTARG ;;
 	6) # skip, test_net library already processed it
 	;;
@@ -95,18 +85,38 @@ while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
 	esac
 done
 
-cleanup_vxlans()
+cleanup_vifaces()
 {
-	tst_resm TINFO "cleanup vxlans..."
-	local vxlans=`ip link | sed -nE 's/^[0-9]+: (ltp_vxl[0-9]+):.+/\1/p'`
-	for vx in $vxlans; do
+	tst_resm TINFO "cleanup virtual interfaces..."
+	local viface=`ip link | sed -nE 's/^[0-9]+: (ltp_v[0-9]+):.+/\1/p'`
+	for vx in $viface; do
 		ip link delete $vx
 	done
 }
 
-TST_CLEANUP="cleanup_vxlans"
+TST_CLEANUP="cleanup_vifaces"
 trap "tst_brkm TBROK 'test interrupted'" INT
 
+virt_setup()
+{
+	local opt="$1"
+	local opt_r="$2"
+
+	tst_resm TINFO "setup local ${virt_type} with '$opt'"
+
+	ROD_SILENT "ip li add ltp_v0 type $virt_type $opt"
+	ROD_SILENT "ip li set ltp_v0 address $mac_virt_local"
+	ROD_SILENT "ip addr add ${ip_virt_local}/24 dev ltp_v0"
+	ROD_SILENT "ip li set up ltp_v0"
+
+	tst_resm TINFO "setup rhost ${virt_type} with '$opt_r'"
+
+	tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $opt_r"
+	tst_rhost_run -s -c "ip li set ltp_v0 address $mac_virt_remote"
+	tst_rhost_run -s -c "ip addr add ${ip_virt_remote}/24 dev ltp_v0"
+	tst_rhost_run -s -c "ip li set up ltp_v0"
+}
+
 vxlan_setup_subnet_uni()
 {
 	tst_kvercmp 3 10 0 && \
@@ -115,21 +125,10 @@ vxlan_setup_subnet_uni()
 	[ "$(ip li add type vxlan help 2>&1 | grep remote)" ] || \
 		tst_brkm TCONF "iproute doesn't support remote unicast address"
 
-	local opt="remote $(tst_ipaddr rhost)"
-
-	tst_resm TINFO "setup VxLANv$ipver with unicast address: '$opt'"
+	local opt="id $1 remote $(tst_ipaddr rhost)"
+	local opt_r="id $2 remote $(tst_ipaddr)"
 
-	ROD_SILENT "ip li add ltp_vxl0 type vxlan id $1 $opt"
-	ROD_SILENT "ip li set ltp_vxl0 address $mac_vxlan_local"
-	ROD_SILENT "ip addr add ${ip_vxlan_local}/24 dev ltp_vxl0"
-	ROD_SILENT "ip li set up ltp_vxl0"
-
-	opt="remote $(tst_ipaddr)"
-
-	tst_rhost_run -s -c "ip li add ltp_vxl0 type vxlan id $2 $opt"
-	tst_rhost_run -s -c "ip li set ltp_vxl0 address $mac_vxlan_remote"
-	tst_rhost_run -s -c "ip addr add ${ip_vxlan_remote}/24 dev ltp_vxl0"
-	tst_rhost_run -s -c "ip li set up ltp_vxl0"
+	virt_setup "$opt" "$opt_r"
 }
 
 vxlan_setup_subnet_multi()
@@ -139,35 +138,27 @@ vxlan_setup_subnet_multi()
 	local b2=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
 	local b3=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
 
-	local opt=
+	local grp=
 	if [ "$TST_IPV6" ]; then
-		opt="group ff05::$(printf '%x:%x%x' $b1 $b2 $b3)"
+		grp="group ff05::$(printf '%x:%x%x' $b1 $b2 $b3)"
 	else
-		opt="group 239.$b1.$b2.$b3"
+		grp="group 239.$b1.$b2.$b3"
 	fi
 
-	tst_resm TINFO "setup VxLANv$ipver with multicast address: '$opt'"
-
-	ROD_SILENT "ip li add ltp_vxl0 type vxlan id $1 $opt dev $(tst_iface)"
-	ROD_SILENT "ip li set ltp_vxl0 address $mac_vxlan_local"
-	ROD_SILENT "ip addr add ${ip_vxlan_local}/24 dev ltp_vxl0"
-	ROD_SILENT "ip li set up ltp_vxl0"
+	local opt="id $1 $grp dev $(tst_iface)"
+	local opt_r="id $2 $grp dev $(tst_iface rhost)"
 
-	tst_rhost_run -s -c "ip li add ltp_vxl0 type vxlan id $2 $opt \
-	                     dev $(tst_iface rhost)"
-	tst_rhost_run -s -c "ip li set ltp_vxl0 address $mac_vxlan_remote"
-	tst_rhost_run -s -c "ip addr add ${ip_vxlan_remote}/24 dev ltp_vxl0"
-	tst_rhost_run -s -c "ip li set up ltp_vxl0"
+	virt_setup "$opt" "$opt_r"
 }
 
-vxlan_compare_netperf()
+virt_compare_netperf()
 {
 	local ret=0
-	tst_netload $ip_vxlan_remote res_ipv4 $net_load || ret=1
-	tst_netload ${ip6_vxlan_remote}%ltp_vxl0 res_ipv6 $net_load || ret=1
+	tst_netload $ip_virt_remote res_ipv4 $net_load || ret=1
+	tst_netload ${ip6_virt_remote}%ltp_v0 res_ipv6 $net_load || ret=1
 
-	ROD_SILENT "ip link delete ltp_vxl0"
-	tst_rhost_run -s -c "ip link delete ltp_vxl0"
+	ROD_SILENT "ip link delete ltp_v0"
+	tst_rhost_run -s -c "ip link delete ltp_v0"
 	[ "$ret" -eq 1 ] && return 1
 	local vt="$(cat res_ipv4)"
 	local vt6="$(cat res_ipv6)"
@@ -175,15 +166,21 @@ vxlan_compare_netperf()
 	tst_netload $ip_remote res_ipv4 $net_load || return 1
 
 	local lt="$(cat res_ipv4)"
-	tst_resm TINFO "time lan($lt) vxlan IPv4($vt) and IPv6($vt6) ms"
+	tst_resm TINFO "time lan($lt) $virt_type IPv4($vt) and IPv6($vt6) ms"
 
 	per=$(( $vt * 100 / $lt - 100 ))
 	per6=$(( $vt6 * 100 / $lt - 100 ))
 
-	tst_resm TINFO "IPv4 VxLAN over IPv$ipver slower by $per %"
-	tst_resm TINFO "IPv6 VxLAN over IPv$ipver slower by $per6 %"
-
-	[ "$per" -ge "$vxlan_threshold" -o "$per6" -ge "$vxlan_threshold" ] \
+	case "$virt_type" in
+	vxlan)
+		tst_resm TINFO "IPv4 VxLAN over IPv$ipver slower by $per %"
+		tst_resm TINFO "IPv6 VxLAN over IPv$ipver slower by $per6 %"
+	;;
+	*)
+		tst_resm TINFO "IPv4 $virt_type slower by $per %"
+		tst_resm TINFO "IPv6 $virt_type slower by $per6 %"
+	esac
+	[ "$per" -ge "$virt_threshold" -o "$per6" -ge "$virt_threshold" ] \
 		&& ret=1
 
 	return $ret
@@ -191,20 +188,24 @@ vxlan_compare_netperf()
 
 tst_require_root
 
-tst_kvercmp 3 8 0 && \
-	tst_brkm TCONF "test must be run with kernel 3.8 or newer"
+case "$virt_type" in
+vxlan)
+	tst_kvercmp 3 8 0 && \
+		tst_brkm TCONF "test must be run with kernel 3.8 or newer"
 
-if [ "$TST_IPV6" ]; then
-	tst_kvercmp 3 12 0 && \
-		tst_brkm TCONF "test must be run with kernel 3.12 or newer"
-fi
+	if [ "$TST_IPV6" ]; then
+		tst_kvercmp 3 12 0 && \
+			tst_brkm TCONF "test must be run with kernels >= 3.12"
+	fi
+;;
+esac
 
 ipver=${TST_IPV6:-'4'}
 
 tst_check_cmds "ip"
 
-ip link add ltp_vxl type vxlan id $start_vni > /dev/null 2>&1
+ip link add ltp_v0 type $virt_type > /dev/null 2>&1
 if [ $? -ne 0 ]; then
-	tst_brkm TCONF "iproute2 or kernel doesn't support vxlan"
+	tst_brkm TCONF "iproute2 or kernel doesn't support $virt_type"
 fi
-ROD_SILENT "ip link delete ltp_vxl"
+ROD_SILENT "ip link delete ltp_v0"
-- 
1.7.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
