Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1ViRVQ-0004ab-25
	for ltp-list@lists.sourceforge.net; Mon, 18 Nov 2013 16:16:56 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ViRVO-0004oW-6K
	for ltp-list@lists.sourceforge.net; Mon, 18 Nov 2013 16:16:56 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rAIGGlN9024383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Nov 2013 11:16:48 -0500
Received: from robin.brq.redhat.com (ovpn-112-43.ams2.redhat.com
	[10.36.112.43])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id rAIGGkTp024476
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Nov 2013 11:16:47 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Mon, 18 Nov 2013 17:16:34 +0100
Message-Id: <1384791394-3905-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH] kernel/mem/lib: don't replace CFLAGS, append instead
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

This (once again) allows ie. -m32 build on amd64.

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/kernel/mem/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/lib/Makefile b/testcases/kernel/mem/lib/Makefile
index c6226f8..6bc5863 100644
--- a/testcases/kernel/mem/lib/Makefile
+++ b/testcases/kernel/mem/lib/Makefile
@@ -20,7 +20,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CFLAGS			:= -I../include
+CFLAGS			+= -I../include
 INTERNAL_LIB		:= libmem.a
 
 include $(top_srcdir)/testcases/kernel/include/lib.mk
-- 
1.8.3.1


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
