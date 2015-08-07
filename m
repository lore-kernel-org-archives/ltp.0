Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1ZNauU-0000hS-4E
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2015 06:13:42 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZNauP-0001te-Cm
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2015 06:13:42 +0000
From: Cui Bixuan <cuibixuan@huawei.com>
Date: Fri, 7 Aug 2015 06:13:03 +0000
Message-ID: <1438927983-154395-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] iptables/iptables_tests: Some cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

* Save the iptables before the testcase and restore it after the testcase
* Add lib function 'cmd_test' for test01
* Add remove_rule and remove_all_rules for test to flush the rules
* Delete the needless check(grep -c Chain and grep "100% packet loss")
  in test01 and test02

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/network/iptables/iptables_tests.sh |  160 +++++++++-----------------
 1 files changed, 53 insertions(+), 107 deletions(-)

diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
index a3f90a3..ae9c3d9 100755
--- a/testcases/network/iptables/iptables_tests.sh
+++ b/testcases/network/iptables/iptables_tests.sh
@@ -40,19 +40,16 @@ init()
 		fi
 	fi
 
-	tst_resm TINFO "INIT: Flushing all rules."
-	iptables -F -t filter > tst_iptables.out 2>&1
-	iptables -F -t nat > tst_iptables.out 2>&1
-	iptables -F -t mangle > tst_iptables.out 2>&1
+	tst_resm TINFO "INIT: Saving and Flushing all rules."
+	ROD_SILENT iptables-save > saved_iptables
+	ROD_SILENT iptables -F
 }
 
 cleanup()
 {
 	lsmod | grep "ip_tables" > tst_iptables.out 2>&1
 	if [ $? -eq 0 ]; then
-		iptables -F -t filter > tst_iptables.out 2>&1
-		iptables -F -t nat > tst_iptables.out 2>&1
-		iptables -F -t mangle > tst_iptables.out 2>&1
+		ROD_SILENT iptables-restore < saved_iptables
 		rmmod -v ipt_limit ipt_multiport ipt_LOG ipt_REJECT \
 			 iptable_mangle iptable_nat ip_conntrack \
 			 iptable_filter ip_tables nf_nat_ipv4 nf_nat \
@@ -63,63 +60,54 @@ cleanup()
 	tst_rmdir
 }
 
-test01()
+cmd_test()
 {
-	local chaincnt=0
-
-	local cmd="iptables -L -t filter"
+	cmd=$*
 	tst_resm TINFO "$cmd will list all rules in table filter."
 	$cmd > tst_iptables.out 2>&1
-	if [ $? -ne 0 ]; then
+	ret=$?
+	if [ $ret -ne 0 ]; then
 		tst_resm TFAIL "$cmd failed to list rules."
 		cat tst_iptables.out
-		return
-	else
-		chaincnt=$(grep -c Chain tst_iptables.out)
-		if [ $chaincnt -lt 3 ]; then
-			tst_resm TFAIL "$cmd failed to list rules."
-			cat tst_iptables.out
-			return
-		else
-			tst_resm TINFO "$cmd lists rules."
-		fi
 	fi
 
-	local cmd="iptables -L -t nat"
-	tst_resm TINFO "$cmd will list all rules in table nat."
-	$cmd > tst_iptables.out 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "$cmd failed to list rules."
+	return $ret
+}
+
+remove_rule()
+{
+	tst_resm TINFO "Deleting rule."
+	iptables -D INPUT 1 > tst_iptables.out 2>&1
+	ret=$?
+	if [ $ret -ne 0 ]; then
+		tst_resm TFAIL "iptables did not remove the rule."
 		cat tst_iptables.out
-		return
-	else
-		chaincnt=$(grep -c Chain tst_iptables.out)
-		if [ $chaincnt -lt 3 ]; then
-			tst_resm TFAIL "$cmd failed to list rules."
-			cat tst_iptables.out
-			return
-		else
-			tst_resm TINFO "$cmd lists rules."
-		fi
 	fi
 
-	local cmd="iptables -L -t mangle"
-	tst_resm TINFO "$cmd will list all rules in table mangle."
-	$cmd > tst_iptables.out 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "$cmd failed to list rules."
+	return $ret
+}
+
+remove_all_rules()
+{
+	tst_resm TINFO "Flushing all rules."
+	iptables -F > tst_iptables.out 2>&1
+	ret=$?
+	if [ $ret -ne 0 ]; then
+		tst_resm TFAIL "iptables did not flush all rules."
 		cat tst_iptables.out
-		return
-	else
-		chaincnt=$(grep -c Chain tst_iptables.out)
-		if [ $chaincnt -lt 5 ]; then
-			tst_resm TFAIL "$cmd failed to list rules."
-			cat tst_iptables.out
-		else
-			tst_resm TINFO "$cmd lists rules."
-		fi
 	fi
 
+	return $ret
+}
+
+test01()
+{
+	cmd_test iptables -L -t filter || return
+
+	cmd_test iptables -L -t nat || return
+
+	cmd_test iptables -L -t mangle || return
+
 	tst_resm TPASS "iptables -L lists rules."
 }
 
