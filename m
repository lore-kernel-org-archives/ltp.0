Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PMtHf-0000Qz-Sc
	for ltp-list@lists.sourceforge.net; Mon, 29 Nov 2010 02:16:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PMtHd-0002PL-IH
	for ltp-list@lists.sourceforge.net; Mon, 29 Nov 2010 02:16:03 +0000
Message-ID: <4CF30B46.8060905@cn.fujitsu.com>
Date: Mon, 29 Nov 2010 10:09:10 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH]Do some cleanup after remove libevent
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

Do some cleanup after remove libevent.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 include/mk/automake.mk |    4 +---
 runtest/syscalls       |    2 --
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/include/mk/automake.mk b/include/mk/automake.mk
index 8f752ef..de21582 100644
--- a/include/mk/automake.mk
+++ b/include/mk/automake.mk
@@ -26,9 +26,7 @@ AUTOCONF	?= autoconf
 AUTOHEADER	?= autoheader
 AUTOMAKE	?= automake
 
-AUTOCONFED_SUBDIRS	= \
-			testcases/kernel/syscalls/libevent \
-			testcases/realtime
+AUTOCONFED_SUBDIRS	= testcases/realtime
 
 # We want to run this every single time to ensure that all of the prereq files
 # are there.
diff --git a/runtest/syscalls b/runtest/syscalls
index b2bf144..085763f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -465,8 +465,6 @@ lchown01_16 lchown01_16
 lchown02 prep_create_link; lchown02
 lchown02_16 prep_create_link; lchown02_16
 
-libevent01 export LTPROOT; $LTPROOT/testcases/bin/libevent/run_libevent.sh
-
 link01 symlink01 -T link01
 link02 link02
 link03 link03
-- 
1.7.0.4




-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
