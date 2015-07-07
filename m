Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZCTqa-00083D-1i
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 14:27:44 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZCTqY-0006TP-2M
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 14:27:44 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t67ERZed003603
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2015 14:27:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t67ERZw7023507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2015 14:27:35 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t67ERXgF015522
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2015 14:27:34 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  7 Jul 2015 17:30:42 +0300
Message-Id: <1436279443-32379-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [Committed 1/2] network/vxlan: change local safe_run to
	ROD_SILENT
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/vxlan/vxlan01.sh   |    8 ++++----
 testcases/network/vxlan/vxlan02.sh   |    6 +++---
 testcases/network/vxlan/vxlan_lib.sh |   28 ++++++++++------------------
 3 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/testcases/network/vxlan/vxlan01.sh b/testcases/network/vxlan/vxlan01.sh
index 0942573..574e9c0 100755
--- a/testcases/network/vxlan/vxlan01.sh
+++ b/testcases/network/vxlan/vxlan01.sh
@@ -33,13 +33,13 @@ opt="group 239.1.1.1"
 vnis=$(seq $start_vni $max)
 
 for i in $vnis; do
-	safe_run "ip link add ltp_vxl${i} type vxlan id $i $opt"
-	safe_run "ip link set ltp_vxl${i} up"
+	ROD_SILENT "ip link add ltp_vxl${i} type vxlan id $i $opt"
+	ROD_SILENT "ip link set ltp_vxl${i} up"
 done
 
 for i in $vnis; do
-	safe_run "ip link set ltp_vxl${i} down"
-	safe_run "ip link delete ltp_vxl${i}"
+	ROD_SILENT "ip link set ltp_vxl${i} down"
+	ROD_SILENT "ip link delete ltp_vxl${i}"
 done
 
 tst_resm TPASS "done"
diff --git a/testcases/network/vxlan/vxlan02.sh b/testcases/network/vxlan/vxlan02.sh
index 3f7e149..6220a0d 100755
--- a/testcases/network/vxlan/vxlan02.sh
+++ b/testcases/network/vxlan/vxlan02.sh
@@ -31,9 +31,9 @@ opt="group 239.1.1.1"
 tst_resm TINFO "create, delete ltp_vxl1 $vxlan_max times"
 
 for i in $(seq 0 $vxlan_max); do
-	safe_run "ip link add ltp_vxl1 type vxlan id $start_vni $opt"
-	safe_run "ip link set ltp_vxl1 up"
-	safe_run "ip link delete ltp_vxl1"
+	ROD_SILENT "ip link add ltp_vxl1 type vxlan id $start_vni $opt"
+	ROD_SILENT "ip link set ltp_vxl1 up"
+	ROD_SILENT "ip link delete ltp_vxl1"
 done
 tst_resm TPASS "done"
 
diff --git a/testcases/network/vxlan/vxlan_lib.sh b/testcases/network/vxlan/vxlan_lib.sh
index c374b43..d3091ac 100644
--- a/testcases/network/vxlan/vxlan_lib.sh
+++ b/testcases/network/vxlan/vxlan_lib.sh
@@ -107,14 +107,6 @@ cleanup_vxlans()
 TST_CLEANUP="cleanup_vxlans"
 trap "tst_brkm TBROK 'test interrupted'" INT
 
-safe_run()
-{
-	$@ > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		tst_brkm TBROK "cmd failed: $@"
-	fi
-}
-
 vxlan_setup_subnet_uni()
 {
 	tst_kvercmp 3 10 0 && \
@@ -127,10 +119,10 @@ vxlan_setup_subnet_uni()
 
 	tst_resm TINFO "setup VxLANv$ipver with unicast address: '$opt'"
 
-	safe_run "ip li add ltp_vxl0 type vxlan id $1 $opt"
-	safe_run "ip li set ltp_vxl0 address $mac_vxlan_local"
-	safe_run "ip addr add ${ip_vxlan_local}/24 dev ltp_vxl0"
-	safe_run "ip li set up ltp_vxl0"
+	ROD_SILENT "ip li add ltp_vxl0 type vxlan id $1 $opt"
+	ROD_SILENT "ip li set ltp_vxl0 address $mac_vxlan_local"
+	ROD_SILENT "ip addr add ${ip_vxlan_local}/24 dev ltp_vxl0"
+	ROD_SILENT "ip li set up ltp_vxl0"
 
 	opt="remote $(tst_ipaddr)"
 
@@ -156,10 +148,10 @@ vxlan_setup_subnet_multi()
 
 	tst_resm TINFO "setup VxLANv$ipver with multicast address: '$opt'"
 
-	safe_run "ip li add ltp_vxl0 type vxlan id $1 $opt dev $(tst_iface)"
-	safe_run "ip li set ltp_vxl0 address $mac_vxlan_local"
-	safe_run "ip addr add ${ip_vxlan_local}/24 dev ltp_vxl0"
-	safe_run "ip li set up ltp_vxl0"
+	ROD_SILENT "ip li add ltp_vxl0 type vxlan id $1 $opt dev $(tst_iface)"
+	ROD_SILENT "ip li set ltp_vxl0 address $mac_vxlan_local"
+	ROD_SILENT "ip addr add ${ip_vxlan_local}/24 dev ltp_vxl0"
+	ROD_SILENT "ip li set up ltp_vxl0"
 
 	tst_rhost_run -s -c "ip li add ltp_vxl0 type vxlan id $2 $opt \
 	                     dev $(tst_iface rhost)"
@@ -217,7 +209,7 @@ vxlan_compare_netperf()
 	netload_test $ip_vxlan_remote res_ipv4 || ret=1
 	netload_test ${ip6_vxlan_remote}%ltp_vxl0 res_ipv6 || ret=1
 
-	safe_run "ip link delete ltp_vxl0"
+	ROD_SILENT "ip link delete ltp_vxl0"
 	tst_rhost_run -s -c "ip link delete ltp_vxl0"
 	[ "$ret" -eq 1 ] && return 1
 	local vt="$(cat res_ipv4)"
@@ -258,4 +250,4 @@ ip link add ltp_vxl type vxlan id $start_vni > /dev/null 2>&1
 if [ $? -ne 0 ]; then
 	tst_brkm TCONF "iproute2 or kernel doesn't support vxlan"
 fi
-safe_run "ip link delete ltp_vxl"
+ROD_SILENT "ip link delete ltp_vxl"
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
