Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95025CA0FED
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 14:56:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 631263CD528
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 16:56:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6690D3CD4E1
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 16:55:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 59BC820006E
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 16:55:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1D293ED68;
 Fri,  5 Sep 2025 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1757084156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sd98wyaKsVDvVdUZAb3I46Xx0w3mxyt1VSniPLvt8bs=;
 b=hEsldiKAuh5ehTmBE/+0rFjoEqHRI6m8gr1d+n7FnHbhYYOzj7qV94XpmTmth5Umko8/t8
 eDNDg85DypfwRjWfEmL3VMcxj71gljduc93UdAti0ZQrQbWXXQLL3Ud72bOreMIGaK5kGY
 O9a4qlaAeqo9cLm8/yWaGxft5aFtuF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1757084156;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sd98wyaKsVDvVdUZAb3I46Xx0w3mxyt1VSniPLvt8bs=;
 b=5KTV1mSJ+513I0qQDx/3FGUU+IVB3IaPtuyxwckfxGGF7Sn6W2SYBbk6/IjsKW6JXtG0WF
 SOnukJahKlL0dqCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hEsldiKA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5KTV1mSJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1757084156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sd98wyaKsVDvVdUZAb3I46Xx0w3mxyt1VSniPLvt8bs=;
 b=hEsldiKAuh5ehTmBE/+0rFjoEqHRI6m8gr1d+n7FnHbhYYOzj7qV94XpmTmth5Umko8/t8
 eDNDg85DypfwRjWfEmL3VMcxj71gljduc93UdAti0ZQrQbWXXQLL3Ud72bOreMIGaK5kGY
 O9a4qlaAeqo9cLm8/yWaGxft5aFtuF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1757084156;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sd98wyaKsVDvVdUZAb3I46Xx0w3mxyt1VSniPLvt8bs=;
 b=5KTV1mSJ+513I0qQDx/3FGUU+IVB3IaPtuyxwckfxGGF7Sn6W2SYBbk6/IjsKW6JXtG0WF
 SOnukJahKlL0dqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9521213306;
 Fri,  5 Sep 2025 14:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9PpQJPz5umhqEAAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 05 Sep 2025 14:55:56 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri,  5 Sep 2025 16:55:55 +0200
Message-ID: <20250905145556.25616-1-akumar@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: A1D293ED68
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add tst_get_max_clocks() routine based on
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
 include/lapi/common_timers.h                  |  6 ---
 include/tst_clocks.h                          |  2 +
 lib/tst_clocks.c                              | 12 +++++
 .../syscalls/clock_adjtime/clock_adjtime02.c  | 26 ++++++----
 .../syscalls/clock_gettime/clock_gettime02.c  | 43 +++++++++++------
 .../syscalls/clock_settime/clock_settime02.c  | 48 ++++++++++++-------
 .../syscalls/timer_create/timer_create02.c    | 19 +++++---
 7 files changed, 100 insertions(+), 56 deletions(-)

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
index 0c5e6ac21..eaa7f807d 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
@@ -61,11 +61,14 @@ static long hz;
 static struct tst_timex saved, ttxc;
 static int supported;
 static void *bad_addr;
