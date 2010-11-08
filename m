Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PFMFS-0007XP-6v
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 07:34:38 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFMFQ-0003CX-4P
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 07:34:38 +0000
Message-ID: <4CD7A81E.1020603@cn.fujitsu.com>
Date: Mon, 08 Nov 2010 15:34:54 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [RFC][PATCH]Skip DOTS category always
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

After applied commit 43b57dbb4b959203bda5743ee7ff36c627e0911c, some error are caught
when install test suite.

make[2]: Entering directory `/home/biannm/ltp-882ad81/testcases/DOTS'
make[2]: *** No rule to make target `install'.  Stop.
make[2]: Leaving directory `/home/biannm/ltp-882ad81/testcases/DOTS'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/biannm/ltp-882ad81/testcases'
make: *** [testcases-install] Error 2

The commit 43b57dbb4b959203bda5743ee7ff36c627e0911c looks to fix some configure error
reported by mitani-san. But at the older LTP, Dots is be filtered out always, why we
add a checking, it looks unnecessary.

------
Dots need be skip always.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 testcases/Makefile |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/testcases/Makefile b/testcases/Makefile
index b30d6d4..4792811 100644
--- a/testcases/Makefile
+++ b/testcases/Makefile
@@ -31,7 +31,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
 #    run).
 # 3. mce-test doesn't fit cleanly in the build, yet.
 # 4. pounder21 is just broken.
-FILTER_OUT_DIRS		:= ballista kdump mce-test open% pounder21
+FILTER_OUT_DIRS		:= DOTS ballista kdump mce-test open% pounder21
 
 # XXX (garrcoop): Not sure why realtime is still in this list; this was the
 # original list of disabled items...
@@ -41,11 +41,6 @@ ifeq ($(UCLINUX),1)
 FILTER_OUT_DIRS		+= realtime
 endif
 
-# DOTS requires javac
-ifeq ($(strip $(JAVAC)),)
-FILTER_OUT_DIRS		+= DOTS
-endif
-
 #
 # XXX (garrcoop): disabling the open_posix_testsuite by request from Subrata
 # due to build times (open_posix_testsuite runs serially by design to
-- 
1.7.0.4




-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
