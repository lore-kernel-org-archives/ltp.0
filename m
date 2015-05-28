Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lijinyue@huawei.com>) id 1Yxu4q-000787-4q
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 09:26:12 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Yxu4n-0005te-49
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 09:26:12 +0000
From: Li Jinyue <lijinyue@huawei.com>
Date: Thu, 28 May 2015 09:23:59 +0000
Message-ID: <1432805039-21401-1-git-send-email-lijinyue@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] controllers/memcg: memory.limit_in_bytes is round
	down on kernel >= 3.19.0
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
Cc: zhanyongming@huawei.com

Since commit 3e32cb2e0a12b6915056ff04601cf1bb9b44f967, case 22-24 in
memcg_function_test.sh will fail for unaligned PAGESIZE input.

We need update the test more smoothly.

Signed-off-by: Li Jinyue <lijinyue@huawei.com>
---
 .../memcg/functional/memcg_function_test.sh         | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index f555939..24439f7 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -158,17 +158,32 @@ testcase_21()
 # Case 22 - 24: Test limit_in_bytes will be aligned to PAGESIZE
 testcase_22()
 {
-	test_limit_in_bytes $((PAGESIZE-1)) $PAGESIZE 0
+	tst_kvercmp 3 19 0
+	if [ $? -eq 0 ]; then
+		test_limit_in_bytes $((PAGESIZE-1)) $PAGESIZE 0
+	else
+		test_limit_in_bytes $((PAGESIZE-1)) 0 0
+	fi
 }
 
 testcase_23()
 {
-	test_limit_in_bytes $((PAGESIZE+1)) $((PAGESIZE*2)) 0
+	tst_kvercmp 3 19 0
+	if [ $? -eq 0 ]; then
+		test_limit_in_bytes $((PAGESIZE+1)) $((PAGESIZE*2)) 0
+	else
+		test_limit_in_bytes $((PAGESIZE+1)) $((PAGESIZE)) 0
+	fi
 }
 
 testcase_24()
 {
-	test_limit_in_bytes 1 $PAGESIZE 0
+	tst_kvercmp 3 19 0
+	if [ $? -eq 0 ]; then
+		test_limit_in_bytes 1 $PAGESIZE 0
+	else
+		test_limit_in_bytes 1 0 0
+	fi
 }
 
 # Case 25 - 28: Test invaild memory.limit_in_bytes
-- 
1.8.2.2


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
