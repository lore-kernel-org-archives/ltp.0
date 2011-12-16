Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1RbTUf-0006y3-Nb
	for ltp-list@lists.sourceforge.net; Fri, 16 Dec 2011 08:50:17 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RbTUd-0007L8-8y
	for ltp-list@lists.sourceforge.net; Fri, 16 Dec 2011 08:50:17 +0000
Message-ID: <4EEB065C.4060805@cn.fujitsu.com>
Date: Fri, 16 Dec 2011 16:50:36 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] memcg_function:fix the wrong of test_proc_kill
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>


test_proc_kill() tests process will be killed due to exceed memory limit, but
when memcg_process exit due to mmap/munmap fails, the case still pass.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 .../memcg/functional/memcg_function_test.sh        |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index 1f07cb5..6cfe9a5 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -175,13 +175,23 @@ test_failcnt()
 test_proc_kill()
 {
 	echo $1 > memory.limit_in_bytes
-	$TEST_PATH/memcg_process $2 -s $3 &
+	($TEST_PATH/memcg_process $2 -s $3 2>/tmp/errlog) &
 	pid=$!
 	sleep 1
 	echo $pid > tasks
 
 	/bin/kill -s SIGUSR1 $pid 2> /dev/null
 	sleep 1
+
+	if [ -s /tmp/errlog ]; then
+		err_msg=`cat /tmp/errlog`
+		rm -f /tmp/errlog
+		result $FAIL "$err_msg"
+		return
+	fi
+
+	rm -f /tmp/errlog
+
 	ps -p $pid > /dev/null 2> /dev/null
 	if [ $? -ne 0 ]; then
 		result $PASS "process $pid is killed"
-- 
1.7.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Learn Windows Azure Live!  Tuesday, Dec 13, 2011
Microsoft is holding a special Learn Windows Azure training event for 
developers. It will provide a great way to learn Windows Azure and what it 
provides. You can attend the event by watching it streamed LIVE online.  
Learn more at http://p.sf.net/sfu/ms-windowsazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
