Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VS2KO-0007LQ-0K
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:09:44 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VS2K8-00023S-7t
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:09:43 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri,  4 Oct 2013 14:09:00 +0400
Message-Id: <1380881342-13025-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 3/5] controllers/cpuset: fix for old grep
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
Cc: vasily.isaenko@oracle.com, miaox@cn.fujitsu.com

It seems that '\s' does not work with old version
of grep (2.6.3).

Therefore several testcases fail on some distributions
using this version. For example - RHEL5-based.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset_memory_spread_testset.sh                |    6 +++---
 .../cpuset_syscall_test/cpuset_syscall_testset.sh  |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index b8a434f..ae1bc09 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -61,7 +61,7 @@ set_memsinfo_val()
 	local nl='
 '
 	# clearing existent value (if present)
-	memsinfo=`echo "$memsinfo" | sed -r "/^\_$1\:\s/d"`
+	memsinfo=`echo "$memsinfo" | sed -r "/^\_$1\: /d"`
 
 	if [ -z "$memsinfo" ]; then
 		memsinfo="_$1: $2"
@@ -74,8 +74,8 @@ set_memsinfo_val()
 get_memsinfo_val()
 {
 	local value=
-	value=`echo "$memsinfo" | grep -e "^\_$1\:\s"`
-	value=`echo "$value" | sed -r "s/^.*\:\s(.*)$/\1/"`
+	value=`echo "$memsinfo" | grep -e "^\_$1\: "`
+	value=`echo "$value" | sed -r "s/^.*\: (.*)$/\1/"`
 	echo "$value"
 }
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index 95196b7..587e912 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -231,7 +231,7 @@ test10()
 			awk '{print $2}')
 	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
 
-	task_policy=$(cat $TEST_PROCNUMA | grep -e "\s\+stack\s\+anon" | \
+	task_policy=$(cat $TEST_PROCNUMA | grep -e "  *stack  *anon" | \
 			awk '{print $2}')
 
 	test "$allowed_list" = "$task_policy"
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
