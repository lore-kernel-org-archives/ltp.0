Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanpai.chen@gmail.com>) id 1QHY3Q-00027N-PD
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 09:07:32 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QHY3L-00070m-T3
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 09:07:32 +0000
Received: by pvc30 with SMTP id 30so581586pvc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 May 2011 02:07:22 -0700 (PDT)
From: Andrew Chen <yanpai.chen@gmail.com>
Date: Wed,  4 May 2011 17:07:03 +0800
Message-Id: <1304500023-2657-1-git-send-email-yanpai.chen@gmail.com>
Subject: [LTP] [PATCH] fix Makefiles for out of source tree build
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
Cc: andrew chen <ypchen@faraday-tech.com>

From: andrew chen <ypchen@faraday-tech.com>

For out of source tree build, realtime_config.h is created under the
top_builddir. Add it into the include path or you will get a missing
file issue.

Signed-off-by: Andrew Chen <ypchen@faraday-tech.com>
---
 ltp-full-20101031/testcases/realtime/config.mk    |    1 +
 ltp-full-20101031/testcases/realtime/lib/Makefile |    3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ltp-full-20101031/testcases/realtime/config.mk b/ltp-full-20101031/testcases/realtime/config.mk
index ddcf4f1..179a01f 100644
--- a/ltp-full-20101031/testcases/realtime/config.mk
+++ b/ltp-full-20101031/testcases/realtime/config.mk
@@ -31,6 +31,7 @@ realtime_builddir	:= $(abs_top_builddir)/$(realtime_reldir)
 realtime_srcdir		:= $(abs_top_srcdir)/$(realtime_reldir)
 
 CPPFLAGS		+= -I$(realtime_srcdir)/include
+CPPFLAGS		+= -I$(realtime_builddir)/include
 CFLAGS			+= -D_GNU_SOURCE
 LDLIBS			+= -lrealtime -lpthread -lrt -lm
 LDFLAGS			+= -L$(realtime_builddir)/lib
diff --git a/ltp-full-20101031/testcases/realtime/lib/Makefile b/ltp-full-20101031/testcases/realtime/lib/Makefile
index f6b9ad4..fbbb873 100644
--- a/ltp-full-20101031/testcases/realtime/lib/Makefile
+++ b/ltp-full-20101031/testcases/realtime/lib/Makefile
@@ -23,8 +23,7 @@
 top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
-
-CPPFLAGS		+= -I$(abs_srcdir)/../include
+include $(abs_srcdir)/../config.mk
 
 CFLAGS			+= -D_GNU_SOURCE
 
-- 
1.6.5


------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
