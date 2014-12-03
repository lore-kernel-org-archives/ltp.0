Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XwANg-00050R-Ef
	for ltp-list@lists.sourceforge.net; Wed, 03 Dec 2014 13:54:12 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XwANf-0005mk-1H
	for ltp-list@lists.sourceforge.net; Wed, 03 Dec 2014 13:54:12 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id sB3Ds4XX027611
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Dec 2014 13:54:05 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sB3Ds3IS027971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Dec 2014 13:54:04 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sB3Ds2ul006172
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Dec 2014 13:54:03 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  3 Dec 2014 16:55:47 +0300
Message-Id: <1417614947-5514-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1417614947-5514-1-git-send-email-alexey.kodanev@oracle.com>
References: <1417614947-5514-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 3/3] network/dhcp: add dnsmasq to dhcp test
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

* use Virtual Ethernet Tunnel pair instead of dummy interface
* move common code to dhcp_lib.sh

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/dhcp/Makefile         |    2 +-
 testcases/network/dhcp/dhcp_lib.sh      |  126 +++++++++++++++++++++++++
 testcases/network/dhcp/dhcpd_tests.sh   |  152 +++++++------------------------
 testcases/network/dhcp/dnsmasq_tests.sh |   63 +++++++++++++
 4 files changed, 224 insertions(+), 119 deletions(-)
 create mode 100755 testcases/network/dhcp/dhcp_lib.sh
 create mode 100755 testcases/network/dhcp/dnsmasq_tests.sh

diff --git a/testcases/network/dhcp/Makefile b/testcases/network/dhcp/Makefile
index a963a45..b419137 100644
--- a/testcases/network/dhcp/Makefile
+++ b/testcases/network/dhcp/Makefile
@@ -24,7 +24,7 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= dhcpd_tests.sh
+INSTALL_TARGETS		:= dhcp_lib.sh dhcpd_tests.sh dnsmasq_tests.sh
 
 MAKE_TARGETS		:=
 
diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
new file mode 100755
index 0000000..b8b3b9f
--- /dev/null
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -0,0 +1,126 @@
+#!/bin/sh
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
+# Author:       Alexey Kodanev alexey.kodanev@oracle.com
+
+stop_dhcp()
+{
+	[ "$(pgrep -x $dhcp_name)" ] || return
+
+	tst_resm TINFO "stopping $dhcp_name"
+	pkill -x $dhcp_name || tst_brkm "failed to stop $dhcp_name"
+	pkill -x $dhcp_name
+	sleep 1
+}
+
+init()
+{
+	tst_require_root
+	tst_check_cmds cat $dhcp_name awk ip pgrep pkill dhclient
+
+	veth_loaded=
+	lsmod | grep -q '^veth ' && veth_loaded=1
+
+	tst_resm TINFO "create veth interfaces"
+	ip li add $iface0 type veth peer name $iface1 || \
+		tst_brkm TBROK "failed to add veth $iface0"
+
+	veth_added=1
+	ip li set up $iface0 || tst_brkm TBROK "failed to bring $iface0 up"
+	ip li set up $iface1 || tst_brkm TBROK "failed to bring $iface1 up"
+
+	tst_tmpdir
+
+	stop_dhcp
+
+	dhclient_lease="/var/lib/dhclient/dhclient${TST_IPV6}.leases"
+	if [ -f $dhclient_lease ]; then
+		tst_resm TINFO "backup dhclient${TST_IPV6}.leases"
+		mv $dhclient_lease .
+	fi
+
+	tst_resm TINFO "add $ip_addr to $iface0"
+	ip addr add $ip_addr dev $iface0 || \
+		tst_brkm TBROK "failed to add ip address"
+}
+
+cleanup()
+{
+	stop_dhcp
+
+	pkill -f "dhclient -$ipv $iface1"
+
+	cleanup_dhcp
+
+	# restore dhclient leases
+	rm -f $dhclient_lease
+	[ -f "dhclient${TST_IPV6}.leases" ] && \
+		mv dhclient${TST_IPV6}.leases $dhclient_lease
+
+	[ $veth_added ] && ip li del $iface0
+
+	if [ -z $veth_loaded ]; then
+		lsmod | grep -q '^veth ' && rmmod veth
+	fi
+
+	tst_rmdir
+}
+
+test01()
+{
+	tst_resm TINFO "starting DHCPv${ipv} server on $iface0"
+
+	start_dhcp$TST_IPV6
+
+	sleep 1
+
+	if [ "$(pgrep '$dhcp_name')" ]; then
+		print_dhcp_log
+		tst_brkm TBROK "Failed to start $dhcp_name"
+	fi
+
+	tst_resm TINFO "starting dhclient -${ipv} $iface1"
+	dhclient -$ipv $iface1 || \
+		tst_brkm TBROK "dhclient failed"
+
+	# check that we get configured ip address
+	ip addr show $iface1 | grep $ip_addr_check > /dev/null
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS "'$ip_addr_check' configured by DHCPv$ipv"
+	else
+		tst_resm TFAIL "'$ip_addr_check' not configured by DHCPv$ipv"
+		print_dhcp_log
+	fi
+
+	stop_dhcp
+}
+
+tst_read_opts $*
+
+iface0="ltp_veth0"
+iface1="ltp_veth1"
+ipv=${TST_IPV6:-"4"}
+
+if [ $TST_IPV6 ]; then
+	ip_addr="fd00:1:1:2::12/64"
+	ip_addr_check="fd00:1:1:2::100/64"
+else
+	ip_addr="10.1.1.12/24"
+	ip_addr_check="10.1.1.100/24"
+fi
+
+trap "tst_brkm TBROK 'test interrupted'" INT
diff --git a/testcases/network/dhcp/dhcpd_tests.sh b/testcases/network/dhcp/dhcpd_tests.sh
index c4c2c21..785dc1e 100755
--- a/testcases/network/dhcp/dhcpd_tests.sh
+++ b/testcases/network/dhcp/dhcpd_tests.sh
@@ -22,19 +22,39 @@
 TST_CLEANUP=cleanup
 TST_TOTAL=1
 TCID="dhcpd"
