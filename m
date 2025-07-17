Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3801C83F1A
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 09:45:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 899003CC16E
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 11:45:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FC593CC204
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:45:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A58406006F6
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:45:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1451B1F7E1;
 Thu, 17 Jul 2025 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752745494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YkIAGtpCUEEoPIKNXRC026xY8BAZvCdBD227i0K4HpU=;
 b=PJSomxNwmtpjuRlP1607z2FXOOmcavVdcTFUhc1Do+BpiyYCVsjmUBXTpiP3cDo8VbfZmS
 nSwaJswvrpZ2zi+/y0ObX2+fvwgxjrI0vd1JmQOU9k8MVeojiX+zdtMVXy3mlwQtlz8WUa
 xTyHO3sl7BzcmTeidLYlLDTgw8AfXy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752745494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YkIAGtpCUEEoPIKNXRC026xY8BAZvCdBD227i0K4HpU=;
 b=c0/e5SgmCt+5REPbZ6LOR8s/+7BVDy2ioLwR8fpuouE3WBBCZR6Nm3EoN/ioplbsWQbmud
 JblrGkZMgYOYFpAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752745494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YkIAGtpCUEEoPIKNXRC026xY8BAZvCdBD227i0K4HpU=;
 b=PJSomxNwmtpjuRlP1607z2FXOOmcavVdcTFUhc1Do+BpiyYCVsjmUBXTpiP3cDo8VbfZmS
 nSwaJswvrpZ2zi+/y0ObX2+fvwgxjrI0vd1JmQOU9k8MVeojiX+zdtMVXy3mlwQtlz8WUa
 xTyHO3sl7BzcmTeidLYlLDTgw8AfXy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752745494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YkIAGtpCUEEoPIKNXRC026xY8BAZvCdBD227i0K4HpU=;
 b=c0/e5SgmCt+5REPbZ6LOR8s/+7BVDy2ioLwR8fpuouE3WBBCZR6Nm3EoN/ioplbsWQbmud
 JblrGkZMgYOYFpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB70C13A88;
 Thu, 17 Jul 2025 09:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2LivNxXGeGi2XAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 17 Jul 2025 09:44:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 17 Jul 2025 11:44:53 +0200
MIME-Version: 1.0
Message-Id: <20250717-clock_nanosleep05-v4-2-78bc62df960f@suse.com>
References: <20250717-clock_nanosleep05-v4-0-78bc62df960f@suse.com>
In-Reply-To: <20250717-clock_nanosleep05-v4-0-78bc62df960f@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752745493; l=5534;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=fSuN+ZSXi14GGfb/iXHg4xNTJyr3PfgTnHeU+KKtm0Q=;
 b=XKOKdcIqIcXwhrEmnDWuXT3FYFZuEOVvDpjBnqMkykry2Fk+UcPTbQxnbxsaqlmWC+Gr9dZuG
 VEhRHFQEPk3BIVDKre2NLAF/FrMyk4gYkP+b1SZQCP6cw2j6SnB2W03
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] Add clock_settime04 test
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

Test that changing the value of the CLOCK_REALTIME clock via
clock_settime(2) shall have no effect on a thread that is blocked
on a relative/absolute clock_nanosleep().

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/clock_settime/.gitignore |   1 +
 .../syscalls/clock_settime/clock_settime04.c       | 140 +++++++++++++++++++++
 3 files changed, 142 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index e738c332bf973840e6cc0bde489882eb65018991..5f392e4845e9ac7bcda30065997a5e6a7fb56945 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -112,6 +112,7 @@ leapsec01 leapsec01
 clock_settime01 clock_settime01
 clock_settime02 clock_settime02
 clock_settime03 clock_settime03
+clock_settime04 clock_settime04
 
 clone01 clone01
 clone02 clone02
diff --git a/testcases/kernel/syscalls/clock_settime/.gitignore b/testcases/kernel/syscalls/clock_settime/.gitignore
index b66169b3eb7b4d8c8ea95e9e689b612d8da37b11..8bcc83d6fc9162087e99193a00b8d3d784d4737d 100644
--- a/testcases/kernel/syscalls/clock_settime/.gitignore
+++ b/testcases/kernel/syscalls/clock_settime/.gitignore
@@ -1,3 +1,4 @@
 clock_settime01
 clock_settime02
 clock_settime03
