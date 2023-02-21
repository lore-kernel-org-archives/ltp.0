Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22970C61DA3
	for <ltp@archiver.kernel.org>; Tue, 21 Feb 2023 01:36:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2DFC3CBDBB
	for <ltp@archiver.kernel.org>; Tue, 21 Feb 2023 02:36:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6081C3CBD0C
 for <ltp@lists.linux.it>; Tue, 21 Feb 2023 02:35:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 931471400968
 for <ltp@lists.linux.it>; Tue, 21 Feb 2023 02:35:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EA9BA5BD17;
 Tue, 21 Feb 2023 01:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676943340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FZMnLGVUNhhUi81za9GOL7UTjDJR1L13awROuvxgp+w=;
 b=Su+vyehcVxYS4cxD8HuukVUCvxyfg14fa8YWwlkgbXRGnYkqc5fwcPln1wU4rZ/VmB04yT
 NsSHMZLyhLCXkXAMwdYAdEEVrH5I/6WQ5DiiCC2X4OQNY5ag84NztKIzkKLWK/VbUGnRBA
 KqzShD7PGuVpF8c9zQVNnWnCktAl9SU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0B1013A2F;
 Tue, 21 Feb 2023 01:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +A2/HOof9GPNWgAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 21 Feb 2023 01:35:38 +0000
To: ltp@lists.linux.it
Date: Mon, 20 Feb 2023 20:34:46 -0500
Message-Id: <20230221013446.19399-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230221013446.19399-1-wegao@suse.com>
References: <20230215023438.11370-1-wegao@suse.com>
 <20230221013446.19399-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] rseq01: basic test rseq
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/lapi/rseq.h                       | 313 ++++++++++++++++++++++
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/rseq/.gitignore |   1 +
 testcases/kernel/syscalls/rseq/Makefile   |  10 +
 testcases/kernel/syscalls/rseq/rseq01.c   |  55 ++++
 5 files changed, 381 insertions(+)
 create mode 100644 include/lapi/rseq.h
 create mode 100644 testcases/kernel/syscalls/rseq/.gitignore
 create mode 100644 testcases/kernel/syscalls/rseq/Makefile
 create mode 100644 testcases/kernel/syscalls/rseq/rseq01.c

