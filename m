Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Ze-0002PJ-JM
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:46 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zb-00080P-Uu
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:46 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696ic7R019698
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t696ibM9020315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:37 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696ibJf004992
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:37 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:27 +0300
Message-Id: <1436424468-11756-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 02/23] network/vxlan: rename vxlan dir and library to
	'virt'
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

Also change vxlan_lib.sh -> virt_lib.sh in Makefile and in
vxlan*.sh tests that source it.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/Makefile      |   26 ++++
 testcases/network/virt/virt_lib.sh   |  211 ++++++++++++++++++++++++++++++++++
 testcases/network/virt/vxlan01.sh    |   50 ++++++++
 testcases/network/virt/vxlan02.sh    |   43 +++++++
 testcases/network/virt/vxlan03.sh    |   83 +++++++++++++
 testcases/network/vxlan/Makefile     |   26 ----
 testcases/network/vxlan/vxlan01.sh   |   50 --------
 testcases/network/vxlan/vxlan02.sh   |   43 -------
 testcases/network/vxlan/vxlan03.sh   |   83 -------------
 testcases/network/vxlan/vxlan_lib.sh |  211 ----------------------------------
 10 files changed, 413 insertions(+), 413 deletions(-)
 create mode 100644 testcases/network/virt/Makefile
 create mode 100644 testcases/network/virt/virt_lib.sh
 create mode 100755 testcases/network/virt/vxlan01.sh
 create mode 100755 testcases/network/virt/vxlan02.sh
 create mode 100755 testcases/network/virt/vxlan03.sh
 delete mode 100644 testcases/network/vxlan/Makefile
 delete mode 100755 testcases/network/vxlan/vxlan01.sh
 delete mode 100755 testcases/network/vxlan/vxlan02.sh
 delete mode 100755 testcases/network/vxlan/vxlan03.sh
 delete mode 100644 testcases/network/vxlan/vxlan_lib.sh

