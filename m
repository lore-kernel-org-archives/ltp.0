Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5a3-0008Br-ON
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:11 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5a2-0006xD-T8
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:11 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696j4ml020463
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t696j4Qd021536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:04 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696j4MU009502
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:04 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:48 +0300
Message-Id: <1436424468-11756-24-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 23/23] network/virt: don't skip when feature options
	not supported
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

Clear parameters variable and proceed, but only once.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/vlan03.sh  |   12 ++++++++----
 testcases/network/virt/vxlan03.sh |    6 +++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index a067065..5c49d41 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -63,18 +63,22 @@ rh1="reorder_hdr on"
 opts="$p0 $lb0 $rh0,$p0 $lb1 $rh1,$p1 $lb0 $rh0,$p1 $lb1 $rh1"
 
 for n in $(seq 1 4); do
-	params="$(echo $opts | cut -d',' -f$n)"
+	p="$(echo $opts | cut -d',' -f$n)"
 
-	virt_check_cmd virt_add ltp_v0 id 0 $params || continue
+	virt_check_cmd virt_add ltp_v0 id 0 $p
+	if [ $? -ne 0 ]; then
+		[ $n -gt 1 ] && continue
+		p=""
+	fi
 
-	virt_setup "id 4094 $params" "id 4094 $params"
+	virt_setup "id 4094 $p" "id 4094 $p"
 	virt_compare_netperf || res="TFAIL"
 
 	tst_resm $res "done"
 
 	tst_resm TINFO "different VLAN ID shall not work together"
 	res="TPASS"
-	virt_setup "id 4093 $params" "id 4094 $params"
+	virt_setup "id 4093 $p" "id 4094 $p"
 	virt_compare_netperf && res="TFAIL"
 
 	tst_resm $res "done"
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 613f4c2..b105afb 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -69,7 +69,11 @@ opts="dstport 0,dstport 0 gbp"
 for n in $(seq 1 2); do
 	p="$(echo $opts | cut -d',' -f$n)"
 
-	virt_check_cmd virt_add ltp_v0 id 0 $p || continue
+	virt_check_cmd virt_add ltp_v0 id 0 $p
+	if [ $? -ne 0 ]; then
+		[ $n -gt 1 ] && continue
+		p=""
+	fi
 
 	tst_resm TINFO "the same VNI must work"
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