diff --git a/include/lapi/rseq.h b/include/lapi/rseq.h
new file mode 100644
index 000000000..5fb29f85f
--- /dev/null
+++ b/include/lapi/rseq.h
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * rseq.h
+ *
+ * Copyright (C) 2016 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ *
+ */
+
+#ifndef LAPI_RSEQ_H__
+#define LAPI_RSEQ_H__
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <syscall.h>
+#include <assert.h>
+#include <signal.h>
+#include <limits.h>
+#include <dlfcn.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <pthread.h>
+#include <signal.h>
+#include <sched.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stddef.h>
+#include "rseq-abi.h"
+#include "compiler.h"
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/rseq-thread-pointer.h"
+
+/*
+ * Empty code injection macros, override when testing.
+ * It is important to consider that the ASM injection macros need to be
+ * fully reentrant (e.g. do not modify the stack).
+ */
+#ifndef RSEQ_INJECT_ASM
+#define RSEQ_INJECT_ASM(n)
+#endif
+
+#ifndef RSEQ_INJECT_C
+#define RSEQ_INJECT_C(n)
+#endif
+
+#ifndef RSEQ_INJECT_INPUT
+#define RSEQ_INJECT_INPUT
+#endif
+
+#ifndef RSEQ_INJECT_CLOBBER
+#define RSEQ_INJECT_CLOBBER
+#endif
+
+#ifndef RSEQ_INJECT_FAILED
+#define RSEQ_INJECT_FAILED
+#endif
+
+
+/* Offset from the thread pointer to the rseq area.  */
+extern ptrdiff_t rseq_offset;
+/* Size of the registered rseq area.  0 if the registration was
+   unsuccessful.  */
+extern unsigned int rseq_size;
+/* Flags used during rseq registration.  */
+extern unsigned int rseq_flags;
+
+static inline struct rseq_abi *rseq_get_abi(void)
+{
+	return (struct rseq_abi *) ((uintptr_t) rseq_thread_pointer() + rseq_offset);
+}
+
+#define rseq_likely(x)		__builtin_expect(!!(x), 1)
+#define rseq_unlikely(x)	__builtin_expect(!!(x), 0)
+#define rseq_barrier()		__asm__ __volatile__("" : : : "memory")
+
+#define RSEQ_ACCESS_ONCE(x)	(*(__volatile__  __typeof__(x) *)&(x))
+#define RSEQ_WRITE_ONCE(x, v)	__extension__ ({ RSEQ_ACCESS_ONCE(x) = (v); })
+#define RSEQ_READ_ONCE(x)	RSEQ_ACCESS_ONCE(x)
+
+#define __rseq_str_1(x)	#x
+#define __rseq_str(x)		__rseq_str_1(x)
+
+#define rseq_log(fmt, args...)						       \
+	fprintf(stderr, fmt "(in %s() at " __FILE__ ":" __rseq_str(__LINE__)"\n", \
+		## args, __func__)
+
+#define rseq_bug(fmt, args...)		\
+	do {				\
+		rseq_log(fmt, ##args);	\
+		abort();		\
+	} while (0)
+
+#if defined(__x86_64__) || defined(__i386__)
+#include "lapi/rseq-x86.h"
+#elif defined(__ARMEL__)
+#include "lapi/rseq-arm.h"
+#elif defined (__AARCH64EL__)
+#include "lapi/rseq-arm64.h"
+#elif defined(__PPC__)
+#include "lapi/rseq-ppc.h"
+#elif defined(__mips__)
+#include "lapi/rseq-mips.h"
+#elif defined(__s390__)
+#include "lapi/rseq-s390.h"
+#elif defined(__riscv)
+#include "lapi/rseq-riscv.h"
+#else
+#error unsupported target
+#endif
+
+/*
+ * Register rseq for the current thread. This needs to be called once
+ * by any thread which uses restartable sequences, before they start
+ * using restartable sequences, to ensure restartable sequences
+ * succeed. A restartable sequence executed from a non-registered
+ * thread will always fail.
+ */
+int rseq_register_current_thread(void);
+
+/*
+ * Unregister rseq for current thread.
+ */
+int rseq_unregister_current_thread(void);
+
+/*
+ * Restartable sequence fallback for reading the current CPU number.
+ */
+int32_t rseq_fallback_current_cpu(void);
+
+/*
+ * Values returned can be either the current CPU number, -1 (rseq is
+ * uninitialized), or -2 (rseq initialization has failed).
+ */
+static inline int32_t rseq_current_cpu_raw(void)
+{
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->cpu_id);
+}
+
+/*
+ * Returns a possible CPU number, which is typically the current CPU.
+ * The returned CPU number can be used to prepare for an rseq critical
+ * section, which will confirm whether the cpu number is indeed the
+ * current one, and whether rseq is initialized.
+ *
+ * The CPU number returned by rseq_cpu_start should always be validated
+ * by passing it to a rseq asm sequence, or by comparing it to the
+ * return value of rseq_current_cpu_raw() if the rseq asm sequence
+ * does not need to be invoked.
+ */
+static inline uint32_t rseq_cpu_start(void)
+{
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->cpu_id_start);
+}
+
+static inline uint32_t rseq_current_cpu(void)
+{
+	int32_t cpu;
+
+	cpu = rseq_current_cpu_raw();
+	if (rseq_unlikely(cpu < 0))
+		cpu = rseq_fallback_current_cpu();
+	return cpu;
+}
+
+static inline void rseq_clear_rseq_cs(void)
+{
+	RSEQ_WRITE_ONCE(rseq_get_abi()->rseq_cs.arch.ptr, 0);
+}
+
+/*
+ * rseq_prepare_unload() should be invoked by each thread executing a rseq
+ * critical section at least once between their last critical section and
+ * library unload of the library defining the rseq critical section (struct
+ * rseq_cs) or the code referred to by the struct rseq_cs start_ip and
+ * post_commit_offset fields. This also applies to use of rseq in code
+ * generated by JIT: rseq_prepare_unload() should be invoked at least once by
+ * each thread executing a rseq critical section before reclaim of the memory
+ * holding the struct rseq_cs or reclaim of the code pointed to by struct
+ * rseq_cs start_ip and post_commit_offset fields.
+ */
+static inline void rseq_prepare_unload(void)
+{
+	rseq_clear_rseq_cs();
+}
+
+static const ptrdiff_t *libc_rseq_offset_p;
+static const unsigned int *libc_rseq_size_p;
+static const unsigned int *libc_rseq_flags_p;
+
+/* Offset from the thread pointer to the rseq area.  */
+ptrdiff_t rseq_offset;
+
+/* Size of the registered rseq area.  0 if the registration was
+   unsuccessful.  */
+unsigned int rseq_size = -1U;
+
+/* Flags used during rseq registration.  */
+unsigned int rseq_flags;
+
+static int rseq_ownership;
+
+static
+__thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"))) = {
+	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
+};
+
+static int sys_rseq(struct rseq_abi *rseq_abi, uint32_t rseq_len,
+		    int flags, uint32_t sig)
+{
+	return tst_syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
+}
+
+int rseq_available(void)
+{
+	int rc;
+
+	rc = sys_rseq(NULL, 0, 0, 0);
+	if (rc != -1)
+		tst_brk(TFAIL | TTERRNO, "Unexpected rseq return value");
+	switch (errno) {
+	case ENOSYS:
+		return 0;
+	case EINVAL:
+		return 1;
+	default:
+		tst_brk(TFAIL | TTERRNO, "Unexpected rseq return value");
+	}
+	return 1;
+}
+
+int rseq_register_current_thread(void)
+{
+	int rc;
+
+	if (!rseq_ownership) {
+		/* Treat libc's ownership as a successful registration. */
+		return 0;
+	}
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), 0, RSEQ_SIG);
+	if (rc)
+		return -1;
+	TST_EXP_POSITIVE(rseq_current_cpu_raw());
+	return 0;
+}
+
+int rseq_unregister_current_thread(void)
+{
+	int rc;
+
+	if (!rseq_ownership) {
+		/* Treat libc's ownership as a successful unregistration. */
+		return 0;
+	}
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	if (rc)
+		return -1;
+	return 0;
+}
+
+static __attribute__((constructor))
+void rseq_init(void)
+{
+	libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
+	libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
+	libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
+	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p &&
+			*libc_rseq_size_p != 0) {
+		/* rseq registration owned by glibc */
+		rseq_offset = *libc_rseq_offset_p;
+		rseq_size = *libc_rseq_size_p;
+		rseq_flags = *libc_rseq_flags_p;
+		return;
+	}
+	if (!rseq_available())
+		return;
+	rseq_ownership = 1;
+	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
+	rseq_size = sizeof(struct rseq_abi);
+	rseq_flags = 0;
+}
+
+static __attribute__((destructor))
+void rseq_exit(void)
+{
+	if (!rseq_ownership)
+		return;
+	rseq_offset = 0;
+	rseq_size = -1U;
+	rseq_ownership = 0;
+}
+
+int32_t rseq_fallback_current_cpu(void)
+{
+	int32_t cpu;
+
+	cpu = sched_getcpu();
+	if (cpu < 0) {
+		tst_brk(TFAIL | TTERRNO, "sched_getcpu() failed");
+	}
+	return cpu;
+}
+
+#endif  /* LAPI_RSEQ_H__ */
+
diff --git a/runtest/syscalls b/runtest/syscalls
index ae37a1192..f46950b27 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1752,6 +1752,8 @@ copy_file_range01 copy_file_range01
 copy_file_range02 copy_file_range02
 copy_file_range03 copy_file_range03
 
