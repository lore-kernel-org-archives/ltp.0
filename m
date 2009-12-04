Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NGbGT-0002yW-7E
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 16:44:17 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NGbGM-0000Eq-BD
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 16:44:17 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 67B7813EDEA92
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Dec 2009 17:42:11 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1NGbER-0004iC-00
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 17:42:11 +0100
Date: Fri, 04 Dec 2009 17:31:55 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u4e90rzmcfnueu@debian>
Subject: [LTP] [PATCH] Fix overreaching clean targets in Makefiles that
 cleaned the readme files
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091204163155.8uDWjZ95XnsVd6b0u2S6VzrupUD6cXlrQl4kLv2ymzw@z>

Hello,

the makefiles in some of the float tests contain the glob "[dr]*" in their clean targets. Unfortunately, this deletes not only the generated reference files, but also the readme files shipped in those directories. This patch fixes it by changing CLEAN_TARGETS to more specific patterns (that capture all generated files in all float tests, however).

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/misc/math/float/iperb/Makefile |    3 ++-
 testcases/misc/math/float/trigo/Makefile |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/misc/math/float/iperb/Makefile b/testcases/misc/math/float/iperb/Makefile
index e7a6774..6b538d1 100644
--- a/testcases/misc/math/float/iperb/Makefile
+++ b/testcases/misc/math/float/iperb/Makefile
@@ -24,7 +24,8 @@ top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CLEAN_TARGETS		:= [dr]* *.ref*
+CLEAN_TARGETS		:= [rd]*sin [rd]sinh [rd]*cos [rd]cosh [rd]*tan [rd]*tan2		\
+[rd]tanh *.ref*
 
 LDLIBS			+= -lm
 
diff --git a/testcases/misc/math/float/trigo/Makefile b/testcases/misc/math/float/trigo/Makefile
index c7390ff..4abf9f9 100644
--- a/testcases/misc/math/float/trigo/Makefile
+++ b/testcases/misc/math/float/trigo/Makefile
@@ -24,7 +24,8 @@ top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CLEAN_TARGETS		:= [dr]*
+CLEAN_TARGETS		:= [rd]*sin [rd]sinh [rd]*cos [rd]cosh [rd]*tan [rd]*tan2		\
+[rd]tanh
 
 LDLIBS			+= -lm
 
-- 
1.6.4.3




------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
