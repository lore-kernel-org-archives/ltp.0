Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WPShn-0006ug-46
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 08:15:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WPShk-00055S-Lp
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 08:15:31 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2H8F7tb003908
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Mar 2014 16:15:11 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 17 Mar 2014 16:13:31 +0800
Message-Id: <1395044011-31911-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1395044011-31911-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1395044011-31911-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 3/3] performance_counters: make performance_counters
	run default
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

Make performance_counter01 run default. This performance_counter01 case
is to use perf_event_open() to test hardware CPU events.

Do not let performance_counter02 run defalult. This test need to know
an upper bound on the number of hardware counters, which varies in
different platforms. So if knowing this value, user can execute:
./performance_counter02 -C (upper bound) to run this test.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/perfcounters    | 3 +--
 scenario_groups/default | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/perfcounters b/runtest/perfcounters
index 73cd1d2..65d18e1 100644
--- a/runtest/perfcounters
+++ b/runtest/perfcounters
@@ -1,5 +1,4 @@
 # Test some Basic Performance Counters
 
 performance_counter01 performance_counter01
-performance_counter02 performance_counter02
-
+#performance_counter02 performance_counter02
diff --git a/scenario_groups/default b/scenario_groups/default
index ff23c7c..ef597b5 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -26,3 +26,4 @@ commands
 hyperthreading
 kernel_misc
 modules
+perfcounters
-- 
1.8.2.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