+dhcp_name="dhcpd"
 
 . test_net.sh
+. dhcp_lib.sh
 
-stop_dhcp()
+setup_dhcpd_conf()
 {
-	if [ "$(pgrep -x dhcpd)" ]; then
-		tst_resm TINFO "stopping DHCP server"
-		pkill -x dhcpd
-		sleep 1
+	if [ -f /etc/dhcpd.conf ]; then
+		DHCPD_CONF="/etc/dhcpd.conf"
+	elif [ -f /etc/dhcp/dhcpd.conf ]; then
+		DHCPD_CONF="/etc/dhcp/dhcpd.conf"
+	else
+		tst_brkm TBROK "failed to find dhcpd.conf"
 	fi
+
+	mv $DHCPD_CONF dhcpd.conf
+	[ $? -ne 0 ] && tst_brkm TBROK "failed to backup dhcpd.conf"
+
+	mv tst_dhcpd.conf $DHCPD_CONF
+	[ $? -ne 0 ] && tst_brkm TBROK "failed to create dhcpd.conf"
 }
 
-setup_conf()
+start_dhcpd()
+{
+	dhcpd -$ipv $iface0 > tst_dhcpd.err 2>&1
+	if [ $? -ne 0 ]; then
+		cat tst_dhcpd.err
+		tst_brkm TBROK "Failed to start dhcpd"
+	fi
+
+}
+
+start_dhcp()
 {
 	cat > tst_dhcpd.conf <<-EOF
 	ddns-update-style none;
@@ -45,9 +65,11 @@ setup_conf()
 		max-lease-time 60;
 	}
 	EOF
+	setup_dhcpd_conf
+	start_dhcpd
 }
 
-setup_conf6()
+start_dhcp6()
 {
 	cat > tst_dhcpd.conf <<-EOF
 	ddns-update-style none;
@@ -58,126 +80,20 @@ setup_conf6()
 		max-lease-time 60;
 	}
 	EOF
+	setup_dhcpd_conf
+	start_dhcpd
 }
 
