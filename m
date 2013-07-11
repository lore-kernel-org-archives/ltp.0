Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UxCX1-0000gl-M9
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 08:47:19 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UxCX0-00052v-6M
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 08:47:19 +0000
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Date: Thu, 11 Jul 2013 16:47:12 +0800
Message-Id: <1373532432-26471-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: [LTP] [PATCH] kmsg01: fix test failure caused by not compiling it
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
To: LTP <ltp-list@lists.sourceforge.net>

We didn't compile and install this case, so this case will
fail by "No such file":

initiation_status="pan(26250): execvp of 'kmsg01' (tag kmsg01) failed.  errno:2  No such file or directory"

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 testcases/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 4b4800d..8b00be9 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -42,6 +42,7 @@ SUBDIRS			+= connectors \
 			   hotplug \
 			   io \
 			   ipc \
+			   logging \
 			   mem \
 			   numa \
 			   performance_counters \
-- 
1.8.3.2.634.g7a3187e


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
