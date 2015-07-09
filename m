Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zu-0003hB-0M
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:02 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zt-000815-1o
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:01 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696itYk019978
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t696ishc020964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:55 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696isXQ005117
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:54 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:40 +0300
Message-Id: <1436424468-11756-16-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 15/23] network/virt/vxlan03.sh: add VXLAN-GBP (group
	policy context) test
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

If supported by kernel and iproute, VxLAN header will include the mark
with group policy context. The test performs with and without gbp option.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/vxlan03.sh |   41 ++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 033d801..14524d4 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -60,24 +60,37 @@ if [ -z $ip_local -o -z $ip_remote ]; then
 	tst_brkm TBROK "you must specify IP address"
 fi
 
-tst_resm TINFO "networks with the same VNI must work"
-# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
-res="TPASS"
+opts="dstport 0,dstport 0 gbp"
 
-if [ "$vxlan_dst_addr" != 'uni' -a $vxlan_dst_addr != 'multi' ]; then
-	tst_brkm TBROK "wrong destination address, can be 'uni' or 'multi'"
-fi
+for n in $(seq 1 2); do
+	params="$(echo $opts | cut -d',' -f$n)"
+
+	virt_add ltp_v0 id 0 $params > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TCONF "iproute or kernel doesn't support '$params'"
+		continue
+	fi
+	ROD_SILENT "ip li delete ltp_v0"
+
+	tst_resm TINFO "networks with the same VNI must work"
+	# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
+	res="TPASS"
+
+	if [ "$vxlan_dst_addr" != 'uni' -a $vxlan_dst_addr != 'multi' ]; then
+		tst_brkm TBROK "wrong dst address, can be 'uni' or 'multi'"
+	fi
 
-vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFE"
-vxlan_compare_netperf || res="TFAIL"
+	vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFE"
+	vxlan_compare_netperf || res="TFAIL"
 
-tst_resm $res "done"
+	tst_resm $res "done"
 
-tst_resm TINFO "different VNI shall not work together"
-res="TPASS"
-vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFD"
-vxlan_compare_netperf && res="TFAIL"
+	tst_resm TINFO "different VNI shall not work together"
+	res="TPASS"
+	vxlan_setup_subnet_$vxlan_dst_addr "0xFFFFFE" "0xFFFFFD"
+	vxlan_compare_netperf && res="TFAIL"
 
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
