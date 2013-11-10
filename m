Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hong.gyu.kim@lge.com>) id 1VfKUf-0000a4-Rr
	for ltp-list@lists.sourceforge.net; Sun, 10 Nov 2013 02:11:17 +0000
Received: from lgemrelse1q.lge.com ([156.147.1.111])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VfKUd-0003Xk-PG
	for ltp-list@lists.sourceforge.net; Sun, 10 Nov 2013 02:11:17 +0000
From: Honggyu Kim <hong.gyu.kim@lge.com>
Date: Sun, 10 Nov 2013 11:11:29 +0900
Message-Id: <1384049489-11024-1-git-send-email-hong.gyu.kim@lge.com>
Subject: [LTP] [PATCH] ext4-new-features: fix to properly configure in ffsb
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

configure in ext4-new-features calls configure in ffsb without arguments.
It always configures for host machine environment even if we pass arguments 
to configure in ext4-new-features.

This patch passes all the arguments to configure in ffsb so that ffsb can 
also be cross-compiled for target machine as well.

Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>
---
 testcases/kernel/fs/ext4-new-features/configure |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/ext4-new-features/configure b/testcases/kernel/fs/ext4-new-features/configure
index 12849e5..15c4f0c 100755
--- a/testcases/kernel/fs/ext4-new-features/configure
+++ b/testcases/kernel/fs/ext4-new-features/configure
@@ -2,7 +2,7 @@
 
 echo "Run the ffsb's configure"
 cd ./ffsb-6.0-rc2
-./configure
+./configure $*
 cd ..
 
 EXT4_DEV=
-- 
1.7.9.5


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