+clock_settime04
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime04.c b/testcases/kernel/syscalls/clock_settime/clock_settime04.c
new file mode 100644
index 0000000000000000000000000000000000000000..6372b038e18fbab94f2dc34b6745137eeb7dc578
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime04.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that changing the value of the CLOCK_REALTIME clock via
+ * clock_settime() shall have no effect on a thread that is blocked on
+ * absolute/relative clock_nanosleep().
+ */
+
+#include "tst_test.h"
+#include "tst_timer.h"
+#include "tst_safe_clocks.h"
+#include "time64_variants.h"
+
+#define SEC_TO_US(x)     (x * 1000 * 1000)
+
+#define CHILD_SLEEP_US   SEC_TO_US(5)
+#define PARENT_SLEEP_US  SEC_TO_US(2)
+#define DELTA_US         SEC_TO_US(1)
+
+static struct tst_ts *begin, *sleep_child, *sleep_parent, *end;
+
+static struct time64_variants variants[] = {
+	{
+		.clock_nanosleep = libc_clock_nanosleep,
+		.ts_type = TST_LIBC_TIMESPEC,
+		.desc = "vDSO or syscall with libc spec"
+	},
+
+#if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
+	{
+		.clock_nanosleep = sys_clock_nanosleep,
+		.ts_type = TST_KERN_OLD_TIMESPEC,
+		.desc = "syscall with old kernel spec"
+	},
+#endif
+
+#if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
+	{
+		.clock_nanosleep = sys_clock_nanosleep64,
+		.ts_type = TST_KERN_TIMESPEC,
+		.desc = "syscall time64 with kernel spec"
+	},
+#endif
+};
+
+static void child_nanosleep(struct time64_variants *tv, const int flags)
+{
+	long long delta;
+
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, tst_ts_get(begin));
+
+	if (flags & TIMER_ABSTIME) {
+		tst_res(TINFO, "Using absolute time sleep");
+
+		*sleep_child = tst_ts_add_us(*begin, CHILD_SLEEP_US);
+	} else {
+		tst_res(TINFO, "Using relative time sleep");
+
+		tst_ts_set_sec(sleep_child, 0);
+		tst_ts_set_nsec(sleep_child, 0);
+
+		*sleep_child = tst_ts_add_us(*sleep_child, CHILD_SLEEP_US);
+	}
+
+	TEST(tv->clock_nanosleep(CLOCK_REALTIME, flags, tst_ts_get(sleep_child), NULL));
+	if (TST_RET)
+		tst_brk(TBROK | TERRNO, "clock_nanosleep() error");
+
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, tst_ts_get(end));
+
+	if (tst_ts_lt(*end, *begin)) {
+		tst_res(TFAIL, "clock_settime() didn't sleep enough. "
+			"begin: %lld ms >= end: %lld ms",
+			tst_ts_to_ms(*begin),
+			tst_ts_to_ms(*end));
+		return;
+	}
+
+	delta = tst_ts_abs_diff_us(*begin, *end);
+	if (!(flags & TIMER_ABSTIME))
+		delta -= CHILD_SLEEP_US;
+
+	if (delta > DELTA_US) {
+		tst_res(TFAIL, "parent clock_settime() affected child sleep. "
+			"begin: %lld ms, end: %lld ms",
+			tst_ts_to_ms(*begin),
+			tst_ts_to_ms(*end));
+		return;
+	}
+
+	tst_res(TPASS, "parent clock_settime() didn't affect child sleep "
+		"(delta time: %lld us)", delta);
+}
+
+static void run(unsigned int tc_index)
+{
+	struct time64_variants *tv = &variants[tst_variant];
+
+	if (!SAFE_FORK()) {
+		child_nanosleep(tv, tc_index ? TIMER_ABSTIME : 0);
+		exit(0);
+	}
+
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, tst_ts_get(begin));
+	SAFE_CLOCK_NANOSLEEP(CLOCK_REALTIME, 0, tst_ts_get(sleep_parent), NULL);
+	SAFE_CLOCK_SETTIME(CLOCK_REALTIME, tst_ts_get(begin));
+}
+
+static void setup(void)
+{
+	begin->type = end->type = sleep_child->type = sleep_parent->type =
+		variants[tst_variant].ts_type;
+
+	tst_ts_set_sec(sleep_parent, 0);
+	tst_ts_set_nsec(sleep_parent, 0);
+
+	*sleep_parent = tst_ts_add_us(*sleep_parent, PARENT_SLEEP_US);
+
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.tcnt = 2,
+	.needs_root = 1,
+	.forks_child = 1,
+	.restore_wallclock = 1,
+	.test_variants = ARRAY_SIZE(variants),
+	.bufs = (struct tst_buffers []) {
+		{&sleep_child, .size = sizeof(struct tst_ts)},
+		{&sleep_parent, .size = sizeof(struct tst_ts)},
+		{&begin, .size = sizeof(struct tst_ts)},
+		{&end, .size = sizeof(struct tst_ts)},
+		{},
+	}
+};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
