Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vlee@twitter.com>) id 1U8cCI-0002IP-OQ
	for ltp-list@lists.sourceforge.net; Thu, 21 Feb 2013 19:52:50 +0000
Received: from mail-pb0-f41.google.com ([209.85.160.41])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1U8cCH-0005wI-Ui
	for ltp-list@lists.sourceforge.net; Thu, 21 Feb 2013 19:52:50 +0000
Received: by mail-pb0-f41.google.com with SMTP id um15so3654135pbc.0
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Feb 2013 11:52:44 -0800 (PST)
From: Vinson Lee <vlee@twitter.com>
Date: Thu, 21 Feb 2013 10:10:50 -0800
Message-Id: <1361470250-2489-1-git-send-email-vlee@twitter.com>
Subject: [LTP] [PATCH] syscalls/getrusage04: Link rt through LDLIBS instead
	of LDFLAGS.
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

Fixes this build error on Ubuntu introduced with commit
07f4e5432dd3e7a60bc0235f13200640c82d8f89.

testcases/kernel/syscalls/getrusage/getrusage04.c:186: undefined reference to `clock_getres'

Signed-off-by: Vinson Lee <vlee@twitter.com>
---
 testcases/kernel/syscalls/getrusage/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getrusage/Makefile b/testcases/kernel/syscalls/getrusage/Makefile
index 6851383..6702f27 100644
--- a/testcases/kernel/syscalls/getrusage/Makefile
+++ b/testcases/kernel/syscalls/getrusage/Makefile
@@ -20,6 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDFLAGS += -lrt
+LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.7.9.5


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
