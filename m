Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5a7-0002SY-KV
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:15 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5a6-0008HN-Hc
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:15 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696j8fh020506
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t696j8t1024709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:08 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t696j2dg002697
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:07 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:46 +0300
Message-Id: <1436424468-11756-22-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 21/23] network/virt: add gre tunnel test
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

It is based on vlan03 test where tunnel is checked by
comparing performance between original link and the tunnel.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/network_stress.features    |    3 ++
 testcases/network/virt/Makefile    |    1 +
 testcases/network/virt/gre01.sh    |   63 ++++++++++++++++++++++++++++++++++++
 testcases/network/virt/virt_lib.sh |   34 ++++++++++++++++---
 4 files changed, 95 insertions(+), 6 deletions(-)
 create mode 100755 testcases/network/virt/gre01.sh

diff --git a/runtest/network_stress.features b/runtest/network_stress.features
index 833258f..f48f0a7 100644
--- a/runtest/network_stress.features
+++ b/runtest/network_stress.features
@@ -22,3 +22,6 @@ macvlan01 macvlan01.sh
 macvtap01 macvtap01.sh
 
 ipvlan01 ipvlan01.sh
+
+gre_ipv4_01 gre01.sh
+gre_ipv6_01 gre01.sh -6
diff --git a/testcases/network/virt/Makefile b/testcases/network/virt/Makefile
index 5b7b847..54e374f 100644
--- a/testcases/network/virt/Makefile
+++ b/testcases/network/virt/Makefile
@@ -19,6 +19,7 @@ top_srcdir		?= ../../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= ipvlan01.sh \
+			   gre01.sh \
 			   macvlan01.sh \
 			   macvtap01.sh \
 			   virt_lib.sh \
diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
new file mode 100755
index 0000000..a900ee3
--- /dev/null
+++ b/testcases/network/virt/gre01.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
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
+# It requires remote host. Test will setup IPv4 and IPv6 virtual
+# tunnel between two hosts, then will compare TCP performance
+# with and without GRE using ping or tcp_fastopen test.
+
+TCID=gre01
+TST_TOTAL=2
+
+. test_net.sh
+
+virt_type="gre"
+[ "$TST_IPV6" ] && virt_type="ip6gre"
+
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
+res="TPASS"
+
+tst_resm TINFO "test $virt_type"
+
+virt_setup "remote $(tst_ipaddr rhost) dev $(tst_iface)" \
+"remote $(tst_ipaddr) dev $(tst_iface rhost)"
+
+virt_compare_netperf || res="TFAIL"
+
+tst_resm $res "done"
+
+tst_exit
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 9597c84..39fd96a 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -107,12 +107,19 @@ virt_add()
 	vlan|vxlan)
 		[ -z "$opt" ] && opt="id 4094"
 	;;
+	gre|ip6gre)
+		[ -z "$opt" ] && \
+			opt="remote $(tst_ipaddr rhost) dev $(tst_iface)"
+	;;
 	esac
 
 	case $virt_type in
 	vxlan)
 		ip li add $vname type $virt_type $opt
 	;;
+	gre|ip6gre)
+		ip -f inet$TST_IPV6 tu add $vname mode $virt_type $opt
+	;;
 	*)
 		ip li add link $(tst_iface) $vname type $virt_type $opt
 	;;
@@ -125,6 +132,10 @@ virt_add_rhost()
 	vxlan)
 		tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $@"
 	;;
+	gre|ip6gre)
+		tst_rhost_run -s -c "ip -f inet$TST_IPV6 tu add ltp_v0 \
+				     mode $virt_type $@"
+	;;
 	*)
 		tst_rhost_run -s -c "ip li add link $(tst_iface rhost) ltp_v0 \
 				     type $virt_type $@"
@@ -167,17 +178,28 @@ virt_setup()
 	local opt_r="$2"
 
 	tst_resm TINFO "setup local ${virt_type} with '$opt'"
-
 	ROD_SILENT "virt_add ltp_v0 $opt"
-	ROD_SILENT "ip li set ltp_v0 address $mac_virt_local"
-	ROD_SILENT "ip addr add ${ip_virt_local}/24 dev ltp_v0"
-	ROD_SILENT "ip li set up ltp_v0"
 
 	tst_resm TINFO "setup rhost ${virt_type} with '$opt_r'"
-
 	virt_add_rhost "$opt_r"
-	tst_rhost_run -s -c "ip li set ltp_v0 address $mac_virt_remote"
+
+	case $virt_type in
+	gre|ip6gre)
+		# We can't set hwaddr to GRE tunnel, add IPv6 link local
+		# addresses manually.
+		ROD_SILENT "ip addr add ${ip6_virt_local}/64 dev ltp_v0"
+		tst_rhost_run -s -c "ip ad add ${ip6_virt_remote}/64 dev ltp_v0"
+	;;
+	*)
+		ROD_SILENT "ip li set ltp_v0 address $mac_virt_local"
+		tst_rhost_run -s -c "ip li set ltp_v0 address $mac_virt_remote"
+	;;
+	esac
+
+	ROD_SILENT "ip addr add ${ip_virt_local}/24 dev ltp_v0"
 	tst_rhost_run -s -c "ip addr add ${ip_virt_remote}/24 dev ltp_v0"
+
+	ROD_SILENT "ip li set up ltp_v0"
 	tst_rhost_run -s -c "ip li set up ltp_v0"
 }
 
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
