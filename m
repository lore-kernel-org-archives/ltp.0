Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCA0C87FD2
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 10:56:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6312C3CA4E2
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 12:56:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F8993CA4F2
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 12:55:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2D7851400252
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 12:55:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C51CF5BE09;
 Fri,  8 Aug 2025 10:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754650536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5nEHbUTGeY3firUU1I/lfrvRo8qsXoON0hJR3p3UiI=;
 b=v7StSFLDPRhl89hDdP+Klr4otyhXxW6SH1A2KgFAfdsZ6MSP3GF4RC07VuO2bt5jSUZHt0
 6d7IpXTHKIzAWXpn0oJrcv+zN+bJ72MXuxQvtSmImgCDNwhIb1Vbnh2mCo9cPMOv/Iyzry
 QbPpPfV0IMTkpqULgAdfK4PdfvDWry8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754650536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5nEHbUTGeY3firUU1I/lfrvRo8qsXoON0hJR3p3UiI=;
 b=b4nFw7gxZUQTFLk1ZtaZsKtmL9APEN9fB+I9JsKpw3n0FwS+KN6C+lWO4P56o5PolvdF/i
 C6zUPKPMbaQcZQAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v7StSFLD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=b4nFw7gx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754650536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5nEHbUTGeY3firUU1I/lfrvRo8qsXoON0hJR3p3UiI=;
 b=v7StSFLDPRhl89hDdP+Klr4otyhXxW6SH1A2KgFAfdsZ6MSP3GF4RC07VuO2bt5jSUZHt0
 6d7IpXTHKIzAWXpn0oJrcv+zN+bJ72MXuxQvtSmImgCDNwhIb1Vbnh2mCo9cPMOv/Iyzry
 QbPpPfV0IMTkpqULgAdfK4PdfvDWry8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754650536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5nEHbUTGeY3firUU1I/lfrvRo8qsXoON0hJR3p3UiI=;
 b=b4nFw7gxZUQTFLk1ZtaZsKtmL9APEN9fB+I9JsKpw3n0FwS+KN6C+lWO4P56o5PolvdF/i
 C6zUPKPMbaQcZQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A168113AB9;
 Fri,  8 Aug 2025 10:55:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qGNpJqjXlWgmcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Aug 2025 10:55:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  8 Aug 2025 12:55:27 +0200
Message-ID: <20250808105528.451372-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808105528.451372-1-pvorel@suse.cz>
References: <20250808105528.451372-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C51CF5BE09
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] m4: lapi: Drop check for old libcap-devel
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

Upstream fix [1] was released in libcap-2.17 released in 2009.
Even old SLES12 we still use for testing has newer libcap,
we can remove the check.

[1] https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=012bca3265ed0d84b57531919a390645052d810e

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/capability.h |  9 ---------
 m4/ltp-cap.m4             | 17 +----------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 14d2d3c12c..aa791dbeb0 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -10,15 +10,6 @@
 
 #ifdef HAVE_SYS_CAPABILITY_H
 # include <sys/capability.h>
-/**
- * Some old libcap-devel(1.96~2.16) define _LINUX_TYPES_H in
- * sys/capability.h that makes ltp-lib cann't include linux/types.h
- * essentially. Here undefine it if include such old header-file.
- */
-# ifndef HAVE_NEWER_LIBCAP
-#  undef _LINUX_TYPES_H
-# endif
-#endif
 
 #ifndef CAP_NET_BIND_SERVICE
 # define CAP_NET_BIND_SERVICE 10
diff --git a/m4/ltp-cap.m4 b/m4/ltp-cap.m4
index 4981e843da..6b26e7d15c 100644
--- a/m4/ltp-cap.m4
+++ b/m4/ltp-cap.m4
@@ -1,6 +1,6 @@
 dnl SPDX-License-Identifier: GPL-2.0-or-later
 dnl Copyright (c) Cisco Systems Inc., 2009
-dnl Copyright (c) Linux Test Project, 2019
+dnl Copyright (c) Linux Test Project, 2019-2025
 dnl Author: Ngie Cooper <yaneurabeya@gmail.com>
 
 AC_DEFUN([LTP_CHECK_CAPABILITY_SUPPORT],[
@@ -14,19 +14,4 @@ if test "x$cap_libs" != x; then
 	AC_DEFINE(HAVE_LIBCAP)
 fi
 AC_SUBST(CAP_LIBS,$cap_libs)
-
-AH_TEMPLATE(HAVE_NEWER_LIBCAP,
-[Define to 1 if you have newer libcap-2 installed.])
-AC_COMPILE_IFELSE([AC_LANG_SOURCE([
-#include <sys/capability.h>
-#include <linux/types.h>
-int main(void) {
-	__u16 a;
-	__u32 b;
-	return 0;
-}])],[has_newer_libcap="yes"])
-
-if test "x$has_newer_libcap" = xyes; then
-	AC_DEFINE(HAVE_NEWER_LIBCAP)
-fi
 ])
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
