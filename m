Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4B5C98302
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 05:41:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBFE23E69B1
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 07:41:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D4D53E52A5
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 07:41:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C0E7A200DA8
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 07:41:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9D4B21D76;
 Wed, 23 Sep 2026 05:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790142086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NHY1pKnaa2OZ9RhTqhonfFtrnk6/k9zCBiNkQGN95Eo=;
 b=q4Qm5+KpmHV46okKb3huU0OWxAeQM5XIifr5V+mkxV7DECVF7WH+mY1cbO1NqbdEwF7N3k
 mdveS/hkN/+55bW65vmSka9+sTIYmUwBziQ46/PVOu3MD2KoQcH0SSRakYXeI9J/2pK6Ta
 Jx2mDmdqZRKix0H7Ruqfxy7Fj4rSw4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790142086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NHY1pKnaa2OZ9RhTqhonfFtrnk6/k9zCBiNkQGN95Eo=;
 b=hUq7HJUCpZ0mwn2bZPWPITlr4j8xoQUbyQHNHugGZ6zi6QldlbjgL9TK/VpbI2r/fIB3pg
 b2lVh8eYMXP4PpBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2p1LdPXt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FnpYEstD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790142081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NHY1pKnaa2OZ9RhTqhonfFtrnk6/k9zCBiNkQGN95Eo=;
 b=2p1LdPXtjHWTgX6bYiOe4tPJDXDu7M1uZ3jB1R9829Krq57qA+BPshjosXVHBRB8eSloYF
 7QRfizbFs3Oqb6LQ1GpBz9KkZA0TnklzKEB2oJqNKy5WD2lLtemzs/jSjU3r2Kb4Nlnkdj
 voU2HmSlzt1ZyD5WS/eSh7Gp3gNbhEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790142081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NHY1pKnaa2OZ9RhTqhonfFtrnk6/k9zCBiNkQGN95Eo=;
 b=FnpYEstDy7mdntUKHGeqYepkYB6H3gH/dwGl+qMCKAVqhZyrF1n4vXqHgR8ux+Ia3h7JU1
 +CIHDQikpRoenRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7767134E8;
 Wed, 23 Sep 2026 05:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ADXkHoFms2o2cgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 23 Sep 2026 05:41:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 23 Sep 2026 07:41:14 +0200
Message-ID: <20260923054114.105891-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E9D4B21D76
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid,fujitsu.com:email,configure.ac:url];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] Stop using libkeyutils
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Using directly <linux/keyctl.h> is enough. Move the rest of struct
checks in to configure.ac (together with other struct checks).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
This is probably too much as a pre-release fix, it should probably wait
after the release.

Changes v1->v2:
* Remove printing "keyutils: ${have_keyutils:-yes}" in configure.ac (agent)
* Remove <keyutils.h> in configure.ac (agent)
* Remove Follow-up: of first commit (I'll add it before merge when we
  have correct hash) (agent)
* Reword commit subject

Link to v1:
https://patchwork.kernel.org/project/ltp/patch/20260922160911.2271754-5-pvorel@suse.cz/
https://lore.kernel.org/ltp/20260922160911.2271754-5-pvorel@suse.cz/


 configure.ac                                   |  7 ++++---
 include/mk/config.mk.in                        |  1 -
 m4/ltp-keyutils.m4                             | 15 ---------------
 testcases/cve/Makefile                         |  2 --
 testcases/kernel/syscalls/add_key/Makefile     |  2 --
 testcases/kernel/syscalls/keyctl/Makefile      |  1 -
 testcases/kernel/syscalls/landlock/Makefile    |  2 --
 testcases/kernel/syscalls/request_key/Makefile |  2 --
 testcases/kernel/watchqueue/Makefile           |  2 --
 9 files changed, 4 insertions(+), 30 deletions(-)
 delete mode 100644 m4/ltp-keyutils.m4

