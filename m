Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PhzHe-0004cD-UV
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 06:55:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PhzHc-0004pG-FK
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 06:55:14 +0000
Message-ID: <4D3FC51B.3080306@cn.fujitsu.com>
Date: Wed, 26 Jan 2011 14:54:19 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Fix Makefile of testcase/kernel/mem/ksm/
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
Cc: ltp-list@lists.sourceforge.net

There is not any directory at testcase/kernel/mem/ksm/,
so replace generic_trunk_target.mk by generic_leaf_target.mk

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 testcases/kernel/mem/ksm/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm/Makefile
index 81509bf..22190f1 100644
--- a/testcases/kernel/mem/ksm/Makefile
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -39,5 +39,5 @@ trunk-clean:: | lib-clean
 lib-clean:: $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
 
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
 include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.7.0.4




-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
