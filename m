Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5a1-0008BC-4g
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:09 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zz-0006vl-91
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:09 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696j1lZ020823
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t696j1MY005537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:01 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696j1hU009465
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:01 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:45 +0300
Message-Id: <1436424468-11756-21-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 20/23] network/virt/vxlan03.sh: fix
	vxlan_compare_netperf()
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

Also fix number of running test-cases.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |    8 ++++----
 testcases/network/virt/vxlan03.sh  |   24 ++++++++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index d79f7bc..9597c84 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -189,8 +189,8 @@ vxlan_setup_subnet_uni()
 	[ "$(ip li add type vxlan help 2>&1 | grep remote)" ] || \
 		tst_brkm TCONF "iproute doesn't support remote unicast address"
 
-	local opt="id $1 remote $(tst_ipaddr rhost)"
-	local opt_r="id $2 remote $(tst_ipaddr)"
+	local opt="$1 remote $(tst_ipaddr rhost)"
+	local opt_r="$2 remote $(tst_ipaddr)"
 
 	virt_setup "$opt" "$opt_r"
 }
@@ -209,8 +209,8 @@ vxlan_setup_subnet_multi()
 		grp="group 239.$b1.$b2.$b3"
 	fi
 
-	local opt="id $1 $grp dev $(tst_iface)"
-	local opt_r="id $2 $grp dev $(tst_iface rhost)"
+	local opt="$1 $grp dev $(tst_iface)"
+	local opt_r="$2 $grp dev $(tst_iface rhost)"
 
 	virt_setup "$opt" "$opt_r"
 }
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 01fa62d..e5015be 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -24,7 +24,7 @@
 #              to communicate only within the same VXLAN segment.
 
 TCID=vxlan03
-TST_TOTAL=2
+TST_TOTAL=4
 
 virt_type="vxlan"
 start_id=16700000
@@ -60,30 +60,30 @@ if [ -z $ip_local -o -z $ip_remote ]; then
 	tst_brkm TBROK "you must specify IP address"
 fi
 
+if [ "$vxlan_dst_addr" != 'uni' -a $vxlan_dst_addr != 'multi' ]; then
+	tst_brkm TBROK "wrong dst address, can be 'uni' or 'multi'"
+fi
+
 opts="dstport 0,dstport 0 gbp"
 
 for n in $(seq 1 2); do
-	params="$(echo $opts | cut -d',' -f$n)"
+	p="$(echo $opts | cut -d',' -f$n)"
 
-	virt_check_cmd virt_add ltp_v0 id 0 $params || continue
+	virt_check_cmd virt_add ltp_v0 id 0 $p || continue
 
-	tst_resm TINFO "networks with the same VNI must work"
+	tst_resm TINFO "the same VNI must work"
 	# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
 	res="TPASS"
 
-	if [ "$vxlan_dst_addr" != 'uni' -a $vxlan_dst_addr != 'multi' ]; then
-		tst_brkm TBROK "wrong dst address, can be 'uni' or 'multi'"
-	fi
-
-	vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFE"
-	vxlan_compare_netperf || res="TFAIL"
+	vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE $p" "id 0xFFFFFE $p"
+	virt_compare_netperf || res="TFAIL"
 
 	tst_resm $res "done"
 
 	tst_resm TINFO "different VNI shall not work together"
 	res="TPASS"
-	vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFD"
-	vxlan_compare_netperf && res="TFAIL"
+	vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE $p" "id 0xFFFFFD $p"
+	virt_compare_netperf && res="TFAIL"
 
 	tst_resm $res "done"
 done
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
