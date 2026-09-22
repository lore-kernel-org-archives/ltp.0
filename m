Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D7DC982FA
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 16:10:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BFFF3E6D40
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 18:10:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA30A3E295D
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:09:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 331C0600A94
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:09:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6FC2821BF8;
 Tue, 22 Sep 2026 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790093361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=por/HXr2BvTCCWuIVjklhJYj3g8/A/WC98lkAu27hGQ=;
 b=Cx69c2DyHQp2qw3OHWB2xxdgdJSrxwcHQo9Yg6hxbrnKA7CRWwxmbDmFatzUyNwkma2l7D
 Z0qgXchTG2Tuzhd87EygwLqWrDo/7SmHqfVXWV1evWVuxY7nPCZMlRVJloDkAoedqTcoBB
 N0HYhTsUhc98D1YC9k336m0RFtqWqEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790093361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=por/HXr2BvTCCWuIVjklhJYj3g8/A/WC98lkAu27hGQ=;
 b=t6CPLxh6FoceZ9UJobM0aqIfuHJryCyDm9CozeZVC0dGtJ6QRKc0DQNPubwmzyx6aq6Ybk
 uyPhyIz6nSoD4SAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790093357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=por/HXr2BvTCCWuIVjklhJYj3g8/A/WC98lkAu27hGQ=;
 b=LIeZm0ih/QCLulvauxC8D2uwLh3+15omDROGPBrKgF39Hp1GUZui3u+jG7W0qt4qrJ/KDW
 uKEXyF/J4Hz1AdXwPiSgvo2bL97udleVz1aJZIA/hRrAu1qUVdJ5R3dfnaPSfx/6xh8H5/
 0piUD79QFScURBaQ8+PVCHtxNsyWWuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790093357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=por/HXr2BvTCCWuIVjklhJYj3g8/A/WC98lkAu27hGQ=;
 b=wqV/epMijK5KPy6vf7M14KHJz9uFJXXQmbG0HLEdHmbsHnAkSQ6eMZZSw9+ZTFhgp7ZgHN
 RI8NuYa9KAEF69DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECB5113A6A;
 Tue, 22 Sep 2026 16:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u3mALCuosmouJgAAD6G6ig:T5
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 16:09:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Sep 2026 18:09:11 +0200
Message-ID: <20260922160911.2271754-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922160911.2271754-1-pvorel@suse.cz>
References: <20260922160911.2271754-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.994];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,configure.ac:url];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] Remove libkeyutils use
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

Follow-up: bc8ead0f06 ("lapi/keyctl.h: Remove <keyutils.h>")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac                                   |  5 ++++-
 include/mk/config.mk.in                        |  1 -
 m4/ltp-keyutils.m4                             | 15 ---------------
 testcases/cve/Makefile                         |  2 --
 testcases/kernel/syscalls/add_key/Makefile     |  2 --
 testcases/kernel/syscalls/keyctl/Makefile      |  1 -
 testcases/kernel/syscalls/landlock/Makefile    |  2 --
 testcases/kernel/syscalls/request_key/Makefile |  2 --
 testcases/kernel/watchqueue/Makefile           |  2 --
 9 files changed, 4 insertions(+), 28 deletions(-)
 delete mode 100644 m4/ltp-keyutils.m4

diff --git a/configure.ac b/configure.ac
index 18bfdb88c7..6ad2ee7fac 100644
--- a/configure.ac
+++ b/configure.ac
@@ -300,6 +300,10 @@ AC_CHECK_TYPES([struct uffdio_move],,,[#include <linux/userfaultfd.h>])
 AC_CHECK_TYPES([struct uffdio_poison],,,[#include <linux/userfaultfd.h>])
 AC_CHECK_TYPES([struct uffdio_writeprotect],,,[#include <linux/userfaultfd.h>])
 
+AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
+	struct keyctl_pkey_query, struct keyctl_pkey_params],,,
+	[#include <linux/keyctl.h>])
+
 # Tools knobs
 
 # Bash
@@ -422,7 +426,6 @@ LTP_CHECK_CLEAR_CACHE
 LTP_CHECK_CRYPTO
 LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_KERNEL_DEVEL
-LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_LIBMNL
 LTP_CHECK_SELINUX
 LTP_CHECK_SYNC_ADD_AND_FETCH
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
