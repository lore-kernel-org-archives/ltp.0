Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1WLU5o-0001QT-61
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 08:55:52 +0000
Received: from mail-pd0-f180.google.com ([209.85.192.180])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WLU5n-0006UT-BC
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 08:55:52 +0000
Received: by mail-pd0-f180.google.com with SMTP id v10so2271705pde.39
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Mar 2014 00:55:45 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Thu,  6 Mar 2014 16:55:35 +0800
Message-Id: <1394096135-22510-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCH] containers/netns: fix header file path for
	check_netns_enabled.c
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

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/kernel/containers/netns/check_netns_enabled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/netns/check_netns_enabled.c b/testcases/kernel/containers/netns/check_netns_enabled.c
index ab8ee2f..7bb2324 100644
--- a/testcases/kernel/containers/netns/check_netns_enabled.c
+++ b/testcases/kernel/containers/netns/check_netns_enabled.c
@@ -20,7 +20,7 @@
 * when trying to use CLONE_NEWNET and CLONE_NEWNS.
 ***************************************************************************/
 #include <stdio.h>
-#include <sched.h>
+#include <linux/sched.h>
 #include "config.h"
 #include "libclone.h"
 #include "linux_syscall_numbers.h"
-- 
1.8.1.4


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
