Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zs-0003gR-9W
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:00 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zr-0004Zs-FI
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:00 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696irS0020458
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t696irX4019229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:53 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696ircm009428
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:53 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:39 +0300
Message-Id: <1436424468-11756-15-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 14/23] network/virt/vxlan01.sh: add parameters
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

Add some parameters while adding VxLAN virtual interfaces such as:
l2miss, l3miss, norsc, nolearning, noproxy, ttl, tos, gbp.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/vxlan01.sh |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
index 6673d7e..63a52d0 100755
--- a/testcases/network/virt/vxlan01.sh
+++ b/testcases/network/virt/vxlan01.sh
@@ -24,11 +24,31 @@ TST_TOTAL=1
 
 virt_type="vxlan"
 start_id=16700000
-virt_count=5000
 
 . test_net.sh
 . virt_lib.sh
 
-virt_multiple_add_test "group 239.1.1.1"
+opts="l2miss l3miss,norsc nolearning noproxy,ttl 0x01 tos 0x01,ttl 0xff tos 0xff,gbp"
+
+start_id=1
+virt_count=1000
+
+for n in $(seq 1 5); do
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
