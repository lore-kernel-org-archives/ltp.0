Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zl-00087f-Ky
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:53 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zj-0006uT-Nv
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:53 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696ijJ7020360
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t696ij6h020674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:45 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696ijEi009385
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:45 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:33 +0300
Message-Id: <1436424468-11756-9-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 08/23] network/virt: rename virt_max to virt_count
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

"virt_max" name could be misleading as it is not the max
value of interfaces but rather the number of interfaces.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |   16 ++++++++--------
 testcases/network/virt/vlan01.sh   |    2 +-
 testcases/network/virt/vlan02.sh   |    2 +-
 testcases/network/virt/vxlan01.sh  |    2 +-
 testcases/network/virt/vxlan02.sh  |    2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 6705868..77fa788 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -64,7 +64,7 @@ while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
 		exit 0
 	;;
 	s) TST_USE_SSH=1 ;;
-	x) virt_max=$OPTARG ;;
+	x) virt_count=$OPTARG ;;
 	i) start_id=$OPTARG ;;
 	c) clients_num=$OPTARG ;;
 	r) client_requests=$OPTARG ;;
@@ -135,13 +135,11 @@ virt_add_rhost()
 virt_multiple_add_test()
 {
 	local opt="$@"
-	local max=$(($start_id + $virt_max))
+	local max=$(($start_id + $virt_count - 1))
 
-	tst_resm TINFO "create $virt_max $virt_type"
+	tst_resm TINFO "add $virt_count $virt_type, then delete"
 
-	local vnis=$(seq $start_id $max)
-
-	for i in $vnis; do
+	for i in $(seq $start_id $max); do
 		ROD_SILENT "virt_add ltp_v$i id $i $opt"
 		ROD_SILENT "ip link set ltp_v$i up"
 	done
@@ -151,9 +149,11 @@ virt_multiple_add_test()
 virt_add_delete_test()
 {
 	local opt="$@"
-	tst_resm TINFO "create, delete $virt_type $virt_max times"
+	local max=$(($virt_count - 1))
+
+	tst_resm TINFO "add/del $virt_type $virt_count times"
 
-	for i in $(seq 0 $virt_max); do
+	for i in $(seq 0 $max); do
 		ROD_SILENT "virt_add ltp_v0 $opt"
 		ROD_SILENT "ip link set ltp_v0 up"
 		ROD_SILENT "ip link delete ltp_v0"
diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
index 9136fbb..0e86668 100755
--- a/testcases/network/virt/vlan01.sh
+++ b/testcases/network/virt/vlan01.sh
@@ -24,7 +24,7 @@ TST_TOTAL=1
 
 virt_type="vlan"
 start_id=0
-virt_max=4094
+virt_count=4095
 
 . test_net.sh
 . virt_lib.sh
diff --git a/testcases/network/virt/vlan02.sh b/testcases/network/virt/vlan02.sh
index a37bd73..0fb35a3 100755
--- a/testcases/network/virt/vlan02.sh
+++ b/testcases/network/virt/vlan02.sh
@@ -24,7 +24,7 @@ TCID=vlan02
 TST_TOTAL=1
 
 virt_type="vlan"
-virt_max="4094"
+virt_count=4095
 
 . test_net.sh
 . virt_lib.sh
diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
index 808726c..6673d7e 100755
--- a/testcases/network/virt/vxlan01.sh
+++ b/testcases/network/virt/vxlan01.sh
@@ -24,7 +24,7 @@ TST_TOTAL=1
 
 virt_type="vxlan"
 start_id=16700000
-virt_max=5000
+virt_count=5000
 
 . test_net.sh
 . virt_lib.sh
diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
index 284a469..1470495 100755
--- a/testcases/network/virt/vxlan02.sh
+++ b/testcases/network/virt/vxlan02.sh
@@ -25,7 +25,7 @@ TST_TOTAL=1
 
 virt_type="vxlan"
 start_id=16700000
-virt_max=5000
+virt_count=5000
 
 . test_net.sh
 . virt_lib.sh
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