diff --git a/configure.ac b/configure.ac
index 18bfdb88c7..e979de0e78 100644
--- a/configure.ac
+++ b/configure.ac
@@ -56,7 +56,6 @@ AC_CHECK_HEADERS_ONCE([ \
     cpuid.h \
     emmintrin.h \
     ifaddrs.h \
-    keyutils.h \
     linux/blkdev.h \
     linux/can.h \
     linux/cgroupstats.h \
@@ -300,6 +299,10 @@ AC_CHECK_TYPES([struct uffdio_move],,,[#include <linux/userfaultfd.h>])
 AC_CHECK_TYPES([struct uffdio_poison],,,[#include <linux/userfaultfd.h>])
 AC_CHECK_TYPES([struct uffdio_writeprotect],,,[#include <linux/userfaultfd.h>])
 
+AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
+	struct keyctl_pkey_query, struct keyctl_pkey_params],,,
+	[#include <linux/keyctl.h>])
+
 # Tools knobs
 
 # Bash
@@ -422,7 +425,6 @@ LTP_CHECK_CLEAR_CACHE
 LTP_CHECK_CRYPTO
 LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_KERNEL_DEVEL
-LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_LIBMNL
 LTP_CHECK_SELINUX
 LTP_CHECK_SYNC_ADD_AND_FETCH
@@ -478,7 +480,6 @@ open posix testsuite: ${with_open_posix_testsuite:-no}
 TI-RPC testsuite: ${with_tirpc:-yes}
 
 LIBRARIES
-keyutils: ${have_keyutils:-yes}
 libacl: ${have_libacl:-no}
 libaio: ${have_libaio:-no} (aio: ${have_aio:-no})
 libcap: $cap_libs (newer: ${has_newer_libcap:-no})
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 4c3da304fc..d796306e3a 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -38,7 +38,6 @@ SELINUX_LIBS		:= @SELINUX_LIBS@
 HAVE_RPC		:= @HAVE_RPC@
 LIBTIRPC_CFLAGS		:= @LIBTIRPC_CFLAGS@
 LIBTIRPC_LIBS		:= @LIBTIRPC_LIBS@
-KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
 HAVE_FTS_H		:= @HAVE_FTS_H@
 LIBMNL_LIBS		:= @LIBMNL_LIBS@
 LIBMNL_CFLAGS		:= @LIBMNL_CFLAGS@
diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
deleted file mode 100644
index 4a6b23dbce..0000000000
--- a/m4/ltp-keyutils.m4
+++ /dev/null
@@ -1,15 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) 2016 Fujitsu Ltd.
-dnl Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
-dnl Copyright (c) Linux Test Project, 2019-2026
-dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-
-AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
-	AC_CHECK_LIB([keyutils], [add_key],
-	[AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have libkeyutils installed.])
-	      AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
-
-	AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
-			struct keyctl_pkey_query, struct keyctl_pkey_params],,,
-			[#include <linux/keyctl.h>])
-])
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index b4e4178ebb..c7c160a1b1 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -9,8 +9,6 @@ CFLAGS			+= -D_GNU_SOURCE
 
 stack_clash:	CFLAGS += -fno-optimize-sibling-calls -Wno-infinite-recursion
 
-cve-2016-7042:	LDLIBS += $(KEYUTILS_LIBS)
-
 cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053 ghostlock refluxfs:  CFLAGS += -pthread
 cve-2014-0196 cve-2016-7117 cve-2017-2671:  LDLIBS += -lrt
 
diff --git a/testcases/kernel/syscalls/add_key/Makefile b/testcases/kernel/syscalls/add_key/Makefile
index 0f51e0bc2f..1273a4e9cb 100644
--- a/testcases/kernel/syscalls/add_key/Makefile
+++ b/testcases/kernel/syscalls/add_key/Makefile
@@ -5,6 +5,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS  += $(KEYUTILS_LIBS)
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/keyctl/Makefile b/testcases/kernel/syscalls/keyctl/Makefile
index 180ece25a2..14d1d20a4e 100644
--- a/testcases/kernel/syscalls/keyctl/Makefile
+++ b/testcases/kernel/syscalls/keyctl/Makefile
@@ -5,7 +5,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS	+= $(KEYUTILS_LIBS)
 keyctl02: LDLIBS	+= -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/landlock/Makefile b/testcases/kernel/syscalls/landlock/Makefile
index 3734d10349..02a66be910 100644
--- a/testcases/kernel/syscalls/landlock/Makefile
+++ b/testcases/kernel/syscalls/landlock/Makefile
@@ -5,6 +5,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-landlock07: LDLIBS += $(KEYUTILS_LIBS)
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/request_key/Makefile b/testcases/kernel/syscalls/request_key/Makefile
index 58a99875e5..15e07c4ca1 100644
--- a/testcases/kernel/syscalls/request_key/Makefile
+++ b/testcases/kernel/syscalls/request_key/Makefile
@@ -6,6 +6,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS		+= $(KEYUTILS_LIBS)
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/watchqueue/Makefile b/testcases/kernel/watchqueue/Makefile
index 896d66d429..cba769739b 100644
--- a/testcases/kernel/watchqueue/Makefile
+++ b/testcases/kernel/watchqueue/Makefile
@@ -4,5 +4,3 @@ top_srcdir			?= ../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-
-LDLIBS += $(KEYUTILS_LIBS)
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