+static clockid_t max_clocks1;
+static clockid_t max_clocks2;
+static clockid_t clk_realtime = CLOCK_REALTIME;
 
 static void cleanup(void);
 
 struct test_case {
-	clockid_t clktype;
+	clockid_t *clktype;
 	unsigned int modes;
 	long lowlimit;
 	long highlimit;
@@ -74,36 +77,36 @@ struct test_case {
 	int droproot;
 };
 
-struct test_case tc[] = {
+static struct test_case tc[] = {
 	{
-	 .clktype = TST_MAX_CLOCKS,
+	 .clktype = &max_clocks1,
 	 .exp_err = EINVAL,
 	},
 	{
-	 .clktype = TST_MAX_CLOCKS + 1,
+	 .clktype = &max_clocks2,
 	 .exp_err = EINVAL,
 	},
 	{
-	 .clktype = CLOCK_REALTIME,
+	 .clktype = &clk_realtime,
 	 .modes = ADJ_ALL,
 	 .exp_err = EFAULT,
 	},
 	{
-	 .clktype = CLOCK_REALTIME,
+	 .clktype = &clk_realtime,
 	 .modes = ADJ_TICK,
 	 .lowlimit = 900000,
 	 .delta = 1,
 	 .exp_err = EINVAL,
 	},
 	{
-	 .clktype = CLOCK_REALTIME,
+	 .clktype = &clk_realtime,
 	 .modes = ADJ_TICK,
 	 .highlimit = 1100000,
 	 .delta = 1,
 	 .exp_err = EINVAL,
 	},
 	{
-	 .clktype = CLOCK_REALTIME,
+	 .clktype = &clk_realtime,
 	 .modes = ADJ_ALL,
 	 .exp_err = EPERM,
 	 .droproot = 1,
@@ -162,9 +165,9 @@ static void verify_clock_adjtime(unsigned int i)
 
 	/* special case: EFAULT for bad addresses */
 	if (tc[i].exp_err == EFAULT) {
-		TEST(tv->clock_adjtime(tc[i].clktype, bad_addr));
+		TEST(tv->clock_adjtime(*tc[i].clktype, bad_addr));
 	} else {
-		TEST(tv->clock_adjtime(tc[i].clktype, tst_timex_get(txcptr)));
+		TEST(tv->clock_adjtime(*tc[i].clktype, tst_timex_get(txcptr)));
 		timex_show("TEST", txcptr);
 	}
 
@@ -223,6 +226,9 @@ static void setup(void)
 			tc[i].lowlimit /= hz;
 		}
 	}
+
+	max_clocks1 = tst_get_max_clocks();
+	max_clocks2 = max_clocks1 + 1;
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
index 1e1769864..9b0b970d3 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
@@ -25,20 +25,30 @@
 #include "tst_safe_clocks.h"
 
 static void *bad_addr;
+static clockid_t max_clocks1;
+static clockid_t max_clocks2;
+static clockid_t clk_realtime = CLOCK_REALTIME;
+static clockid_t clk_monotonic = CLOCK_MONOTONIC;
+static clockid_t clk_process_cputime_id = CLOCK_PROCESS_CPUTIME_ID;
+static clockid_t clk_thread_cputime_id = CLOCK_THREAD_CPUTIME_ID;
+static clockid_t clk_realtime_coarse = CLOCK_REALTIME_COARSE;
+static clockid_t clk_monotonic_coarse = CLOCK_MONOTONIC_COARSE;
+static clockid_t clk_monotonic_raw = CLOCK_MONOTONIC_RAW;
+static clockid_t clk_boottime = CLOCK_BOOTTIME;
 
 struct test_case {
-	clockid_t clktype;
+	clockid_t *clktype;
 	int exp_err;
 	int allow_inval;
 };
 
 static struct test_case tc[] = {
 	{
-	 .clktype = TST_MAX_CLOCKS,
+	 .clktype = &max_clocks1,
 	 .exp_err = EINVAL,
 	 },
 	{
-	 .clktype = TST_MAX_CLOCKS + 1,
+	 .clktype = &max_clocks2,
 	 .exp_err = EINVAL,
 	 },
 	/*
@@ -46,38 +56,38 @@ static struct test_case tc[] = {
 	 * It justifies testing EFAULT for all.
 	 */
 	{
-	 .clktype = CLOCK_REALTIME,
+	 .clktype = &clk_realtime,
 	 .exp_err = EFAULT,
 	 },
 	{
-	 .clktype = CLOCK_MONOTONIC,
+	 .clktype = &clk_monotonic,
 	 .exp_err = EFAULT,
 	 },
 	{
-	 .clktype = CLOCK_PROCESS_CPUTIME_ID,
+	 .clktype = &clk_process_cputime_id,
 	 .exp_err = EFAULT,
 	 },
 	{
-	 .clktype = CLOCK_THREAD_CPUTIME_ID,
+	 .clktype = &clk_thread_cputime_id,
 	 .exp_err = EFAULT,
 	 },
 	{
-	 .clktype = CLOCK_REALTIME_COARSE,
+	 .clktype = &clk_realtime_coarse,
 	 .exp_err = EFAULT,
 	 .allow_inval = 1,
 	 },
 	{
-	 .clktype = CLOCK_MONOTONIC_COARSE,
+	 .clktype = &clk_monotonic_coarse,
 	 .exp_err = EFAULT,
 	 .allow_inval = 1,
 	 },
 	{
-	 .clktype = CLOCK_MONOTONIC_RAW,
+	 .clktype = &clk_monotonic_raw,
 	 .exp_err = EFAULT,
 	 .allow_inval = 1,
 	 },
 	{
-	 .clktype = CLOCK_BOOTTIME,
+	 .clktype = &clk_boottime,
 	 .exp_err = EFAULT,
 	 .allow_inval = 1,
 	 },
@@ -103,6 +113,9 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %d: %s", tst_variant, variants[tst_variant].desc);
 
 	bad_addr = tst_get_bad_addr(NULL);
+
+	max_clocks1 = tst_get_max_clocks();
+	max_clocks2 = max_clocks1 + 1;
 }
 
 static void verify_clock_gettime(unsigned int i)
@@ -118,21 +131,21 @@ static void verify_clock_gettime(unsigned int i)
 		ts = tst_ts_get(&spec);
 	}
 
-	TEST(tv->clock_gettime(tc[i].clktype, ts));
+	TEST(tv->clock_gettime(*tc[i].clktype, ts));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "clock_gettime(2): clock %s passed unexpectedly",
-			tst_clock_name(tc[i].clktype));
+			tst_clock_name(*tc[i].clktype));
 		return;
 	}
 
 	if ((tc[i].exp_err == TST_ERR) ||
 	    (tc[i].allow_inval && TST_ERR == EINVAL)) {
 		tst_res(TPASS | TTERRNO, "clock_gettime(2): clock %s failed as expected",
-			tst_clock_name(tc[i].clktype));
+			tst_clock_name(*tc[i].clktype));
 	} else {
 		tst_res(TFAIL | TTERRNO, "clock_gettime(2): clock %s failed unexpectedly",
-			tst_clock_name(tc[i].clktype));
+			tst_clock_name(*tc[i].clktype));
 	}
 }
 
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
index 9d703565b..55190db03 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime02.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
@@ -16,75 +16,84 @@
 #define DELTA_SEC 10
 
 static void *bad_addr;
