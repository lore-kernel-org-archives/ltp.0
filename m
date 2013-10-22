Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VYXJI-0007wu-5x
	for ltp-list@lists.sourceforge.net; Tue, 22 Oct 2013 08:27:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VYXJG-00007v-S7
	for ltp-list@lists.sourceforge.net; Tue, 22 Oct 2013 08:27:28 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9M8REUE024251
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Oct 2013 16:27:14 +0800
Message-ID: <526636E4.6040504@cn.fujitsu.com>
Date: Tue, 22 Oct 2013 16:27:16 +0800
From: "Wang, Xiaoguang" <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] add some common errno values
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


Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 lib/tst_res.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index 245bd5f..f73022b 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -249,7 +249,12 @@ static const char *strerrnodef(int err)
 		    PAIR(EPIPE)
 		    PAIR(EDOM)
 		    PAIR(ERANGE)
+		    PAIR(EDEADLK)
 		    PAIR(ENAMETOOLONG)
+		    PAIR(ENOLCK)
+		    PAIR(ENOSYS)
+		    PAIR(ENOTEMPTY)
+		    PAIR(ELOOP)
 	};
 	return pair_lookup(errno_pairs, err);
 }
-- 
1.7.1

Regards,
Xiaoguang Wang


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
