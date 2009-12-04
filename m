Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NGboF-0002QY-Ow
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 17:19:11 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NGboA-0003ya-Fr
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 17:19:11 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 3EB961373C347
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Dec 2009 18:18:52 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314) id 1NGbnv-0007QT-00
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 18:18:51 +0100
Date: Fri, 04 Dec 2009 18:04:06 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u4fbpwhxcfnueu@debian>
Subject: [LTP] [PATCH] Support for parallel compilation
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
Message-ID: <20091204170406.XJsHkqVIBXkwi3irP5vYWFb2FGOPd3F9tNc_TEoD_hg@z>

Hello,

I tried to make ltp with the -j switch and found the following problems:

 - the autotools target fail because of missing dependency on aclocal.m4 (almost all autotools targets depend on it)

 - the shell loop in generic_trunk_target makes the "all" rules of the subdirectories run strictly sequentially

This patch fixes these issues by adding dependencies to the autotools targets (it also deletes some of the duplicated targets from the realtime Makefile), and by making one target for each subdirectory in generic_trunk_target.

Note that I really don't know if this works on an arbitrary make version.

Regards
    Jiri Palcek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 include/mk/automake.mk              |    4 ++--
 include/mk/generic_trunk_target.inc |   15 ++++++++++-----
 testcases/realtime/Makefile         |   16 ++++++----------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/mk/automake.mk b/include/mk/automake.mk
index 81d77c9..ba75f94 100644
--- a/include/mk/automake.mk
+++ b/include/mk/automake.mk
@@ -54,7 +54,7 @@ autoheader: include/config.h.in
 include:
 	mkdir -p "$@"
 
-include/config.h.in: configure.ac $(wildcard m4/*.m4) m4/ltp-version.m4
+include/config.h.in: configure.ac $(wildcard m4/*.m4) m4/ltp-version.m4 aclocal.m4
 	$(AUTOHEADER)
 	touch $@
 
@@ -65,7 +65,7 @@ m4/ltp-version.m4: ChangeLog
 AUTOMAKE_FILES := config.guess config.sub install-sh missing stamp-h1
 automake: aclocal $(AUTOMAKE_FILES)
 $(AUTOMAKE_FILES): m4/Makefile.in
-m4/Makefile.in: m4/Makefile.am
+m4/Makefile.in: m4/Makefile.am aclocal.m4
 	$(AUTOMAKE) -c -a
 
 .PHONY: ac-clean ac-distclean ac-maintainer-clean
diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
index 7ffb9e9..deaddcc 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -52,15 +52,23 @@ RECURSIVE_TARGETS		?= all install
 
 $(eval $(get_make_dirs))
 
-.PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS))
+.PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS)) $(foreach tgt,$(RECURSIVE_TARGETS),$(addprefix trunk-subdir-$(tgt)--,$(SUBDIRS)))
 
 $(SUBDIRS): %:
 	mkdir -m 00755 -p "$@"
 
+get_trunk_target = $(firstword $(subst --, ,$(patsubst trunk-subdir-%,%,$(1))))
+get_trunk_subdir = $(patsubst trunk-subdir-$(call get_trunk_target,$(1))--%,%,$(1))
+
+$(foreach tgt,$(RECURSIVE_TARGETS),$(addprefix trunk-subdir-$(tgt)--,$(SUBDIRS))): %:
+	mkdir -m 00755 -p "$(call get_trunk_subdir,$@)"
+	$(MAKE) -C $(call get_trunk_subdir,$@) -f "$(abs_srcdir)/$(call get_trunk_subdir,$@)/Makefile" $(call get_trunk_target,$@)
+
 $(MAKE_TARGETS): | $(MAKE_DEPS)
 
 trunk-all: $(MAKE_TARGETS)
 
+
 trunk-clean:: | $(SUBDIRS)
 	$(if $(strip $(CLEAN_TARGETS)),$(RM) -f $(CLEAN_TARGETS))
 
@@ -89,10 +97,7 @@ ifeq ($(strip $(SUBDIRS)),)
 	$(warning CURDIR is: $(CURDIR))
 	$(error SUBDIRS empty -- did you want generic_leaf_target instead?)
 else
-$(RECURSIVE_TARGETS): %: | $(SUBDIRS)
-	@set -e; for dir in $(SUBDIRS); do \
-	    $(MAKE) -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
-	done
+$(RECURSIVE_TARGETS): %: $(addprefix trunk-subdir-%--,$(SUBDIRS))
 endif
 
 # vim: syntax=make
diff --git a/testcases/realtime/Makefile b/testcases/realtime/Makefile
index 9527b55..3aff429 100644
--- a/testcases/realtime/Makefile
+++ b/testcases/realtime/Makefile
@@ -54,26 +54,22 @@ ac-distclean:: ac-clean
 ac-maintainer-clean:: ac-distclean
 	$(RM) -f aclocal.m4 configure $(AUTOMAKE_FILES) m4/Makefile.in
 
-aclocal:
-	$(ACLOCAL) -I $(abs_srcdir)/m4
-
-autoconf:
-	$(AUTOCONF)
+aclocal: aclocal.m4
 
-autoheader:
-	$(AUTOHEADER)
+aclocal.m4:
+	$(ACLOCAL) -I $(abs_srcdir)/m4
 
 autoconf: configure
 
-include/realtime_config.h.in: configure.in $(wildcard m4/*.m4)
+include/realtime_config.h.in: configure.in $(wildcard m4/*.m4)  aclocal.m4
 	$(AUTOHEADER)
 	touch $@
 
 configure: configure.in aclocal.m4
 	$(AUTOCONF)
-automake: aclocal $(AUTOMAKE_FILES)
+automake: $(AUTOMAKE_FILES)
 $(AUTOMAKE_FILES): m4/Makefile.in
-m4/Makefile.in: m4/Makefile.am
+m4/Makefile.in: m4/Makefile.am aclocal.m4
 	$(AUTOMAKE) -c -a
 
 .PHONY: autoheader
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
