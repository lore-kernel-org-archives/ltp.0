Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YxPlj-000869-1a
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 01:04:27 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YxPle-0008JQ-Lu
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 01:04:27 +0000
Message-ID: <55651804.9050008@huawei.com>
Date: Wed, 27 May 2015 09:04:04 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
In-Reply-To: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
Subject: [LTP] [PATCH 5/5] iptables/iptables_tests.sh: Add new testcases for
 iptables -R
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

Add new testcase for testing 'iptables -R'

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/network/iptables/iptables_tests.sh |   40 +++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
index a2128c2..1f1d72c 100755
--- a/testcases/network/iptables/iptables_tests.sh
+++ b/testcases/network/iptables/iptables_tests.sh
@@ -22,7 +22,7 @@
 #				       <hubertNOSPAAAM@symbio.com.tw>

 export TCID="iptables"
-export TST_TOTAL=9
+export TST_TOTAL=10

 . test.sh

@@ -544,6 +544,43 @@ test09()
         tst_resm TPASS "iptables -N/E test succeed."
 }

+test10()
+{
+	tst_resm TINFO "iptables -R test."
+        iptables -A INPUT -s 127.0.0.1 -j DROP > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                tst_resm TFAIL "iptables command failed to append new rule."
+                cat tst_iptables.out
+                return
+        fi
+
+        tst_resm TINFO "Pinging 127.0.0.1"
+        ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+        if [ $? -eq 0 ]; then
+		tst_resm TFAIL "Ping 127.0.0.1 succeed,test failed"
+		cat tst_iptables.out
+                return
+        fi
+
+        tst_resm TINFO "Use iptable -R to reset the rule."
+        iptables -R INPUT 1 -s 127.0.0.1 -j ACCEPT > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                tst_resm TFAIL "iptables -R can't reset the rule."
+                cat tst_iptables.out
+                return
+        fi
+
+        tst_resm TINFO "Pinging 127.0.0.1 again"
+        ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                tst_resm TFAIL "Ping 127.0.0.1 failed"
+		cat tst_iptables.out
+                return
+        fi
+
+	tst_resm TPASS "iptables -R test succeed."
+}
+
 init
 TST_CLEANUP=cleanup

@@ -556,5 +593,6 @@ test06
 test07
 test08
 test09
+test10

 tst_exit
-- 
1.6.0.2 .


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
