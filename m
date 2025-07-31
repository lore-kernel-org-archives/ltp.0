Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4729AC87FCC
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 11:46:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3CE23CBE60
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 13:46:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A84CD3CB1A6
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 13:46:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFB5A1400247
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 13:46:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C23A41F7F3;
 Thu, 31 Jul 2025 11:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753962391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nU9qDAox2J6XVZ/C+A8wXA3z39YdTv+hk8BUVrDqIAs=;
 b=FcY7iIJq8onDkh0/gpjuWZmVdJsSu8EmwMfhxZKRWYHAKAoQSafs+0vCWQqv7qY4gAh/ar
 675uGd3yRJ5akoJ+yoLHrgAfArt36LBevIsn0Qo2I0VM2TLtAedO6AdBKqDQs5mK42SRbL
 XuQEwfgt2pR9k5cZ4wkd0YGlOd2XR8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753962391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nU9qDAox2J6XVZ/C+A8wXA3z39YdTv+hk8BUVrDqIAs=;
 b=jlLwqRehAPnbl1uVPP3V2orL8gWscpo/qQyGoJPcOfK2EsCi10SEGNyHS0RZCzTADk2NBN
 MtBv9o1p8jlAtiAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FcY7iIJq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jlLwqReh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753962391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nU9qDAox2J6XVZ/C+A8wXA3z39YdTv+hk8BUVrDqIAs=;
 b=FcY7iIJq8onDkh0/gpjuWZmVdJsSu8EmwMfhxZKRWYHAKAoQSafs+0vCWQqv7qY4gAh/ar
 675uGd3yRJ5akoJ+yoLHrgAfArt36LBevIsn0Qo2I0VM2TLtAedO6AdBKqDQs5mK42SRbL
 XuQEwfgt2pR9k5cZ4wkd0YGlOd2XR8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753962391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nU9qDAox2J6XVZ/C+A8wXA3z39YdTv+hk8BUVrDqIAs=;
 b=jlLwqRehAPnbl1uVPP3V2orL8gWscpo/qQyGoJPcOfK2EsCi10SEGNyHS0RZCzTADk2NBN
 MtBv9o1p8jlAtiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AC9B13A8A;
 Thu, 31 Jul 2025 11:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kKEeI5dXi2h2SgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 31 Jul 2025 11:46:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 31 Jul 2025 13:46:26 +0200
MIME-Version: 1.0
Message-Id: <20250731-clock_nanosleep05-v5-2-0118cf6b2454@suse.com>
References: <20250731-clock_nanosleep05-v5-0-0118cf6b2454@suse.com>
In-Reply-To: <20250731-clock_nanosleep05-v5-0-0118cf6b2454@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753962391; l=6202;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=uy9MeTKl4w6E6GhD+X2pdqzMfG6AamCxdO59jClkcMs=;
 b=Jkbvddip3fGb/M8AxudIUU4rjXT1tKCiE8tlV/Q8Shd0lmstqY4xqkmUwgHZ9Yr+wTNp32pGU
 K3ZynpgkyZmBWK6ivmLmkvlFYn1cwlotq5uRXq9JWjsmYpInvTYD3JU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: C23A41F7F3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] Add clock_settime04 test
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
 .../syscalls/clock_settime/clock_settime04.c       | 160 +++++++++++++++++++++
 3 files changed, 162 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index f15331da3711ec3fe19baed10efb5fe21dfa0e0d..6a17a34f8b5fc1289947d4504b7a146f3d022f1c 100644
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
index 0000000000000000000000000000000000000000..6326c96e62d6914ac924f65b817153d56108fb08
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime04.c
@@ -0,0 +1,160 @@
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
+		.clock_settime = libc_clock_settime,
+		.clock_gettime = libc_clock_gettime,
+		.ts_type = TST_LIBC_TIMESPEC,
+		.desc = "vDSO or syscall with libc spec"
+	},
+
+#if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
+	{
+		.clock_nanosleep = sys_clock_nanosleep,
+		.clock_settime = sys_clock_settime,
+		.clock_gettime = sys_clock_gettime,
+		.ts_type = TST_KERN_OLD_TIMESPEC,
+		.desc = "syscall with old kernel spec"
+	},
+#endif
+
+#if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
+	{
+		.clock_nanosleep = sys_clock_nanosleep64,
+		.clock_settime = sys_clock_settime64,
+		.clock_gettime = sys_clock_gettime64,
+		.ts_type = TST_KERN_TIMESPEC,
+		.desc = "syscall time64 with kernel spec"
+	},
+#endif
+};
+
+static void child_nanosleep(struct time64_variants *tv, const int flags)
+{
+	int ret;
+	long long delta;
+
+	ret = tv->clock_gettime(CLOCK_MONOTONIC, tst_ts_get(begin));
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "clock_gettime() failed");
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
+	ret = tv->clock_gettime(CLOCK_MONOTONIC, tst_ts_get(end));
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "clock_gettime() failed");
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
+	int ret;
+	struct time64_variants *tv = &variants[tst_variant];
+
+	if (!SAFE_FORK()) {
+		child_nanosleep(tv, tc_index ? TIMER_ABSTIME : 0);
+		exit(0);
+	}
+
+	ret = tv->clock_gettime(CLOCK_REALTIME, tst_ts_get(begin));
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "clock_gettime() failed");
+
+	ret = tv->clock_nanosleep(CLOCK_REALTIME, 0, tst_ts_get(sleep_parent), NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "clock_nanosleep() failed");
+
+	ret = tv->clock_settime(CLOCK_REALTIME, tst_ts_get(begin));
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "clock_settime() failed");
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
