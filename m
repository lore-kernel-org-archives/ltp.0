Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo-fnst@cn.fujitsu.com>) id 1MsA4K-00078v-UW
	for ltp-list@lists.sourceforge.net; Mon, 28 Sep 2009 06:50:44 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MsA4F-0003w4-BT
	for ltp-list@lists.sourceforge.net; Mon, 28 Sep 2009 06:50:44 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 33B5517008D
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 Sep 2009 14:50:26 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id n8S6o3Qv019750
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Sep 2009 14:50:03 +0800
Received: from localhost.localdomain (unknown [10.167.141.170])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 33496D429C
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 Sep 2009 14:53:10 +0800 (CST)
Message-ID: <4AC05C9E.1040201@cn.fujitsu.com>
Date: Mon, 28 Sep 2009 14:50:06 +0800
From: liubo <liubo-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] memcg : fix various test failures
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

In memcg testcases,

1. use /dev/memcg consistently

2. for testcase_25, since 2.6.31, writing -1 to 
   memory.limit_in_bytes will reset to unlimit.

3. for testcase 35, writing to memory.force_empty for 
   non-empty cgroup should return failure.

Signed-off-by: Liu Bo <liubo-fnst@cn.fujitsu.com>

---
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index e48c8dd..e22954f 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -398,8 +398,12 @@ testcase_24()
 testcase_25()
 {
 	echo -1 > memory.limit_in_bytes 2> /dev/null
-#	result $(( !($? != 0) ))  "return value is $?"  //lizf
-	result $(( !($? == 0) ))  "return value is $?"
+	tst_kvercmp 2 6 31
+	if [ $? -eq 0 ]; then
+		result $(( !($? != 0) ))  "return value is $?"
+       else
+		result $(( !($? == 0) ))  "return value is $?"
+	fi
 }
 
 testcase_26()
@@ -488,8 +492,8 @@ testcase_35()
 {
 	# writing to non-empty top mem cgroup's force_empty
 	# should return failure
-	echo 1 > /memcg/memory.force_empty 2> /dev/null
-	result $(( $? )) "return value is $?"
+	echo 1 > /dev/memcg/memory.force_empty 2> /dev/null
+	result $(( !$? )) "return value is $?"
 }
 
 # Case 36 - 38: Test that group and subgroup have no relationship
diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 1e17525..86b8cb9 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -68,11 +68,11 @@ run_stress()
 
 	for ((i = 0; i < $1; i++))
 	{
-		mkdir /memcg/$i 2> /dev/null
+		mkdir /dev/memcg/$i 2> /dev/null
 		./memcg_process_stress $2 $3 &
 		pid[$i]=$!
 
-		echo ${pid[$i]} > /memcg/$i/tasks
+		echo ${pid[$i]} > /dev/memcg/$i/tasks
 	}
 
 	for ((i = 0; i < $1; i++))
@@ -87,7 +87,7 @@ run_stress()
 		/bin/kill -s SIGINT ${pid[$i]} 2> /dev/null
 		wait ${pid[$i]}
 
-		rmdir /memcg/$i 2> /dev/null
+		rmdir /dev/memcg/$i 2> /dev/null
 	}
 
 	cleanup;

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