-init()
+cleanup_dhcp()
 {
-	tst_require_root
-	tst_check_cmds cat dhcpd awk ip pgrep pkill dhclient
-
-	dummy_loaded=
-	lsmod | grep -q '^dummy '
-	if [ $? -eq 0 ]; then
-		dummy_loaded=1
-	else
-		modprobe dummy || tst_brkm TCONF "failed to find dummy module"
-	fi
-
-	tst_resm TINFO "create dummy interface"
-	ip li add $iface type dummy || \
-		tst_brkm TBROK "failed to add dummy $iface"
-
-	ip li set up $iface || tst_brkm TBROK "failed to bring $iface up"
-
-	tst_tmpdir
-
-	stop_dhcp
-
-	setup_conf$TST_IPV6
-
-	if [ -f /etc/dhcpd.conf ]; then
-		DHCPD_CONF="/etc/dhcpd.conf"
-	elif [ -f /etc/dhcp/dhcpd.conf ]; then
-		DHCPD_CONF="/etc/dhcp/dhcpd.conf"
-	else
-		tst_brkm TBROK "failed to find dhcpd.conf"
-	fi
-
-	mv $DHCPD_CONF dhcpd.conf
-	[ $? -ne 0 ] && tst_brkm TBROK "failed to backup dhcpd.conf"
-
-	mv tst_dhcpd.conf $DHCPD_CONF
-	[ $? -ne 0 ] && tst_brkm TBROK "failed to create dhcpd.conf"
-
-	dhclient_lease="/var/lib/dhclient/dhclient${TST_IPV6}.leases"
-	if [ -f $dhclient_lease ]; then
-		tst_resm TINFO "backup dhclient${TST_IPV6}.leases"
-		mv $dhclient_lease .
-	fi
-
-	tst_resm TINFO "add $ip_addr to $iface to create private network"
-	ip addr add $ip_addr dev $iface || \
-		tst_brkm TBROK "failed to add ip address"
-}
-
-cleanup()
-{
-	stop_dhcp
-
-	pkill -f "dhclient -$ipv $iface"
-
 	[ -f dhcpd.conf ] && mv dhcpd.conf $DHCPD_CONF
-
-	# restore dhclient leases
-	rm -f $dhclient_lease
-	[ -f "dhclient${TST_IPV6}.leases" ] && \
-		mv dhclient${TST_IPV6}.leases $dhclient_lease
-
-	if [ "$dummy_loaded" ]; then
-		ip li del $iface
-	else
-		rmmod dummy
-	fi
-
-	tst_rmdir
 }
 
-test01()
+print_dhcp_log()
 {
-	tst_resm TINFO "starting DHCPv${ipv} server on $iface"
-	dhcpd -$ipv $iface > tst_dhcpd.err 2>&1
-	if [ $? -ne 0 ]; then
-		cat tst_dhcpd.err
-		tst_brkm TBROK "Failed to start dhcpd"
-	fi
-
-	sleep 1
-
-	if [ "$(pgrep 'dhcpd -$ipv $iface')" ]; then
-		cat tst_dhcpd.err
-		tst_brkm TBROK "Failed to start dhcpd"
-	fi
-
-	tst_resm TINFO "starting dhclient -${ipv} $iface"
-	dhclient -$ipv $iface || \
-		tst_brkm TBROK "dhclient failed"
-
-	# check that we get configured ip address
-	ip addr show $iface | grep $ip_addr_check > /dev/null
-	if [ $? -eq 0 ]; then
-		tst_resm TPASS "'$ip_addr_check' configured by DHCPv$ipv"
-	else
-		tst_resm TFAIL "'$ip_addr_check' not configured by DHCPv$ipv"
-	fi
-
-	stop_dhcp
+	cat tst_dhcpd.err
 }
 
-tst_read_opts $*
-
-iface="ltp_dummy"
-ipv=${TST_IPV6:-"4"}
-
-if [ $TST_IPV6 ]; then
-	ip_addr="fd00:1:1:2::12/64"
-	ip_addr_check="fd00:1:1:2::100/64"
-else
-	ip_addr="10.1.1.12/24"
-	ip_addr_check="10.1.1.100/24"
-fi
-
-trap "tst_brkm TBROK 'test interrupted'" INT
-
 init
 test01
 tst_exit
diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
new file mode 100755
index 0000000..d2f7430
--- /dev/null
+++ b/testcases/network/dhcp/dnsmasq_tests.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
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
+# Author: Alexey Kodanev alexey.kodanev@oracle.com
+
+TST_CLEANUP=cleanup
+TST_TOTAL=1
+TCID="dnsmasq"
+dhcp_name="dnsmasq"
+
+. test_net.sh
+. dhcp_lib.sh
+
+start_dhcp()
+{
+	dnsmasq $common_opt \
+	        --dhcp-range=10.1.1.100,10.1.1.100,255.255.255.0,2m \
+	        --dhcp-option=option:router --dhcp-option=option:dns-server
+}
+
+start_dhcp6()
+{
+	# check that dnsmasq supports IPv6
+	dnsmasq --dhcp-range=fd00::1,fd00::1 --test > /dev/null 2>&1 || \
+		tst_brkm TCONF "dnsmasq doesn't support DHCPv6"
+
+	dnsmasq $common_opt \
+	        --dhcp-range=fd00:1:1:2::100,fd00:1:1:2::100 --enable-ra \
+	        --dhcp-option=option6:dns-server
+}
+
+cleanup_dhcp()
+{
+	rm -f tst_dnsmasq.log
+}
+
+print_dhcp_log()
+{
+	cat tst_dnsmasq.log
+}
+
+init
+
+common_opt="--no-hosts --no-resolv --dhcp-authoritative \
+	--log-facility=$(pwd)/tst_dnsmasq.log --interface=$iface0 \
+	--dhcp-leasefile=$(pwd)/tst_dnsmasq.lease --conf-file= "
+
+test01
+tst_exit
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
