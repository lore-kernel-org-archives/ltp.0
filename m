Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zi-0004QK-4B
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:50 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zh-0006uI-1G
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:50 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696ihar020317
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t696igtw020554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:43 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696igcG009348
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:42 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:31 +0300
Message-Id: <1436424468-11756-7-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 06/23] network/virt/vlan01: add new test-case
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

This is similar to vxlan01 test. Create test interfaces
in the specified range. So move common code from vxlan01.sh
to virt_lib.sh.

Also some minor fixes:
  * add two options to virt_add() so that interface name
    could be changed
  * add default options to vlan and vxlan

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/network_stress.features    |    2 ++
 testcases/network/virt/Makefile    |    1 +
 testcases/network/virt/virt_lib.sh |   33 +++++++++++++++++++++++++++++----
 testcases/network/virt/vlan01.sh   |   34 ++++++++++++++++++++++++++++++++++
 testcases/network/virt/vxlan01.sh  |   18 +-----------------
 5 files changed, 67 insertions(+), 21 deletions(-)
 create mode 100755 testcases/network/virt/vlan01.sh

diff --git a/runtest/network_stress.features b/runtest/network_stress.features
index dd8e1a4..59de5b0 100644
--- a/runtest/network_stress.features
+++ b/runtest/network_stress.features
@@ -13,3 +13,5 @@ vxlan_uni_03 vxlan03.sh -d uni
 
 vxlan_ipv6_multi_03 vxlan03.sh -6 -d multi
 vxlan_ipv6_uni_03 vxlan03.sh -6 -d uni
+
+vlan01 vlan01.sh
diff --git a/testcases/network/virt/Makefile b/testcases/network/virt/Makefile
index d05890f..7ed0621 100644
--- a/testcases/network/virt/Makefile
+++ b/testcases/network/virt/Makefile
@@ -19,6 +19,7 @@ top_srcdir		?= ../../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= virt_lib.sh \
+			   vlan01.sh \
 			   vxlan01.sh \
 			   vxlan02.sh \
 			   vxlan03.sh \
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 22e4415..fb1270a 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -100,12 +100,21 @@ trap "tst_brkm TBROK 'test interrupted'" INT
 
 virt_add()
 {
+	local vname=$1
+	local opt="${@:2}"
+
+	case $virt_type in
+	vlan|vxlan)
+		[ -z "$opt" ] && opt="id 4094"
+	;;
+	esac
+
 	case $virt_type in
 	vxlan)
-		ip li add ltp_v0 type $virt_type $@
+		ip li add $vname type $virt_type $opt
 	;;
 	*)
-		ip li add link $(tst_iface) ltp_v0 type $virt_type $@
+		ip li add link $(tst_iface) $vname type $virt_type $opt
 	;;
 	esac
 }
@@ -123,6 +132,22 @@ virt_add_rhost()
 	esac
 }
 
+virt_multiple_add_test()
+{
+	local opt="$@"
+	local max=$(($start_id + $virt_max))
+
+	tst_resm TINFO "create $virt_max $virt_type"
+
+	local vnis=$(seq $start_id $max)
+
+	for i in $vnis; do
+		ROD_SILENT "virt_add ltp_v$i id $i $opt"
+		ROD_SILENT "ip link set ltp_v$i up"
+	done
+	tst_resm TPASS "done"
+}
+
 virt_setup()
 {
 	local opt="$1"
@@ -130,7 +155,7 @@ virt_setup()
 
 	tst_resm TINFO "setup local ${virt_type} with '$opt'"
 
-	ROD_SILENT "virt_add $opt"
+	ROD_SILENT "virt_add ltp_v0 $opt"
 	ROD_SILENT "ip li set ltp_v0 address $mac_virt_local"
 	ROD_SILENT "ip addr add ${ip_virt_local}/24 dev ltp_v0"
 	ROD_SILENT "ip li set up ltp_v0"
@@ -230,7 +255,7 @@ ipver=${TST_IPV6:-'4'}
 
 tst_check_cmds "ip"
 
-virt_add || \
+virt_add ltp_v0 || \
 	tst_brkm TCONF "iproute2 or kernel doesn't support $virt_type"
 
 ROD_SILENT "ip link delete ltp_v0"
diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
new file mode 100755
index 0000000..9136fbb
--- /dev/null
+++ b/testcases/network/virt/vlan01.sh
@@ -0,0 +1,34 @@
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
+# Test-case 1: Local test, check if we can create 4095 VLAN interfaces.
+#
+
+TCID=vlan01
+TST_TOTAL=1
+
+virt_type="vlan"
+start_id=0
+virt_max=4094
+
+. test_net.sh
+. virt_lib.sh
+
+virt_multiple_add_test
+
+tst_exit
diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
index a8624a3..808726c 100755
--- a/testcases/network/virt/vxlan01.sh
+++ b/testcases/network/virt/vxlan01.sh
@@ -29,22 +29,6 @@ virt_max=5000
 . test_net.sh
 . virt_lib.sh
 
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
+virt_multiple_add_test "group 239.1.1.1"
 
 tst_exit
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