+rseq01 rseq01
+
 statx01 statx01
 statx02 statx02
 statx03 statx03
diff --git a/testcases/kernel/syscalls/rseq/.gitignore b/testcases/kernel/syscalls/rseq/.gitignore
new file mode 100644
index 000000000..8a6c7ee36
--- /dev/null
+++ b/testcases/kernel/syscalls/rseq/.gitignore
@@ -0,0 +1 @@
+/rseq01
diff --git a/testcases/kernel/syscalls/rseq/Makefile b/testcases/kernel/syscalls/rseq/Makefile
new file mode 100644
index 000000000..2897fc581
--- /dev/null
+++ b/testcases/kernel/syscalls/rseq/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#  Copyright (C) 2012 Linux Test Project, Inc.
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+rseq01: CFLAGS += -lpthread -ldl
+
diff --git a/testcases/kernel/syscalls/rseq/rseq01.c b/testcases/kernel/syscalls/rseq/rseq01.c
new file mode 100644
index 000000000..35d2c2644
--- /dev/null
+++ b/testcases/kernel/syscalls/rseq/rseq01.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2016 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Restartable Sequences basic tests.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sched.h>
+#include "lapi/rseq.h"
+
+void test_cpu_pointer(void)
+{
+	cpu_set_t affinity, test_affinity;
+	int i;
+
+	sched_getaffinity(0, sizeof(affinity), &affinity);
+	CPU_ZERO(&test_affinity);
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (CPU_ISSET(i, &affinity)) {
+			CPU_SET(i, &test_affinity);
+			sched_setaffinity(0, sizeof(test_affinity),
+					&test_affinity);
+			TST_EXP_VAL(sched_getcpu(), i);
+			TST_EXP_VAL(rseq_current_cpu(), i);
+			TST_EXP_VAL(rseq_current_cpu_raw(), i);
+			TST_EXP_VAL(rseq_cpu_start(), i);
+			CPU_CLR(i, &test_affinity);
+		}
+	}
+	sched_setaffinity(0, sizeof(affinity), &affinity);
+}
+
+
+static void run(void)
+{
+	if (rseq_register_current_thread())
+		tst_brk(TFAIL | TTERRNO, "Error: rseq_register_current_thread(...) failed");
+
+	test_cpu_pointer();
+
+	if (rseq_unregister_current_thread())
+		tst_brk(TFAIL | TTERRNO, "Error: rseq_unregister_current_thread(...) failed");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
