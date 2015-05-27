Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YxPkF-00081e-LI
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 01:02:55 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YxPkE-0004ng-79
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 01:02:55 +0000
Message-ID: <556517AC.7060406@huawei.com>
Date: Wed, 27 May 2015 09:02:36 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
In-Reply-To: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
Subject: [LTP] [PATCH 3/5] iptables/iptables_tests.sh: Add new testcases for
 iptables -o
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net, zhanyongming@huawei.com, zhuyanpeng@huawei.com

Add new testcase for testing 'iptables -o'

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/network/iptables/iptables_tests.sh |   54 +++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
index 387cdfa..a464240 100755
--- a/testcases/network/iptables/iptables_tests.sh
+++ b/testcases/network/iptables/iptables_tests.sh
@@ -22,7 +22,7 @@
 #				       <hubertNOSPAAAM@symbio.com.tw>

 export TCID="iptables"
-export TST_TOTAL=7
+export TST_TOTAL=8

 . test.sh

@@ -450,6 +450,57 @@ test07()
 	tst_resm TPASS "iptables -c test succeed."
 }

+test08()
+{
+	tst_resm TINFO "Use iptables to DROP packets from particular" \
+		"network card"
+	tst_resm TINFO "Rule to block icmp from 127.0.0.1"
+
+	iptables -A OUTPUT -o lo -p icmp -j DROP > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                tst_resm TFAIL "iptables command failed to append new rule."
+                cat tst_iptables.out
+                return
+        fi
+
+        tst_resm TINFO "Pinging 127.0.0.1"
+        ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                grep "100% packet loss" tst_iptables.out > tst_iptables.err 2>&1
+                if [ $? -ne 0 ]; then
+                        tst_resm TFAIL \
+                                 "iptables did not block packets from loopback"
+                        cat tst_iptables.err
+                        return
+                else
+                        tst_resm TINFO "Ping 127.0.0.1 not successful."
+                fi
+        else
+                tst_resm TFAIL "iptables did not block icmp from 127.0.0.1"
+                cat tst_iptables.out
+                return
+        fi
+
+        tst_resm TINFO "Deleting icmp DROP from lo rule."
+        iptables -D OUTPUT 1 > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                tst_resm TFAIL "iptables did not remove the rule."
+                cat tst_iptables.out
+                return
+        fi
+        tst_resm TINFO "Pinging 127.0.0.1 again"
+        ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                tst_resm TFAIL "iptables blocking loopback. This is expected" \
+                               "behaviour on certain distributions where" \
+                               "enabling firewall drops all packets by default."
+                cat tst_iptables.out
+                return
+        fi
+        tst_resm TINFO "Ping succsess"
+        tst_resm TPASS "iptables can DROP packets from particular network card."
+}
+
 init
 TST_CLEANUP=cleanup

@@ -460,5 +511,6 @@ test04
 test05
 test06
 test07
+test08

 tst_exit
-- 
1.6.0.2 .


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
