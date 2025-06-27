Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD52C7EE31
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 11:18:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFE833C7ABD
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 13:18:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E73D3C6CC1
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 13:17:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1ECCD1000926
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 13:17:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7461321179;
 Fri, 27 Jun 2025 11:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751023072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mw/KdHRBKj3ml7H8yuRMyfC9HkiBOsFek8DszXEwd0s=;
 b=WwwNLfdQpyLeYY4O6guds9EZWXmKRJbH3KfAIwbml8D41WQyomtb+WB718fZHL+K6vQRL3
 r4qTRW7s+GEIR0xTxnRlkpL4jkHOlkD/gGc8IzjAqpgA097sLDPD6cJ+2uRZHC1NUJ7m3h
 lb9B4q3Wy5hlR65Vehm5BhqXGv31flQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751023072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mw/KdHRBKj3ml7H8yuRMyfC9HkiBOsFek8DszXEwd0s=;
 b=SALDuXfdVWamhxEBl980y/TvEz8dIYxV1HrWUk4KZKcbXz+6qY8ZvxJxbBxixHoSkwmmL+
 9nptvoQ67O4khdBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WwwNLfdQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SALDuXfd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751023072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mw/KdHRBKj3ml7H8yuRMyfC9HkiBOsFek8DszXEwd0s=;
 b=WwwNLfdQpyLeYY4O6guds9EZWXmKRJbH3KfAIwbml8D41WQyomtb+WB718fZHL+K6vQRL3
 r4qTRW7s+GEIR0xTxnRlkpL4jkHOlkD/gGc8IzjAqpgA097sLDPD6cJ+2uRZHC1NUJ7m3h
 lb9B4q3Wy5hlR65Vehm5BhqXGv31flQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751023072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mw/KdHRBKj3ml7H8yuRMyfC9HkiBOsFek8DszXEwd0s=;
 b=SALDuXfdVWamhxEBl980y/TvEz8dIYxV1HrWUk4KZKcbXz+6qY8ZvxJxbBxixHoSkwmmL+
 9nptvoQ67O4khdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A0F5138A7;
 Fri, 27 Jun 2025 11:17:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MHpQFOB9Xmh3EwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 27 Jun 2025 11:17:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 27 Jun 2025 13:17:07 +0200
MIME-Version: 1.0
Message-Id: <20250627-clock_nanosleep05-v1-1-1357109a2c81@suse.com>
X-B4-Tracking: v=1; b=H4sIALJ9XmgC/x3MQQqAIBBA0avErBOmCVt0lYhQG2soNBQikO6et
 HyL/wtkTsIZxqZA4luyxFDRtQ243YSNlazVQEgaB0LlzuiOJZgQ88l8oVYD2t55azR5htpdib0
 8/3Oa3/cDF6DxIWMAAAA=
X-Change-ID: 20250620-clock_nanosleep05-60b3cfba52fe
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751023028; l=7320;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=46wXO+TiRg9qutjKj1C1i6Igh7jr6KyYxTduQc2ebOM=;
 b=JSYwWLJQKAtthAS16X0rOemGJS+hAv6ACdsCIeyrJk6BMXtP2kIOSu08tsDN5Wr7kIteR0KH9
 icIqN3D1xFaC9p4lW8OLMJKWeAF0zRnJYVKCRBGxDxFCSpiqj5dT4tR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7461321179
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add clock_settime04 test
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
on a relative clock_nanosleep().

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Both clock_settime_7-1 and clock_settime_8-1 are affected by the
same bug which is probably related to the way tests are written.

sleep() is used by the parent and is not reliable. It can oversleep
or undersleep according to system overload or signals which are
received. And we never check for its return value. Using
clock_nanosleep would make parent more reliable in this case.

At the same time, the test is taking for granted a certain
synchronization between child and parent, which is not always true
in case of system overload.