diff --git a/testcases/network/virt/Makefile b/testcases/network/virt/Makefile
new file mode 100644
index 0000000..d05890f
--- /dev/null
+++ b/testcases/network/virt/Makefile
@@ -0,0 +1,26 @@
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= virt_lib.sh \
+			   vxlan01.sh \
+			   vxlan02.sh \
+			   vxlan03.sh \
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
new file mode 100644
index 0000000..d6ae77c
--- /dev/null
+++ b/testcases/network/virt/virt_lib.sh
@@ -0,0 +1,211 @@
+#!/bin/sh
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+# VxLAN
+# -----
+# Virtual eXtensible Local Area Network (VxLAN) provides L2 networks
+# over existed L3 networks. It is using UDP (port 8472) to encapsulate
+# data packets. More information:
+# http://tools.ietf.org/html/draft-mahalingam-dutt-dcops-vxlan-08
+#
+# Warning: Test assumes that machines don't have any existed VxLANs.
+#          If machine has VxLANs, the test might fail or eventually delete
+#          them in cleanup function. See "start_vni" variable which can
+#          solve it.
+
+ip_local=$(tst_ipaddr)
+ip_virt_local="192.168.124.1"
+ip6_virt_local="fe80::381c:c0ff:fea8:7c01"
+mac_virt_local="3A:1C:C0:A8:7C:01"
+
+ip_remote=$(tst_ipaddr rhost)
+ip_virt_remote="192.168.124.2"
+ip6_virt_remote="fe80::381c:c0ff:fea8:7c02"
+mac_virt_remote="3A:1C:C0:A8:7C:02"
+
+clients_num=2
+client_requests=500000
+max_requests=3
+net_load="TFO"
+virt_threshold=30
+
+while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
+	case "$opt" in
+	h)
+		echo "Usage:"
+		echo "h        help"
+		echo "s        use ssh to run remote cmds"
+		echo "x n      n is a number of interfaces for tc1 and tc2"
+		echo "i n      start ID to use"
+		echo "r n      client requests for TCP performance test"
+		echo "c n      clients run concurrently in TCP perf"
+		echo "R n      num of reqs, after which conn.closed in TCP perf"
+		echo "p x      x and x + 1 are ports in TCP perf"
+		echo "n x      virtual network 192.168.x"
+		echo "l x      network load: x is PING or TFO(tcp_fastopen)"
+		echo "t x      performance threshold, default is 60%"
+		echo "d x      VxLAN destination address, 'uni' or 'multi'"
+		echo "6        run over IPv6"
+		exit 0
+	;;
+	s) TST_USE_SSH=1 ;;
+	x) virt_max=$OPTARG ;;
+	i) start_id=$OPTARG ;;
+	c) clients_num=$OPTARG ;;
+	r) client_requests=$OPTARG ;;
+	R) max_requests=$OPTARG ;;
+	p) srv_port=$OPTARG ;;
+	n)
+		ip_virt_local="192.168.${OPTARG}.1"
+		ip_virt_remote="192.168.${OPTARG}.2"
+	;;
+	l) net_load=$OPTARG ;;
+	t) virt_threshold=$OPTARG ;;
+	d) vxlan_dst_addr=$OPTARG ;;
+	6) # skip, test_net library already processed it
+	;;
+	*)
+		tst_brkm TBROK "unknown option: $opt"
+	;;
+	esac
+done
+
+cleanup_vifaces()
+{
+	tst_resm TINFO "cleanup virtual interfaces..."
+	local viface=`ip link | sed -nE 's/^[0-9]+: (ltp_v[0-9]+):.+/\1/p'`
+	for vx in $viface; do
+		ip link delete $vx
+	done
+}
+
+TST_CLEANUP="cleanup_vifaces"
+trap "tst_brkm TBROK 'test interrupted'" INT
+
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
+vxlan_setup_subnet_uni()
+{
+	tst_kvercmp 3 10 0 && \
+		tst_brkm TCONF "test must be run with kernel 3.10 or newer"
+
+	[ "$(ip li add type vxlan help 2>&1 | grep remote)" ] || \
+		tst_brkm TCONF "iproute doesn't support remote unicast address"
+
+	local opt="id $1 remote $(tst_ipaddr rhost)"
+	local opt_r="id $2 remote $(tst_ipaddr)"
+
+	virt_setup "$opt" "$opt_r"
+}
+
+vxlan_setup_subnet_multi()
+{
+	tst_check_cmds "od"
+	local b1=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
+	local b2=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
+	local b3=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
+
+	local grp=
+	if [ "$TST_IPV6" ]; then
+		grp="group ff05::$(printf '%x:%x%x' $b1 $b2 $b3)"
+	else
+		grp="group 239.$b1.$b2.$b3"
+	fi
+
+	local opt="id $1 $grp dev $(tst_iface)"
+	local opt_r="id $2 $grp dev $(tst_iface rhost)"
+
+	virt_setup "$opt" "$opt_r"
+}
+
+virt_compare_netperf()
+{
+	local ret=0
+	tst_netload $ip_virt_remote res_ipv4 $net_load || ret=1
+	tst_netload ${ip6_virt_remote}%ltp_v0 res_ipv6 $net_load || ret=1
+
+	ROD_SILENT "ip link delete ltp_v0"
+	tst_rhost_run -s -c "ip link delete ltp_v0"
+	[ "$ret" -eq 1 ] && return 1
+	local vt="$(cat res_ipv4)"
+	local vt6="$(cat res_ipv6)"
+
+	tst_netload $ip_remote res_ipv4 $net_load || return 1
+
+	local lt="$(cat res_ipv4)"
+	tst_resm TINFO "time lan($lt) $virt_type IPv4($vt) and IPv6($vt6) ms"
+
+	per=$(( $vt * 100 / $lt - 100 ))
+	per6=$(( $vt6 * 100 / $lt - 100 ))
+
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
+		&& ret=1
+
+	return $ret
+}
+
+tst_require_root
+
+case "$virt_type" in
+vxlan)
+	tst_kvercmp 3 8 0 && \
+		tst_brkm TCONF "test must be run with kernel 3.8 or newer"
+
+	if [ "$TST_IPV6" ]; then
+		tst_kvercmp 3 12 0 && \
+			tst_brkm TCONF "test must be run with kernels >= 3.12"
+	fi
+;;
+esac
+
+ipver=${TST_IPV6:-'4'}
+
+tst_check_cmds "ip"
+
+ip link add ltp_v0 type $virt_type > /dev/null 2>&1
+if [ $? -ne 0 ]; then
+	tst_brkm TCONF "iproute2 or kernel doesn't support $virt_type"
+fi
+ROD_SILENT "ip link delete ltp_v0"
diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
new file mode 100755
index 0000000..a8624a3
--- /dev/null
+++ b/testcases/network/virt/vxlan01.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+# Test-case 1: Local test, check if we can create 5000 VXLAN interfaces.
+#
+
+TCID=vxlan01
+TST_TOTAL=1
+
+virt_type="vxlan"
+start_id=16700000
+virt_max=5000
+
+. test_net.sh
+. virt_lib.sh
+
+max=$(( $start_id + $virt_max ))
+tst_resm TINFO "create $virt_max VXLANs, then delete them"
+opt="group 239.1.1.1"
+
+vnis=$(seq $start_id $max)
+
+for i in $vnis; do
+	ROD_SILENT "ip link add ltp_v${i} type vxlan id $i $opt"
+	ROD_SILENT "ip link set ltp_v${i} up"
+done
+
+for i in $vnis; do
+	ROD_SILENT "ip link set ltp_v${i} down"
+	ROD_SILENT "ip link delete ltp_v${i}"
+done
+
+tst_resm TPASS "done"
+
+tst_exit
diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
new file mode 100755
index 0000000..a0b9267
--- /dev/null
+++ b/testcases/network/virt/vxlan02.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+# Test-case 1: Local test, check if we can create and then delete VXLAN
+#              interface 5000 times.
+#
+
+TCID=vxlan02
+TST_TOTAL=1
+
+virt_type="vxlan"
+start_id=16700000
+virt_max=5000
+
+. test_net.sh
+. virt_lib.sh
+
+opt="group 239.1.1.1"
+tst_resm TINFO "create, delete ltp_v0 $virt_max times"
+
+for i in $(seq 0 $virt_max); do
+	ROD_SILENT "ip link add ltp_v0 type vxlan id $start_id $opt"
+	ROD_SILENT "ip link set ltp_v0 up"
+	ROD_SILENT "ip link delete ltp_v0"
+done
+tst_resm TPASS "done"
+
+tst_exit
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
new file mode 100755
index 0000000..033d801
--- /dev/null
+++ b/testcases/network/virt/vxlan03.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+# Test-case 1: It requires remote host. Test will setup IPv4 and IPv6 virtual
+#              sub-nets between two hosts, then will compare TCP performance
+#              with and without VxLAN using ping or tcp_fastopen test.
+#
+# Test-case 2: The same as above but must fail, because VXLAN allows
+#              to communicate only within the same VXLAN segment.
+
+TCID=vxlan03
+TST_TOTAL=2
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
+. test_net.sh
+. virt_lib.sh
+
+cleanup()
+{
+	cleanup_vifaces
+	tst_rhost_run -c "ip link delete ltp_v0"
+	if [ "$net_load" = "TFO" ]; then
+		tst_rhost_run -c "pkill -9 tcp_fastopen\$"
+		pkill -9 "tcp_fastopen\$"
+	fi
+}
+TST_CLEANUP="cleanup"
+
+if [ "$net_load" = "TFO" ]; then
+	tst_check_cmds "tcp_fastopen"
+fi
+
+if [ -z $ip_local -o -z $ip_remote ]; then
+	tst_brkm TBROK "you must specify IP address"
+fi
+
+tst_resm TINFO "networks with the same VNI must work"
+# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
+res="TPASS"
+
+if [ "$vxlan_dst_addr" != 'uni' -a $vxlan_dst_addr != 'multi' ]; then
+	tst_brkm TBROK "wrong destination address, can be 'uni' or 'multi'"
+fi
+
+vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFE"
+vxlan_compare_netperf || res="TFAIL"
+
+tst_resm $res "done"
+
+tst_resm TINFO "different VNI shall not work together"
+res="TPASS"
+vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFD"
+vxlan_compare_netperf && res="TFAIL"
+
+tst_resm $res "done"
+
+tst_exit
diff --git a/testcases/network/vxlan/Makefile b/testcases/network/vxlan/Makefile
deleted file mode 100644
index 407d88a..0000000
--- a/testcases/network/vxlan/Makefile
+++ /dev/null
@@ -1,26 +0,0 @@
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= vxlan_lib.sh \
-			   vxlan01.sh \
-			   vxlan02.sh \
-			   vxlan03.sh \
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/vxlan/vxlan01.sh b/testcases/network/vxlan/vxlan01.sh
deleted file mode 100755
index 85a57ea..0000000
--- a/testcases/network/vxlan/vxlan01.sh
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
-#
-# Test-case 1: Local test, check if we can create 5000 VXLAN interfaces.
-#
-
-TCID=vxlan01
-TST_TOTAL=1
-
-virt_type="vxlan"
-start_id=16700000
-virt_max=5000
-
-. test_net.sh
-. vxlan_lib.sh
-
-max=$(( $start_id + $virt_max ))
-tst_resm TINFO "create $virt_max VXLANs, then delete them"
-opt="group 239.1.1.1"
-
-vnis=$(seq $start_id $max)
-
-for i in $vnis; do
-	ROD_SILENT "ip link add ltp_v${i} type vxlan id $i $opt"
-	ROD_SILENT "ip link set ltp_v${i} up"
-done
-
-for i in $vnis; do
-	ROD_SILENT "ip link set ltp_v${i} down"
-	ROD_SILENT "ip link delete ltp_v${i}"
-done
-
-tst_resm TPASS "done"
-
-tst_exit
diff --git a/testcases/network/vxlan/vxlan02.sh b/testcases/network/vxlan/vxlan02.sh
deleted file mode 100755
index ca82c58..0000000
--- a/testcases/network/vxlan/vxlan02.sh
+++ /dev/null
@@ -1,43 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
-#
-# Test-case 1: Local test, check if we can create and then delete VXLAN
-#              interface 5000 times.
-#
-
-TCID=vxlan02
-TST_TOTAL=1
-
-virt_type="vxlan"
-start_id=16700000
-virt_max=5000
-
-. test_net.sh
-. vxlan_lib.sh
-
-opt="group 239.1.1.1"
-tst_resm TINFO "create, delete ltp_v0 $virt_max times"
-
-for i in $(seq 0 $virt_max); do
-	ROD_SILENT "ip link add ltp_v0 type vxlan id $start_id $opt"
-	ROD_SILENT "ip link set ltp_v0 up"
-	ROD_SILENT "ip link delete ltp_v0"
-done
-tst_resm TPASS "done"
-
-tst_exit
diff --git a/testcases/network/vxlan/vxlan03.sh b/testcases/network/vxlan/vxlan03.sh
deleted file mode 100755
index 7e8ffd1..0000000
--- a/testcases/network/vxlan/vxlan03.sh
+++ /dev/null
@@ -1,83 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
-#
-# Test-case 1: It requires remote host. Test will setup IPv4 and IPv6 virtual
-#              sub-nets between two hosts, then will compare TCP performance
-#              with and without VxLAN using ping or tcp_fastopen test.
-#
-# Test-case 2: The same as above but must fail, because VXLAN allows
-#              to communicate only within the same VXLAN segment.
-
-TCID=vxlan03
-TST_TOTAL=2
-
-virt_type="vxlan"
-start_id=16700000
-
-# In average cases (with small packets less then 150 bytes) vxlan slower
-# by 10-30%. If hosts are too close to each one, e.g. connected to the same
-# switch the performance can be slower by 50%. Set 60% as default, the above
-# will be an error in VXLAN.
-virt_threshold=60
-
-# Destination address, can be unicast or multicast address
-vxlan_dst_addr="uni"
-
-. test_net.sh
-. vxlan_lib.sh
-
-cleanup()
-{
-	cleanup_vifaces
-	tst_rhost_run -c "ip link delete ltp_v0"
-	if [ "$net_load" = "TFO" ]; then
-		tst_rhost_run -c "pkill -9 tcp_fastopen\$"
-		pkill -9 "tcp_fastopen\$"
-	fi
-}
-TST_CLEANUP="cleanup"
-
-if [ "$net_load" = "TFO" ]; then
-	tst_check_cmds "tcp_fastopen"
-fi
-
-if [ -z $ip_local -o -z $ip_remote ]; then
-	tst_brkm TBROK "you must specify IP address"
-fi
-
-tst_resm TINFO "networks with the same VNI must work"
-# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
-res="TPASS"
-
-if [ "$vxlan_dst_addr" != 'uni' -a $vxlan_dst_addr != 'multi' ]; then
-	tst_brkm TBROK "wrong destination address, can be 'uni' or 'multi'"
-fi
-
-vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFE"
-vxlan_compare_netperf || res="TFAIL"
-
-tst_resm $res "done"
-
-tst_resm TINFO "different VNI shall not work together"
-res="TPASS"
-vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFD"
-vxlan_compare_netperf && res="TFAIL"
-
-tst_resm $res "done"
-
-tst_exit
diff --git a/testcases/network/vxlan/vxlan_lib.sh b/testcases/network/vxlan/vxlan_lib.sh
deleted file mode 100644
index d6ae77c..0000000
--- a/testcases/network/vxlan/vxlan_lib.sh
+++ /dev/null
@@ -1,211 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
-#
-# VxLAN
-# -----
-# Virtual eXtensible Local Area Network (VxLAN) provides L2 networks
-# over existed L3 networks. It is using UDP (port 8472) to encapsulate
-# data packets. More information:
-# http://tools.ietf.org/html/draft-mahalingam-dutt-dcops-vxlan-08
-#
-# Warning: Test assumes that machines don't have any existed VxLANs.
-#          If machine has VxLANs, the test might fail or eventually delete
-#          them in cleanup function. See "start_vni" variable which can
-#          solve it.
-
-ip_local=$(tst_ipaddr)
-ip_virt_local="192.168.124.1"
-ip6_virt_local="fe80::381c:c0ff:fea8:7c01"
-mac_virt_local="3A:1C:C0:A8:7C:01"
-
-ip_remote=$(tst_ipaddr rhost)
-ip_virt_remote="192.168.124.2"
-ip6_virt_remote="fe80::381c:c0ff:fea8:7c02"
-mac_virt_remote="3A:1C:C0:A8:7C:02"
-
-clients_num=2
-client_requests=500000
-max_requests=3
-net_load="TFO"
-virt_threshold=30
-
-while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
-	case "$opt" in
-	h)
-		echo "Usage:"
-		echo "h        help"
-		echo "s        use ssh to run remote cmds"
-		echo "x n      n is a number of interfaces for tc1 and tc2"
-		echo "i n      start ID to use"
-		echo "r n      client requests for TCP performance test"
-		echo "c n      clients run concurrently in TCP perf"
-		echo "R n      num of reqs, after which conn.closed in TCP perf"
-		echo "p x      x and x + 1 are ports in TCP perf"
-		echo "n x      virtual network 192.168.x"
-		echo "l x      network load: x is PING or TFO(tcp_fastopen)"
-		echo "t x      performance threshold, default is 60%"
-		echo "d x      VxLAN destination address, 'uni' or 'multi'"
-		echo "6        run over IPv6"
-		exit 0
-	;;
-	s) TST_USE_SSH=1 ;;
-	x) virt_max=$OPTARG ;;
-	i) start_id=$OPTARG ;;
-	c) clients_num=$OPTARG ;;
-	r) client_requests=$OPTARG ;;
-	R) max_requests=$OPTARG ;;
-	p) srv_port=$OPTARG ;;
-	n)
-		ip_virt_local="192.168.${OPTARG}.1"
-		ip_virt_remote="192.168.${OPTARG}.2"
-	;;
-	l) net_load=$OPTARG ;;
-	t) virt_threshold=$OPTARG ;;
-	d) vxlan_dst_addr=$OPTARG ;;
-	6) # skip, test_net library already processed it
-	;;
-	*)
-		tst_brkm TBROK "unknown option: $opt"
-	;;
-	esac
-done
-
-cleanup_vifaces()
-{
-	tst_resm TINFO "cleanup virtual interfaces..."
-	local viface=`ip link | sed -nE 's/^[0-9]+: (ltp_v[0-9]+):.+/\1/p'`
-	for vx in $viface; do
-		ip link delete $vx
-	done
-}
-
-TST_CLEANUP="cleanup_vifaces"
-trap "tst_brkm TBROK 'test interrupted'" INT
-
-virt_setup()
-{
-	local opt="$1"
-	local opt_r="$2"
-
-	tst_resm TINFO "setup local ${virt_type} with '$opt'"
-
-	ROD_SILENT "ip li add ltp_v0 type $virt_type $opt"
-	ROD_SILENT "ip li set ltp_v0 address $mac_virt_local"
-	ROD_SILENT "ip addr add ${ip_virt_local}/24 dev ltp_v0"
-	ROD_SILENT "ip li set up ltp_v0"
-
-	tst_resm TINFO "setup rhost ${virt_type} with '$opt_r'"
-
-	tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $opt_r"
-	tst_rhost_run -s -c "ip li set ltp_v0 address $mac_virt_remote"
-	tst_rhost_run -s -c "ip addr add ${ip_virt_remote}/24 dev ltp_v0"
-	tst_rhost_run -s -c "ip li set up ltp_v0"
-}
-
-vxlan_setup_subnet_uni()
-{
-	tst_kvercmp 3 10 0 && \
-		tst_brkm TCONF "test must be run with kernel 3.10 or newer"
-
-	[ "$(ip li add type vxlan help 2>&1 | grep remote)" ] || \
-		tst_brkm TCONF "iproute doesn't support remote unicast address"
-
-	local opt="id $1 remote $(tst_ipaddr rhost)"
-	local opt_r="id $2 remote $(tst_ipaddr)"
-
-	virt_setup "$opt" "$opt_r"
-}
-
-vxlan_setup_subnet_multi()
-{
-	tst_check_cmds "od"
-	local b1=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
-	local b2=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
-	local b3=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
-
-	local grp=
-	if [ "$TST_IPV6" ]; then
-		grp="group ff05::$(printf '%x:%x%x' $b1 $b2 $b3)"
-	else
-		grp="group 239.$b1.$b2.$b3"
-	fi
-
-	local opt="id $1 $grp dev $(tst_iface)"
-	local opt_r="id $2 $grp dev $(tst_iface rhost)"
-
-	virt_setup "$opt" "$opt_r"
-}
-
-virt_compare_netperf()
-{
-	local ret=0
-	tst_netload $ip_virt_remote res_ipv4 $net_load || ret=1
-	tst_netload ${ip6_virt_remote}%ltp_v0 res_ipv6 $net_load || ret=1
-
-	ROD_SILENT "ip link delete ltp_v0"
-	tst_rhost_run -s -c "ip link delete ltp_v0"
-	[ "$ret" -eq 1 ] && return 1
-	local vt="$(cat res_ipv4)"
-	local vt6="$(cat res_ipv6)"
-
-	tst_netload $ip_remote res_ipv4 $net_load || return 1
-
-	local lt="$(cat res_ipv4)"
-	tst_resm TINFO "time lan($lt) $virt_type IPv4($vt) and IPv6($vt6) ms"
-
-	per=$(( $vt * 100 / $lt - 100 ))
-	per6=$(( $vt6 * 100 / $lt - 100 ))
-
-	case "$virt_type" in
-	vxlan)
-		tst_resm TINFO "IPv4 VxLAN over IPv$ipver slower by $per %"
-		tst_resm TINFO "IPv6 VxLAN over IPv$ipver slower by $per6 %"
-	;;
-	*)
-		tst_resm TINFO "IPv4 $virt_type slower by $per %"
-		tst_resm TINFO "IPv6 $virt_type slower by $per6 %"
-	esac
-	[ "$per" -ge "$virt_threshold" -o "$per6" -ge "$virt_threshold" ] \
-		&& ret=1
-
-	return $ret
-}
-
-tst_require_root
-
-case "$virt_type" in
-vxlan)
-	tst_kvercmp 3 8 0 && \
-		tst_brkm TCONF "test must be run with kernel 3.8 or newer"
-
-	if [ "$TST_IPV6" ]; then
-		tst_kvercmp 3 12 0 && \
-			tst_brkm TCONF "test must be run with kernels >= 3.12"
-	fi
-;;
-esac
-
-ipver=${TST_IPV6:-'4'}
-
-tst_check_cmds "ip"
-
-ip link add ltp_v0 type $virt_type > /dev/null 2>&1
-if [ $? -ne 0 ]; then
-	tst_brkm TCONF "iproute2 or kernel doesn't support $virt_type"
-fi
-ROD_SILENT "ip link delete ltp_v0"
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
