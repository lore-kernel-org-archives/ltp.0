Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38217C04FFE
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 13:29:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CFD33CFFA6
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 15:29:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B32553CFD90
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:28:30 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 79FB9203C6B
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:28:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A2BC5FF7D;
 Tue, 23 Apr 2024 13:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713878908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oZXNIXnvtSW8tGFSDokmWD8U863M2PmDQKoKyRGWD0=;
 b=igY3jDobeCL9F/UFx254V7o3oaycG8WqDedb1siO50sBPV3H6ccWWKrcIn9h04YMvij17Z
 AdwAmhYRRZ51VFaW43KP65COcNoAXLPZCdZGSujuUC7Z1FOeqyp4hsHJU8dSi2OnzcEZCD
 MmG8ygW/moQifO7amgLwvosbZTu2DIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713878908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oZXNIXnvtSW8tGFSDokmWD8U863M2PmDQKoKyRGWD0=;
 b=SczpLLnGUsK6tKOc0C6WdaF02Q29wlxFcQf3RU5KoKRH5Ssu2CwFfMff1jK/0PBsyrhKCC
 xpY9f6njsC8AvoAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nt2aIkZJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EjR+lOIa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713878907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oZXNIXnvtSW8tGFSDokmWD8U863M2PmDQKoKyRGWD0=;
 b=Nt2aIkZJUqVf+F2R/TKi0IrYkfjGwU+SBByI8d7Cq3P9r7orPymHA50jRzr8gu2hICU9P1
 B2XQRs2y9JVpmqDYY+mUdlgQX4LIR3SB04x8dc9AndcqTWkvgiGWvCD0snO7aQRYz71kjX
 nCUwdXiUq5IekS+vsPujm43FvkQ7kSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713878907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oZXNIXnvtSW8tGFSDokmWD8U863M2PmDQKoKyRGWD0=;
 b=EjR+lOIauWCT1t23y9PokhudZ7iNUNdNESi8xXRkpzB2iMliHEcx/ymvEcKlTvzx0ZK8eI
 v8Zqzosro4SE5TBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0DF5139A1;
 Tue, 23 Apr 2024 13:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EMxuMnq3J2YTZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Apr 2024 13:28:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 23 Apr 2024 15:28:23 +0200
Message-ID: <20240423132823.194179-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423132823.194179-1-pvorel@suse.cz>
References: <20240423132823.194179-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0A2BC5FF7D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_SEVEN(0.00)[8];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,fujitsu.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux-nfs.org:url,suse.cz:dkim,suse.cz:email,ozlabs.org:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] lapi: getrandom05: Add getrandom() fallback
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

Fix missing getrandom() support detection on glibc < 2.25 and musl
< 1.1.20.

Add m4 check and use lapi header in getrandom05 to fix error:

    getrandom05.c:16:24: fatal error: sys/random.h: No such file or directory
    #include <sys/random.h>

on openSUSE Leap 42.2 (glibc 2.22, kernel 4.4).

NOTE: getrandom() requires Linux >= 3.17, which is not supported. While
it'd be quite easy to check (it would require e.g. AC_LINK_IFELSE()
check), I skipped that, because we are going to drop kernel 3.10 support.

Fixes: d9280782d ("getrandom: Add negative tests for getrandom")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Based on the fix I did some this last year for nfs-utils:

https://git.linux-nfs.org/?p=steved/nfs-utils.git;a=commitdiff;h=f92fd6ca815025c435dabf45da28472ac0aa04a4

For LTP I decided to ignore kernel 3.10 support check, thus it's enough
just to check for <sys/random.h>.

Can we drop 3.10 support? I suppose yes, but more ack for my commit
would be great.

https://patchwork.ozlabs.org/project/ltp/patch/20240419124221.207445-1-pvorel@suse.cz/
https://lore.kernel.org/ltp/20240419124221.207445-1-pvorel@suse.cz/

Kind regards,
Petr

 configure.ac                                      |  1 +
 include/lapi/getrandom.h                          | 15 +++++++++++++--
 testcases/kernel/syscalls/getrandom/getrandom05.c |  3 ++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1d7e862d8..15a5847fa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -76,6 +76,7 @@ AC_CHECK_HEADERS_ONCE([ \
     sys/inotify.h \
     sys/pidfd.h
     sys/prctl.h \
+    sys/random.h \
     sys/shm.h \
     sys/timerfd.h \
     sys/ustat.h \
diff --git a/include/lapi/getrandom.h b/include/lapi/getrandom.h
index c654ca1ac..706ef9b8f 100644
--- a/include/lapi/getrandom.h
+++ b/include/lapi/getrandom.h
@@ -8,10 +8,14 @@
 
 #include "config.h"
 
-#if HAVE_LINUX_RANDOM_H
-#include <linux/random.h>
+#ifdef HAVE_SYS_RANDOM_H
+# include <sys/random.h>
+#elif HAVE_LINUX_RANDOM_H
+# include <linux/random.h>
 #endif
 
+#include "lapi/syscalls.h"
+
 /*
  * Flags for getrandom(2)
  *
@@ -27,4 +31,11 @@
 # define GRND_RANDOM	0x0002
 #endif
 
+#ifndef HAVE_SYS_RANDOM_H
+static inline int getrandom(void *buf, size_t buflen, unsigned int flags)
+{
+	return tst_syscall(SYS_getrandom, buf, buflen, flags);
+}
+#endif
+
 #endif /* LAPI_GETRANDOM_H__ */
diff --git a/testcases/kernel/syscalls/getrandom/getrandom05.c b/testcases/kernel/syscalls/getrandom/getrandom05.c
index 1a9614330..92098deb7 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom05.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom05.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2024
  * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
  */
 
@@ -13,8 +14,8 @@
  * - EINVAL when flag is invalid
  */
 
-#include <sys/random.h>
 #include "tst_test.h"
+#include "lapi/getrandom.h"
 
 static char buff_efault[64];
 static char buff_einval[64];
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
