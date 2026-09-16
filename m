Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E61C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:05:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78EFB3E8C4D
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:05:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D014E3C72EC
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6A25610002BF
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 762AA1FEEF;
 Wed, 16 Sep 2026 14:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAnIlHagQE+8JRL9cSuMr4jLvXDwNZx14R54AS1RR80=;
 b=illpdm+lMDRXUtGG3R5SqzwATzeGRPkeONtiLZ9zx0gFK6F781D1oig+v41NLvTSVksupS
 hCA62ZPKcOHVlgJ957QOI3HzA4JaoyllUwZ6uCoikPVVY07V7b3JVB3RgmHQ+bQm6bvFRF
 sC/uOujKFrd3VN94lW6rnqIuRuV0Bwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAnIlHagQE+8JRL9cSuMr4jLvXDwNZx14R54AS1RR80=;
 b=m0L8NFIQIRBwWPVX7DyDs4Ag9gIJ/GUiyyaqX7NHcIMMX03fz7Z/CROyYUSqb0TPZrWK0r
 ws1zRHv+LsW//PAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="BL/XVQ5f";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fvT7TIsi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAnIlHagQE+8JRL9cSuMr4jLvXDwNZx14R54AS1RR80=;
 b=BL/XVQ5f96CWDKSwUZVMNw0lajYeants3z6ythH98VqcFRrqxf58VpWJgD0eIJ2pMiX2Co
 wSoOp9zYZhwYHjGK2DWLbw/8V0zcxbOV2Ddu3XyRGw5YMX79ZxhMg4qM+FFcaD8LxNBQmC
 OXgl304SgtOonZ+iwVSNFT4LkH16iyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAnIlHagQE+8JRL9cSuMr4jLvXDwNZx14R54AS1RR80=;
 b=fvT7TIsi+7t0Ua49bFMeo1qVuKSM2Dn4IzP8O1eQsNmVOLI4rPLlObHFzybyFOnJf8LLoz
 HFQL+8fhNwazRZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BD50136DB;
 Wed, 16 Sep 2026 14:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T2
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:27 +0200
Message-ID: <20260916140402.1797325-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 762AA1FEEF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,fujitsu.com:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 01/36] lapi/keyctl.h: Add fallback definitions for
 extended ops
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add fallback definitions for KEYCTL_LINK, KEYCTL_RESTRICT_KEYRING,
KEYCTL_MOVE, and KEYCTL_MOVE_EXCL, as well as fallback definitions
for struct keyctl_dh_params and struct keyctl_kdf_params when built
without linux/keyctl.h.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel
* Remove <keyutils.h> usage - use only <linux/keyctl.h>
* Add check for struct keyctl_dh_params.priv for Leap 42.2 ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/keyctl.h | 36 +++++++++++++++++++++++++++++++++++-
 m4/ltp-keyutils.m4    |  7 +++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 83fa09303c..1c6627f555 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -8,6 +8,8 @@
 
 #include "config.h"
 
+#include <stdint.h>
+
 #if defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS)
 # include <keyutils.h>
 #else
@@ -16,7 +18,6 @@
 # endif /* HAVE_LINUX_KEYCTL_H */
 
 # include <stdarg.h>
-# include <stdint.h>
 # include "lapi/syscalls.h"
 typedef int32_t key_serial_t;
 
@@ -60,6 +61,23 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 
 #endif /* defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS) */
 
+#ifndef HAVE_STRUCT_KEYCTL_DH_PARAMS
+struct keyctl_dh_params {
+	int32_t priv;
+	int32_t prime;
+	int32_t base;
+};
+#endif
+
+#ifndef HAVE_STRUCT_KEYCTL_KDF_PARAMS
+struct keyctl_kdf_params {
+	char *hashname;
+	char *otherinfo;
+	uint32_t otherinfolen;
+	uint32_t __spare[8];
+};
+#endif
+
 /* special process keyring shortcut IDs */
 #ifndef KEY_SPEC_THREAD_KEYRING
 # define KEY_SPEC_THREAD_KEYRING -1
@@ -124,6 +142,10 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_CLEAR 7
 #endif
 
+#ifndef KEYCTL_LINK
+# define KEYCTL_LINK 8
+#endif
+
 #ifndef KEYCTL_UNLINK
 # define KEYCTL_UNLINK 9
 #endif
@@ -168,6 +190,18 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_WATCH_KEY 32
 #endif
 
+#ifndef KEYCTL_RESTRICT_KEYRING
+# define KEYCTL_RESTRICT_KEYRING 29
+#endif
+
+#ifndef KEYCTL_MOVE
+# define KEYCTL_MOVE 30
+#endif
+
+#ifndef KEYCTL_MOVE_EXCL
+# define KEYCTL_MOVE_EXCL 0x00000001 /* do not displace from the to-keyring */
+#endif
+
 /* key permissions */
 #ifndef KEY_POS_VIEW
 # define KEY_POS_VIEW    0x01000000
diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
index 451c549f38..35bad783e5 100644
--- a/m4/ltp-keyutils.m4
+++ b/m4/ltp-keyutils.m4
@@ -1,10 +1,17 @@
 dnl SPDX-License-Identifier: GPL-2.0-or-later
 dnl Copyright (c) 2016 Fujitsu Ltd.
 dnl Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+dnl Copyright (c) Linux Test Project, 2019-2026
 dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 
 AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
 	AC_CHECK_LIB([keyutils], [add_key],
 	[AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have libkeyutils installed.])
 	      AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
+
+	AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
+			struct keyctl_pkey_query, struct keyctl_pkey_params],,,
+			[#include <linux/keyctl.h>])
+
+	AC_CHECK_MEMBERS([struct keyctl_dh_params.priv],,,[#include <linux/keyctl.h>])
 ])
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
