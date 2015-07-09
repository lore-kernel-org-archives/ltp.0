Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zr-0002QP-GW
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:59 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zq-0008Ed-DH
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:59 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696iqgl020441
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t696iquU020890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:52 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696iquA009425
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:52 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:38 +0300
Message-Id: <1436424468-11756-14-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 13/23] network/virt: add new ipvlan01 test
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

Based on vlan02 test. It creates then deletes ipvlan
interfaces multiple times with mode l2 and l3.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/network_stress.features    |    2 +
 testcases/network/virt/Makefile    |    3 +-
 testcases/network/virt/ipvlan01.sh |   51 ++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletions(-)
 create mode 100755 testcases/network/virt/ipvlan01.sh

diff --git a/runtest/network_stress.features b/runtest/network_stress.features
index bc62919..d2451ba 100644
--- a/runtest/network_stress.features
+++ b/runtest/network_stress.features
@@ -19,3 +19,5 @@ vlan02 vlan02.sh
 vlan03 vlan03.sh
 
 macvlan01 macvlan01.sh
+
+ipvlan01 ipvlan01.sh
diff --git a/testcases/network/virt/Makefile b/testcases/network/virt/Makefile
index 4cc9de9..170852d 100644
--- a/testcases/network/virt/Makefile
+++ b/testcases/network/virt/Makefile
@@ -18,7 +18,8 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= macvlan01.sh \
+INSTALL_TARGETS		:= ipvlan01.sh \
+			   macvlan01.sh \
 			   virt_lib.sh \
 			   vlan01.sh \
 			   vlan02.sh \
diff --git a/testcases/network/virt/ipvlan01.sh b/testcases/network/virt/ipvlan01.sh
new file mode 100755
index 0000000..2044fb8
--- /dev/null
+++ b/testcases/network/virt/ipvlan01.sh
@@ -0,0 +1,51 @@
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
+# Test-case 1: Local test, check if we can create and then delete ipvlan
+#              interface 500 times.
+
+TCID=ipvlan01
+TST_TOTAL=2
+
+virt_type="ipvlan"
+
+. test_net.sh
+. virt_lib.sh
+
+modes="l2 l3"
+
+start_id=1
+virt_count=500
+
+for m in $modes; do
+	tst_resm TINFO "add $virt_type with mode '$m'"
+
+	virt_add ltp_v0 mode $m > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TCONF "iproute or kernel doesn't support mode '$m'"
+		m=""
+	else
+		ROD_SILENT "ip li delete ltp_v0"
+	fi
+
+	virt_add_delete_test "mode $m"
+
+	start_id=$(($start_id + $virt_count))
+done
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
