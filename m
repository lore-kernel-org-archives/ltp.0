Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YxPkz-0004tx-2q
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 01:03:41 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YxPkw-0006Rc-16
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 01:03:41 +0000
Message-ID: <556517D3.1030805@huawei.com>
Date: Wed, 27 May 2015 09:03:15 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
In-Reply-To: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
Subject: [LTP] [PATCH 4/5] iptables/iptables_tests.sh: Add new testcases for
 iptables -N/E
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

Add new testcase for testing 'iptables -N/E'

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/network/iptables/iptables_tests.sh |   46 +++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
index a464240..a2128c2 100755
--- a/testcases/network/iptables/iptables_tests.sh
+++ b/testcases/network/iptables/iptables_tests.sh
@@ -22,7 +22,7 @@
 #				       <hubertNOSPAAAM@symbio.com.tw>

 export TCID="iptables"
-export TST_TOTAL=8
+export TST_TOTAL=9

 . test.sh

@@ -501,6 +501,49 @@ test08()
         tst_resm TPASS "iptables can DROP packets from particular network card."
 }

+test09()
+{
+        tst_resm TINFO "iptables -N/E test."
+
+        iptables -N chains > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                tst_resm TFAIL "iptables command failed to append new chains."
+                cat tst_iptables.out
+                return
+        fi
+
+        iptables -L -v |grep chains > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                tst_resm TFAIL "iptables append new chains failed."
+                cat tst_iptables.err
+                return
+        fi
+
+	iptables -E chains newchains > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                tst_resm TFAIL "iptables command failed to change chains to" \
+			"newchains."
+                cat tst_iptables.out
+                return
+        fi
+
+	iptables -L -v |grep newchains > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                tst_resm TFAIL "iptables change chains failed."
+                cat tst_iptables.err
+                return
+        fi
+
+        iptables -X > tst_iptables.out 2>&1
+        if [ $? -ne 0 ]; then
+                tst_resm TFAIL "iptables did not remove the rule."
+                cat tst_iptables.out
+                return
+        fi
+
+        tst_resm TPASS "iptables -N/E test succeed."
+}
+
 init
 TST_CLEANUP=cleanup

@@ -512,5 +555,6 @@ test05
 test06
 test07
 test08
+test09

 tst_exit
-- 
1.6.0.2 .


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
