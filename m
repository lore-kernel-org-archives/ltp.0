Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13995C25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 10:45:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 767BD3D0987
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 12:45:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCBA43CFFBF
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 12:45:20 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CEF0510103A4
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 12:45:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C6071F7F1;
 Wed,  5 Jun 2024 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717584318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BTVAdH3S991fBZ+WoG6k+emkXIi2VnSJjsgRPO08S4Y=;
 b=fvlLlpKtZqlvlViorukgA8eaLIpfQj7raY/j6BIPNwzt+JJgqazrHENQ1YA0vrc9zcIzkp
 YcgyuBCArDdoPM8j9QdK1YBRpqoV4W1a4iVMx0r+hs344McUz2EwS7goo6LqADogY278ir
 AVRK2qNW4KSDOEBaCFs/b3YC1CUGYwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717584318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BTVAdH3S991fBZ+WoG6k+emkXIi2VnSJjsgRPO08S4Y=;
 b=COjIAFp84jjudXUSg/xZrQ4HdxKc4b5k6BaMNl83OZOsVjh1Bj5t9GbryC96c1rtXneDi4
 5UHgY/zHqYIk3nBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717584318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BTVAdH3S991fBZ+WoG6k+emkXIi2VnSJjsgRPO08S4Y=;
 b=fvlLlpKtZqlvlViorukgA8eaLIpfQj7raY/j6BIPNwzt+JJgqazrHENQ1YA0vrc9zcIzkp
 YcgyuBCArDdoPM8j9QdK1YBRpqoV4W1a4iVMx0r+hs344McUz2EwS7goo6LqADogY278ir
 AVRK2qNW4KSDOEBaCFs/b3YC1CUGYwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717584318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BTVAdH3S991fBZ+WoG6k+emkXIi2VnSJjsgRPO08S4Y=;
 b=COjIAFp84jjudXUSg/xZrQ4HdxKc4b5k6BaMNl83OZOsVjh1Bj5t9GbryC96c1rtXneDi4
 5UHgY/zHqYIk3nBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B14C13AA1;
 Wed,  5 Jun 2024 10:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1l2/Ab5BYGa8ZQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 05 Jun 2024 10:45:18 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Jun 2024 12:45:12 +0200
Message-ID: <20240605104512.18296-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] testcases: realtime: Get rid of autotools
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: John Stultz <jstultz@google.com>,
 Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The autotools checks are outdated and not needed anymore.

CC: John Stultz <jstultz@google.com>
CC: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

Changes in v2:

Removed realtime from mk/automake.mk as well.

CI run https://github.com/metan-ucw/ltp/actions/runs/9382597033

 include/mk/automake.mk                 |  5 --
 testcases/realtime/Makefile            | 64 +-------------------------
 testcases/realtime/configure.ac        | 42 -----------------
 testcases/realtime/include/librttest.h |  9 +---
 testcases/realtime/lib/libstats.c      |  6 ---
 testcases/realtime/m4/.gitignore       |  1 -
 testcases/realtime/m4/GNUmakefile      | 37 ---------------
 testcases/realtime/m4/Makefile.am      |  1 -
 testcases/realtime/m4/check.m4         | 14 ------
 9 files changed, 2 insertions(+), 177 deletions(-)
 delete mode 100644 testcases/realtime/configure.ac
 delete mode 100644 testcases/realtime/m4/.gitignore
 delete mode 100644 testcases/realtime/m4/GNUmakefile
 delete mode 100644 testcases/realtime/m4/Makefile.am
 delete mode 100644 testcases/realtime/m4/check.m4

diff --git a/include/mk/automake.mk b/include/mk/automake.mk
index 3ecdd3144..0fa059f11 100644
--- a/include/mk/automake.mk
+++ b/include/mk/automake.mk
@@ -27,15 +27,10 @@ AUTOHEADER	?= autoheader
 AUTOMAKE	?= automake
 
 AUTOCONFED_SUBDIRS	= \
-			testcases/realtime \
 			testcases/open_posix_testsuite
 
 # We want to run this every single time to ensure that all of the prereq files
 # are there.
-.PHONY: testcases/realtime/configure
-testcases/realtime/configure:
-	$(MAKE) -C $(@D) autotools
-
 .PHONY: testcases/open_posix_testsuite/configure
 testcases/open_posix_testsuite/configure:
 	$(MAKE) -C $(@D) autotools
