Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5ab-0003pk-Hh
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:45 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5aZ-0008J2-K1
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:45:45 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696jbpj021419
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t696jbVY021059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:37 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696ix9I005133
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:45:09 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:44 +0300
Message-Id: <1436424468-11756-20-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 19/23] network/virt: add test-case 02 to virt_lib.sh
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

Add new function virt_test_02() to the library and update
tests with it.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/ipvlan01.sh  |   19 ++++---------------
 testcases/network/virt/macvlan01.sh |   19 ++++---------------
 testcases/network/virt/macvtap01.sh |   19 ++++---------------
 testcases/network/virt/virt_lib.sh  |   28 ++++++++++++++++++++++++++++
 testcases/network/virt/vlan02.sh    |    4 ++--
 testcases/network/virt/vxlan02.sh   |    4 ++--
 6 files changed, 44 insertions(+), 49 deletions(-)

diff --git a/testcases/network/virt/ipvlan01.sh b/testcases/network/virt/ipvlan01.sh
index 706c1d8..156de78 100755
--- a/testcases/network/virt/ipvlan01.sh
+++ b/testcases/network/virt/ipvlan01.sh
@@ -16,8 +16,8 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
-# Test-case 1: Local test, check if we can create and then delete ipvlan
-#              interface 500 times.
+# Local test, check if we can create and then delete ipvlan
+# interface 1000 times.
 
 TCID=ipvlan01
 TST_TOTAL=2
@@ -27,19 +27,8 @@ virt_type="ipvlan"
 . test_net.sh
 . virt_lib.sh
 
-modes="l2 l3"
+options="mode l2,mode l3"
 
-start_id=1
-virt_count=500
-
-for m in $modes; do
-	tst_resm TINFO "add $virt_type with mode '$m'"
-
-	virt_check_cmd virt_add ltp_v0 mode $m || m=""
-
-	virt_add_delete_test "mode $m"
-
-	start_id=$(($start_id + $virt_count))
-done
+virt_test_02 "$options"
 
 tst_exit
diff --git a/testcases/network/virt/macvlan01.sh b/testcases/network/virt/macvlan01.sh
index 35febd0..402edde 100755
--- a/testcases/network/virt/macvlan01.sh
+++ b/testcases/network/virt/macvlan01.sh
@@ -16,8 +16,8 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
-# Test-case 1: Local test, check if we can create and then delete macvlan
-#              interface 500 times.
+# Local test, check if we can create and then delete macvlan
+# interface 2000 times.
 
 TCID=macvlan01
 TST_TOTAL=4
@@ -27,19 +27,8 @@ virt_type="macvlan"
 . test_net.sh
 . virt_lib.sh
 
-modes="private vepa bridge passthru"
+options="mode private,mode vepa,mode bridge,mode passthru"
 
-start_id=1
-virt_count=500
-
-for m in $modes; do
-	tst_resm TINFO "add $virt_type with mode '$m'"
-
-	virt_check_cmd virt_add ltp_v0 mode $m || m=""
-
-	virt_add_delete_test "mode $m"
-
-	start_id=$(($start_id + $virt_count))
-done
+virt_test_02 "$options"
 
 tst_exit
diff --git a/testcases/network/virt/macvtap01.sh b/testcases/network/virt/macvtap01.sh
index 8bb3636..3408c94 100755
--- a/testcases/network/virt/macvtap01.sh
+++ b/testcases/network/virt/macvtap01.sh
@@ -16,8 +16,8 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
-# Test-case 1: Local test, check if we can create and then delete macvtap
-#              interface 500 times.
+# Local test, check if we can create and then delete macvtap
+# interface 2000 times.
 
 TCID=macvtap01
 TST_TOTAL=4
@@ -27,19 +27,8 @@ virt_type="macvtap"
 . test_net.sh
 . virt_lib.sh
 
-modes="private vepa bridge passthru"
+options="mode private,mode vepa,mode bridge,mode passthru"
 
-start_id=1
-virt_count=500
-
-for m in $modes; do
-	tst_resm TINFO "add $virt_type with mode '$m'"
-
-	virt_check_cmd virt_add ltp_v0 mode $m || m=""
-
-	virt_add_delete_test "mode $m"
-
-	start_id=$(($start_id + $virt_count))
-done
+virt_test_02 "$options"
 
 tst_exit
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 2ccba43..d79f7bc 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -289,6 +289,34 @@ virt_test_01()
 	done
 }
 
+# Check if we can create then delete virtual interface n times.
+# virt_test_02 [OPTIONS]
+# OPTIONS - different options separated by comma.
+virt_test_02()
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
+		tst_resm TINFO "add and then delete $virt_type with '$p'"
+
+		virt_check_cmd virt_add ltp_v0 $p || p=""
+
+		virt_add_delete_test "$p"
+
+		start_id=$(($start_id + $virt_count))
+	done
+}
+
 tst_require_root
 
 case "$virt_type" in
diff --git a/testcases/network/virt/vlan02.sh b/testcases/network/virt/vlan02.sh
index 0fb35a3..60addba 100755
--- a/testcases/network/virt/vlan02.sh
+++ b/testcases/network/virt/vlan02.sh
@@ -16,8 +16,8 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
-# Test-case 1: Local test, check if we can create and then delete VLAN
-#              interface 4095 times.
+# Local test, check if we can create and then delete VLAN
+# interface 4095 times.
 #
 
 TCID=vlan02
diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
index 1470495..0b3a21c 100755
--- a/testcases/network/virt/vxlan02.sh
+++ b/testcases/network/virt/vxlan02.sh
@@ -16,8 +16,8 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
-# Test-case 1: Local test, check if we can create and then delete VXLAN
-#              interface 5000 times.
+# Local test, check if we can create and then delete VXLAN
+# interface 5000 times.
 #
 
 TCID=vxlan02
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
