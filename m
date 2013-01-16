Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1TvZhR-0001zQ-KU
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 20:35:06 +0000
Received: from mail-bk0-f44.google.com ([209.85.214.44])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TvZhP-00081z-AK
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 20:35:03 +0000
Received: by mail-bk0-f44.google.com with SMTP id w11so953658bku.3
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Jan 2013 12:34:57 -0800 (PST)
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 16 Jan 2013 21:34:48 +0100
Message-Id: <1358368488-5082-1-git-send-email-sedat.dilek@gmail.com>
Subject: [LTP] [PATCH] realtime/lib: Fix includes in Makefile
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

On a freshly cloned ltp-git source-dir and with ltp-full-20130109, executing
'make distclean' fails with these errors:

testcases/realtime/lib/Makefile:25: ../../../../config.mk: No such file or directory
make[2]: *** No rule to make target `../../../../config.mk'.  Stop.

The patch fixes the issue by using env_pre.mk to include config.mk from
the correct location.

Tested with ltp-full-20130109 and ltp-git (20130109-5-g385d792).

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 testcases/realtime/lib/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/realtime/lib/Makefile b/testcases/realtime/lib/Makefile
index 8860549..fbbb873 100644
--- a/testcases/realtime/lib/Makefile
+++ b/testcases/realtime/lib/Makefile
@@ -22,7 +22,8 @@
 
 top_srcdir		?= ../../..
 
-include $(top_srcdir)/../config.mk
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../config.mk
 
 CFLAGS			+= -D_GNU_SOURCE
 
-- 
1.8.1.1


------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
