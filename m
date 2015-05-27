Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YxPjV-0006Ag-9Q
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 01:02:09 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YxPjS-0002FY-4Y
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 01:02:09 +0000
Message-ID: <5565177B.7080308@huawei.com>
Date: Wed, 27 May 2015 09:01:47 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
In-Reply-To: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
Subject: [LTP] [PATCH 2/5] iptables/iptables_tests.sh: Add new testcases for
 iptables -c
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

Add new testcase for testing 'iptables -c'

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/network/iptables/iptables_tests.sh |   43 +++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
index f8a7981..387cdfa 100755
--- a/testcases/network/iptables/iptables_tests.sh
+++ b/testcases/network/iptables/iptables_tests.sh
@@ -22,7 +22,7 @@
 #				       <hubertNOSPAAAM@symbio.com.tw>

 export TCID="iptables"
-export TST_TOTAL=6
+export TST_TOTAL=7

 . test.sh

@@ -410,6 +410,46 @@ test06()
 	tst_resm TPASS "iptables can log packets with limited rate."
 }

+test07()
+{
+	local logcnt=0
+	tst_resm TINFO "iptables -c test."
+
+	iptables -A INPUT -s 127.0.0.1 -j DROP -c 10 500 \
+		> tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables command failed to append new rule."
+		cat tst_iptables.out
+		return
+	fi
+
+	logcnt=`iptables -L -v |grep localhost |awk '{print $2}'` \
+		> tst_iptables.out 2>&1
+	if [ $logcnt -ne 500 ]; then
+		tst_resm TFAIL "iptables -c 10 500 failed."
+		cat tst_iptables.err
+		return
+	fi
+
+	logcnt=`iptables -L -v |grep localhost |awk '{print $1}'` \
+		> tst_iptables.out 2>&1
+		if [ $logcnt -ne 10 ]; then
+		tst_resm TFAIL "iptables -c 10 500 failed."
+		cat tst_iptables.err
+		return
+	fi
+
+	tst_resm TINFO "Deleting rule."
+	iptables -D INPUT 1 > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables did not remove the rule."
+		cat tst_iptables.out
+		return
+	fi
+
+	tst_resm TPASS "iptables -c test succeed."
+}
+
 init
 TST_CLEANUP=cleanup

@@ -419,5 +459,6 @@ test03
 test04
 test05
 test06
+test07

 tst_exit
-- 
1.6.0.2 .


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
