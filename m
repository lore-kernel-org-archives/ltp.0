Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18166CA1015
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 08:46:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 387223CD4ED
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 10:46:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10FA43CD49F
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 10:46:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0C0E2600972
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 10:46:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 51E2E438C;
 Fri,  5 Sep 2025 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1757061969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OLv7HgDXWCCHSjDqZLU5d2imNn9u/kKwyV0jOrUGiPw=;
 b=mjZDugsvtxxy5C7JfTiaosHjMb2e/uQD4nZ8N7KsCXhVP8g4US0wHVA3y5eE8KvLKv9mam
 BI+4e5ilL5tePQX2nGYpB9pm8XOi0oOlOBmsIFA7U+UmFDfzfW9xAuEmQaqvZAJfBCdLxI
 oadEPZLL1XfG+cyg9zuU35KSGdeCK2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1757061969;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OLv7HgDXWCCHSjDqZLU5d2imNn9u/kKwyV0jOrUGiPw=;
 b=MXQzHNIZU4SRL81LfEIa5SG6bPBBXLHQV/Ka2qHljpdD+vpT3ahx27+lt6RW3HlcWOcYVL
 7tdWkw2KNCfwu7AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mjZDugsv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MXQzHNIZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1757061969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OLv7HgDXWCCHSjDqZLU5d2imNn9u/kKwyV0jOrUGiPw=;
 b=mjZDugsvtxxy5C7JfTiaosHjMb2e/uQD4nZ8N7KsCXhVP8g4US0wHVA3y5eE8KvLKv9mam
 BI+4e5ilL5tePQX2nGYpB9pm8XOi0oOlOBmsIFA7U+UmFDfzfW9xAuEmQaqvZAJfBCdLxI
 oadEPZLL1XfG+cyg9zuU35KSGdeCK2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1757061969;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OLv7HgDXWCCHSjDqZLU5d2imNn9u/kKwyV0jOrUGiPw=;
 b=MXQzHNIZU4SRL81LfEIa5SG6bPBBXLHQV/Ka2qHljpdD+vpT3ahx27+lt6RW3HlcWOcYVL
 7tdWkw2KNCfwu7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 454DF139B9;
 Fri,  5 Sep 2025 08:46:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JTqYEFGjumj5HgAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 05 Sep 2025 08:46:09 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri,  5 Sep 2025 10:46:07 +0200
Message-ID: <20250905084608.11958-1-akumar@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.de:mid, suse.de:dkim,
 suse.de:email]
X-Rspamd-Queue-Id: 51E2E438C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add tst_get_max_clocks() routine based on
 tst_kconfig_check()
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

current logic for defining TST_MAX_CLOCKS is based on checking the kernel
version provided by glibc headers which is not right as there are
mismatches possible between kernel version being tested and version
provided by headers.
Instead use tst_kconfig_check() routine for checking if the
CONFIG_POSIX_AUX_CLOCKS config option is set and define max clocks
accordingly in the tests for invalid clock types.

Fixes: da6b61438 ("define TST_MAX_CLOCKS to account MAX_AUX_CLOCKS also")
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 include/lapi/common_timers.h                         |  6 ------
 include/tst_clocks.h                                 |  2 ++
 lib/tst_clocks.c                                     | 12 ++++++++++++
 .../kernel/syscalls/clock_adjtime/clock_adjtime02.c  |  7 +++++--
 .../kernel/syscalls/clock_gettime/clock_gettime02.c  |  7 +++++--
 .../kernel/syscalls/clock_settime/clock_settime02.c  |  7 +++++--
 .../kernel/syscalls/timer_create/timer_create02.c    |  5 ++++-
 7 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
index f68cea811..6a615c3f4 100644
--- a/include/lapi/common_timers.h
+++ b/include/lapi/common_timers.h
@@ -33,12 +33,6 @@ static const clock_t clock_list[] = {
 
 #define MAX_AUX_CLOCKS 8
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 17, 0)
-#define TST_MAX_CLOCKS (MAX_CLOCKS + MAX_AUX_CLOCKS)
-#else
-#define TST_MAX_CLOCKS (MAX_CLOCKS)
-#endif
-
 #define CLOCK_TO_STR(def_name)	\
 	case def_name:		\
 		return #def_name;
diff --git a/include/tst_clocks.h b/include/tst_clocks.h
index 8b7f33d4f..69251d5d4 100644
--- a/include/tst_clocks.h
+++ b/include/tst_clocks.h
@@ -48,4 +48,6 @@ time_t tst_fs_timestamp_start(void);
  */
 time_t tst_fs_timestamp_end(void);
 
+int tst_get_max_clocks(void);
+
 #endif /* TST_CLOCKS__ */
diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index fba4a4f7b..704ce9551 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -11,6 +11,8 @@
 #include "tst_clocks.h"
 #include "lapi/syscalls.h"
 #include "lapi/posix_clocks.h"
