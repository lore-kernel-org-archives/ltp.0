Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zw-0002RL-Hj
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:04 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zv-0006ur-C7
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:04 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696ivG8020517
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t696iv8O005362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:57 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696ivHC009456
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:57 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:42 +0300
Message-Id: <1436424468-11756-18-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 17/23] network/virt: add test-case 01 to virt_lib.sh
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

And make use of it in the tests.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |   34 ++++++++++++++++++++++++++++++++++
 testcases/network/virt/vlan01.sh   |   25 +++----------------------
 testcases/network/virt/vxlan01.sh  |   28 +++++-----------------------
 3 files changed, 42 insertions(+), 45 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 77fa788..b27bd6a 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -250,6 +250,40 @@ virt_compare_netperf()
 	return $ret
 }
 
+# Check if we can create then delete virtual interface n times.
+# virt_test_01 [OPTIONS]
+# OPTIONS - different options separated by comma.
+virt_test_01()
+{
+	start_id=1
+	virt_count=500
+
+	local opts=${1:-""}
+	local n=0
+
+	while ((1)); do
+		n=$((n + 1))
+		p="$(echo $opts | cut -d',' -f$n)"
+		if [ -z "$p" -a $n -gt 1 ]; then
+			break
+		fi
+
+		tst_resm TINFO "add $virt_type with '$p'"
+
+		virt_add ltp_v0 id 0 $p > /dev/null 2>&1
+		if [ $? -ne 0 ]; then
+			tst_resm TCONF "iproute/kernel doesn't support '$p'"
+			p=""
+		else
+			ROD_SILENT "ip li delete ltp_v0"
+		fi
+
+		virt_multiple_add_test "$p"
+
+		start_id=$(($start_id + $virt_count))
+	done
+}
+
 tst_require_root
 
 case "$virt_type" in
diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
index ac74463..fb96562 100755
--- a/testcases/network/virt/vlan01.sh
+++ b/testcases/network/virt/vlan01.sh
@@ -16,7 +16,7 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
-# Test-case 1: Local test, check if we can create 4095 VLAN interfaces.
+# Local test, check if we can create 4000 VLAN interfaces.
 #
 
 TCID=vlan01
@@ -34,28 +34,9 @@ lb1="loose_binding on"
 rh0="reorder_hdr off"
 rh1="reorder_hdr on"
 
-opts="$p0 $lb0 $rh0,$p0 $lb0 $rh1,$p0 $lb1 $rh0,$p0 $lb1 $rh1,\
+options="$p0 $lb0 $rh0,$p0 $lb0 $rh1,$p0 $lb1 $rh0,$p0 $lb1 $rh1,\
 $p1 $lb0 $rh0,$p1 $lb0 $rh1,$p1 $lb1 $rh0,$p1 $lb1 $rh1,"
 
-start_id=1
-virt_count=500
-
-for n in $(seq 1 8); do
-	params="$(echo $opts | cut -d',' -f$n)"
-
-	tst_resm TINFO "add $virt_type with '$params'"
-
-	virt_add ltp_v0 id 0 $params > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TCONF "iproute or kernel doesn't support '$params'"
-		params=""
-	else
-		ROD_SILENT "ip li delete ltp_v0"
-	fi
-
-	virt_multiple_add_test "$params"
-
-	start_id=$(($start_id + $virt_count))
-done
+virt_test_01 "$options"
 
 tst_exit
diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
index 63a52d0..4dfe3d7 100755
--- a/testcases/network/virt/vxlan01.sh
+++ b/testcases/network/virt/vxlan01.sh
@@ -16,11 +16,11 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
-# Test-case 1: Local test, check if we can create 5000 VXLAN interfaces.
+# Local test, check if we can create 2500 VXLAN interfaces.
 #
 
 TCID=vxlan01
-TST_TOTAL=1
+TST_TOTAL=5
 
 virt_type="vxlan"
 start_id=16700000
@@ -28,27 +28,9 @@ start_id=16700000
 . test_net.sh
 . virt_lib.sh
 
-opts="l2miss l3miss,norsc nolearning noproxy,ttl 0x01 tos 0x01,ttl 0xff tos 0xff,gbp"
+options="l2miss l3miss,norsc nolearning noproxy,\
+ttl 0x01 tos 0x01,ttl 0xff tos 0xff,gbp"
 
-start_id=1
-virt_count=1000
-
-for n in $(seq 1 5); do
-	params="$(echo $opts | cut -d',' -f$n)"
-
-	tst_resm TINFO "add $virt_type with '$params'"
-
-	virt_add ltp_v0 id 0 $params > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TCONF "iproute or kernel doesn't support '$params'"
-		params=""
-	else
-		ROD_SILENT "ip li delete ltp_v0"
-	fi
-
-	virt_multiple_add_test "$params"
-
-	start_id=$(($start_id + $virt_count))
-done
+virt_test_01 "$options"
 
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
