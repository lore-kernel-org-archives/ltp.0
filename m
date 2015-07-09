Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zo-00088l-Dr
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:56 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zn-0008EZ-Mz
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:56 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696inoN020414
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t696inn9020814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:49 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t696inRj023365
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:49 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:36 +0300
Message-Id: <1436424468-11756-12-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 11/23] network/virt/vlan03.sh: add protocol,
	loose_binding and hdr options
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

protocol {802.1Q | 802.1ad}, loose_binding {off | on} and
reorder_hdr {off | on}.

The options combinations are less than in vlan01 test in order to
not waste too much time for no good reason.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/vlan01.sh |    2 +-
 testcases/network/virt/vlan03.sh |   39 ++++++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
index c4d56e8..ac74463 100755
--- a/testcases/network/virt/vlan01.sh
+++ b/testcases/network/virt/vlan01.sh
@@ -20,7 +20,7 @@
 #
 
 TCID=vlan01
-TST_TOTAL=1
+TST_TOTAL=8
 
 virt_type="vlan"
 
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index 4cc9a05..670a241 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -24,7 +24,7 @@
 #              to communicate only within the same VLAN segment.
 
 TCID=vlan03
-TST_TOTAL=2
+TST_TOTAL=8
 
 virt_type="vlan"
 
@@ -51,19 +51,38 @@ if [ -z $ip_local -o -z $ip_remote ]; then
 fi
 
 tst_resm TINFO "networks with the same VLAN ID must work"
-
 res="TPASS"
 
-virt_setup "id 4094" "id 4094"
-virt_compare_netperf || res="TFAIL"
+p0="protocol 802.1Q"
+p1="protocol 802.1ad"
+lb0="loose_binding off"
+lb1="loose_binding on"
+rh0="reorder_hdr off"
+rh1="reorder_hdr on"
 
-tst_resm $res "done"
+opts="$p0 $lb0 $rh0,$p0 $lb1 $rh1,$p1 $lb0 $rh0,$p1 $lb1 $rh1"
 
-tst_resm TINFO "different VLAN ID shall not work together"
-res="TPASS"
-virt_setup "id 4093" "id 4094"
-virt_compare_netperf && res="TFAIL"
+for n in $(seq 1 4); do
+	params="$(echo $opts | cut -d',' -f$n)"
+
+	virt_add ltp_v0 id 0 $params > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TCONF "iproute or kernel doesn't support '$params'"
+		continue
+	fi
+	ROD_SILENT "ip li delete ltp_v0"
+
+	virt_setup "id 4094 $params" "id 4094 $params"
+	virt_compare_netperf || res="TFAIL"
+
+	tst_resm $res "done"
+
+	tst_resm TINFO "different VLAN ID shall not work together"
+	res="TPASS"
+	virt_setup "id 4093 $params" "id 4094 $params"
+	virt_compare_netperf && res="TFAIL"
 
-tst_resm $res "done"
+	tst_resm $res "done"
+done
 
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
