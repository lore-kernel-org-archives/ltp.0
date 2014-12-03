Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XwANd-0002x1-VX
	for ltp-list@lists.sourceforge.net; Wed, 03 Dec 2014 13:54:09 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XwANb-0007D6-Q2
	for ltp-list@lists.sourceforge.net; Wed, 03 Dec 2014 13:54:09 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id sB3Ds1Td031009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Dec 2014 13:54:02 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	sB3Ds0xq007446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Dec 2014 13:54:01 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sB3Ds0bZ005761
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Dec 2014 13:54:00 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  3 Dec 2014 16:55:46 +0300
Message-Id: <1417614947-5514-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1417614947-5514-1-git-send-email-alexey.kodanev@oracle.com>
References: <1417614947-5514-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/3] network/dhcpd: rename to dhcp
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
 testcases/network/dhcp/Makefile        |   31 ++++++
 testcases/network/dhcp/dhcpd_tests.sh  |  183 ++++++++++++++++++++++++++++++++
 testcases/network/dhcpd/Makefile       |   31 ------
 testcases/network/dhcpd/dhcpd_tests.sh |  183 --------------------------------
 4 files changed, 214 insertions(+), 214 deletions(-)
 create mode 100644 testcases/network/dhcp/Makefile
 create mode 100755 testcases/network/dhcp/dhcpd_tests.sh
 delete mode 100644 testcases/network/dhcpd/Makefile
 delete mode 100755 testcases/network/dhcpd/dhcpd_tests.sh

