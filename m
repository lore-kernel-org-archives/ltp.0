Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zy-0003ih-OU
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:06 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zw-00081G-Ob
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:06 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696iwC8020534
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t696iwvo019536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:58 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696iwl9009459
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:58 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:43 +0300
Message-Id: <1436424468-11756-19-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 18/23] network/virt: move checking for command support
	to virt_lib.sh
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

Add new function "virt_check_cmd". Change TCONF to TINFO so that
we just skip not supported options and don't return TCONF as a
end test result.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/ipvlan01.sh  |    8 +-------
 testcases/network/virt/macvlan01.sh |    8 +-------
 testcases/network/virt/macvtap01.sh |    8 +-------
 testcases/network/virt/virt_lib.sh  |   19 ++++++++++++-------
 testcases/network/virt/vlan03.sh    |    7 +------
 testcases/network/virt/vxlan03.sh   |    7 +------
 6 files changed, 17 insertions(+), 40 deletions(-)

diff --git a/testcases/network/virt/ipvlan01.sh b/testcases/network/virt/ipvlan01.sh
index 2044fb8..706c1d8 100755
--- a/testcases/network/virt/ipvlan01.sh
+++ b/testcases/network/virt/ipvlan01.sh
@@ -35,13 +35,7 @@ virt_count=500
 for m in $modes; do
 	tst_resm TINFO "add $virt_type with mode '$m'"
 
-	virt_add ltp_v0 mode $m > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TCONF "iproute or kernel doesn't support mode '$m'"
-		m=""
-	else
-		ROD_SILENT "ip li delete ltp_v0"
-	fi
+	virt_check_cmd virt_add ltp_v0 mode $m || m=""
 
 	virt_add_delete_test "mode $m"
 
diff --git a/testcases/network/virt/macvlan01.sh b/testcases/network/virt/macvlan01.sh
index aac9d02..35febd0 100755
--- a/testcases/network/virt/macvlan01.sh
+++ b/testcases/network/virt/macvlan01.sh
@@ -35,13 +35,7 @@ virt_count=500
 for m in $modes; do
 	tst_resm TINFO "add $virt_type with mode '$m'"
 
-	virt_add ltp_v0 mode $m > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TCONF "iproute or kernel doesn't support mode '$m'"
-		m=""
-	else
-		ROD_SILENT "ip li delete ltp_v0"
-	fi
+	virt_check_cmd virt_add ltp_v0 mode $m || m=""
 
 	virt_add_delete_test "mode $m"
 
diff --git a/testcases/network/virt/macvtap01.sh b/testcases/network/virt/macvtap01.sh
index 8623080..8bb3636 100755
--- a/testcases/network/virt/macvtap01.sh
+++ b/testcases/network/virt/macvtap01.sh
@@ -35,13 +35,7 @@ virt_count=500
 for m in $modes; do
 	tst_resm TINFO "add $virt_type with mode '$m'"
 
-	virt_add ltp_v0 mode $m > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TCONF "iproute or kernel doesn't support mode '$m'"
-		m=""
-	else
-		ROD_SILENT "ip li delete ltp_v0"
-	fi
+	virt_check_cmd virt_add ltp_v0 mode $m || m=""
 
 	virt_add_delete_test "mode $m"
 
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index b27bd6a..2ccba43 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -250,6 +250,17 @@ virt_compare_netperf()
 	return $ret
 }
 
+virt_check_cmd()
+{
+	$@ > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TINFO "'$@' option(s) not supported, skipping it"
+		return 1
+	fi
+	ROD_SILENT "ip li delete ltp_v0"
+	return 0
+}
+
 # Check if we can create then delete virtual interface n times.
 # virt_test_01 [OPTIONS]
 # OPTIONS - different options separated by comma.
@@ -270,13 +281,7 @@ virt_test_01()
 
 		tst_resm TINFO "add $virt_type with '$p'"
 
-		virt_add ltp_v0 id 0 $p > /dev/null 2>&1
-		if [ $? -ne 0 ]; then
-			tst_resm TCONF "iproute/kernel doesn't support '$p'"
-			p=""
-		else
-			ROD_SILENT "ip li delete ltp_v0"
-		fi
+		virt_check_cmd virt_add ltp_v0 id 0 $p || p=""
 
 		virt_multiple_add_test "$p"
 
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index 670a241..a067065 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -65,12 +65,7 @@ opts="$p0 $lb0 $rh0,$p0 $lb1 $rh1,$p1 $lb0 $rh0,$p1 $lb1 $rh1"
 for n in $(seq 1 4); do
 	params="$(echo $opts | cut -d',' -f$n)"
 
-	virt_add ltp_v0 id 0 $params > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TCONF "iproute or kernel doesn't support '$params'"
-		continue
-	fi
-	ROD_SILENT "ip li delete ltp_v0"
+	virt_check_cmd virt_add ltp_v0 id 0 $params || continue
 
 	virt_setup "id 4094 $params" "id 4094 $params"
 	virt_compare_netperf || res="TFAIL"
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 14524d4..01fa62d 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -65,12 +65,7 @@ opts="dstport 0,dstport 0 gbp"
 for n in $(seq 1 2); do
 	params="$(echo $opts | cut -d',' -f$n)"
 
-	virt_add ltp_v0 id 0 $params > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TCONF "iproute or kernel doesn't support '$params'"
-		continue
-	fi
-	ROD_SILENT "ip li delete ltp_v0"
+	virt_check_cmd virt_add ltp_v0 id 0 $params || continue
 
 	tst_resm TINFO "networks with the same VNI must work"
 	# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
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
