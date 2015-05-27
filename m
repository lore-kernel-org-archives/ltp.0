Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YxPhC-0007ww-J6
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 00:59:46 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YxPh9-0008By-1a
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 00:59:46 +0000
From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 27 May 2015 00:59:20 +0000
Message-ID: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/5] iptables/iptables_tests.sh: Add test cases for
	iptables -L
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
Cc: zhuyanpeng@huawei.com, zhanyongming@huawei.com

Add cases in test01 for iptables -L -t raw/security

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/network/iptables/iptables_tests.sh |   34 ++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
index a3f90a3..f8a7981 100755
--- a/testcases/network/iptables/iptables_tests.sh
+++ b/testcases/network/iptables/iptables_tests.sh
@@ -120,6 +120,40 @@ test01()
 		fi
 	fi
 
+	local cmd="iptables -L -t raw"
+	tst_resm TINFO "$cmd will list all rules in table raw."
+	$cmd > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$cmd failed to list rules."
+		cat tst_iptables.out
+		return
+	else
+		chaincnt=$(grep -c Chain tst_iptables.out)
+		if [ $chaincnt -lt 2 ]; then
+			tst_resm TFAIL "$cmd failed to list rules."
+			cat tst_iptables.out
+		else
+			tst_resm TINFO "$cmd lists rules."
+		fi
+	fi
+
+	local cmd="iptables -L -t security"
+	tst_resm TINFO "$cmd will list all rules in table security."
+	$cmd > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$cmd failed to list rules."
+		cat tst_iptables.out
+		return
+	else
+		chaincnt=$(grep -c Chain tst_iptables.out)
+		if [ $chaincnt -lt 3 ]; then
+			tst_resm TFAIL "$cmd failed to list rules."
+			cat tst_iptables.out
+		else
+			tst_resm TINFO "$cmd lists rules."
+		fi
+	fi
+
 	tst_resm TPASS "iptables -L lists rules."
 }
 
-- 
1.6.0.2


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