diff --git a/testcases/network/dhcp/Makefile b/testcases/network/dhcp/Makefile
new file mode 100644
index 0000000..a963a45
--- /dev/null
+++ b/testcases/network/dhcp/Makefile
@@ -0,0 +1,31 @@
+#
+#    network/dhcpd testcases Makefile.
+#
+#    Copyright (C) 2009, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= dhcpd_tests.sh
+
+MAKE_TARGETS		:=
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/dhcp/dhcpd_tests.sh b/testcases/network/dhcp/dhcpd_tests.sh
new file mode 100755
index 0000000..c4c2c21
--- /dev/null
+++ b/testcases/network/dhcp/dhcpd_tests.sh
@@ -0,0 +1,183 @@
+#!/bin/sh
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2001
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
+# Author:       Manoj Iyer, manjo@mail.utexas.edu
+# Author:       Alexey Kodanev alexey.kodanev@oracle.com
+
+TST_CLEANUP=cleanup
+TST_TOTAL=1
+TCID="dhcpd"
+
+. test_net.sh
+
+stop_dhcp()
+{
+	if [ "$(pgrep -x dhcpd)" ]; then
+		tst_resm TINFO "stopping DHCP server"
+		pkill -x dhcpd
+		sleep 1
+	fi
+}
+
+setup_conf()
+{
+	cat > tst_dhcpd.conf <<-EOF
+	ddns-update-style none;
+	update-static-leases off;
+	subnet 10.1.1.0 netmask 255.255.255.0 {
+		range 10.1.1.100 10.1.1.100;
+		default-lease-time 60;
+		max-lease-time 60;
+	}
+	EOF
+}
+
+setup_conf6()
+{
+	cat > tst_dhcpd.conf <<-EOF
+	ddns-update-style none;
+	update-static-leases off;
+	subnet6 fd00:1:1:2::/64 {
+		range6 fd00:1:1:2::100 fd00:1:1:2::100;
+		default-lease-time 60;
+		max-lease-time 60;
+	}
+	EOF
+}
+
+init()
+{
+	tst_require_root
+	tst_check_cmds cat dhcpd awk ip pgrep pkill dhclient
+
+	dummy_loaded=
+	lsmod | grep -q '^dummy '
+	if [ $? -eq 0 ]; then
+		dummy_loaded=1
+	else
+		modprobe dummy || tst_brkm TCONF "failed to find dummy module"
+	fi
+
+	tst_resm TINFO "create dummy interface"
+	ip li add $iface type dummy || \
+		tst_brkm TBROK "failed to add dummy $iface"
+
+	ip li set up $iface || tst_brkm TBROK "failed to bring $iface up"
+
+	tst_tmpdir
+
+	stop_dhcp
+
+	setup_conf$TST_IPV6
+
+	if [ -f /etc/dhcpd.conf ]; then
+		DHCPD_CONF="/etc/dhcpd.conf"
+	elif [ -f /etc/dhcp/dhcpd.conf ]; then
+		DHCPD_CONF="/etc/dhcp/dhcpd.conf"
+	else
+		tst_brkm TBROK "failed to find dhcpd.conf"
+	fi
+
+	mv $DHCPD_CONF dhcpd.conf
+	[ $? -ne 0 ] && tst_brkm TBROK "failed to backup dhcpd.conf"
+
+	mv tst_dhcpd.conf $DHCPD_CONF
+	[ $? -ne 0 ] && tst_brkm TBROK "failed to create dhcpd.conf"
+
+	dhclient_lease="/var/lib/dhclient/dhclient${TST_IPV6}.leases"
+	if [ -f $dhclient_lease ]; then
+		tst_resm TINFO "backup dhclient${TST_IPV6}.leases"
+		mv $dhclient_lease .
+	fi
+
+	tst_resm TINFO "add $ip_addr to $iface to create private network"
+	ip addr add $ip_addr dev $iface || \
+		tst_brkm TBROK "failed to add ip address"
+}
+
+cleanup()
+{
+	stop_dhcp
+
+	pkill -f "dhclient -$ipv $iface"
+
+	[ -f dhcpd.conf ] && mv dhcpd.conf $DHCPD_CONF
+
+	# restore dhclient leases
+	rm -f $dhclient_lease
+	[ -f "dhclient${TST_IPV6}.leases" ] && \
+		mv dhclient${TST_IPV6}.leases $dhclient_lease
+
+	if [ "$dummy_loaded" ]; then
+		ip li del $iface
+	else
+		rmmod dummy
+	fi
+
+	tst_rmdir
+}
+
+test01()
+{
+	tst_resm TINFO "starting DHCPv${ipv} server on $iface"
+	dhcpd -$ipv $iface > tst_dhcpd.err 2>&1
+	if [ $? -ne 0 ]; then
+		cat tst_dhcpd.err
+		tst_brkm TBROK "Failed to start dhcpd"
+	fi
+
+	sleep 1
+
+	if [ "$(pgrep 'dhcpd -$ipv $iface')" ]; then
+		cat tst_dhcpd.err
+		tst_brkm TBROK "Failed to start dhcpd"
+	fi
+
+	tst_resm TINFO "starting dhclient -${ipv} $iface"
+	dhclient -$ipv $iface || \
+		tst_brkm TBROK "dhclient failed"
+
+	# check that we get configured ip address
+	ip addr show $iface | grep $ip_addr_check > /dev/null
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS "'$ip_addr_check' configured by DHCPv$ipv"
+	else
+		tst_resm TFAIL "'$ip_addr_check' not configured by DHCPv$ipv"
+	fi
+
+	stop_dhcp
+}
+
+tst_read_opts $*
+
+iface="ltp_dummy"
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
+
+init
+test01
+tst_exit
diff --git a/testcases/network/dhcpd/Makefile b/testcases/network/dhcpd/Makefile
deleted file mode 100644
index a963a45..0000000
--- a/testcases/network/dhcpd/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    network/dhcpd testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Garrett Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= dhcpd_tests.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/dhcpd/dhcpd_tests.sh b/testcases/network/dhcpd/dhcpd_tests.sh
deleted file mode 100755
index c4c2c21..0000000
--- a/testcases/network/dhcpd/dhcpd_tests.sh
+++ /dev/null
@@ -1,183 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2001
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
-#
-# Author:       Manoj Iyer, manjo@mail.utexas.edu
-# Author:       Alexey Kodanev alexey.kodanev@oracle.com
-
-TST_CLEANUP=cleanup
-TST_TOTAL=1
-TCID="dhcpd"
-
-. test_net.sh
-
-stop_dhcp()
-{
-	if [ "$(pgrep -x dhcpd)" ]; then
-		tst_resm TINFO "stopping DHCP server"
-		pkill -x dhcpd
-		sleep 1
-	fi
-}
-
-setup_conf()
-{
-	cat > tst_dhcpd.conf <<-EOF
-	ddns-update-style none;
-	update-static-leases off;
-	subnet 10.1.1.0 netmask 255.255.255.0 {
-		range 10.1.1.100 10.1.1.100;
-		default-lease-time 60;
-		max-lease-time 60;
-	}
-	EOF
-}
-
-setup_conf6()
-{
-	cat > tst_dhcpd.conf <<-EOF
-	ddns-update-style none;
-	update-static-leases off;
-	subnet6 fd00:1:1:2::/64 {
-		range6 fd00:1:1:2::100 fd00:1:1:2::100;
-		default-lease-time 60;
-		max-lease-time 60;
-	}
-	EOF
-}
-
-init()
-{
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
-	[ -f dhcpd.conf ] && mv dhcpd.conf $DHCPD_CONF
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
-}
-
-test01()
-{
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
-}
-
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
-init
-test01
-tst_exit
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
