Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WMYr7-0005ac-0L
	for ltp-list@lists.sourceforge.net; Sun, 09 Mar 2014 08:13:09 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WMYqr-0004Kh-CV
	for ltp-list@lists.sourceforge.net; Sun, 09 Mar 2014 08:13:08 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s298CiI0012450
	for <ltp-list@lists.sourceforge.net>; Sun, 9 Mar 2014 16:12:44 +0800
Message-ID: <1394352758.2346.2.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Sun, 09 Mar 2014 16:12:38 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH 1/2] lapi: fcntl.h: Add O_NOATIME
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 include/lapi/fcntl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index fe8b2cc..089f22a 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -47,4 +47,8 @@
 # define AT_SYMLINK_NOFOLLOW 0x100
 #endif
 
+#ifndef O_NOATIME
+# define O_NOATIME 01000000
+#endif
+
 #endif /* __LAPI_FCNTL_H__ */
-- 
1.8.4.2




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
