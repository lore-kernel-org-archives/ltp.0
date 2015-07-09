Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zj-00087H-Ik
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:51 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zi-0008EU-IK
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:51 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696iiHx020353
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t696iiIo018879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:44 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696iieU009378
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:44 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:32 +0300
Message-Id: <1436424468-11756-8-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 07/23] network/virt/vlan02: add new test-case
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

Based on vxlan02 test-cases. Common code moved to
virt_lib.sh.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/network_stress.features    |    1 +
 testcases/network/virt/Makefile    |    1 +
 testcases/network/virt/virt_lib.sh |   13 +++++++++++++
 testcases/network/virt/vlan02.sh   |   34 ++++++++++++++++++++++++++++++++++
 testcases/network/virt/vxlan02.sh  |    8 +-------
 5 files changed, 50 insertions(+), 7 deletions(-)
 create mode 100755 testcases/network/virt/vlan02.sh

diff --git a/runtest/network_stress.features b/runtest/network_stress.features
index 59de5b0..35bcfaf 100644
--- a/runtest/network_stress.features
+++ b/runtest/network_stress.features
@@ -15,3 +15,4 @@ vxlan_ipv6_multi_03 vxlan03.sh -6 -d multi
 vxlan_ipv6_uni_03 vxlan03.sh -6 -d uni
 
 vlan01 vlan01.sh
+vlan02 vlan02.sh
diff --git a/testcases/network/virt/Makefile b/testcases/network/virt/Makefile
index 7ed0621..2ef0b37 100644
--- a/testcases/network/virt/Makefile
+++ b/testcases/network/virt/Makefile
@@ -20,6 +20,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= virt_lib.sh \
 			   vlan01.sh \
+			   vlan02.sh \
 			   vxlan01.sh \
 			   vxlan02.sh \
 			   vxlan03.sh \
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index fb1270a..6705868 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -148,6 +148,19 @@ virt_multiple_add_test()
 	tst_resm TPASS "done"
 }
 
+virt_add_delete_test()
+{
+	local opt="$@"
+	tst_resm TINFO "create, delete $virt_type $virt_max times"
+
+	for i in $(seq 0 $virt_max); do
+		ROD_SILENT "virt_add ltp_v0 $opt"
+		ROD_SILENT "ip link set ltp_v0 up"
+		ROD_SILENT "ip link delete ltp_v0"
+	done
+	tst_resm TPASS "done"
+}
+
 virt_setup()
 {
 	local opt="$1"
diff --git a/testcases/network/virt/vlan02.sh b/testcases/network/virt/vlan02.sh
new file mode 100755
index 0000000..a37bd73
--- /dev/null
+++ b/testcases/network/virt/vlan02.sh
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
+# Test-case 1: Local test, check if we can create and then delete VLAN
+#              interface 4095 times.
+#
+
+TCID=vlan02
+TST_TOTAL=1
+
+virt_type="vlan"
+virt_max="4094"
+
+. test_net.sh
+. virt_lib.sh
+
+virt_add_delete_test "id 4094"
+
+tst_exit
diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
index a0b9267..284a469 100755
--- a/testcases/network/virt/vxlan02.sh
+++ b/testcases/network/virt/vxlan02.sh
@@ -31,13 +31,7 @@ virt_max=5000
 . virt_lib.sh
 
 opt="group 239.1.1.1"
-tst_resm TINFO "create, delete ltp_v0 $virt_max times"
 
-for i in $(seq 0 $virt_max); do
-	ROD_SILENT "ip link add ltp_v0 type vxlan id $start_id $opt"
-	ROD_SILENT "ip link set ltp_v0 up"
-	ROD_SILENT "ip link delete ltp_v0"
-done
-tst_resm TPASS "done"
+virt_add_delete_test "id $start_id $opt"
 
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