+#include "lapi/common_timers.h"
+#include "tst_kconfig.h"
 
 typedef int (*mysyscall)(clockid_t clk_id, void *ts);
 
@@ -168,3 +170,13 @@ time_t tst_fs_timestamp_end(void)
 {
 	return tst_clock_get_timestamp(CLOCK_REALTIME);
 }
+
+int tst_get_max_clocks(void)
+{
+	static const char * const kconf_aux[] = {"CONFIG_POSIX_AUX_CLOCKS=y", NULL};
+
+	if (!tst_kconfig_check(kconf_aux))
+		return MAX_CLOCKS + MAX_AUX_CLOCKS;
+	else
+		return MAX_CLOCKS;
+}
diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
index 0c5e6ac21..ba62bf716 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
@@ -76,11 +76,11 @@ struct test_case {
 
 struct test_case tc[] = {
 	{
-	 .clktype = TST_MAX_CLOCKS,
+	 .clktype = 0,
 	 .exp_err = EINVAL,
 	},
 	{
-	 .clktype = TST_MAX_CLOCKS + 1,
+	 .clktype = 0,
 	 .exp_err = EINVAL,
 	},
 	{
@@ -223,6 +223,9 @@ static void setup(void)
 			tc[i].lowlimit /= hz;
 		}
 	}
+
+	tc[0].clktype = tst_get_max_clocks();
+	tc[1].clktype = tst_get_max_clocks() + 1;
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
index 1e1769864..091188d8a 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
@@ -34,11 +34,11 @@ struct test_case {
 
 static struct test_case tc[] = {
 	{
-	 .clktype = TST_MAX_CLOCKS,
+	 .clktype = 0,
 	 .exp_err = EINVAL,
 	 },
 	{
-	 .clktype = TST_MAX_CLOCKS + 1,
+	 .clktype = 0,
 	 .exp_err = EINVAL,
 	 },
 	/*
@@ -103,6 +103,9 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %d: %s", tst_variant, variants[tst_variant].desc);
 
 	bad_addr = tst_get_bad_addr(NULL);
+
+	tc[0].clktype = tst_get_max_clocks();
+	tc[1].clktype = tst_get_max_clocks() + 1;
 }
 
 static void verify_clock_gettime(unsigned int i)
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
index 9d703565b..cf002b30e 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime02.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
@@ -59,11 +59,11 @@ struct test_case tc[] = {
 	 .exp_err = EINVAL,
 	 },
 	{				/* case 06: MAXCLOCK		      */
-	 .type = TST_MAX_CLOCKS,
+	 .type = 0,
 	 .exp_err = EINVAL,
 	 },
 	{				/* case 07: MAXCLOCK+1		      */
-	 .type = TST_MAX_CLOCKS + 1,
+	 .type = 0,
 	 .exp_err = EINVAL,
 	 },
 	/* Linux specific */
@@ -106,6 +106,9 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 
 	bad_addr = tst_get_bad_addr(NULL);
+
+	tc[5].type = tst_get_max_clocks();
+	tc[6].type = tst_get_max_clocks() + 1;
 }
 
 static void verify_clock_settime(unsigned int i)
diff --git a/testcases/kernel/syscalls/timer_create/timer_create02.c b/testcases/kernel/syscalls/timer_create/timer_create02.c
index af3a5203e..cc7b6d0d0 100644
--- a/testcases/kernel/syscalls/timer_create/timer_create02.c
+++ b/testcases/kernel/syscalls/timer_create/timer_create02.c
@@ -25,6 +25,7 @@
 #include <signal.h>
 #include "tst_test.h"
 #include "lapi/common_timers.h"
+#include "tst_safe_clocks.h"
 
 static struct sigevent sig_ev = {
 	.sigev_notify = SIGEV_NONE,
@@ -52,7 +53,7 @@ static struct testcase {
 } tcases[] = {
 	{CLOCK_REALTIME, NULL, &timer_id, EFAULT, "invalid sigevent struct"},
 	{CLOCK_REALTIME, &sig_ev, NULL, EFAULT, "invalid timer ID"},
-	{TST_MAX_CLOCKS, &sig_ev, &timer_id, EINVAL, "invalid clock"},
+	{0, &sig_ev, &timer_id, EINVAL, "invalid clock"},
 	{CLOCK_REALTIME, &sig_ev_inv_not, &timer_id, EINVAL, "wrong sigev_notify"},
 	{CLOCK_REALTIME, &sig_ev_inv_sig, &timer_id, EINVAL, "wrong sigev_signo"},
 };
@@ -84,6 +85,8 @@ static void setup(void)
 		if (!tcases[i].kt_ptr)
 			tcases[i].kt_ptr = tst_get_bad_addr(NULL);
 	}
+
+    tcases[2].clock = tst_get_max_clocks();
 }
 
 static struct tst_test test = {
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