+static clockid_t max_clocks1;
+static clockid_t max_clocks2;
+static clockid_t clk_realtime = CLOCK_REALTIME;
+static clockid_t clk_monotonic = CLOCK_MONOTONIC;
+static clockid_t clk_process_cputime_id = CLOCK_PROCESS_CPUTIME_ID;
+static clockid_t clk_thread_cputime_id = CLOCK_THREAD_CPUTIME_ID;
+static clockid_t clk_monotonic_coarse = CLOCK_MONOTONIC_COARSE;
+static clockid_t clk_monotonic_raw = CLOCK_MONOTONIC_RAW;
+static clockid_t clk_boottime = CLOCK_BOOTTIME;
 
 struct test_case {
-	clockid_t type;
+	clockid_t *type;
 	int exp_err;
 	int replace;
 	long tv_sec;
 	long tv_nsec;
 };
 
-struct test_case tc[] = {
+static struct test_case tc[] = {
 	{				/* case 01: REALTIME: timespec NULL   */
-	 .type = CLOCK_REALTIME,
+	 .type = &clk_realtime,
 	 .exp_err = EFAULT,
 	 .replace = 1,
 	 .tv_sec = 0,
 	 .tv_nsec = 0,
 	 },
 	{				/* case 02: REALTIME: tv_sec = -1     */
-	 .type = CLOCK_REALTIME,
+	 .type = &clk_realtime,
 	 .exp_err = EINVAL,
 	 .replace = 1,
 	 .tv_sec = -1,
 	 .tv_nsec = 0,
 	 },
 	{				/* case 03: REALTIME: tv_nsec = -1    */
-	 .type = CLOCK_REALTIME,
+	 .type = &clk_realtime,
 	 .exp_err = EINVAL,
 	 .replace = 1,
 	 .tv_sec = 0,
 	 .tv_nsec = -1,
 	 },
 	{				/* case 04: REALTIME: tv_nsec = 1s+1  */
-	 .type = CLOCK_REALTIME,
+	 .type = &clk_realtime,
 	 .exp_err = EINVAL,
 	 .replace = 1,
 	 .tv_sec = 0,
 	 .tv_nsec = NSEC_PER_SEC + 1,
 	 },
 	{				/* case 05: MONOTONIC		      */
-	 .type = CLOCK_MONOTONIC,
+	 .type = &clk_monotonic,
 	 .exp_err = EINVAL,
 	 },
 	{				/* case 06: MAXCLOCK		      */
-	 .type = TST_MAX_CLOCKS,
+	 .type = &max_clocks1,
 	 .exp_err = EINVAL,
 	 },
 	{				/* case 07: MAXCLOCK+1		      */
-	 .type = TST_MAX_CLOCKS + 1,
+	 .type = &max_clocks2,
 	 .exp_err = EINVAL,
 	 },
 	/* Linux specific */
 	{				/* case 08: CLOCK_MONOTONIC_COARSE    */
-	 .type = CLOCK_MONOTONIC_COARSE,
+	 .type = &clk_monotonic_coarse,
 	 .exp_err = EINVAL,
 	 },
 	{				/* case 09: CLOCK_MONOTONIC_RAW       */
-	 .type = CLOCK_MONOTONIC_RAW,
+	 .type = &clk_monotonic_raw,
 	 .exp_err = EINVAL,
 	 },
 	{				/* case 10: CLOCK_BOOTTIME	      */
-	 .type = CLOCK_BOOTTIME,
+	 .type = &clk_boottime,
 	 .exp_err = EINVAL,
 	 },
 	{				/* case 11: CLOCK_PROCESS_CPUTIME_ID  */
-	 .type = CLOCK_PROCESS_CPUTIME_ID,
+	 .type = &clk_process_cputime_id,
 	 .exp_err = EINVAL,
 	 },
 	{				/* case 12: CLOCK_THREAD_CPUTIME_ID   */
-	 .type = CLOCK_THREAD_CPUTIME_ID,
+	 .type = &clk_thread_cputime_id,
 	 .exp_err = EINVAL,
 	 },
 };
@@ -106,6 +115,9 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 
 	bad_addr = tst_get_bad_addr(NULL);
+
+	max_clocks1 = tst_get_max_clocks();
+	max_clocks2 = max_clocks1 + 1;
 }
 
 static void verify_clock_settime(unsigned int i)
