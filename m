Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1RLxcR-0002CH-Oj
	for ltp-list@lists.sourceforge.net; Thu, 03 Nov 2011 13:46:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RLxcN-0003SA-Kw
	for ltp-list@lists.sourceforge.net; Thu, 03 Nov 2011 13:46:11 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA3Dk12j022692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Nov 2011 09:46:01 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id pA3Dk0MS029748
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Nov 2011 09:46:00 -0400
Message-ID: <4EB29B17.7090607@redhat.com>
Date: Thu, 03 Nov 2011 14:45:59 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080401080803050607040009"
Subject: [LTP] [PATCH] memcg_function_test: do a warmup before actual test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080401080803050607040009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


This test relies on getting correct rss number out of memory.stat.
Very rarely it fails and finds bigger number than expected,
for example:
memcg_function_test    6  TFAIL  :  rss=8192/4096

My assumption is that extra page is faulted in as result of
need for another stack page.

Documentation describes it as:
"rss - # of bytes of anonymous and swap cache memory."

This includes also stack pages. I intentionally modified
memcg_process' sigusr handler to grab few extra stack pages,
to confirm, that these indeed contribute to this number.

This patch adds a 'warmup' before actual test. The point
is to exercise the whole code path, so that any page fault,
which is unrelated to actual test occurs before process is
moved to target cgroup.

What happens now is:
spawn process
[NEW] signal it with SIGUSR1 (alloc)
[NEW] signal it with SIGUSR1 (free)
move it to cgroup
signal it with SIGUSR1 (alloc)
check rss in memory.stat
signal it with SIGUSR1 (free)
optionally check rss in memory.stat

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  .../memcg/functional/memcg_function_test.sh        |   43 
++++++++++++++++++++
  1 files changed, 43 insertions(+), 0 deletions(-)



--------------080401080803050607040009
Content-Type: text/x-patch;
	name="0001-memcg_function_test-do-a-warmup-before-actual-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-memcg_function_test-do-a-warmup-before-actual-test.patc";
	filename*1="h"

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index 73c1fa1..f281256 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -93,6 +93,34 @@ check_mem_stat()
 	result $pass "rss=$rss/$1"
 }
 
+warmup()
+{
+	pid=$1
+
+	case $cur_id in
+	"11"|"12"|"13")
+		#no warmp here, these are expected to fail
+		;;
+	*)
+		echo "Warming up for test: $cur_id, pid: $pid"
+		/bin/kill -s SIGUSR1 $pid 2> /dev/null
+		sleep 1
+		/bin/kill -s SIGUSR1 $pid 2> /dev/null
+		sleep 1
+
+		kill -0 $pid
+		if [ $? -ne 0 ]; then
+			result $FAIL "cur_id=$cur_id"
+			return 1
+		else
+			echo "Process is still here after warm up: $pid"
+		fi
+		;;
+	esac
+	return 0
+}
+
+
 # Run test cases which checks memory.stat after make
 # some memory allocation
 #
@@ -102,8 +130,15 @@ check_mem_stat()
 # $4 - check after free ?
 test_mem_stat()
 {
+	echo "Running $TEST_PATH/memcg_process $1 -s $2"
 	$TEST_PATH/memcg_process $1 -s $2 &
 	sleep 1
+
+	warmup $!
+	if [ $? -ne 0 ]; then
+		return
+	fi
+
 	echo $! > tasks
 	/bin/kill -s SIGUSR1 $! 2> /dev/null
 	sleep 1
@@ -235,8 +270,15 @@ test_subgroup()
 	echo $1 > memory.limit_in_bytes
 	echo $2 > subgroup/memory.limit_in_bytes
 
+	echo "Running $TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE"
 	$TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE &
 	sleep 1
+
+	warmup $!
+	if [ $? -ne 0 ]; then
+		return
+	fi
+
 	echo $! > tasks
 	/bin/kill -s SIGUSR1 $! 2> /dev/null
 	sleep 1
@@ -520,6 +562,7 @@ fi
 
 cleanup()
 {
+	killall -9 memcg_process 2>/dev/null
 	if [ -e /dev/memcg ]; then
 		umount /dev/memcg 2>/dev/null
 		rmdir /dev/memcg 2>/dev/null


--------------080401080803050607040009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
--------------080401080803050607040009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080401080803050607040009--

