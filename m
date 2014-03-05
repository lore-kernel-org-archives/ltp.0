Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WL1ZY-0005ba-0K
	for ltp-list@lists.sourceforge.net; Wed, 05 Mar 2014 02:28:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WL1ZX-00046K-3f
	for ltp-list@lists.sourceforge.net; Wed, 05 Mar 2014 02:28:39 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s252SSu1012075
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Mar 2014 10:28:28 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 5 Mar 2014 10:26:49 +0800
Message-Id: <1393986411-29379-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2 1/3] fallocate/fallocate02.c: fix compilation error
	on RHEL5.10
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

Add #define _GNU_SOURCE in order to have LLONG_MAX defined on RHEL5.10.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fallocate/fallocate02.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index 6412050..fa63f3b 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -25,6 +25,8 @@
  *	EBADF, EINVAL and EFBIG.
  */
 
+#define _GNU_SOURCE
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <endian.h>
-- 
1.8.2.1


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
