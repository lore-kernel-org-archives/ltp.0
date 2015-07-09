Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zm-0003fe-KI
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:54 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zl-0004Zi-HH
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:54 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696ilwk020377
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t696il2n020721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:47 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696ikM8005052
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:46 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:34 +0300
Message-Id: <1436424468-11756-10-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 09/23] network/virt/vlan03: add new test-case
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

It is based on vxlan03 test-case and use the same approach.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/network_stress.features  |    1 +
 testcases/network/virt/Makefile  |    1 +
 testcases/network/virt/vlan03.sh |   69 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100755 testcases/network/virt/vlan03.sh

diff --git a/runtest/network_stress.features b/runtest/network_stress.features
index 35bcfaf..2071d94 100644
--- a/runtest/network_stress.features
+++ b/runtest/network_stress.features
@@ -16,3 +16,4 @@ vxlan_ipv6_uni_03 vxlan03.sh -6 -d uni
 
 vlan01 vlan01.sh
 vlan02 vlan02.sh
+vlan03 vlan03.sh
diff --git a/testcases/network/virt/Makefile b/testcases/network/virt/Makefile
index 2ef0b37..af19f5b 100644
--- a/testcases/network/virt/Makefile
+++ b/testcases/network/virt/Makefile
@@ -21,6 +21,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
 INSTALL_TARGETS		:= virt_lib.sh \
 			   vlan01.sh \
 			   vlan02.sh \
+			   vlan03.sh \
 			   vxlan01.sh \
 			   vxlan02.sh \
 			   vxlan03.sh \
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
new file mode 100755
index 0000000..4cc9a05
--- /dev/null
+++ b/testcases/network/virt/vlan03.sh
@@ -0,0 +1,69 @@
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
+# Test-case 1: It requires remote host. Test will setup IPv4 and IPv6 virtual
+#              sub-nets between two hosts, then will compare TCP performance
+#              with and without VLAN using ping or tcp_fastopen test.
+#
+# Test-case 2: The same as above but must fail, because VLAN allows
+#              to communicate only within the same VLAN segment.
+
+TCID=vlan03
+TST_TOTAL=2
+
+virt_type="vlan"
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
+tst_resm TINFO "networks with the same VLAN ID must work"
+
+res="TPASS"
+
+virt_setup "id 4094" "id 4094"
+virt_compare_netperf || res="TFAIL"
+
+tst_resm $res "done"
+
+tst_resm TINFO "different VLAN ID shall not work together"
+res="TPASS"
+virt_setup "id 4093" "id 4094"
+virt_compare_netperf && res="TFAIL"
+
+tst_resm $res "done"
+
+tst_exit
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
