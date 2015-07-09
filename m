Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zn-0004Qn-Nf
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:55 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zm-00080p-Tu
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:55 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696imtm019908
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t696im54019051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:48 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696imYH005059
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:48 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:35 +0300
Message-Id: <1436424468-11756-11-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 10/23] network/virt/vlan01.sh: add protocol,
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/vlan01.sh |   33 ++++++++++++++++++++++++++++++---
 1 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
index 0e86668..c4d56e8 100755
--- a/testcases/network/virt/vlan01.sh
+++ b/testcases/network/virt/vlan01.sh
@@ -23,12 +23,39 @@ TCID=vlan01
 TST_TOTAL=1
 
 virt_type="vlan"
-start_id=0
-virt_count=4095
 
 . test_net.sh
 . virt_lib.sh
 
-virt_multiple_add_test
+p0="protocol 802.1Q"
+p1="protocol 802.1ad"
+lb0="loose_binding off"
+lb1="loose_binding on"
+rh0="reorder_hdr off"
+rh1="reorder_hdr on"
+
+opts="$p0 $lb0 $rh0,$p0 $lb0 $rh1,$p0 $lb1 $rh0,$p0 $lb1 $rh1,\
+$p1 $lb0 $rh0,$p1 $lb0 $rh1,$p1 $lb1 $rh0,$p1 $lb1 $rh1,"
+
+start_id=1
+virt_count=500
+
+for n in $(seq 1 8); do
+	params="$(echo $opts | cut -d',' -f$n)"
+
+	tst_resm TINFO "add $virt_type with '$params'"
+
+	virt_add ltp_v0 id 0 $params > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TCONF "iproute or kernel doesn't support '$params'"
+		params=""
+	else
+		ROD_SILENT "ip li delete ltp_v0"
+	fi
+
+	virt_multiple_add_test "$params"
+
+	start_id=$(($start_id + $virt_count))
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
