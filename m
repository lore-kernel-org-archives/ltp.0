Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BD5C2BA4C
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 12:36:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54BEE3C96D8
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 13:36:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 148993C0C9F
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84A64200D01
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1AEEB1F3B6;
 Wed, 26 Jan 2022 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643200557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9toT3+XA7dqE/yxjZvIzfROFPByeTK/tTqGA4SGvfg=;
 b=kKsejDsqRGWXIpgGE1GelPXIcGhu9uo9qrDnfqdbz/zk/B3Aoton67tKA+JBFnaD6w9hdf
 8IsUtK1FcinhXjtYWAFp2amAxKWSDYQAPmxUZCT1khqBq6Mu1ZlfQRryMsUH/paWmNL6Me
 TY74hMT39liyROm8mWzJJFcioi5qh5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643200557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9toT3+XA7dqE/yxjZvIzfROFPByeTK/tTqGA4SGvfg=;
 b=zrPkOuqljfdlC0znJhbeInNBP+wowvJxflpS8AyUFXlS9h0z5MftESXnVp9BbzygMfe7E8
 kpPm1YcmKODuY/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7E2213BB5;
 Wed, 26 Jan 2022 12:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WF8QMyxA8WGkOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 12:35:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 13:35:46 +0100
Message-Id: <20220126123547.13298-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126123547.13298-1-pvorel@suse.cz>
References: <20220126123547.13298-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v2 6/7] m4: Remove check for clone() supports 7
 args
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix from 1db62666ce (2014) for SLES10, RHEL4. Save to remove now.

NOTE: support for 7 args was missing in kernel 2.4 and earlier.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2

 configure.ac         |  1 -
 lib/cloner.c         | 10 ----------
 m4/ltp-clone7args.m4 | 17 -----------------
 3 files changed, 28 deletions(-)
 delete mode 100644 m4/ltp-clone7args.m4

diff --git a/configure.ac b/configure.ac
index 41c385edcb..f83bbe950b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -352,7 +352,6 @@ LTP_CHECK_ATOMIC_MEMORY_MODEL
 LTP_CHECK_BUILTIN_CLEAR_CACHE
 LTP_CHECK_CAPABILITY_SUPPORT
 LTP_CHECK_CC_WARN_OLDSTYLE
-LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 LTP_CHECK_CRYPTO
 LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_KERNEL_DEVEL
diff --git a/lib/cloner.c b/lib/cloner.c
index 11401f2303..95954f6df3 100644
--- a/lib/cloner.c
+++ b/lib/cloner.c
@@ -50,11 +50,6 @@ extern int __clone2(int (*fn) (void *arg), void *child_stack_base,
                     pid_t *parent_tid, void *tls, pid_t *child_tid);
 #endif
 
-#ifndef CLONE_SUPPORTS_7_ARGS
-# define clone(fn, stack, flags, arg, ptid, tls, ctid) \
-         clone(fn, stack, flags, arg)
-#endif
-
 /*
  * ltp_clone: wrapper for clone to hide the architecture dependencies.
  *   1. hppa takes bottom of stack and no stacksize (stack grows up)
@@ -109,12 +104,7 @@ int ltp_clone7(unsigned long flags, int (*fn)(void *arg), void *arg,
 	ctid = va_arg(arg_clone, pid_t *);
 	va_end(arg_clone);
 
-#ifdef CLONE_SUPPORTS_7_ARGS
 	return ltp_clone_(flags, fn, arg, stack_size, stack, ptid, tls, ctid);
-#else
-	errno = ENOSYS;
-	return -1;
-#endif
 }
 
 /*
diff --git a/m4/ltp-clone7args.m4 b/m4/ltp-clone7args.m4
deleted file mode 100644
index ab55c1e335..0000000000
--- a/m4/ltp-clone7args.m4
+++ /dev/null
@@ -1,17 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Linux Test Project, 2014
-
-AC_DEFUN([LTP_CHECK_CLONE_SUPPORTS_7_ARGS],[
-AH_TEMPLATE(CLONE_SUPPORTS_7_ARGS,
-[Define to 1 if clone() supports 7 arguments.])
-AC_MSG_CHECKING([if clone() supports 7 args])
-AC_TRY_LINK([#define _GNU_SOURCE
-		#include <sched.h>
-		#include <stdlib.h>],
-		[
-		#ifndef __ia64__
-		clone(NULL, NULL, 0, NULL, NULL, NULL, NULL);
-		#endif
-		],
-		AC_DEFINE(CLONE_SUPPORTS_7_ARGS) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
-])
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