My suggestion is to rewrite the test using LTP, which has better
timing handling (see tst_timer.h).
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/clock_settime/.gitignore |   1 +
 .../syscalls/clock_settime/clock_settime04.c       | 170 +++++++++++++++++++++
 3 files changed, 172 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d5582ca8da01f11adba75a56d22cb6e5c4996c68..2dc734c5537f1d5477f4c98d08b9717fb89ac05c 100644
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
index 0000000000000000000000000000000000000000..6050fb3c6dabe81116d4a3697605d8137691458a
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime04.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that changing the value of the CLOCK_REALTIME clock via
+ * clock_settime() shall have no effect on a thread that is blocked on
+ * absolute clock_nanosleep().
+ */
+
+#include "tst_test.h"
+#include "tst_timer.h"
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
+		.clock_gettime = libc_clock_gettime,
+		.clock_settime = libc_clock_settime,
+		.clock_nanosleep = libc_clock_nanosleep,
+		.ts_type = TST_LIBC_TIMESPEC,
+		.desc = "vDSO or syscall with libc spec"
+	},
+
+#if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
+	{
+		.clock_gettime = sys_clock_gettime,
+		.clock_settime = sys_clock_settime,
+		.clock_nanosleep = sys_clock_nanosleep,
+		.ts_type = TST_KERN_OLD_TIMESPEC,
+		.desc = "syscall with old kernel spec"
+	},
+#endif
+
+#if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
+	{
+		.clock_gettime = sys_clock_gettime64,
+		.clock_settime = sys_clock_settime64,
+		.clock_nanosleep = sys_clock_nanosleep64,
+		.ts_type = TST_KERN_TIMESPEC,
+		.desc = "syscall time64 with kernel spec"
+	},
+#endif
+};
+
+static void child_nanosleep(struct time64_variants *tv, unsigned int tc_index)
+{
+	long long delta;
+
+	if (tc_index) {
+		tst_res(TINFO, "Using absolute time sleep");
+
+		*sleep_child = tst_ts_add_us(*begin, CHILD_SLEEP_US);
+
+		TST_CHECKPOINT_WAKE(0);
+
+		TEST(tv->clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME,
+				  tst_ts_get(sleep_child), NULL));
+		if (TST_RET)
+			tst_brk(TBROK | TERRNO, "clock_nanosleep() error");
+	} else {
+		tst_res(TINFO, "Using relative time sleep");
+
+		tst_ts_set_sec(sleep_child, 0);
+		tst_ts_set_nsec(sleep_child, 0);
+
+		*sleep_child = tst_ts_add_us(*sleep_child, CHILD_SLEEP_US);
+
+		TST_CHECKPOINT_WAKE(0);
+
+		TEST(tv->clock_nanosleep(CLOCK_REALTIME, 0,
+				tst_ts_get(sleep_child), NULL));
+		if (TST_RET)
+			tst_brk(TBROK | TERRNO, "clock_nanosleep() error");
+
+		/* normalize to absolute time so we can compare times later on */
+		*sleep_child = tst_ts_add_us(*begin, CHILD_SLEEP_US - PARENT_SLEEP_US);
+	}
+
+	TEST(tv->clock_gettime(CLOCK_REALTIME, tst_ts_get(end)));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "clock_gettime() error");
+
+	if (tst_ts_lt(*end, *sleep_child)) {
+		tst_res(TFAIL, "clock_settime() didn't sleep enough. "
+			"end=%lld < sleep=%lld", tst_ts_get_sec(*end),
+			tst_ts_get_sec(*sleep_child));
+		return;
+	}
+
+	delta = tst_ts_abs_diff_us(*sleep_child, *end);
+	if (delta > DELTA_US) {
+		tst_res(TFAIL, "clock_settime() affected child sleep. "
+			"end=%lld <= sleep=%lld", tst_ts_get_nsec(*end),
+			tst_ts_get_nsec(*sleep_child));
+		return;
+	}
+
+	tst_res(TPASS, "clock_settime() didn't affect child sleep "
+		"(delta time: %lld us)", delta);
+}
+
+static void run(unsigned int tc_index)
+{
+	struct time64_variants *tv = &variants[tst_variant];
+
+	TEST(tv->clock_gettime(CLOCK_REALTIME, tst_ts_get(begin)));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "clock_gettime() error");
+
+	if (!SAFE_FORK()) {
+		child_nanosleep(tv, tc_index);
+		exit(0);
+	}
+
+	*sleep_parent = tst_ts_add_us(*begin, PARENT_SLEEP_US);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	TEST(tv->clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME,
+			  tst_ts_get(sleep_parent), NULL));
+	if (TST_RET)
+		tst_brk(TBROK | TERRNO, "clock_nanosleep() error");
+
+	TEST(tv->clock_settime(CLOCK_REALTIME, tst_ts_get(begin)));
+	if (TST_RET)
+		tst_brk(TBROK | TERRNO, "clock_settime() error");
+
+	tst_reap_children();
+
+	/* restore initial clock */
+	*end = tst_ts_sub_us(*begin, PARENT_SLEEP_US);
+
+	TEST(tv->clock_settime(CLOCK_REALTIME, tst_ts_get(end)));
+	if (TST_RET)
+		tst_brk(TBROK | TERRNO, "clock_settime() error");
+}
+
+static void setup(void)
+{
+	begin->type = end->type = sleep_child->type = sleep_parent->type =
+		variants[tst_variant].ts_type;
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
+	.needs_checkpoints = 1,
+	.test_variants = ARRAY_SIZE(variants),
+	.bufs = (struct tst_buffers []) {
+		{&begin, .size = sizeof(struct tst_ts)},
+		{&sleep_child, .size = sizeof(struct tst_ts)},
+		{&sleep_parent, .size = sizeof(struct tst_ts)},
+		{&end, .size = sizeof(struct tst_ts)},
+		{},
+	}
+};

---
base-commit: df591113afeb31107bc45bd5ba28a99b556d1028
change-id: 20250620-clock_nanosleep05-60b3cfba52fe

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
