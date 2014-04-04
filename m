Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WW3Tz-0003qk-BD
	for ltp-list@lists.sourceforge.net; Fri, 04 Apr 2014 12:44:31 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WW3Tx-0001vE-K5
	for ltp-list@lists.sourceforge.net; Fri, 04 Apr 2014 12:44:31 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s34CiNpQ019999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Apr 2014 12:44:23 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s34CiMi8025351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Apr 2014 12:44:22 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s34CiMNX025338
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Apr 2014 12:44:22 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri,  4 Apr 2014 16:44:40 +0400
Message-Id: <1396615481-13156-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v3 1/2] network: vxlan: add new test
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


Virtual eXtensible Local Area Network (VXLAN) provides L2 networks
over existed L3 networks. It is using UDP (port 8472) to encapsulate
data packets. More information:
http://tools.ietf.org/html/draft-mahalingam-dutt-dcops-vxlan-08

Test cases:
1. Local test, check if we can create 5000 VXLAN interfaces.
2. Local test, check if we can create and then delete VXLAN
interface 5000 times.
3. Requires remote host, test will setup virtual sub-net
192.168.124.*/24 between two hosts, then will compare
TCP performance with and without VXLAN (tcp_fastopen test).
4. The same as above but must fail, because VXLAN allows
to communicate only within the same VXLAN segment.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v3: Move common code to vxlan_lib.sh
    Move test-cases to separate files

v2: Remove debug log saving to /tmp/tcp.log
    Test-case 4 didn't cleanup vxlan ifaces, fix it
    Add VXLAN network command-line option: 192.168.n
    Add safe_rhost_run()

 testcases/network/vxlan/Makefile     |   26 ++++
 testcases/network/vxlan/vxlan01.sh   |   47 ++++++++
 testcases/network/vxlan/vxlan02.sh   |   40 ++++++
 testcases/network/vxlan/vxlan03.sh   |   67 +++++++++++
 testcases/network/vxlan/vxlan_lib.sh |  217 ++++++++++++++++++++++++++++++++++
 5 files changed, 397 insertions(+), 0 deletions(-)
 create mode 100644 testcases/network/vxlan/Makefile
 create mode 100755 testcases/network/vxlan/vxlan01.sh
 create mode 100755 testcases/network/vxlan/vxlan02.sh
 create mode 100755 testcases/network/vxlan/vxlan03.sh
 create mode 100644 testcases/network/vxlan/vxlan_lib.sh

