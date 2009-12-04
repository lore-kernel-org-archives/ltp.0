Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NGbJ4-0000M1-GS
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 16:46:58 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NGbJ0-0007bJ-HM
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 16:46:58 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 69244146A7F34
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Dec 2009 17:46:17 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1NGbIP-0005lK-00
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 17:46:17 +0100
Date: Fri, 04 Dec 2009 17:42:22 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u4e97mtdcfnueu@debian>
Subject: [LTP] [PATCH] Fix the objdump test's makefile (and reenable it)
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
Message-ID: <20091204164222.v4ECQ8H3OivKV0fy0lvsh3_Sykpf18a68d0Ljku_LWc@z>

Hello,

the objdump tests' Makefile is disabled in the current LTP. This patch reenables it, and makes it work (at least for me).

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/commands/ade/Makefile         |    3 ---
 testcases/commands/ade/objdump/Makefile |    6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/testcases/commands/ade/Makefile b/testcases/commands/ade/Makefile
index cf7a487..9f57629 100644
--- a/testcases/commands/ade/Makefile
+++ b/testcases/commands/ade/Makefile
@@ -24,7 +24,4 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-# XXX (garrcoop): objdump's Makefile needs fixing.
-FILTER_OUT_DIRS		:= objdump
-
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/ade/objdump/Makefile b/testcases/commands/ade/objdump/Makefile
index 862438c..ed3ad26 100644
--- a/testcases/commands/ade/objdump/Makefile
+++ b/testcases/commands/ade/objdump/Makefile
@@ -27,13 +27,13 @@ include $(top_srcdir)/include/mk/env_pre.mk
 test: CPPFLAGS += -O
 
 test_arch.obj: test.o
-	mv $< "$@"
+	cp $< "$@"
 
 test_D: test.o
-	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION) $@
+	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
 
 INSTALL_TARGETS		:= objdump01
- 
+
 MAKE_TARGETS		:= test test_arch.obj test_D
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
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
