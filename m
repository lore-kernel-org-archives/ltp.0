Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2150EC4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 14:18:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1C4E3D0046
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 16:18:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 416C93D0036
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 16:17:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C789D1A05C98
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 16:17:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4BDF266EAE;
 Wed, 24 Apr 2024 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713968275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAsZeh/SlVOFHvh9MQk+oqV6fHG3ciKuo719Cr82bTA=;
 b=anPihf7GZwwMRazZ7N1COGQhlAooximukKPOJw7RjhYbG82LceoLrzWWNx0HW5KETcg2n4
 zWF3deYPGvhQDo5Yl6Awniy+oqzms9x6l7UaPh0z/vIg+o/VvZm02sYSRKahYyetBRSPCa
 523fKgqKmpAe1EplNDPuWvmEJzmKGBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713968275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAsZeh/SlVOFHvh9MQk+oqV6fHG3ciKuo719Cr82bTA=;
 b=mCZa281OJg9CiZpveU7BRzmxnIjer/OpI9w97LVOnL/k5G0uvSAG5CDpRO/T+ngTRlbZXu
 wPUZ6SijbVILK1DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713968275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAsZeh/SlVOFHvh9MQk+oqV6fHG3ciKuo719Cr82bTA=;
 b=anPihf7GZwwMRazZ7N1COGQhlAooximukKPOJw7RjhYbG82LceoLrzWWNx0HW5KETcg2n4
 zWF3deYPGvhQDo5Yl6Awniy+oqzms9x6l7UaPh0z/vIg+o/VvZm02sYSRKahYyetBRSPCa
 523fKgqKmpAe1EplNDPuWvmEJzmKGBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713968275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAsZeh/SlVOFHvh9MQk+oqV6fHG3ciKuo719Cr82bTA=;
 b=mCZa281OJg9CiZpveU7BRzmxnIjer/OpI9w97LVOnL/k5G0uvSAG5CDpRO/T+ngTRlbZXu
 wPUZ6SijbVILK1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F767139A8;
 Wed, 24 Apr 2024 14:17:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eMzsCpMUKWZ9EgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Apr 2024 14:17:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Apr 2024 16:17:51 +0200
Message-ID: <20240424141751.247015-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424141751.247015-1-pvorel@suse.cz>
References: <20240424141751.247015-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] lapi: getrandom05: Add getrandom() fallback
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
The same as in v1.

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
