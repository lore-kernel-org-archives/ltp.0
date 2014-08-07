Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1XFD6X-0001lG-EI
	for ltp-list@lists.sourceforge.net; Thu, 07 Aug 2014 02:06:57 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XFD6W-00054K-52
	for ltp-list@lists.sourceforge.net; Thu, 07 Aug 2014 02:06:57 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s7726lKV003161
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Aug 2014 10:06:47 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Thu, 7 Aug 2014 10:05:01 +0800
Message-ID: <1407377101-16898-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] perf_event_open: fix test case identifier
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

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/perf_event_open/perf_event_open01.c | 2 +-
 testcases/kernel/syscalls/perf_event_open/perf_event_open02.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
index 02a87cd..b12de5c 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
@@ -46,7 +46,7 @@
 #include "linux_syscall_numbers.h"
 #include "safe_macros.h"
 
-char *TCID = "performance_counter01";
+char *TCID = "perf_event_open01";
 int TST_TOTAL = 6;
 
 #if HAVE_PERF_EVENT_ATTR
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index e345ed4..fe94b6a 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -74,7 +74,7 @@ The -v flag makes it print out the values of each counter.
 #include "safe_macros.h"
 #include "linux_syscall_numbers.h"
 
-char *TCID = "performance_counter02";
+char *TCID = "perf_event_open02";
 int TST_TOTAL = 1;
 
 #if HAVE_PERF_EVENT_ATTR
-- 
1.9.3


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