@@ -137,23 +149,23 @@ static void verify_clock_settime(unsigned int i)
 	else
 		ts = tst_ts_get(&spec);
 
-	TEST(tv->clock_settime(tc[i].type, ts));
+	TEST(tv->clock_settime(*tc[i].type, ts));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL | TTERRNO, "clock_settime(2): clock %s passed unexpectedly, expected %s",
-			tst_clock_name(tc[i].type),
+			tst_clock_name(*tc[i].type),
 			tst_strerrno(tc[i].exp_err));
 		return;
 	}
 
 	if (tc[i].exp_err == TST_ERR) {
 		tst_res(TPASS | TTERRNO, "clock_settime(%s): failed as expected",
-			tst_clock_name(tc[i].type));
+			tst_clock_name(*tc[i].type));
 		return;
 	}
 
 	tst_res(TFAIL | TTERRNO, "clock_settime(2): clock %s " "expected to fail with %s",
-		tst_clock_name(tc[i].type), tst_strerrno(tc[i].exp_err));
+		tst_clock_name(*tc[i].type), tst_strerrno(tc[i].exp_err));
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/timer_create/timer_create02.c b/testcases/kernel/syscalls/timer_create/timer_create02.c
index af3a5203e..eda8d5477 100644
--- a/testcases/kernel/syscalls/timer_create/timer_create02.c
+++ b/testcases/kernel/syscalls/timer_create/timer_create02.c
@@ -25,6 +25,7 @@
 #include <signal.h>
 #include "tst_test.h"
 #include "lapi/common_timers.h"
+#include "tst_safe_clocks.h"
 
 static struct sigevent sig_ev = {
 	.sigev_notify = SIGEV_NONE,
@@ -42,26 +43,28 @@ static struct sigevent sig_ev_inv_sig = {
 };
 
 static kernel_timer_t timer_id;
+static clock_t max_clocks;
+static clock_t clk_realtime = CLOCK_REALTIME;
 
 static struct testcase {
-	clock_t clock;
+	clock_t *clock;
 	struct sigevent	*ev_ptr;
 	kernel_timer_t	*kt_ptr;
 	int		error;
 	char		*desc;
 } tcases[] = {
-	{CLOCK_REALTIME, NULL, &timer_id, EFAULT, "invalid sigevent struct"},
-	{CLOCK_REALTIME, &sig_ev, NULL, EFAULT, "invalid timer ID"},
-	{TST_MAX_CLOCKS, &sig_ev, &timer_id, EINVAL, "invalid clock"},
-	{CLOCK_REALTIME, &sig_ev_inv_not, &timer_id, EINVAL, "wrong sigev_notify"},
-	{CLOCK_REALTIME, &sig_ev_inv_sig, &timer_id, EINVAL, "wrong sigev_signo"},
+	{&clk_realtime, NULL, &timer_id, EFAULT, "invalid sigevent struct"},
+	{&clk_realtime, &sig_ev, NULL, EFAULT, "invalid timer ID"},
+	{&max_clocks, &sig_ev, &timer_id, EINVAL, "invalid clock"},
+	{&clk_realtime, &sig_ev_inv_not, &timer_id, EINVAL, "wrong sigev_notify"},
+	{&clk_realtime, &sig_ev_inv_sig, &timer_id, EINVAL, "wrong sigev_signo"},
 };
 
 static void run(unsigned int n)
 {
 	struct testcase *tc = &tcases[n];
 
-	TEST(tst_syscall(__NR_timer_create, tc->clock, tc->ev_ptr, tc->kt_ptr));
+	TEST(tst_syscall(__NR_timer_create, *tc->clock, tc->ev_ptr, tc->kt_ptr));
 
 	if (TST_RET != -1 || TST_ERR != tc->error) {
 		tst_res(TFAIL | TTERRNO,
@@ -84,6 +87,8 @@ static void setup(void)
 		if (!tcases[i].kt_ptr)
 			tcases[i].kt_ptr = tst_get_bad_addr(NULL);
 	}
+
+	max_clocks = tst_get_max_clocks();
 }
 
 static struct tst_test test = {
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
