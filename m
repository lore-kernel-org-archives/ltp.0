Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WDVtN-0006nR-6K
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 09:14:05 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WDVtL-0003Hv-7L
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 09:14:05 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1C9Dq0U008978
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Feb 2014 17:13:53 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 12 Feb 2014 17:12:36 +0800
Message-Id: <1392196356-23259-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <52BC269D.9060009@cn.fujitsu.com>
References: <52BC269D.9060009@cn.fujitsu.com>
Subject: [LTP] [PATCH v2] controllers/memcg_lib.sh: reset root cgroup's
	memory.use_hierarchy to 0
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

In some linux distribution, such as RHEL7U0Beta, memory.use_hierarchy is
set to 1 by systemd default, which will cause some tests failed, such as
memcg_stat_test.sh, memcg_use_hierarchy_test.sh.

According to kernel Documentation/cgroups/memory.txt's description,
the default value should be 0, and some ltp tests are written based on
this assumption, so here we set the root cgroup's memory.use_hierarchy
to 0 before running the test and restore it when finishing the test.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 .../kernel/controllers/memcg/functional/memcg_lib.sh     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 16e30ec..db9691c 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -38,6 +38,7 @@ HUGEPAGESIZE=`grep Hugepagesize /proc/meminfo | awk '{ print $2 }'`
 HUGEPAGESIZE=$(( $HUGEPAGESIZE * 1024 ))
 PASS=0
 FAIL=1
+orig_memory_use_hierarchy="none"
 
 cur_id=0
 failed=0
@@ -396,6 +397,15 @@ test_move_charge()
 
 cleanup()
 {
+	if [ "$orig_memory_use_hierarchy" != "none" ];then
+		echo $orig_memory_use_hierarchy > \
+		     /dev/memcg/memory.use_hierarchy
+		if [ $? -ne 0 ];then
+			tst_resm TINFO "restore "\
+				 "/dev/memcg/memory.use_hierarchy failed"
+		fi
+	fi
+	orig_memory_use_hierarchy="none"
 	killall -9 memcg_process 2>/dev/null
 	if [ -e /dev/memcg ]; then
 		umount /dev/memcg 2>/dev/null
@@ -409,4 +419,10 @@ do_mount()
 
 	mkdir /dev/memcg 2> /dev/null
 	mount -t cgroup -omemory memcg /dev/memcg
+
+	orig_memory_use_hierarchy=$(cat /dev/memcg/memory.use_hierarchy)
+	echo 0 > /dev/memcg/memory.use_hierarchy
+	if [ $? -ne 0 ];then
+		tst_resm TINFO "set /dev/memcg/memory.use_hierarchy to 0 failed"
+	fi
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