diff --git a/testcases/realtime/Makefile b/testcases/realtime/Makefile
index 61663bfd9..b90ecf8c4 100644
--- a/testcases/realtime/Makefile
+++ b/testcases/realtime/Makefile
@@ -22,74 +22,12 @@
 
 top_srcdir		?= ../..
 
-# Override these variables to use non-system available tools.
-ACLOCAL			?= aclocal
-AUTOCONF		?= autoconf
-AUTOHEADER		?= autoheader
-AUTOMAKE		?= automake
-
 include $(top_srcdir)/include/mk/env_pre.mk
-# Ensure that this error / warning only applies for build targets.
-#
-# NOTE (garrcoop): this criterium should be in-sync with include/mk/env_pre.mk
-# (minus help as that's only invoked in the top-level Makefile).
-ifeq ($(filter autotools %clean .gitignore gitignore.%,$(MAKECMDGOALS)),)
-include $(abs_srcdir)/config.mk
-endif
 
 LIBDIR			:= lib
-FILTER_OUT_DIRS		:= $(LIBDIR) m4
+FILTER_OUT_DIRS		:= $(LIBDIR)
 LIB			:= $(LIBDIR)/librealtime.a
 
-# START autotools junk
-AUTOGENERATED_FILES	= \
-			m4/Makefile
-
-AUTOMAKE_FILES := config.guess config.sub install-sh missing stamp-h1
-
-.PHONY: autotools aclocal autoconf autoheader automake
-autotools: aclocal autoconf autoheader automake
-
-.PHONY: ac-clean ac-distclean ac-maintainer-clean
-ac-clean::
-	$(RM) -rf autom4te.cache
-	$(RM) -f aclocal.m4 config.log config.status
-	$(RM) -f include/realtime_config.h include/stamp-h1
-
-ac-distclean:: ac-clean
-ac-maintainer-clean:: ac-distclean
-	$(RM) -f aclocal.m4 configure $(AUTOMAKE_FILES) m4/Makefile.in
-	$(RM) -f include/realtime_config.h.in
-
-aclocal.m4:
-	$(ACLOCAL) -I $(abs_srcdir)/m4
-
-autoconf: configure
-
-include/realtime_config.h.in: configure.ac $(wildcard m4/*.m4) aclocal.m4
-	$(AUTOHEADER)
-
-configure: configure.ac aclocal.m4
-	$(AUTOCONF)
-automake: $(AUTOMAKE_FILES)
-$(AUTOMAKE_FILES): m4/Makefile.in
-m4/Makefile.in: m4/Makefile.am aclocal.m4
-	$(AUTOMAKE) -c -a
-
-.PHONY: autoheader
-autoheader: include/realtime_config.h.in
-	$(AUTOHEADER)
-
-distclean:: %: clean ac-distclean
-	$(RM) -f $(AUTOGENERATED_FILES)
-
-maintainer-clean:: distclean ac-maintainer-clean
-
-$(AUTOGENERATED_FILES): $(top_builddir)/config.status
-	$(SHELL) $^
-
-# END autotools junk
-
 $(LIBDIR):
 	mkdir -p "$@"
 
diff --git a/testcases/realtime/configure.ac b/testcases/realtime/configure.ac
deleted file mode 100644
index 6f50f1490..000000000
--- a/testcases/realtime/configure.ac
+++ /dev/null
@@ -1,42 +0,0 @@
-AC_PREREQ(2.61)
-AC_INIT([realtime],[realtime-20090930],[ltp-results@lists.sourceforge.net])
-AC_CONFIG_AUX_DIR([.])
-AM_INIT_AUTOMAKE
-AC_CONFIG_HEADERS([include/realtime_config.h])
-AC_CONFIG_FILES([   \
-	m4/Makefile \
-])
-AC_CHECK_HEADERS_ONCE([ \
-	pthread.h \
-])
-AC_CANONICAL_HOST
-
-AC_PROG_CC
-# <= autoconf 2.61 doesn't have AC_PROG_AR, but 2.63 has it. Not sure about
-# 2.62.
-AC_DEFUN([AC_PROG_AR], [AC_CHECK_TOOL(AR, ar, :)])
-AC_PROG_AR
-AC_PROG_RANLIB
-
-AC_MSG_CHECKING([for __sync_add_and_fetch gcc builtin function])
-AC_LINK_IFELSE([AC_LANG_SOURCE([
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-#include <stdlib.h>
-int main(void) {
-	char *c;
-	return __sync_add_and_fetch(c, 1);
-}])],[has___sync_add_and_fetch=yes])
-if test "x$has___sync_add_and_fetch" = xyes; then
-	AC_DEFINE(HAVE___SYNC_ADD_AND_FETCH,1,[Define to 1 if you have the __sync_add_and_fetch gcc builtin function])
-	AC_MSG_RESULT(yes)
-else
-	AC_MSG_RESULT(no)
-fi
-
-AC_CHECK_LIB([m], [exp10], [AC_DEFINE([HAVE_EXP10], 1, [Define to 1 if you have exp10 function])])
-
-REALTIME_CHECK_PRIO_INHERIT
-
-AC_OUTPUT
diff --git a/testcases/realtime/include/librttest.h b/testcases/realtime/include/librttest.h
index 8e3421869..8733479e7 100644
--- a/testcases/realtime/include/librttest.h
+++ b/testcases/realtime/include/librttest.h
@@ -56,7 +56,6 @@
 #include <time.h>
 #include <unistd.h>
 #include "list.h"
-#include "realtime_config.h"
 
 extern void setup(void);
 extern void cleanup(int i);
@@ -113,15 +112,9 @@ extern double pass_criteria;
  */
 static inline int atomic_add(int i, atomic_t *v)
 {
-	/* XXX (garrcoop): only available in later versions of gcc */
-#if HAVE___SYNC_ADD_AND_FETCH
 	return __sync_add_and_fetch(&v->counter, i);
-#else
-	printf("%s: %s\n", __func__, strerror(ENOSYS));
-	exit(1);
-	return -1;
-#endif
 }
+
 /* atomic_inc: atomically increment the integer passed by reference
  */
 static inline int atomic_inc(atomic_t *v)
diff --git a/testcases/realtime/lib/libstats.c b/testcases/realtime/lib/libstats.c
index f12d618f4..96090bd15 100644
--- a/testcases/realtime/lib/libstats.c
+++ b/testcases/realtime/lib/libstats.c
@@ -46,12 +46,6 @@
 #include <libstats.h>
 #include <librttest.h>
 
-#include "../include/realtime_config.h"
-
-#ifndef HAVE_EXP10
-# define exp10(x) (exp((x) * log(10)))
-#endif
-
 int save_stats = 0;
 
 /* static helper functions */
diff --git a/testcases/realtime/m4/.gitignore b/testcases/realtime/m4/.gitignore
deleted file mode 100644
index 5fc607b9e..000000000
--- a/testcases/realtime/m4/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/Makefile
diff --git a/testcases/realtime/m4/GNUmakefile b/testcases/realtime/m4/GNUmakefile
deleted file mode 100644
index 2a5b4c613..000000000
--- a/testcases/realtime/m4/GNUmakefile
+++ /dev/null
@@ -1,37 +0,0 @@
-#
-#    m4 Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-M4MACROS		:= $(notdir $(wildcard *.m4))
-
-INSTALL_DIR		:= $(datarootdir)/aclocal
-
-INSTALL_MODE		:= 00644
-
-INSTALL_TARGETS		:= $(M4_MACROS)
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/m4/Makefile.am b/testcases/realtime/m4/Makefile.am
deleted file mode 100644
index 87c304b42..000000000
--- a/testcases/realtime/m4/Makefile.am
+++ /dev/null
@@ -1 +0,0 @@
-# bogus makefile to appease automake
diff --git a/testcases/realtime/m4/check.m4 b/testcases/realtime/m4/check.m4
deleted file mode 100644
index d04a2cc73..000000000
--- a/testcases/realtime/m4/check.m4
+++ /dev/null
@@ -1,14 +0,0 @@
-AC_DEFUN([REALTIME_CHECK_PRIO_INHERIT],[
-AC_MSG_CHECKING([for PTHREAD_PRIO_INHERIT])
-AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
-#include <pthread.h>]], [[int main(void) {
-	pthread_mutexattr_t attr;
-	return pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
-}]])],[has_priority_inherit="yes"],[])
-if test "x$has_priority_inherit" = "xyes" ; then
-	AC_DEFINE(HAS_PRIORITY_INHERIT,1,[Define to 1 if you have PTHREAD_PRIO_INHERIT])
-	AC_MSG_RESULT(yes)
-else
-	AC_MSG_RESULT(no)
-fi
-])
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
