Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FD6C61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 08:16:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4130A3CD878
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 09:16:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C977C3CB1A1
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 09:16:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4CF251A00E0E
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 09:16:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97EFF21AA7;
 Thu,  9 Mar 2023 08:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678349773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dsEidH5s3MoEMgrJCGDftdYlPhPCj90nMjzejWFigg=;
 b=DK8ZHI5ldsbnT8S5Osl16BnI5lDOTql8LQ+OyXcT4sZ9zDrOP8CLGZvBRo0XX9Aw5AjF13
 tpb8FL3LSfceqiWIfoSiPjP5kpjxA3jyrPnSm7RjIfIhe7JwbFMDUfFGDYczkfCVYIn933
 bHOgoDQRL08N9Oj66eC9/wn8LCJHW/g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D56C013A10;
 Thu,  9 Mar 2023 08:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AcZ9K8yVCWRTZAAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 09 Mar 2023 08:16:12 +0000
To: ltp@lists.linux.it
Date: Thu,  9 Mar 2023 03:16:08 -0500
Message-Id: <20230309081608.9493-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230309020403.20662-1-wegao@suse.com>
References: <20230309020403.20662-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] rseq01: basic test rseq
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
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/rseq/.gitignore     |   1 +
 testcases/kernel/syscalls/rseq/Makefile       |  10 +
 testcases/kernel/syscalls/rseq/rseq-abi.h     | 151 ++++++++
 .../syscalls/rseq/rseq-x86-thread-pointer.h   |  40 +++
 testcases/kernel/syscalls/rseq/rseq.h         | 221 ++++++++++++
 testcases/kernel/syscalls/rseq/rseq01.c       | 322 ++++++++++++++++++
 7 files changed, 747 insertions(+)
 create mode 100644 testcases/kernel/syscalls/rseq/.gitignore
 create mode 100644 testcases/kernel/syscalls/rseq/Makefile
 create mode 100644 testcases/kernel/syscalls/rseq/rseq-abi.h
 create mode 100644 testcases/kernel/syscalls/rseq/rseq-x86-thread-pointer.h
 create mode 100644 testcases/kernel/syscalls/rseq/rseq.h
 create mode 100644 testcases/kernel/syscalls/rseq/rseq01.c

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
diff --git a/testcases/kernel/syscalls/rseq/rseq-abi.h b/testcases/kernel/syscalls/rseq/rseq-abi.h
new file mode 100644
index 000000000..a8c44d9af
--- /dev/null
+++ b/testcases/kernel/syscalls/rseq/rseq-abi.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _RSEQ_ABI_H
+#define _RSEQ_ABI_H
+
+/*
+ * rseq-abi.h
+ *
+ * Restartable sequences system call API
+ *
+ * Copyright (c) 2015-2022 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+enum rseq_abi_cpu_id_state {
+	RSEQ_ABI_CPU_ID_UNINITIALIZED			= -1,
+	RSEQ_ABI_CPU_ID_REGISTRATION_FAILED		= -2,
+};
+
+enum rseq_abi_flags {
+	RSEQ_ABI_FLAG_UNREGISTER = (1 << 0),
+};
+
+enum rseq_abi_cs_flags_bit {
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
+};
+
+enum rseq_abi_cs_flags {
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT),
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+};
+
+/*
+ * struct rseq_abi_cs is aligned on 4 * 8 bytes to ensure it is always
+ * contained within a single cache-line. It is usually declared as
+ * link-time constant data.
+ */
+struct rseq_abi_cs {
+	/* Version of this structure. */
+	__u32 version;
+	/* enum rseq_abi_cs_flags */
+	__u32 flags;
+	__u64 start_ip;
+	/* Offset from start_ip. */
+	__u64 post_commit_offset;
+	__u64 abort_ip;
+} __attribute__((aligned(4 * sizeof(__u64))));
+
+/*
+ * struct rseq_abi is aligned on 4 * 8 bytes to ensure it is always
+ * contained within a single cache-line.
+ *
+ * A single struct rseq_abi per thread is allowed.
+ */
+struct rseq_abi {
+	/*
+	 * Restartable sequences cpu_id_start field. Updated by the
+	 * kernel. Read by user-space with single-copy atomicity
+	 * semantics. This field should only be read by the thread which
+	 * registered this data structure. Aligned on 32-bit. Always
+	 * contains a value in the range of possible CPUs, although the
+	 * value may not be the actual current CPU (e.g. if rseq is not
+	 * initialized). This CPU number value should always be compared
+	 * against the value of the cpu_id field before performing a rseq
+	 * commit or returning a value read from a data structure indexed
+	 * using the cpu_id_start value.
+	 */
+	__u32 cpu_id_start;
+	/*
+	 * Restartable sequences cpu_id field. Updated by the kernel.
+	 * Read by user-space with single-copy atomicity semantics. This
+	 * field should only be read by the thread which registered this
+	 * data structure. Aligned on 32-bit. Values
+	 * RSEQ_CPU_ID_UNINITIALIZED and RSEQ_CPU_ID_REGISTRATION_FAILED
+	 * have a special semantic: the former means "rseq uninitialized",
+	 * and latter means "rseq initialization failed". This value is
+	 * meant to be read within rseq critical sections and compared
+	 * with the cpu_id_start value previously read, before performing
+	 * the commit instruction, or read and compared with the
+	 * cpu_id_start value before returning a value loaded from a data
+	 * structure indexed using the cpu_id_start value.
+	 */
+	__u32 cpu_id;
+	/*
+	 * Restartable sequences rseq_cs field.
+	 *
+	 * Contains NULL when no critical section is active for the current
+	 * thread, or holds a pointer to the currently active struct rseq_cs.
+	 *
+	 * Updated by user-space, which sets the address of the currently
+	 * active rseq_cs at the beginning of assembly instruction sequence
+	 * block, and set to NULL by the kernel when it restarts an assembly
+	 * instruction sequence block, as well as when the kernel detects that
+	 * it is preempting or delivering a signal outside of the range
+	 * targeted by the rseq_cs. Also needs to be set to NULL by user-space
+	 * before reclaiming memory that contains the targeted struct rseq_cs.
+	 *
+	 * Read and set by the kernel. Set by user-space with single-copy
+	 * atomicity semantics. This field should only be updated by the
+	 * thread which registered this data structure. Aligned on 64-bit.
+	 */
+	union {
+		__u64 ptr64;
+
+		/*
+		 * The "arch" field provides architecture accessor for
+		 * the ptr field based on architecture pointer size and
+		 * endianness.
+		 */
+		struct {
+#ifdef __LP64__
+			__u64 ptr;
+#elif defined(__BYTE_ORDER) ? (__BYTE_ORDER == __BIG_ENDIAN) : defined(__BIG_ENDIAN)
+			__u32 padding;		/* Initialized to zero. */
+			__u32 ptr;
+#else
+			__u32 ptr;
+			__u32 padding;		/* Initialized to zero. */
+#endif
+		} arch;
+	} rseq_cs;
+
+	/*
+	 * Restartable sequences flags field.
+	 *
+	 * This field should only be updated by the thread which
+	 * registered this data structure. Read by the kernel.
+	 * Mainly used for single-stepping through rseq critical sections
+	 * with debuggers.
+	 *
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT
+	 *     Inhibit instruction sequence block restart on preemption
+	 *     for this thread.
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL
+	 *     Inhibit instruction sequence block restart on signal
+	 *     delivery for this thread.
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE
+	 *     Inhibit instruction sequence block restart on migration for
+	 *     this thread.
+	 */
+	__u32 flags;
+} __attribute__((aligned(4 * sizeof(__u64))));
+
+#endif /* _RSEQ_ABI_H */
diff --git a/testcases/kernel/syscalls/rseq/rseq-x86-thread-pointer.h b/testcases/kernel/syscalls/rseq/rseq-x86-thread-pointer.h
new file mode 100644
index 000000000..d3133587d
--- /dev/null
+++ b/testcases/kernel/syscalls/rseq/rseq-x86-thread-pointer.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+/*
+ * rseq-x86-thread-pointer.h
+ *
+ * (C) Copyright 2021 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef _RSEQ_X86_THREAD_POINTER
+#define _RSEQ_X86_THREAD_POINTER
+
+#include <features.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#if __GNUC_PREREQ (11, 1)
+static inline void *rseq_thread_pointer(void)
+{
+	return __builtin_thread_pointer();
+}
+#else
+static inline void *rseq_thread_pointer(void)
+{
+	void *__result;
+
+# ifdef __x86_64__
+	__asm__ ("mov %%fs:0, %0" : "=r" (__result));
+# else
+	__asm__ ("mov %%gs:0, %0" : "=r" (__result));
+# endif
+	return __result;
+}
+#endif /* !GCC 11 */
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/testcases/kernel/syscalls/rseq/rseq.h b/testcases/kernel/syscalls/rseq/rseq.h
new file mode 100644
index 000000000..19d189546
--- /dev/null
+++ b/testcases/kernel/syscalls/rseq/rseq.h
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2016 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+#include <stdint.h>
+#include <dlfcn.h>
+
+#include "rseq-abi.h"
+#include "rseq-x86-thread-pointer.h"
+#include "lapi/syscalls.h"
+
+/*
+ * gcc prior to 4.8.2 miscompiles asm goto.
+ * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
+ *
+ * gcc prior to 8.1.0 miscompiles asm goto at O1.
+ * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=103908
+ *
+ * clang prior to version 13.0.1 miscompiles asm goto at O2.
+ * https://github.com/llvm/llvm-project/issues/52735
+ *
+ * Work around these issues by adding a volatile inline asm with
+ * memory clobber in the fallthrough after the asm goto and at each
+ * label target.  Emit this for all compilers in case other similar
+ * issues are found in the future.
+ */
+
+#define rseq_after_asm_goto()   asm volatile ("" : : : "memory")
+
+/* Offset from the thread pointer to the rseq area.  */
+extern ptrdiff_t rseq_offset;
+/* Size of the registered rseq area.  0 if the registration was
+ * unsuccessful.
+ */
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
+ * RSEQ_SIG is used with the following reserved undefined instructions, which
+ * trap in user-space:
+ *
+ * x86-32:    0f b9 3d 53 30 05 53      ud1    0x53053053,%edi
+ * x86-64:    0f b9 3d 53 30 05 53      ud1    0x53053053(%rip),%edi
+ */
+#define RSEQ_SIG	0x53053053
+
+/*
+ * Due to a compiler optimization bug in gcc-8 with asm goto and TLS asm input
+ * operands, we cannot use "m" input operands, and rather pass the __rseq_abi
+ * address through a "r" input operand.
+ */
+
+/* Offset of cpu_id and rseq_cs fields in struct rseq. */
+#define RSEQ_CPU_ID_OFFSET	4
+#define RSEQ_CS_OFFSET		8
+
+#ifdef __x86_64__
+
+#define RSEQ_ASM_TP_SEGMENT	%%fs
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
+				start_ip, post_commit_offset, abort_ip)	\
+		".pushsection __rseq_cs, \"aw\"\n\t"			\
+		".balign 32\n\t"					\
+		__rseq_str(label) ":\n\t"				\
+		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		".quad " __rseq_str(start_ip) ", " __rseq_str(post_commit_offset) ", " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"					\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
+		".quad " __rseq_str(label) "b\n\t"			\
+		".popsection\n\t"
+
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
+				(post_commit_ip - start_ip), abort_ip)
+
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
+		"leaq " __rseq_str(cs_label) "(%%rip), %%rax\n\t"	\
+		"movq %%rax, " __rseq_str(rseq_cs) "\n\t"		\
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+		"cmpl %[" __rseq_str(cpu_id) "], " __rseq_str(current_cpu_id) "\n\t" \
+		"jnz " __rseq_str(label) "\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
+		".pushsection __rseq_failure, \"ax\"\n\t"		\
+		/* Disassembler-friendly signature: ud1 <sig>(%rip),%edi. */ \
+		".byte 0x0f, 0xb9, 0x3d\n\t"				\
+		".long " __rseq_str(RSEQ_SIG) "\n\t"			\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"jmp %l[" __rseq_str(abort_label) "]\n\t"		\
+		".popsection\n\t"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+
+	__asm__ __volatile__ goto(
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
+		: abort, cmpfail
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+}
+
+/*
+ * Compare @v against @expectnot. When it does _not_ match, load @v
+ * into @load, and store the content of *@v + voffp into @v.
+ */
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+
+	__asm__ __volatile__ goto(
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		"movq %[v], %%rbx\n\t"
+		"cmpq %%rbx, %[expectnot]\n\t"
+		"je %l[cmpfail]\n\t"
+		"movq %%rbx, %[load]\n\t"
+		"addq %[voffp], %%rbx\n\t"
+		"movq (%%rbx), %%rbx\n\t"
+		/* final store */
+		"movq %%rbx, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"er" (voffp),
+		  [load]		"m" (*load)
+		: "memory", "cc", "rax", "rbx"
+		: abort, cmpfail
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+}
+
+#else
+/* Todo for other arch*/
+#endif
diff --git a/testcases/kernel/syscalls/rseq/rseq01.c b/testcases/kernel/syscalls/rseq/rseq01.c
new file mode 100644
index 000000000..6489a8a31
--- /dev/null
+++ b/testcases/kernel/syscalls/rseq/rseq01.c
@@ -0,0 +1,322 @@
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
+#include <assert.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stddef.h>
+
+#include "tst_test.h"
+#include "rseq.h"
+
+#define NR_THREAD 200
+static const ptrdiff_t *libc_rseq_offset_p;
+static const unsigned int *libc_rseq_size_p;
+static const unsigned int *libc_rseq_flags_p;
+
+/* Offset from the thread pointer to the rseq area.  */
+ptrdiff_t rseq_offset;
+
+/* Size of the registered rseq area.  0 if the registration was
+ * unsuccessful.
+ */
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
+static void rseq_available(void)
+{
+	sys_rseq(NULL, 0, 0, 0);
+}
+
+struct percpu_list_node {
+	intptr_t data;
+	struct percpu_list_node *next;
+};
+
+struct percpu_list_entry {
+	struct percpu_list_node *head;
+} __attribute__((aligned(128)));
+
+struct percpu_list {
+	struct percpu_list_entry c[CPU_SETSIZE];
+};
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
+
+	if (rseq_current_cpu_raw() < 0)
+		tst_res(TFAIL, "rseq_current_cpu_raw failed");
+
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
+
+	rseq_available();
+
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
+void this_cpu_list_push(struct percpu_list *list,
+			struct percpu_list_node *node,
+			int *_cpu)
+{
+	int cpu;
+
+	for (;;) {
+		intptr_t *targetptr, newval, expect;
+		int ret;
+
+		cpu = rseq_cpu_start();
+		/* Load list->c[cpu].head with single-copy atomicity. */
+		expect = (intptr_t)RSEQ_READ_ONCE(list->c[cpu].head);
+		newval = (intptr_t)node;
+		targetptr = (intptr_t *)&list->c[cpu].head;
+		node->next = (struct percpu_list_node *)expect;
+		ret = rseq_cmpeqv_storev(targetptr, expect, newval, cpu);
+		if (rseq_likely(!ret))
+			break;
+		/* Retry if comparison fails or rseq aborts. */
+	}
+	if (_cpu)
+		*_cpu = cpu;
+}
+
+/*
+ * __percpu_list_pop is not safe against concurrent accesses. Should
+ * only be used on lists that are not concurrently modified.
+ */
+struct percpu_list_node *__percpu_list_pop(struct percpu_list *list, int cpu)
+{
+	struct percpu_list_node *node;
+
+	node = list->c[cpu].head;
+	if (!node)
+		return NULL;
+	list->c[cpu].head = node->next;
+	return node;
+}
+
+/*
+ * Unlike a traditional lock-less linked list; the availability of a
+ * rseq primitive allows us to implement pop without concerns over
+ * ABA-type races.
+ */
+struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
+					   int *_cpu)
+{
+	for (;;) {
+		struct percpu_list_node *head;
+		intptr_t *targetptr, expectnot, *load;
+		long offset;
+		int ret, cpu;
+
+		cpu = rseq_cpu_start();
+		targetptr = (intptr_t *)&list->c[cpu].head;
+		expectnot = (intptr_t)NULL;
+		offset = offsetof(struct percpu_list_node, next);
+		load = (intptr_t *)&head;
+		ret = rseq_cmpnev_storeoffp_load(targetptr, expectnot,
+						 offset, load, cpu);
+		if (rseq_likely(!ret)) {
+			if (_cpu)
+				*_cpu = cpu;
+			return head;
+		}
+		if (ret > 0)
+			return NULL;
+		/* Retry if rseq aborts. */
+	}
+}
+
+void *test_percpu_list_thread(void *arg)
+{
+	int i;
+	struct percpu_list *list = (struct percpu_list *)arg;
+
+	if (rseq_register_current_thread())
+		tst_brk(TFAIL | TTERRNO, "Error: rseq_register_current_thread(...) failed");
+
+	for (i = 0; i < 100000; i++) {
+		struct percpu_list_node *node;
+
+		node = this_cpu_list_pop(list, NULL);
+		sched_yield();  /* encourage shuffling */
+		if (node)
+			this_cpu_list_push(list, node, NULL);
+	}
+
+	if (rseq_unregister_current_thread())
+		tst_brk(TFAIL | TTERRNO, "Error: rseq_unregister_current_thread(...) failed");
+
+	return NULL;
+}
+
+/* Simultaneous modification to a per-cpu linked list from many threads.  */
+void test_percpu_list(void)
+{
+	unsigned int i, j;
+	uint64_t sum = 0, expected_sum = 0;
+	struct percpu_list list;
+	pthread_t test_threads[NR_THREAD];
+	cpu_set_t allowed_cpus;
+
+	memset(&list, 0, sizeof(list));
+
+	/* Generate list entries for every usable cpu. */
+	sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus);
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+		for (j = 1; j <= 100; j++) {
+			struct percpu_list_node *node;
+
+			expected_sum += j;
+
+			node = malloc(sizeof(*node));
+			assert(node);
+			node->data = j;
+			node->next = list.c[i].head;
+			list.c[i].head = node;
+		}
+	}
+
+	for (i = 0; i < NR_THREAD; i++)
+		pthread_create(&test_threads[i], NULL,
+		       test_percpu_list_thread, &list);
+
+	for (i = 0; i < NR_THREAD; i++)
+		pthread_join(test_threads[i], NULL);
+
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		struct percpu_list_node *node;
+
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+
+		while ((node = __percpu_list_pop(&list, i))) {
+			sum += node->data;
+			free(node);
+		}
+	}
+
+	/*
+	 * All entries should now be accounted for (unless some external
+	 * actor is interfering with our allowed affinity while this
+	 * test is running).
+	 */
+	TST_EXP_EQ_LU(sum, expected_sum);
+}
+
+static void run(void)
+{
+	if (rseq_register_current_thread())
+		tst_brk(TFAIL | TTERRNO, "Error: rseq_register_current_thread(...) failed");
+
+#ifdef __x86_64__
+	test_percpu_list();
+#else
+	tst_res(TCONF, "Further rseq test only support on x86_64, SKIP it");
+#endif
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
