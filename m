Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xiaofeng_yan2006@126.com>) id 1ZCm23-0003yS-OV
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2015 09:52:47 +0000
Received: from m50-112.126.com ([123.125.50.112])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZCm20-0007a1-8T
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2015 09:52:47 +0000
From: Xiumiao Song <songxiumiao@inspur.com>
Date: Wed,  8 Jul 2015 17:52:24 +0800
Message-Id: <1436349144-9621-1-git-send-email-songxiumiao@inspur.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] memcg_functinon: testcase_30 function
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
Cc: Xiumiao Song <songxiumiao@inspur.com>, wunan@inspur.com

Testcase_30 function testing mem_cgroup_force_empty_write
function return -EBUSY,when there is a task in cgroup.
Namely when setting memory.force_empty,it will be failed.
However,kernel 3.16 and above do nothing,
whatever there is a task in cgroup or not.

Signed-off-by: Xiumiao Song <songxiumiao@inspur.com>
---
 .../kernel/controllers/memcg/functional/memcg_function_test.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index 2c2f32a..6a5c58d 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -234,11 +234,11 @@ testcase_30()
 	sleep 1
 
 	echo 1 > memory.force_empty 2> /dev/null
-	if [ $? -ne 0 ]; then
-		result $PASS "force memory failed as expected"
-	else
-		result $FAIL "force memory should fail"
-	fi
+ 	if [ $? -eq 0 ]; then
+                result $PASS "force memory succeeded"
+        else
+                result $FAIL "force memory failed"
+        fi	
 
 	kill -s INT $pid 2> /dev/null
 }
-- 
1.9.1



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