diff --git a/testcases/network/vxlan/Makefile b/testcases/network/vxlan/Makefile
new file mode 100644
index 0000000..407d88a
--- /dev/null
+++ b/testcases/network/vxlan/Makefile
@@ -0,0 +1,26 @@
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
+INSTALL_TARGETS		:= vxlan_lib.sh \
+			   vxlan01.sh \
+			   vxlan02.sh \
+			   vxlan03.sh \
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/vxlan/vxlan01.sh b/testcases/network/vxlan/vxlan01.sh
new file mode 100755
index 0000000..0942573
--- /dev/null
+++ b/testcases/network/vxlan/vxlan01.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+# Test-case 1: Local test, check if we can create 5000 VXLAN interfaces.
+#
+
+TCID=vxlan01
+TST_TOTAL=1
+. test_net.sh
+. vxlan_lib.sh
+
+max=$(( $start_vni + $vxlan_max ))
+tst_resm TINFO "create $vxlan_max VXLANs, then delete them"
+opt="group 239.1.1.1"
+
+vnis=$(seq $start_vni $max)
+
+for i in $vnis; do
+	safe_run "ip link add ltp_vxl${i} type vxlan id $i $opt"
+	safe_run "ip link set ltp_vxl${i} up"
+done
+
+for i in $vnis; do
+	safe_run "ip link set ltp_vxl${i} down"
+	safe_run "ip link delete ltp_vxl${i}"
+done
+
+tst_resm TPASS "done"
+
+tst_exit
diff --git a/testcases/network/vxlan/vxlan02.sh b/testcases/network/vxlan/vxlan02.sh
new file mode 100755
index 0000000..3f7e149
--- /dev/null
+++ b/testcases/network/vxlan/vxlan02.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+# Test-case 1: Local test, check if we can create and then delete VXLAN
+#              interface 5000 times.
+#
+
+TCID=vxlan02
+TST_TOTAL=1
+. test_net.sh
+. vxlan_lib.sh
+
+opt="group 239.1.1.1"
+tst_resm TINFO "create, delete ltp_vxl1 $vxlan_max times"
+
+for i in $(seq 0 $vxlan_max); do
+	safe_run "ip link add ltp_vxl1 type vxlan id $start_vni $opt"
+	safe_run "ip link set ltp_vxl1 up"
+	safe_run "ip link delete ltp_vxl1"
+done
+tst_resm TPASS "done"
+
+tst_exit
diff --git a/testcases/network/vxlan/vxlan03.sh b/testcases/network/vxlan/vxlan03.sh
new file mode 100755
index 0000000..7ce496e
--- /dev/null
+++ b/testcases/network/vxlan/vxlan03.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+# Test-case 1: Requires remote host, test will setup virtual sub-net
+#              192.168.124.*/24 between two hosts, then will compare
+#              TCP performance with and without VXLAN (tcp_fastopen test).
+#
+# Test-case 2: The same as above but must fail, because VXLAN allows
+#              to communicate only within the same VXLAN segment.
+
+TCID=vxlan03
+TST_TOTAL=2
+. test_net.sh
+. vxlan_lib.sh
+
+cleanup()
+{
+	cleanup_vxlans
+	tst_rhost_run -c "ip link delete ltp_vxl0"
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
+vxlan_setup_subnet "0xFFFFFE" "0xFFFFFE"
+vxlan_compare_netperf || res="TFAIL"
+
+tst_resm $res "done"
+
+tst_resm TINFO "different VNI shall not work together"
+res="TPASS"
+vxlan_setup_subnet "0xFFFFFE" "0xFFFFFD"
+vxlan_compare_netperf && res="TFAIL"
+
+tst_resm $res "done"
+
+tst_exit
diff --git a/testcases/network/vxlan/vxlan_lib.sh b/testcases/network/vxlan/vxlan_lib.sh
new file mode 100644
index 0000000..59d7dde
--- /dev/null
+++ b/testcases/network/vxlan/vxlan_lib.sh
@@ -0,0 +1,217 @@
+#!/bin/sh
+
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+# Virtual eXtensible Local Area Network (VXLAN) provides L2 networks
+# over existed L3 networks. It is using UDP (port 8472) to encapsulate
+# data packets. More information:
+# http://tools.ietf.org/html/draft-mahalingam-dutt-dcops-vxlan-08
+#
+# Warning: Test assumes that machines don't have any existed VXLANs.
+#          If machine has VXLANs, the test might fail or eventually delete
+#          them in cleanup function. See "start_vni" variable which can
+#          solve it.
+
+user_name="root"
+
+ip_local=${IPV4_NETWORK}.${LHOST_IPV4_HOST}
+ip_vxlan_local="192.168.124.1"
+mac_vxlan_local="3A:1C:C0:A8:7C:01"
+
+ip_remote=${IPV4_NETWORK}.${RHOST_IPV4_HOST}
+ip_vxlan_remote="192.168.124.2"
+mac_vxlan_remote="3A:1C:C0:A8:7C:02"
+
+vxlan_max=5000
+start_vni=16700000
+clients_num=2
+client_requests=500000
+max_requests=3
+net_load="TFO"
+
+# In average cases (with small packets less then 150 bytes) vxlan slower
+# by 10-30%. If hosts are too close to each one, e.g. connected to the same
+# switch the performance can be slower by 50%. Set 60% as default, the above
+# will be an error in VXLAN.
+vxlan_threshold=60
+
+while getopts :hsx:i:r:c:R:p:n:l:t: opt; do
+	case "$opt" in
+	h)
+		echo "Usage:"
+		echo "h        help"
+		echo "s        use ssh to run remote cmds"
+		echo "x n      n is a number of VXLANs for tc1 and tc2"
+		echo "i n      start VNI to use"
+		echo "r n      client requests for TCP performance test"
+		echo "c n      clients run concurrently in TCP perf"
+		echo "R n      num of reqs, after which conn.closed in TCP perf"
+		echo "p x      x and x + 1 are ports in TCP perf"
+		echo "n x      VXLAN network 192.168.x"
+		echo "l x      network load: x is PING or TFO(tcp_fastopen)"
+		echo "t x      VXLAN performance threshold, default is 60%"
+		exit 0
+	;;
+	s) TST_USE_SSH=1 ;;
+	x) vxlan_max=$OPTARG ;;
+	i) start_vni=$OPTARG ;;
+	c) clients_num=$OPTARG ;;
+	r) client_requests=$OPTARG ;;
+	R) max_requests=$OPTARG ;;
+	p) srv_port=$OPTARG ;;
+	n)
+		ip_vxlan_local="192.168.${OPTARG}.1"
+		ip_vxlan_remote="192.168.${OPTARG}.2"
+	;;
+	l) net_load=$OPTARG ;;
+	t) vxlan_threshold=$OPTARG ;;
+	*)
+		tst_brkm TBROK "unknown option: $opt"
+	;;
+	esac
+done
+
+cleanup_vxlans()
+{
+	tst_resm TINFO "cleanup vxlans..."
+	local vxlans=`ip link | sed -nE 's/^[0-9]+: (ltp_vxl[0-9]+):.+/\1/p'`
+	for vx in $vxlans; do
+		ip link delete $vx
+	done
+}
+
+TST_CLEANUP="cleanup_vxlans"
+trap "tst_brkm TBROK 'test interrupted'" INT
+
+safe_run()
+{
+	$@ > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "cmd failed: $@"
+	fi
+}
+
+vxlan_setup_subnet()
+{
+	tst_resm TINFO "virtual bridge & VXLAN, connect 2 hosts"
+	local opt="rsc proxy nolearning"
+
+	safe_run "ip link add ltp_vxl0 type vxlan id $1 $opt"
+	safe_run "ip link set ltp_vxl0 address $mac_vxlan_local"
+	safe_run "ip address add ${ip_vxlan_local}/24 dev ltp_vxl0"
+	safe_run "ip link set up ltp_vxl0"
+
+	safe_run "arp -s $ip_vxlan_remote $mac_vxlan_remote -i ltp_vxl0"
+	safe_run "bridge fdb add to $mac_vxlan_remote dst $ip_remote \
+	          dev ltp_vxl0"
+
+	tst_rhost_run -s -c "ip link add ltp_vxl0 type vxlan id $2 $opt"
+	tst_rhost_run -s -c "ip link set ltp_vxl0 address $mac_vxlan_remote"
+	tst_rhost_run -s -c "ip address add ${ip_vxlan_remote}/24 dev ltp_vxl0"
+	tst_rhost_run -s -c "ip link set up ltp_vxl0"
+
+	tst_rhost_run -s -c "arp -s $ip_vxlan_local $mac_vxlan_local \
+	                     -i ltp_vxl0"
+	tst_rhost_run -s -c "bridge fdb add to $mac_vxlan_local dst $ip_local \
+	                     dev ltp_vxl0"
+}
+
+netload_test()
+{
+	local ip_addr="$1"
+	local rfile="$2"
+	local ret=0
+
+	case "$net_load" in
+	PING)
+		tst_resm TINFO "run ping test with rhost '$ip_addr'..."
+		local res=
+		res=$(ping -f -c $client_requests $ip_addr -w 600 2>&1)
+		[ $? -ne 0 ] && return 1
+		echo $res | sed -nE 's/.*time ([0-9]+)ms.*/\1/p' > $rfile
+	;;
+	TFO)
+		tst_resm TINFO "run tcp_fastopen test with rhost '$ip_addr'"
+		local port=
+		port=$(tst_rhost_run -c 'tst_get_unused_port ipv4 stream')
+		[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
+
+		tst_rhost_run -s -b -c "tcp_fastopen -R $max_requests -g $port"
+
+		sleep 5
+
+		# run local tcp client
+		tcp_fastopen -a $clients_num -r $client_requests -l \
+			-H $ip_addr -g $port -d $rfile > /dev/null 2>&1 || ret=1
+
+		if [ $ret -eq 0 -a ! -f $rfile ]; then
+			tst_brkm TBROK "can't read $rfile"
+		fi
+
+		tst_rhost_run -c "pkill -9 tcp_fastopen\$"
+	;;
+	*) tst_brkm TBROK "invalid net_load type '$net_load'" ;;
+	esac
+
+	return $ret
+}
+
+vxlan_compare_netperf()
+{
+	local ret=0
+	local res_file="${TMPDIR}/vxlan_result"
+
+	netload_test $ip_vxlan_remote $res_file || ret=1
+
+	safe_run "ip link delete ltp_vxl0"
+	tst_rhost_run -s -c "ip link delete ltp_vxl0"
+	[ "$ret" -eq 1 ] && return 1
+	local vt="$(cat $res_file)"
+
+	netload_test $ip_remote $res_file || return 1
+
+	local lt="$(cat $res_file)"
+	tst_resm TINFO "time lan($lt) vxlan($vt) ms"
+
+	per=$(( $vt * 100 / $lt - 100 ))
+
+	if [ "$per" -lt "$vxlan_threshold" ]; then
+		tst_resm TINFO "vxlan slower by $per %"
+	else
+		tst_resm TINFO "vxlan too slow: by $per %"
+		ret=1
+	fi
+
+	return $ret
+}
+
+tst_require_root
+
+tst_kvercmp 3 8 0
+if [ $? -eq 0 ]; then
+	tst_brkm TCONF "test must be run with kernel 3.8 or newer"
+fi
+
+tst_check_cmds "ip"
+
+ip link add ltp_vxl type vxlan id $start_vni > /dev/null 2>&1
+if [ $? -ne 0 ]; then
+	tst_brkm TCONF "iproute2 or kernel doesn't support vxlan"
+fi
+safe_run "ip link delete ltp_vxl"
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