@@ -137,29 +125,15 @@ test02()
 
 	tst_resm TINFO "Pinging 127.0.0.1"
 	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
-	if [ $? -ne 0 ]; then
-		grep "100% packet loss" tst_iptables.out > tst_iptables.err 2>&1
-		if [ $? -ne 0 ]; then
-			tst_resm TFAIL \
-				 "iptables did not block packets from loopback"
-			cat tst_iptables.err
-			return
-		else
-			tst_resm TINFO "Ping 127.0.0.1 not successful."
-		fi
-	else
+	if [ $? -eq 0 ]; then
 		tst_resm TFAIL "iptables did not block icmp from 127.0.0.1"
 		cat tst_iptables.out
 		return
 	fi
+	tst_resm TINFO "ping failed, iptables blocked ICMP as expected"
+
+	remove_rule || return
 
-	tst_resm TINFO "Deleting icmp DROP from 127.0.0.1 rule."
-	iptables -D INPUT 1 > tst_iptables.out 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "iptables did not remove the rule."
-		cat tst_iptables.out
-		return
-	fi
 	tst_resm TINFO "Pinging 127.0.0.1 again"
 	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
 	if [ $? -ne 0 ]; then
@@ -188,28 +162,15 @@ test03()
 
 	tst_resm TINFO "Pinging 127.0.0.1"
 	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
-	if [ $? -ne 0 ]; then
-		grep "100% packet loss" tst_iptables.out > tst_iptables.err 2>&1
-		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "iptables did not block ping request."
-			cat tst_iptables.err
-			return
-		else
-			tst_resm TINFO "Ping 127.0.0.1 not successful."
-		fi
-	else
+	if [ $? -eq 0 ]; then
 		tst_resm TFAIL "iptables did not reject ping request."
 		cat tst_iptables.out
 		return
 	fi
+	tst_resm TINFO "ping failed, iptables reject ping request as expected"
+
+	remove_rule || return
 
-	tst_resm TINFO "Deleting icmp request REJECT rule."
-	iptables -D INPUT 1 > tst_iptables.out 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "iptables did not remove the rule."
-		cat tst_iptables.out
-		return
-	fi
 	tst_resm TINFO "Pinging 127.0.0.1 again"
 	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
 	if [ $? -ne 0 ]; then
@@ -259,13 +220,8 @@ test04()
 		return
 	fi
 
-	tst_resm TINFO "Deleting the rule to log."
-	iptables -D INPUT 1 > tst_iptables.out 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "iptables did not remove the rule."
-		cat tst_iptables.out
-		return
-	fi
+	remove_rule || return
+
 	tst_resm TINFO "iptables logging succsess"
 	tst_resm TPASS "iptables can log packets to particular port."
 }
@@ -317,13 +273,8 @@ test05()
 		fi
 	done
 
-	tst_resm TINFO "Flushing all rules."
-	iptables -F > tst_iptables.out 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "iptables did not flush all rules."
-		cat tst_iptables.out
-		return
-	fi
+	remove_all_rules || return
+
 	tst_resm TINFO "iptables logging succsess"
 	tst_resm TPASS "iptables can log packets to multiple ports."
 }
@@ -365,13 +316,8 @@ test06()
 		return
 	fi
 
-	tst_resm TINFO "Deleting the rule to log."
-	iptables -D INPUT 1 > tst_iptables.out 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "iptables did not remove the rule."
-		cat tst_iptables.out
-		return
-	fi
+	remove_rule || return
+
 	tst_resm TINFO "iptables limited logging succsess"
 	tst_resm TPASS "iptables can log packets with limited rate."
 }
-- 
1.6.0.2


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
