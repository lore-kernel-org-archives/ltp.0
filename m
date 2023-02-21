Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225BCC636D6
	for <ltp@archiver.kernel.org>; Tue, 21 Feb 2023 01:35:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4305B3CBD07
	for <ltp@archiver.kernel.org>; Tue, 21 Feb 2023 02:35:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0514C3CAFE7
 for <ltp@lists.linux.it>; Tue, 21 Feb 2023 02:35:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 11D8A60076A
 for <ltp@lists.linux.it>; Tue, 21 Feb 2023 02:35:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 27A65340EF;
 Tue, 21 Feb 2023 01:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676943336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KYXuSCQM2wyO3tbdf4WXjw9syMaK+HLwHy+aKboDxfU=;
 b=UApZzSxtyxXs/MNyCwvAy1BpYgRj4vn0sJG2C+KBbh/pvEq54Uz/88+fBrtqDxZ24coU/j
 SD4ygE/db8QaaeRuSGmSeRzuxixmwjmuullCKjlppUpWsyoAtyNVg+15XYqlNMgv39MJCG
 dThqTiNcjaQOtHQvbVkxIB9wir96E0A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F7D913A2F;
 Tue, 21 Feb 2023 01:35:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WLDjGN8f9GPNWgAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 21 Feb 2023 01:35:27 +0000
To: ltp@lists.linux.it
Date: Mon, 20 Feb 2023 20:34:45 -0500
Message-Id: <20230221013446.19399-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230221013446.19399-1-wegao@suse.com>
References: <20230215023438.11370-1-wegao@suse.com>
 <20230221013446.19399-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] rseq: Copy linux rseq test header files to ltp
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
 include/lapi/compiler.h                    |   30 +
 include/lapi/rseq-abi.h                    |  151 +++
 include/lapi/rseq-arm.h                    |  827 ++++++++++++
 include/lapi/rseq-arm64.h                  |  695 ++++++++++
 include/lapi/rseq-generic-thread-pointer.h |   25 +
 include/lapi/rseq-mips.h                   |  777 +++++++++++
 include/lapi/rseq-ppc-thread-pointer.h     |   30 +
 include/lapi/rseq-ppc.h                    |  791 ++++++++++++
 include/lapi/rseq-riscv.h                  |  677 ++++++++++
 include/lapi/rseq-s390.h                   |  610 +++++++++
 include/lapi/rseq-skip.h                   |   65 +
 include/lapi/rseq-thread-pointer.h         |   19 +
 include/lapi/rseq-x86-thread-pointer.h     |   40 +
 include/lapi/rseq-x86.h                    | 1365 ++++++++++++++++++++
 14 files changed, 6102 insertions(+)
 create mode 100644 include/lapi/compiler.h
 create mode 100644 include/lapi/rseq-abi.h
 create mode 100644 include/lapi/rseq-arm.h
 create mode 100644 include/lapi/rseq-arm64.h
 create mode 100644 include/lapi/rseq-generic-thread-pointer.h
 create mode 100644 include/lapi/rseq-mips.h
 create mode 100644 include/lapi/rseq-ppc-thread-pointer.h
 create mode 100644 include/lapi/rseq-ppc.h
 create mode 100644 include/lapi/rseq-riscv.h
 create mode 100644 include/lapi/rseq-s390.h
 create mode 100644 include/lapi/rseq-skip.h
 create mode 100644 include/lapi/rseq-thread-pointer.h
 create mode 100644 include/lapi/rseq-x86-thread-pointer.h
 create mode 100644 include/lapi/rseq-x86.h

diff --git a/include/lapi/compiler.h b/include/lapi/compiler.h
new file mode 100644
index 000000000..876eb6a7f
--- /dev/null
+++ b/include/lapi/compiler.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+/*
+ * rseq/compiler.h
+ *
+ * Work-around asm goto compiler bugs.
+ *
+ * (C) Copyright 2021 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef RSEQ_COMPILER_H
+#define RSEQ_COMPILER_H
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
+#define rseq_after_asm_goto()	asm volatile ("" : : : "memory")
+
+#endif  /* RSEQ_COMPILER_H_ */
diff --git a/include/lapi/rseq-abi.h b/include/lapi/rseq-abi.h
new file mode 100644
index 000000000..a8c44d9af
--- /dev/null
+++ b/include/lapi/rseq-abi.h
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
diff --git a/include/lapi/rseq-arm.h b/include/lapi/rseq-arm.h
new file mode 100644
index 000000000..893a11eca
--- /dev/null
+++ b/include/lapi/rseq-arm.h
@@ -0,0 +1,827 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-arm.h
+ *
+ * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+/*
+ * - ARM little endian
+ *
+ * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
+ * value 0x5de3. This traps if user-space reaches this instruction by mistake,
+ * and the uncommon operand ensures the kernel does not move the instruction
+ * pointer to attacker-controlled code on rseq abort.
+ *
+ * The instruction pattern in the A32 instruction set is:
+ *
+ * e7f5def3    udf    #24035    ; 0x5de3
+ *
+ * This translates to the following instruction pattern in the T16 instruction
+ * set:
+ *
+ * little endian:
+ * def3        udf    #243      ; 0xf3
+ * e7f5        b.n    <7f5>
+ *
+ * - ARMv6+ big endian (BE8):
+ *
+ * ARMv6+ -mbig-endian generates mixed endianness code vs data: little-endian
+ * code and big-endian data. The data value of the signature needs to have its
+ * byte order reversed to generate the trap instruction:
+ *
+ * Data: 0xf3def5e7
+ *
+ * Translates to this A32 instruction pattern:
+ *
+ * e7f5def3    udf    #24035    ; 0x5de3
+ *
+ * Translates to this T16 instruction pattern:
+ *
+ * def3        udf    #243      ; 0xf3
+ * e7f5        b.n    <7f5>
+ *
+ * - Prior to ARMv6 big endian (BE32):
+ *
+ * Prior to ARMv6, -mbig-endian generates big-endian code and data
+ * (which match), so the endianness of the data representation of the
+ * signature should not be reversed. However, the choice between BE32
+ * and BE8 is done by the linker, so we cannot know whether code and
+ * data endianness will be mixed before the linker is invoked. So rather
+ * than try to play tricks with the linker, the rseq signature is simply
+ * data (not a trap instruction) prior to ARMv6 on big endian. This is
+ * why the signature is expressed as data (.word) rather than as
+ * instruction (.inst) in assembler.
+ */
+
+#ifdef __ARMEB__
+#define RSEQ_SIG    0xf3def5e7      /* udf    #24035    ; 0x5de3 (ARMv6+) */
+#else
+#define RSEQ_SIG    0xe7f5def3      /* udf    #24035    ; 0x5de3 */
+#endif
+
+#define rseq_smp_mb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
+#define rseq_smp_rmb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
+#define rseq_smp_wmb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_smp_mb();							\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_smp_mb();							\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
+				post_commit_offset, abort_ip)		\
+		".pushsection __rseq_cs, \"aw\"\n\t"			\
+		".balign 32\n\t"					\
+		__rseq_str(label) ":\n\t"					\
+		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
+		".popsection\n\t"					\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
+		".word " __rseq_str(label) "b, 0x0\n\t"			\
+		".popsection\n\t"
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
+		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) ", 0x0\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
+		RSEQ_INJECT_ASM(1)					\
+		"adr r0, " __rseq_str(cs_label) "\n\t"			\
+		"str r0, %[" __rseq_str(rseq_cs) "]\n\t"		\
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+		RSEQ_INJECT_ASM(2)					\
+		"ldr r0, %[" __rseq_str(current_cpu_id) "]\n\t"	\
+		"cmp %[" __rseq_str(cpu_id) "], r0\n\t"		\
+		"bne " __rseq_str(label) "\n\t"
+
+#define __RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown,		\
+				abort_label, version, flags,		\
+				start_ip, post_commit_offset, abort_ip)	\
+		".balign 32\n\t"					\
+		__rseq_str(table_label) ":\n\t"				\
+		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
+		".word " __rseq_str(RSEQ_SIG) "\n\t"			\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"b %l[" __rseq_str(abort_label) "]\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown, abort_label, \
+			      start_ip, post_commit_ip, abort_ip)	\
+	__RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown,		\
+				abort_label, 0x0, 0x0, start_ip,	\
+				(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label)		\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"b %l[" __rseq_str(cmpfail_label) "]\n\t"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[error2]\n\t"
+#endif
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expectnot], r0\n\t"
+		"beq %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expectnot], r0\n\t"
+		"beq %l[error2]\n\t"
+#endif
+		"str r0, %[load]\n\t"
+		"add r0, %[voffp]\n\t"
+		"ldr r0, [r0]\n\t"
+		/* final store */
+		"str r0, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"Ir" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		"ldr r0, %[v]\n\t"
+		"add r0, %[count]\n\t"
+		/* final store */
+		"str r0, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [count]		"Ir" (count)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[error2]\n\t"
+#endif
+		/* try store */
+		"str %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[error2]\n\t"
+#endif
+		/* try store */
+		"str %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		"dmb\n\t"	/* full mb provides store-release */
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		"ldr r0, %[v2]\n\t"
+		"cmp %[expect2], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[error2]\n\t"
+		"ldr r0, %[v2]\n\t"
+		"cmp %[expect2], r0\n\t"
+		"bne %l[error3]\n\t"
+#endif
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_after_asm_goto();
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uint32_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		"str %[src], %[rseq_scratch0]\n\t"
+		"str %[dst], %[rseq_scratch1]\n\t"
+		"str %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne 7f\n\t"
+#endif
+		/* try memcpy */
+		"cmp %[len], #0\n\t" \
+		"beq 333f\n\t" \
+		"222:\n\t" \
+		"ldrb %%r0, [%[src]]\n\t" \
+		"strb %%r0, [%[dst]]\n\t" \
+		"adds %[src], #1\n\t" \
+		"adds %[dst], #1\n\t" \
+		"subs %[len], #1\n\t" \
+		"bne 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"ldr %[len], %[rseq_scratch2]\n\t"
+		"ldr %[dst], %[rseq_scratch1]\n\t"
+		"ldr %[src], %[rseq_scratch0]\n\t"
+		"b 8f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4,
+				      /* teardown */
+				      "ldr %[len], %[rseq_scratch2]\n\t"
+				      "ldr %[dst], %[rseq_scratch1]\n\t"
+				      "ldr %[src], %[rseq_scratch0]\n\t",
+				      abort, 1b, 2b, 4f)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					error2)
+#endif
+		"8:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	uint32_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		"str %[src], %[rseq_scratch0]\n\t"
+		"str %[dst], %[rseq_scratch1]\n\t"
+		"str %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne 7f\n\t"
+#endif
+		/* try memcpy */
+		"cmp %[len], #0\n\t" \
+		"beq 333f\n\t" \
+		"222:\n\t" \
+		"ldrb %%r0, [%[src]]\n\t" \
+		"strb %%r0, [%[dst]]\n\t" \
+		"adds %[src], #1\n\t" \
+		"adds %[dst], #1\n\t" \
+		"subs %[len], #1\n\t" \
+		"bne 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		"dmb\n\t"	/* full mb provides store-release */
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"ldr %[len], %[rseq_scratch2]\n\t"
+		"ldr %[dst], %[rseq_scratch1]\n\t"
+		"ldr %[src], %[rseq_scratch0]\n\t"
+		"b 8f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4,
+				      /* teardown */
+				      "ldr %[len], %[rseq_scratch2]\n\t"
+				      "ldr %[dst], %[rseq_scratch1]\n\t"
+				      "ldr %[src], %[rseq_scratch0]\n\t",
+				      abort, 1b, 2b, 4f)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					error2)
+#endif
+		"8:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/include/lapi/rseq-arm64.h b/include/lapi/rseq-arm64.h
new file mode 100644
index 000000000..cbe190a4d
--- /dev/null
+++ b/include/lapi/rseq-arm64.h
@@ -0,0 +1,695 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-arm64.h
+ *
+ * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2018 - Will Deacon <will.deacon@arm.com>
+ */
+
+/*
+ * aarch64 -mbig-endian generates mixed endianness code vs data:
+ * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
+ * matches code endianness.
+ */
+#define RSEQ_SIG_CODE	0xd428bc00	/* BRK #0x45E0.  */
+
+#ifdef __AARCH64EB__
+#define RSEQ_SIG_DATA	0x00bc28d4	/* BRK #0x45E0.  */
+#else
+#define RSEQ_SIG_DATA	RSEQ_SIG_CODE
+#endif
+
+#define RSEQ_SIG	RSEQ_SIG_DATA
+
+#define rseq_smp_mb()	__asm__ __volatile__ ("dmb ish" ::: "memory")
+#define rseq_smp_rmb()	__asm__ __volatile__ ("dmb ishld" ::: "memory")
+#define rseq_smp_wmb()	__asm__ __volatile__ ("dmb ishst" ::: "memory")
+
+#define rseq_smp_load_acquire(p)						\
+__extension__ ({								\
+	__typeof(*p) ____p1;							\
+	switch (sizeof(*p)) {							\
+	case 1:									\
+		asm volatile ("ldarb %w0, %1"					\
+			: "=r" (*(__u8 *)p)					\
+			: "Q" (*p) : "memory");					\
+		break;								\
+	case 2:									\
+		asm volatile ("ldarh %w0, %1"					\
+			: "=r" (*(__u16 *)p)					\
+			: "Q" (*p) : "memory");					\
+		break;								\
+	case 4:									\
+		asm volatile ("ldar %w0, %1"					\
+			: "=r" (*(__u32 *)p)					\
+			: "Q" (*p) : "memory");					\
+		break;								\
+	case 8:									\
+		asm volatile ("ldar %0, %1"					\
+			: "=r" (*(__u64 *)p)					\
+			: "Q" (*p) : "memory");					\
+		break;								\
+	}									\
+	____p1;									\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)						\
+do {										\
+	switch (sizeof(*p)) {							\
+	case 1:									\
+		asm volatile ("stlrb %w1, %0"					\
+				: "=Q" (*p)					\
+				: "r" ((__u8)v)					\
+				: "memory");					\
+		break;								\
+	case 2:									\
+		asm volatile ("stlrh %w1, %0"					\
+				: "=Q" (*p)					\
+				: "r" ((__u16)v)				\
+				: "memory");					\
+		break;								\
+	case 4:									\
+		asm volatile ("stlr %w1, %0"					\
+				: "=Q" (*p)					\
+				: "r" ((__u32)v)				\
+				: "memory");					\
+		break;								\
+	case 8:									\
+		asm volatile ("stlr %1, %0"					\
+				: "=Q" (*p)					\
+				: "r" ((__u64)v)				\
+				: "memory");					\
+		break;								\
+	}									\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+#define RSEQ_ASM_TMP_REG32	"w15"
+#define RSEQ_ASM_TMP_REG	"x15"
+#define RSEQ_ASM_TMP_REG_2	"x14"
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,		\
+				post_commit_offset, abort_ip)			\
+	"	.pushsection	__rseq_cs, \"aw\"\n"				\
+	"	.balign	32\n"							\
+	__rseq_str(label) ":\n"							\
+	"	.long	" __rseq_str(version) ", " __rseq_str(flags) "\n"	\
+	"	.quad	" __rseq_str(start_ip) ", "				\
+			  __rseq_str(post_commit_offset) ", "			\
+			  __rseq_str(abort_ip) "\n"				\
+	"	.popsection\n\t"						\
+	"	.pushsection __rseq_cs_ptr_array, \"aw\"\n"				\
+	"	.quad " __rseq_str(label) "b\n"					\
+	"	.popsection\n"
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip)	\
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,			\
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
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)				\
+	"	.pushsection __rseq_exit_point_array, \"aw\"\n"			\
+	"	.quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n"	\
+	"	.popsection\n"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
+	RSEQ_INJECT_ASM(1)							\
+	"	adrp	" RSEQ_ASM_TMP_REG ", " __rseq_str(cs_label) "\n"	\
+	"	add	" RSEQ_ASM_TMP_REG ", " RSEQ_ASM_TMP_REG		\
+			", :lo12:" __rseq_str(cs_label) "\n"			\
+	"	str	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(rseq_cs) "]\n"	\
+	__rseq_str(label) ":\n"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
+	"	b	222f\n"							\
+	"	.inst 	"	__rseq_str(RSEQ_SIG_CODE) "\n"			\
+	__rseq_str(label) ":\n"							\
+	"	b	%l[" __rseq_str(abort_label) "]\n"			\
+	"222:\n"
+
+#define RSEQ_ASM_OP_STORE(value, var)						\
+	"	str	%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n"
+
+#define RSEQ_ASM_OP_STORE_RELEASE(value, var)					\
+	"	stlr	%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n"
+
+#define RSEQ_ASM_OP_FINAL_STORE(value, var, post_commit_label)			\
+	RSEQ_ASM_OP_STORE(value, var)						\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_FINAL_STORE_RELEASE(value, var, post_commit_label)		\
+	RSEQ_ASM_OP_STORE_RELEASE(value, var)					\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_CMPEQ(var, expect, label)					\
+	"	ldr	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(var) "]\n"		\
+	"	sub	" RSEQ_ASM_TMP_REG ", " RSEQ_ASM_TMP_REG		\
+			", %[" __rseq_str(expect) "]\n"				\
+	"	cbnz	" RSEQ_ASM_TMP_REG ", " __rseq_str(label) "\n"
+
+#define RSEQ_ASM_OP_CMPEQ32(var, expect, label)					\
+	"	ldr	" RSEQ_ASM_TMP_REG32 ", %[" __rseq_str(var) "]\n"	\
+	"	sub	" RSEQ_ASM_TMP_REG32 ", " RSEQ_ASM_TMP_REG32		\
+			", %w[" __rseq_str(expect) "]\n"			\
+	"	cbnz	" RSEQ_ASM_TMP_REG32 ", " __rseq_str(label) "\n"
+
+#define RSEQ_ASM_OP_CMPNE(var, expect, label)					\
+	"	ldr	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(var) "]\n"		\
+	"	sub	" RSEQ_ASM_TMP_REG ", " RSEQ_ASM_TMP_REG		\
+			", %[" __rseq_str(expect) "]\n"				\
+	"	cbz	" RSEQ_ASM_TMP_REG ", " __rseq_str(label) "\n"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)			\
+	RSEQ_INJECT_ASM(2)							\
+	RSEQ_ASM_OP_CMPEQ32(current_cpu_id, cpu_id, label)
+
+#define RSEQ_ASM_OP_R_LOAD(var)							\
+	"	ldr	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(var) "]\n"
+
+#define RSEQ_ASM_OP_R_STORE(var)						\
+	"	str	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(var) "]\n"
+
+#define RSEQ_ASM_OP_R_LOAD_OFF(offset)						\
+	"	ldr	" RSEQ_ASM_TMP_REG ", [" RSEQ_ASM_TMP_REG		\
+			", %[" __rseq_str(offset) "]]\n"
+
+#define RSEQ_ASM_OP_R_ADD(count)						\
+	"	add	" RSEQ_ASM_TMP_REG ", " RSEQ_ASM_TMP_REG		\
+			", %[" __rseq_str(count) "]\n"
+
+#define RSEQ_ASM_OP_R_FINAL_STORE(var, post_commit_label)			\
+	"	str	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(var) "]\n"		\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)					\
+	"	cbz	%[" __rseq_str(len) "], 333f\n"				\
+	"	mov	" RSEQ_ASM_TMP_REG_2 ", %[" __rseq_str(len) "]\n"	\
+	"222:	sub	" RSEQ_ASM_TMP_REG_2 ", " RSEQ_ASM_TMP_REG_2 ", #1\n"	\
+	"	ldrb	" RSEQ_ASM_TMP_REG32 ", [%[" __rseq_str(src) "]"	\
+			", " RSEQ_ASM_TMP_REG_2 "]\n"				\
+	"	strb	" RSEQ_ASM_TMP_REG32 ", [%[" __rseq_str(dst) "]"	\
+			", " RSEQ_ASM_TMP_REG_2 "]\n"				\
+	"	cbnz	" RSEQ_ASM_TMP_REG_2 ", 222b\n"				\
+	"333:\n"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[error2])
+#endif
+		RSEQ_ASM_OP_R_LOAD(v)
+		RSEQ_ASM_OP_R_STORE(load)
+		RSEQ_ASM_OP_R_LOAD_OFF(voffp)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [load]		"Qo" (*load),
+		  [voffp]		"r" (voffp)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		RSEQ_ASM_OP_R_LOAD(v)
+		RSEQ_ASM_OP_R_ADD(count)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [count]		"r" (count)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_STORE(newv2, v2)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [expect]		"r" (expect),
+		  [v]			"Qo" (*v),
+		  [newv]		"r" (newv),
+		  [v2]			"Qo" (*v2),
+		  [newv2]		"r" (newv2)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_STORE(newv2, v2)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [expect]		"r" (expect),
+		  [v]			"Qo" (*v),
+		  [newv]		"r" (newv),
+		  [v2]			"Qo" (*v2),
+		  [newv2]		"r" (newv2)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error3])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[cmpfail])
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
+#endif
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [expect]		"r" (expect),
+		  [v2]			"Qo" (*v2),
+		  [expect2]		"r" (expect2),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+error3:
+	rseq_after_asm_goto();
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [expect]		"r" (expect),
+		  [v]			"Qo" (*v),
+		  [newv]		"r" (newv),
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG, RSEQ_ASM_TMP_REG_2
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [expect]		"r" (expect),
+		  [v]			"Qo" (*v),
+		  [newv]		"r" (newv),
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG, RSEQ_ASM_TMP_REG_2
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/include/lapi/rseq-generic-thread-pointer.h b/include/lapi/rseq-generic-thread-pointer.h
new file mode 100644
index 000000000..38c584661
--- /dev/null
+++ b/include/lapi/rseq-generic-thread-pointer.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+/*
+ * rseq-generic-thread-pointer.h
+ *
+ * (C) Copyright 2021 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef _RSEQ_GENERIC_THREAD_POINTER
+#define _RSEQ_GENERIC_THREAD_POINTER
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* Use gcc builtin thread pointer. */
+static inline void *rseq_thread_pointer(void)
+{
+	return __builtin_thread_pointer();
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/include/lapi/rseq-mips.h b/include/lapi/rseq-mips.h
new file mode 100644
index 000000000..878739fae
--- /dev/null
+++ b/include/lapi/rseq-mips.h
@@ -0,0 +1,777 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Author: Paul Burton <paul.burton@mips.com>
+ * (C) Copyright 2018 MIPS Tech LLC
+ *
+ * Based on rseq-arm.h:
+ * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+/*
+ * RSEQ_SIG uses the break instruction. The instruction pattern is:
+ *
+ * On MIPS:
+ *	0350000d        break     0x350
+ *
+ * On nanoMIPS:
+ *      00100350        break     0x350
+ *
+ * On microMIPS:
+ *      0000d407        break     0x350
+ *
+ * For nanoMIPS32 and microMIPS, the instruction stream is encoded as 16-bit
+ * halfwords, so the signature halfwords need to be swapped accordingly for
+ * little-endian.
+ */
+#if defined(__nanomips__)
+# ifdef __MIPSEL__
+#  define RSEQ_SIG	0x03500010
+# else
+#  define RSEQ_SIG	0x00100350
+# endif
+#elif defined(__mips_micromips)
+# ifdef __MIPSEL__
+#  define RSEQ_SIG	0xd4070000
+# else
+#  define RSEQ_SIG	0x0000d407
+# endif
+#elif defined(__mips__)
+# define RSEQ_SIG	0x0350000d
+#else
+/* Unknown MIPS architecture. */
+#endif
+
+#define rseq_smp_mb()	__asm__ __volatile__ ("sync" ::: "memory")
+#define rseq_smp_rmb()	rseq_smp_mb()
+#define rseq_smp_wmb()	rseq_smp_mb()
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_smp_mb();							\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_smp_mb();							\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+#if _MIPS_SZLONG == 64
+# define LONG			".dword"
+# define LONG_LA		"dla"
+# define LONG_L			"ld"
+# define LONG_S			"sd"
+# define LONG_ADDI		"daddiu"
+# define U32_U64_PAD(x)		x
+#elif _MIPS_SZLONG == 32
+# define LONG			".word"
+# define LONG_LA		"la"
+# define LONG_L			"lw"
+# define LONG_S			"sw"
+# define LONG_ADDI		"addiu"
+# ifdef __BIG_ENDIAN
+#  define U32_U64_PAD(x)	"0x0, " x
+# else
+#  define U32_U64_PAD(x)	x ", 0x0"
+# endif
+#else
+# error unsupported _MIPS_SZLONG
+#endif
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip, \
+				post_commit_offset, abort_ip) \
+		".pushsection __rseq_cs, \"aw\"\n\t" \
+		".balign 32\n\t" \
+		__rseq_str(label) ":\n\t"					\
+		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(post_commit_offset)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(abort_ip)) "\n\t" \
+		".popsection\n\t" \
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(label) "b") "\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip, \
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
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip) \
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(exit_ip)) "\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs) \
+		RSEQ_INJECT_ASM(1) \
+		LONG_LA " $4, " __rseq_str(cs_label) "\n\t" \
+		LONG_S  " $4, %[" __rseq_str(rseq_cs) "]\n\t" \
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label) \
+		RSEQ_INJECT_ASM(2) \
+		"lw  $4, %[" __rseq_str(current_cpu_id) "]\n\t" \
+		"bne $4, %[" __rseq_str(cpu_id) "], " __rseq_str(label) "\n\t"
+
+#define __RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown, \
+				abort_label, version, flags, \
+				start_ip, post_commit_offset, abort_ip) \
+		".balign 32\n\t" \
+		__rseq_str(table_label) ":\n\t" \
+		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(post_commit_offset)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(abort_ip)) "\n\t" \
+		".word " __rseq_str(RSEQ_SIG) "\n\t" \
+		__rseq_str(label) ":\n\t" \
+		teardown \
+		"b %l[" __rseq_str(abort_label) "]\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown, abort_label, \
+			      start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown, \
+				abort_label, 0x0, 0x0, start_ip, \
+				(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label) \
+		__rseq_str(label) ":\n\t" \
+		teardown \
+		"b %l[" __rseq_str(cmpfail_label) "]\n\t"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[error2]\n\t"
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"beq $4, %[expectnot], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"beq $4, %[expectnot], %l[error2]\n\t"
+#endif
+		LONG_S " $4, %[load]\n\t"
+		LONG_ADDI " $4, %[voffp]\n\t"
+		LONG_L " $4, 0($4)\n\t"
+		/* final store */
+		LONG_S " $4, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"Ir" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		LONG_L " $4, %[v]\n\t"
+		LONG_ADDI " $4, %[count]\n\t"
+		/* final store */
+		LONG_S " $4, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [count]		"Ir" (count)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[error2]\n\t"
+#endif
+		/* try store */
+		LONG_S " %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[error2]\n\t"
+#endif
+		/* try store */
+		LONG_S " %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		"sync\n\t"	/* full sync provides store-release */
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		LONG_L " $4, %[v2]\n\t"
+		"bne $4, %[expect2], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[error2]\n\t"
+		LONG_L " $4, %[v2]\n\t"
+		"bne $4, %[expect2], %l[error3]\n\t"
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uintptr_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		LONG_S " %[src], %[rseq_scratch0]\n\t"
+		LONG_S "  %[dst], %[rseq_scratch1]\n\t"
+		LONG_S " %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], 7f\n\t"
+#endif
+		/* try memcpy */
+		"beqz %[len], 333f\n\t" \
+		"222:\n\t" \
+		"lb   $4, 0(%[src])\n\t" \
+		"sb   $4, 0(%[dst])\n\t" \
+		LONG_ADDI " %[src], 1\n\t" \
+		LONG_ADDI " %[dst], 1\n\t" \
+		LONG_ADDI " %[len], -1\n\t" \
+		"bnez %[len], 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		LONG_L " %[len], %[rseq_scratch2]\n\t"
+		LONG_L " %[dst], %[rseq_scratch1]\n\t"
+		LONG_L " %[src], %[rseq_scratch0]\n\t"
+		"b 8f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4,
+				      /* teardown */
+				      LONG_L " %[len], %[rseq_scratch2]\n\t"
+				      LONG_L " %[dst], %[rseq_scratch1]\n\t"
+				      LONG_L " %[src], %[rseq_scratch0]\n\t",
+				      abort, 1b, 2b, 4f)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error2)
+#endif
+		"8:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	uintptr_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		LONG_S " %[src], %[rseq_scratch0]\n\t"
+		LONG_S " %[dst], %[rseq_scratch1]\n\t"
+		LONG_S " %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], 7f\n\t"
+#endif
+		/* try memcpy */
+		"beqz %[len], 333f\n\t" \
+		"222:\n\t" \
+		"lb   $4, 0(%[src])\n\t" \
+		"sb   $4, 0(%[dst])\n\t" \
+		LONG_ADDI " %[src], 1\n\t" \
+		LONG_ADDI " %[dst], 1\n\t" \
+		LONG_ADDI " %[len], -1\n\t" \
+		"bnez %[len], 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		"sync\n\t"	/* full sync provides store-release */
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		LONG_L " %[len], %[rseq_scratch2]\n\t"
+		LONG_L " %[dst], %[rseq_scratch1]\n\t"
+		LONG_L " %[src], %[rseq_scratch0]\n\t"
+		"b 8f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4,
+				      /* teardown */
+				      LONG_L " %[len], %[rseq_scratch2]\n\t"
+				      LONG_L " %[dst], %[rseq_scratch1]\n\t"
+				      LONG_L " %[src], %[rseq_scratch0]\n\t",
+				      abort, 1b, 2b, 4f)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error2)
+#endif
+		"8:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/include/lapi/rseq-ppc-thread-pointer.h b/include/lapi/rseq-ppc-thread-pointer.h
new file mode 100644
index 000000000..263eee84f
--- /dev/null
+++ b/include/lapi/rseq-ppc-thread-pointer.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+/*
+ * rseq-ppc-thread-pointer.h
+ *
+ * (C) Copyright 2021 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef _RSEQ_PPC_THREAD_POINTER
+#define _RSEQ_PPC_THREAD_POINTER
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+static inline void *rseq_thread_pointer(void)
+{
+#ifdef __powerpc64__
+	register void *__result asm ("r13");
+#else
+	register void *__result asm ("r2");
+#endif
+	asm ("" : "=r" (__result));
+	return __result;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/include/lapi/rseq-ppc.h b/include/lapi/rseq-ppc.h
new file mode 100644
index 000000000..bab8e0b9f
--- /dev/null
+++ b/include/lapi/rseq-ppc.h
@@ -0,0 +1,791 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-ppc.h
+ *
+ * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2016-2018 - Boqun Feng <boqun.feng@gmail.com>
+ */
+
+/*
+ * RSEQ_SIG is used with the following trap instruction:
+ *
+ * powerpc-be:    0f e5 00 0b           twui   r5,11
+ * powerpc64-le:  0b 00 e5 0f           twui   r5,11
+ * powerpc64-be:  0f e5 00 0b           twui   r5,11
+ */
+
+#define RSEQ_SIG	0x0fe5000b
+
+#define rseq_smp_mb()		__asm__ __volatile__ ("sync"	::: "memory", "cc")
+#define rseq_smp_lwsync()	__asm__ __volatile__ ("lwsync"	::: "memory", "cc")
+#define rseq_smp_rmb()		rseq_smp_lwsync()
+#define rseq_smp_wmb()		rseq_smp_lwsync()
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_smp_lwsync();						\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_lwsync()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_smp_lwsync();						\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+/*
+ * The __rseq_cs_ptr_array and __rseq_cs sections can be used by debuggers to
+ * better handle single-stepping through the restartable critical sections.
+ */
+
+#ifdef __PPC64__
+
+#define RSEQ_STORE_LONG(arg)	"std%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* To memory ("m" constraint) */
+#define RSEQ_STORE_INT(arg)	"stw%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* To memory ("m" constraint) */
+#define RSEQ_LOAD_LONG(arg)	"ld%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* From memory ("m" constraint) */
+#define RSEQ_LOAD_INT(arg)	"lwz%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* From memory ("m" constraint) */
+#define RSEQ_LOADX_LONG		"ldx "							/* From base register ("b" constraint) */
+#define RSEQ_CMP_LONG		"cmpd "
+#define RSEQ_CMP_LONG_INT	"cmpdi "
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,				\
+			start_ip, post_commit_offset, abort_ip)			\
+		".pushsection __rseq_cs, \"aw\"\n\t"				\
+		".balign 32\n\t"						\
+		__rseq_str(label) ":\n\t"					\
+		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t"	\
+		".quad " __rseq_str(start_ip) ", " __rseq_str(post_commit_offset) ", " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"						\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"			\
+		".quad " __rseq_str(label) "b\n\t"				\
+		".popsection\n\t"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
+		RSEQ_INJECT_ASM(1)						\
+		"lis %%r17, (" __rseq_str(cs_label) ")@highest\n\t"		\
+		"ori %%r17, %%r17, (" __rseq_str(cs_label) ")@higher\n\t"	\
+		"rldicr %%r17, %%r17, 32, 31\n\t"				\
+		"oris %%r17, %%r17, (" __rseq_str(cs_label) ")@high\n\t"	\
+		"ori %%r17, %%r17, (" __rseq_str(cs_label) ")@l\n\t"		\
+		"std %%r17, %[" __rseq_str(rseq_cs) "]\n\t"			\
+		__rseq_str(label) ":\n\t"
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
+#else /* #ifdef __PPC64__ */
+
+#define RSEQ_STORE_LONG(arg)	"stw%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* To memory ("m" constraint) */
+#define RSEQ_STORE_INT(arg)	RSEQ_STORE_LONG(arg)					/* To memory ("m" constraint) */
+#define RSEQ_LOAD_LONG(arg)	"lwz%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* From memory ("m" constraint) */
+#define RSEQ_LOAD_INT(arg)	RSEQ_LOAD_LONG(arg)					/* From memory ("m" constraint) */
+#define RSEQ_LOADX_LONG		"lwzx "							/* From base register ("b" constraint) */
+#define RSEQ_CMP_LONG		"cmpw "
+#define RSEQ_CMP_LONG_INT	"cmpwi "
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,				\
+			start_ip, post_commit_offset, abort_ip)			\
+		".pushsection __rseq_cs, \"aw\"\n\t"				\
+		".balign 32\n\t"						\
+		__rseq_str(label) ":\n\t"					\
+		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t"	\
+		/* 32-bit only supported on BE */				\
+		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"					\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
+		".long 0x0, " __rseq_str(label) "b\n\t"			\
+		".popsection\n\t"
+
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)				\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"		\
+		/* 32-bit only supported on BE */				\
+		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) "\n\t"	\
+		".popsection\n\t"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
+		RSEQ_INJECT_ASM(1)						\
+		"lis %%r17, (" __rseq_str(cs_label) ")@ha\n\t"			\
+		"addi %%r17, %%r17, (" __rseq_str(cs_label) ")@l\n\t"		\
+		RSEQ_STORE_INT(rseq_cs) "%%r17, %[" __rseq_str(rseq_cs) "]\n\t"	\
+		__rseq_str(label) ":\n\t"
+
+#endif /* #ifdef __PPC64__ */
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip)	\
+		__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
+					(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)			\
+		RSEQ_INJECT_ASM(2)						\
+		RSEQ_LOAD_INT(current_cpu_id) "%%r17, %[" __rseq_str(current_cpu_id) "]\n\t" \
+		"cmpw cr7, %[" __rseq_str(cpu_id) "], %%r17\n\t"		\
+		"bne- cr7, " __rseq_str(label) "\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
+		".pushsection __rseq_failure, \"ax\"\n\t"			\
+		".long " __rseq_str(RSEQ_SIG) "\n\t"				\
+		__rseq_str(label) ":\n\t"					\
+		"b %l[" __rseq_str(abort_label) "]\n\t"				\
+		".popsection\n\t"
+
+/*
+ * RSEQ_ASM_OPs: asm operations for rseq
+ * 	RSEQ_ASM_OP_R_*: has hard-code registers in it
+ * 	RSEQ_ASM_OP_* (else): doesn't have hard-code registers(unless cr7)
+ */
+#define RSEQ_ASM_OP_CMPEQ(var, expect, label)					\
+		RSEQ_LOAD_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"		\
+		RSEQ_CMP_LONG "cr7, %%r17, %[" __rseq_str(expect) "]\n\t"		\
+		"bne- cr7, " __rseq_str(label) "\n\t"
+
+#define RSEQ_ASM_OP_CMPNE(var, expectnot, label)				\
+		RSEQ_LOAD_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"		\
+		RSEQ_CMP_LONG "cr7, %%r17, %[" __rseq_str(expectnot) "]\n\t"		\
+		"beq- cr7, " __rseq_str(label) "\n\t"
+
+#define RSEQ_ASM_OP_STORE(value, var)						\
+		RSEQ_STORE_LONG(var) "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t"
+
+/* Load @var to r17 */
+#define RSEQ_ASM_OP_R_LOAD(var)							\
+		RSEQ_LOAD_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"
+
+/* Store r17 to @var */
+#define RSEQ_ASM_OP_R_STORE(var)						\
+		RSEQ_STORE_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"
+
+/* Add @count to r17 */
+#define RSEQ_ASM_OP_R_ADD(count)						\
+		"add %%r17, %[" __rseq_str(count) "], %%r17\n\t"
+
+/* Load (r17 + voffp) to r17 */
+#define RSEQ_ASM_OP_R_LOADX(voffp)						\
+		RSEQ_LOADX_LONG "%%r17, %[" __rseq_str(voffp) "], %%r17\n\t"
+
+/* TODO: implement a faster memcpy. */
+#define RSEQ_ASM_OP_R_MEMCPY() \
+		RSEQ_CMP_LONG_INT "%%r19, 0\n\t" \
+		"beq 333f\n\t" \
+		"addi %%r20, %%r20, -1\n\t" \
+		"addi %%r21, %%r21, -1\n\t" \
+		"222:\n\t" \
+		"lbzu %%r18, 1(%%r20)\n\t" \
+		"stbu %%r18, 1(%%r21)\n\t" \
+		"addi %%r19, %%r19, -1\n\t" \
+		RSEQ_CMP_LONG_INT "%%r19, 0\n\t" \
+		"bne 222b\n\t" \
+		"333:\n\t" \
+
+#define RSEQ_ASM_OP_R_FINAL_STORE(var, post_commit_label)			\
+		RSEQ_STORE_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"			\
+		__rseq_str(post_commit_label) ":\n\t"
+
+#define RSEQ_ASM_OP_FINAL_STORE(value, var, post_commit_label)			\
+		RSEQ_STORE_LONG(var) "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t" \
+		__rseq_str(post_commit_label) ":\n\t"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v not equal to @expectnot */
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v not equal to @expectnot */
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[error2])
+#endif
+		/* load the value of @v */
+		RSEQ_ASM_OP_R_LOAD(v)
+		/* store it in @load */
+		RSEQ_ASM_OP_R_STORE(load)
+		/* dereference voffp(v) */
+		RSEQ_ASM_OP_R_LOADX(voffp)
+		/* final store the value at voffp(v) */
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"b" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		/* load the value of @v */
+		RSEQ_ASM_OP_R_LOAD(v)
+		/* add @count to it */
+		RSEQ_ASM_OP_R_ADD(count)
+		/* final store */
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"r" (count)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* try store */
+		RSEQ_ASM_OP_STORE(newv2, v2)
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* try store */
+		RSEQ_ASM_OP_STORE(newv2, v2)
+		RSEQ_INJECT_ASM(5)
+		/* for 'release' */
+		"lwsync\n\t"
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+		/* cmp @v2 equal to @expct2 */
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[cmpfail])
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+		/* cmp @v2 equal to @expct2 */
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
+#endif
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_after_asm_goto();
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* setup for mempcy */
+		"mr %%r19, %[len]\n\t"
+		"mr %%r20, %[src]\n\t"
+		"mr %%r21, %[dst]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* try memcpy */
+		RSEQ_ASM_OP_R_MEMCPY()
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17", "r18", "r19", "r20", "r21"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* setup for mempcy */
+		"mr %%r19, %[len]\n\t"
+		"mr %%r20, %[src]\n\t"
+		"mr %%r21, %[dst]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* try memcpy */
+		RSEQ_ASM_OP_R_MEMCPY()
+		RSEQ_INJECT_ASM(5)
+		/* for 'release' */
+		"lwsync\n\t"
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17", "r18", "r19", "r20", "r21"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/include/lapi/rseq-riscv.h b/include/lapi/rseq-riscv.h
new file mode 100644
index 000000000..3a391c9bf
--- /dev/null
+++ b/include/lapi/rseq-riscv.h
@@ -0,0 +1,677 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Select the instruction "csrw mhartid, x0" as the RSEQ_SIG. Unlike
+ * other architectures, the ebreak instruction has no immediate field for
+ * distinguishing purposes. Hence, ebreak is not suitable as RSEQ_SIG.
+ * "csrw mhartid, x0" can also satisfy the RSEQ requirement because it
+ * is an uncommon instruction and will raise an illegal instruction
+ * exception when executed in all modes.
+ */
+#include <endian.h>
+
+#if defined(__BYTE_ORDER) ? (__BYTE_ORDER == __LITTLE_ENDIAN) : defined(__LITTLE_ENDIAN)
+#define RSEQ_SIG   0xf1401073  /* csrr mhartid, x0 */
+#else
+#error "Currently, RSEQ only supports Little-Endian version"
+#endif
+
+#if __riscv_xlen == 64
+#define __REG_SEL(a, b)	a
+#elif __riscv_xlen == 32
+#define __REG_SEL(a, b)	b
+#endif
+
+#define REG_L	__REG_SEL("ld ", "lw ")
+#define REG_S	__REG_SEL("sd ", "sw ")
+
+#define RISCV_FENCE(p, s) \
+	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
+#define rseq_smp_mb()	RISCV_FENCE(rw, rw)
+#define rseq_smp_rmb()	RISCV_FENCE(r, r)
+#define rseq_smp_wmb()	RISCV_FENCE(w, w)
+#define RSEQ_ASM_TMP_REG_1	"t6"
+#define RSEQ_ASM_TMP_REG_2	"t5"
+#define RSEQ_ASM_TMP_REG_3	"t4"
+#define RSEQ_ASM_TMP_REG_4	"t3"
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*(p)) ____p1 = RSEQ_READ_ONCE(*(p));			\
+	RISCV_FENCE(r, rw)						\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	RISCV_FENCE(rw, w);						\
+	RSEQ_WRITE_ONCE(*(p), v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
+				post_commit_offset, abort_ip)		\
+	".pushsection	__rseq_cs, \"aw\"\n"				\
+	".balign	32\n"						\
+	__rseq_str(label) ":\n"						\
+	".long	" __rseq_str(version) ", " __rseq_str(flags) "\n"	\
+	".quad	" __rseq_str(start_ip) ", "				\
+			  __rseq_str(post_commit_offset) ", "		\
+			  __rseq_str(abort_ip) "\n"			\
+	".popsection\n\t"						\
+	".pushsection __rseq_cs_ptr_array, \"aw\"\n"			\
+	".quad " __rseq_str(label) "b\n"				\
+	".popsection\n"
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		 \
+				((post_commit_ip) - (start_ip)), abort_ip)
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
+	".pushsection __rseq_exit_point_array, \"aw\"\n"		\
+	".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n"	\
+	".popsection\n"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
+	RSEQ_INJECT_ASM(1)						\
+	"la	" RSEQ_ASM_TMP_REG_1 ", " __rseq_str(cs_label) "\n"	\
+	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(rseq_cs) "]\n"	\
+	__rseq_str(label) ":\n"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)			\
+	"j	222f\n"							\
+	".balign	4\n"						\
+	".long "	__rseq_str(RSEQ_SIG) "\n"			\
+	__rseq_str(label) ":\n"						\
+	"j	%l[" __rseq_str(abort_label) "]\n"			\
+	"222:\n"
+
+#define RSEQ_ASM_OP_STORE(value, var)					\
+	REG_S	"%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n"
+
+#define RSEQ_ASM_OP_CMPEQ(var, expect, label)				\
+	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
+	"bne	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+		  __rseq_str(label) "\n"
+
+#define RSEQ_ASM_OP_CMPEQ32(var, expect, label)				\
+	"lw	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"	\
+	"bne	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+		  __rseq_str(label) "\n"
+
+#define RSEQ_ASM_OP_CMPNE(var, expect, label)				\
+	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
+	"beq	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+		  __rseq_str(label) "\n"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+	RSEQ_INJECT_ASM(2)						\
+	RSEQ_ASM_OP_CMPEQ32(current_cpu_id, cpu_id, label)
+
+#define RSEQ_ASM_OP_R_LOAD(var)						\
+	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"
+
+#define RSEQ_ASM_OP_R_STORE(var)					\
+	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"
+
+#define RSEQ_ASM_OP_R_LOAD_OFF(offset)					\
+	"add	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(offset) "], "	\
+		 RSEQ_ASM_TMP_REG_1 "\n"				\
+	REG_L	RSEQ_ASM_TMP_REG_1 ", (" RSEQ_ASM_TMP_REG_1 ")\n"
+
+#define RSEQ_ASM_OP_R_ADD(count)					\
+	"add	" RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1		\
+		", %[" __rseq_str(count) "]\n"
+
+#define RSEQ_ASM_OP_FINAL_STORE(value, var, post_commit_label)		\
+	RSEQ_ASM_OP_STORE(value, var)					\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_FINAL_STORE_RELEASE(value, var, post_commit_label)	\
+	"fence	rw, w\n"						\
+	RSEQ_ASM_OP_STORE(value, var)					\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_R_FINAL_STORE(var, post_commit_label)		\
+	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)				\
+	"beqz	%[" __rseq_str(len) "], 333f\n"				\
+	"mv	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(len) "]\n"	\
+	"mv	" RSEQ_ASM_TMP_REG_2 ", %[" __rseq_str(src) "]\n"	\
+	"mv	" RSEQ_ASM_TMP_REG_3 ", %[" __rseq_str(dst) "]\n"	\
+	"222:\n"							\
+	"lb	" RSEQ_ASM_TMP_REG_4 ", 0(" RSEQ_ASM_TMP_REG_2 ")\n"	\
+	"sb	" RSEQ_ASM_TMP_REG_4 ", 0(" RSEQ_ASM_TMP_REG_3 ")\n"	\
+	"addi	" RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1 ", -1\n"	\
+	"addi	" RSEQ_ASM_TMP_REG_2 ", " RSEQ_ASM_TMP_REG_2 ", 1\n"	\
+	"addi	" RSEQ_ASM_TMP_REG_3 ", " RSEQ_ASM_TMP_REG_3 ", 1\n"	\
+	"bnez	" RSEQ_ASM_TMP_REG_1 ", 222b\n"				\
+	"333:\n"
+
+#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, post_commit_label)		\
+	"mv	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(ptr) "]\n"	\
+	RSEQ_ASM_OP_R_ADD(off)						\
+	REG_L	  RSEQ_ASM_TMP_REG_1 ", 0(" RSEQ_ASM_TMP_REG_1 ")\n"	\
+	RSEQ_ASM_OP_R_ADD(inc)						\
+	__rseq_str(post_commit_label) ":\n"
+
+static inline __always_inline
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [expect]		"r" (expect),
+				    [newv]		"r" (newv)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __always_inline
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_R_LOAD(v)
+				  RSEQ_ASM_OP_R_STORE(load)
+				  RSEQ_ASM_OP_R_LOAD_OFF(voffp)
+				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [expectnot]		"r" (expectnot),
+				    [load]		"m" (*load),
+				    [voffp]		"r" (voffp)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __always_inline
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+#endif
+				  RSEQ_ASM_OP_R_LOAD(v)
+				  RSEQ_ASM_OP_R_ADD(count)
+				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [count]		"r" (count)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __always_inline
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_STORE(newv2, v2)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [expect]		"r" (expect),
+				    [v]			"m" (*v),
+				    [newv]		"r" (newv),
+				    [v2]			"m" (*v2),
+				    [newv2]		"r" (newv2)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __always_inline
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_STORE(newv2, v2)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [expect]		"r" (expect),
+				    [v]			"m" (*v),
+				    [newv]		"r" (newv),
+				    [v2]			"m" (*v2),
+				    [newv2]		"r" (newv2)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __always_inline
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error3]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[error3]")
+#endif
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [expect]		"r" (expect),
+				    [v2]			"m" (*v2),
+				    [expect2]		"r" (expect2),
+				    [newv]		"r" (newv)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2, error3
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __always_inline
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [expect]		"r" (expect),
+				    [v]			"m" (*v),
+				    [newv]		"r" (newv),
+				    [dst]			"r" (dst),
+				    [src]			"r" (src),
+				    [len]			"r" (len)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
+				    RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __always_inline
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [expect]		"r" (expect),
+				    [v]			"m" (*v),
+				    [newv]		"r" (newv),
+				    [dst]			"r" (dst),
+				    [src]			"r" (src),
+				    [len]			"r" (len)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
+				    RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __always_inline
+int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+#endif
+				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, 3)
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]      "m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [ptr]			"r" (ptr),
+				    [off]			"er" (off),
+				    [inc]			"er" (inc)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/include/lapi/rseq-s390.h b/include/lapi/rseq-s390.h
new file mode 100644
index 000000000..4e6dc5f0c
--- /dev/null
+++ b/include/lapi/rseq-s390.h
@@ -0,0 +1,610 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+
+/*
+ * RSEQ_SIG uses the trap4 instruction. As Linux does not make use of the
+ * access-register mode nor the linkage stack this instruction will always
+ * cause a special-operation exception (the trap-enabled bit in the DUCT
+ * is and will stay 0). The instruction pattern is
+ *	b2 ff 0f ff	trap4	4095(%r0)
+ */
+#define RSEQ_SIG	0xB2FF0FFF
+
+#define rseq_smp_mb()	__asm__ __volatile__ ("bcr 15,0" ::: "memory")
+#define rseq_smp_rmb()	rseq_smp_mb()
+#define rseq_smp_wmb()	rseq_smp_mb()
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_barrier();							\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_barrier();							\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+#ifdef __s390x__
+
+#define LONG_L			"lg"
+#define LONG_S			"stg"
+#define LONG_LT_R		"ltgr"
+#define LONG_CMP		"cg"
+#define LONG_CMP_R		"cgr"
+#define LONG_ADDI		"aghi"
+#define LONG_ADD_R		"agr"
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
+#elif __s390__
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
+				start_ip, post_commit_offset, abort_ip)	\
+		".pushsection __rseq_cs, \"aw\"\n\t"			\
+		".balign 32\n\t"					\
+		__rseq_str(label) ":\n\t"				\
+		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"					\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
+		".long 0x0, " __rseq_str(label) "b\n\t"			\
+		".popsection\n\t"
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
+		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) "\n\t" \
+		".popsection\n\t"
+
+#define LONG_L			"l"
+#define LONG_S			"st"
+#define LONG_LT_R		"ltr"
+#define LONG_CMP		"c"
+#define LONG_CMP_R		"cr"
+#define LONG_ADDI		"ahi"
+#define LONG_ADD_R		"ar"
+
+#endif
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
+				(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
+		RSEQ_INJECT_ASM(1)					\
+		"larl %%r0, " __rseq_str(cs_label) "\n\t"		\
+		LONG_S " %%r0, %[" __rseq_str(rseq_cs) "]\n\t"		\
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+		RSEQ_INJECT_ASM(2)					\
+		"c %[" __rseq_str(cpu_id) "], %[" __rseq_str(current_cpu_id) "]\n\t" \
+		"jnz " __rseq_str(label) "\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
+		".pushsection __rseq_failure, \"ax\"\n\t"		\
+		".long " __rseq_str(RSEQ_SIG) "\n\t"			\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"jg %l[" __rseq_str(abort_label) "]\n\t"		\
+		".popsection\n\t"
+
+#define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label)		\
+		".pushsection __rseq_failure, \"ax\"\n\t"		\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"jg %l[" __rseq_str(cmpfail_label) "]\n\t"		\
+		".popsection\n\t"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_CMP " %[expect], %[v]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_CMP " %[expect], %[v]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r0"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
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
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " %%r1, %[v]\n\t"
+		LONG_CMP_R " %%r1, %[expectnot]\n\t"
+		"je %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " %%r1, %[v]\n\t"
+		LONG_CMP_R " %%r1, %[expectnot]\n\t"
+		"je %l[error2]\n\t"
+#endif
+		LONG_S " %%r1, %[load]\n\t"
+		LONG_ADD_R " %%r1, %[voffp]\n\t"
+		LONG_L " %%r1, 0(%%r1)\n\t"
+		/* final store */
+		LONG_S " %%r1, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"r" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r0", "r1"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		LONG_L " %%r0, %[v]\n\t"
+		LONG_ADD_R " %%r0, %[count]\n\t"
+		/* final store */
+		LONG_S " %%r0, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"r" (count)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r0"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_CMP " %[expect], %[v]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_CMP " %[expect], %[v]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* try store */
+		LONG_S " %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r0"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/* s390 is TSO. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	return rseq_cmpeqv_trystorev_storev(v, expect, v2, newv2, newv, cpu);
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_CMP " %[expect], %[v]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		LONG_CMP " %[expect2], %[v2]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_CMP " %[expect], %[v]\n\t"
+		"jnz %l[error2]\n\t"
+		LONG_CMP " %[expect2], %[v2]\n\t"
+		"jnz %l[error3]\n\t"
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r0"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_after_asm_goto();
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uint64_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		LONG_S " %[src], %[rseq_scratch0]\n\t"
+		LONG_S " %[dst], %[rseq_scratch1]\n\t"
+		LONG_S " %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_CMP " %[expect], %[v]\n\t"
+		"jnz 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		LONG_CMP " %[expect], %[v]\n\t"
+		"jnz 7f\n\t"
+#endif
+		/* try memcpy */
+		LONG_LT_R " %[len], %[len]\n\t"
+		"jz 333f\n\t"
+		"222:\n\t"
+		"ic %%r0,0(%[src])\n\t"
+		"stc %%r0,0(%[dst])\n\t"
+		LONG_ADDI " %[src], 1\n\t"
+		LONG_ADDI " %[dst], 1\n\t"
+		LONG_ADDI " %[len], -1\n\t"
+		"jnz 222b\n\t"
+		"333:\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		LONG_L " %[len], %[rseq_scratch2]\n\t"
+		LONG_L " %[dst], %[rseq_scratch1]\n\t"
+		LONG_L " %[src], %[rseq_scratch0]\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			LONG_L " %[len], %[rseq_scratch2]\n\t"
+			LONG_L " %[dst], %[rseq_scratch1]\n\t"
+			LONG_L " %[src], %[rseq_scratch0]\n\t",
+			abort)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+			LONG_L " %[len], %[rseq_scratch2]\n\t"
+			LONG_L " %[dst], %[rseq_scratch1]\n\t"
+			LONG_L " %[src], %[rseq_scratch0]\n\t",
+			cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+			LONG_L " %[len], %[rseq_scratch2]\n\t"
+			LONG_L " %[dst], %[rseq_scratch1]\n\t"
+			LONG_L " %[src], %[rseq_scratch0]\n\t",
+			error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+			LONG_L " %[len], %[rseq_scratch2]\n\t"
+			LONG_L " %[dst], %[rseq_scratch1]\n\t"
+			LONG_L " %[src], %[rseq_scratch0]\n\t",
+			error2)
+#endif
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r0"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/* s390 is TSO. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	return rseq_cmpeqv_trymemcpy_storev(v, expect, dst, src, len,
+					    newv, cpu);
+}
+#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/include/lapi/rseq-skip.h b/include/lapi/rseq-skip.h
new file mode 100644
index 000000000..7b53dac1f
--- /dev/null
+++ b/include/lapi/rseq-skip.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-skip.h
+ *
+ * (C) Copyright 2017-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	return -1;
+}
diff --git a/include/lapi/rseq-thread-pointer.h b/include/lapi/rseq-thread-pointer.h
new file mode 100644
index 000000000..977c25d75
--- /dev/null
+++ b/include/lapi/rseq-thread-pointer.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+/*
+ * rseq-thread-pointer.h
+ *
+ * (C) Copyright 2021 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef _RSEQ_THREAD_POINTER
+#define _RSEQ_THREAD_POINTER
+
+#if defined(__x86_64__) || defined(__i386__)
+#include "rseq-x86-thread-pointer.h"
+#elif defined(__PPC__)
+#include "rseq-ppc-thread-pointer.h"
+#else
+#include "rseq-generic-thread-pointer.h"
+#endif
+
+#endif
diff --git a/include/lapi/rseq-x86-thread-pointer.h b/include/lapi/rseq-x86-thread-pointer.h
new file mode 100644
index 000000000..d3133587d
--- /dev/null
+++ b/include/lapi/rseq-x86-thread-pointer.h
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
diff --git a/include/lapi/rseq-x86.h b/include/lapi/rseq-x86.h
new file mode 100644
index 000000000..bd01dc41c
--- /dev/null
+++ b/include/lapi/rseq-x86.h
@@ -0,0 +1,1365 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-x86.h
+ *
+ * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include <stdint.h>
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
+#define rseq_smp_mb()	\
+	__asm__ __volatile__ ("lock; addl $0,-128(%%rsp)" ::: "memory", "cc")
+#define rseq_smp_rmb()	rseq_barrier()
+#define rseq_smp_wmb()	rseq_barrier()
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_barrier();							\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_barrier();							\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
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
+		RSEQ_INJECT_ASM(1)					\
+		"leaq " __rseq_str(cs_label) "(%%rip), %%rax\n\t"	\
+		"movq %%rax, " __rseq_str(rseq_cs) "\n\t"		\
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+		RSEQ_INJECT_ASM(2)					\
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
+#define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label)		\
+		".pushsection __rseq_failure, \"ax\"\n\t"		\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"jmp %l[" __rseq_str(cmpfail_label) "]\n\t"		\
+		".popsection\n\t"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
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
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movq %[v], %%rbx\n\t"
+		"cmpq %%rbx, %[expectnot]\n\t"
+		"je %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"movq %[v], %%rbx\n\t"
+		"cmpq %%rbx, %[expectnot]\n\t"
+		"je %l[error2]\n\t"
+#endif
+		"movq %%rbx, %[load]\n\t"
+		"addq %[voffp], %%rbx\n\t"
+		"movq (%%rbx), %%rbx\n\t"
+		/* final store */
+		"movq %%rbx, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
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
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+#endif
+		/* final store */
+		"addq %[count], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"er" (count)
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __attribute__((always_inline))
+int rseq_offset_deref_addv(intptr_t *ptr, long off, intptr_t inc, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+#endif
+		/* get p+v */
+		"movq %[ptr], %%rbx\n\t"
+		"addq %[off], %%rbx\n\t"
+		/* get pv */
+		"movq (%%rbx), %%rcx\n\t"
+		/* *pv += inc */
+		"addq %[inc], (%%rcx)\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [ptr]			"m" (*ptr),
+		  [off]			"er" (off),
+		  [inc]			"er" (inc)
+		: "memory", "cc", "rax", "rbx", "rcx"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* try store */
+		"movq %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/* x86-64 is TSO. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	return rseq_cmpeqv_trystorev_storev(v, expect, v2, newv2, newv, cpu);
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		"cmpq %[v2], %[expect2]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+		"cmpq %[v2], %[expect2]\n\t"
+		"jnz %l[error3]\n\t"
+#endif
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_after_asm_goto();
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uint64_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		"movq %[src], %[rseq_scratch0]\n\t"
+		"movq %[dst], %[rseq_scratch1]\n\t"
+		"movq %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 6f)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz 7f\n\t"
+#endif
+		/* try memcpy */
+		"test %[len], %[len]\n\t" \
+		"jz 333f\n\t" \
+		"222:\n\t" \
+		"movb (%[src]), %%al\n\t" \
+		"movb %%al, (%[dst])\n\t" \
+		"inc %[src]\n\t" \
+		"inc %[dst]\n\t" \
+		"dec %[len]\n\t" \
+		"jnz 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"movq %[rseq_scratch2], %[len]\n\t"
+		"movq %[rseq_scratch1], %[dst]\n\t"
+		"movq %[rseq_scratch0], %[src]\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			abort)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			error2)
+#endif
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/* x86-64 is TSO. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	return rseq_cmpeqv_trymemcpy_storev(v, expect, dst, src, len,
+					    newv, cpu);
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
+
+#elif defined(__i386__)
+
+#define RSEQ_ASM_TP_SEGMENT	%%gs
+
+#define rseq_smp_mb()	\
+	__asm__ __volatile__ ("lock; addl $0,-128(%%esp)" ::: "memory", "cc")
+#define rseq_smp_rmb()	\
+	__asm__ __volatile__ ("lock; addl $0,-128(%%esp)" ::: "memory", "cc")
+#define rseq_smp_wmb()	\
+	__asm__ __volatile__ ("lock; addl $0,-128(%%esp)" ::: "memory", "cc")
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_smp_mb();							\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_smp_mb();							\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+/*
+ * Use eax as scratch register and take memory operands as input to
+ * lessen register pressure. Especially needed when compiling in O0.
+ */
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
+				start_ip, post_commit_offset, abort_ip)	\
+		".pushsection __rseq_cs, \"aw\"\n\t"			\
+		".balign 32\n\t"					\
+		__rseq_str(label) ":\n\t"				\
+		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		".long " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
+		".popsection\n\t"					\
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
+		".long " __rseq_str(label) "b, 0x0\n\t"			\
+		".popsection\n\t"
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
+		".long " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) ", 0x0\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
+		RSEQ_INJECT_ASM(1)					\
+		"movl $" __rseq_str(cs_label) ", " __rseq_str(rseq_cs) "\n\t"	\
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+		RSEQ_INJECT_ASM(2)					\
+		"cmpl %[" __rseq_str(cpu_id) "], " __rseq_str(current_cpu_id) "\n\t" \
+		"jnz " __rseq_str(label) "\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
+		".pushsection __rseq_failure, \"ax\"\n\t"		\
+		/* Disassembler-friendly signature: ud1 <sig>,%edi. */	\
+		".byte 0x0f, 0xb9, 0x3d\n\t"				\
+		".long " __rseq_str(RSEQ_SIG) "\n\t"			\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"jmp %l[" __rseq_str(abort_label) "]\n\t"		\
+		".popsection\n\t"
+
+#define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label)		\
+		".pushsection __rseq_failure, \"ax\"\n\t"		\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"jmp %l[" __rseq_str(cmpfail_label) "]\n\t"		\
+		".popsection\n\t"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* final store */
+		"movl %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
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
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[v], %%ebx\n\t"
+		"cmpl %%ebx, %[expectnot]\n\t"
+		"je %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"movl %[v], %%ebx\n\t"
+		"cmpl %%ebx, %[expectnot]\n\t"
+		"je %l[error2]\n\t"
+#endif
+		"movl %%ebx, %[load]\n\t"
+		"addl %[voffp], %%ebx\n\t"
+		"movl (%%ebx), %%ebx\n\t"
+		/* final store */
+		"movl %%ebx, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"ir" (voffp),
+		  [load]		"m" (*load)
+		: "memory", "cc", "eax", "ebx"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+#endif
+		/* final store */
+		"addl %[count], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"ir" (count)
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* try store */
+		"movl %[newv2], %%eax\n\t"
+		"movl %%eax, %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"movl %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"m" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %[v], %%eax\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"movl %[expect], %%eax\n\t"
+		"cmpl %[v], %%eax\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* try store */
+		"movl %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		"lock; addl $0,-128(%%esp)\n\t"
+		/* final store */
+		"movl %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"m" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		"cmpl %[expect2], %[v2]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+		"cmpl %[expect2], %[v2]\n\t"
+		"jnz %l[error3]\n\t"
+#endif
+		"movl %[newv], %%eax\n\t"
+		/* final store */
+		"movl %%eax, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"m" (newv)
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_after_asm_goto();
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+/* TODO: implement a faster memcpy. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uint32_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		"movl %[src], %[rseq_scratch0]\n\t"
+		"movl %[dst], %[rseq_scratch1]\n\t"
+		"movl %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 6f)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 7f\n\t"
+#endif
+		/* try memcpy */
+		"test %[len], %[len]\n\t" \
+		"jz 333f\n\t" \
+		"222:\n\t" \
+		"movb (%[src]), %%al\n\t" \
+		"movb %%al, (%[dst])\n\t" \
+		"inc %[src]\n\t" \
+		"inc %[dst]\n\t" \
+		"dec %[len]\n\t" \
+		"jnz 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		"movl %[newv], %%eax\n\t"
+		/* final store */
+		"movl %%eax, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"movl %[rseq_scratch2], %[len]\n\t"
+		"movl %[rseq_scratch1], %[dst]\n\t"
+		"movl %[rseq_scratch0], %[src]\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			abort)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error2)
+#endif
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"m" (expect),
+		  [newv]		"m" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/* TODO: implement a faster memcpy. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	uint32_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		"movl %[src], %[rseq_scratch0]\n\t"
+		"movl %[dst], %[rseq_scratch1]\n\t"
+		"movl %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 6f)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 7f\n\t"
+#endif
+		/* try memcpy */
+		"test %[len], %[len]\n\t" \
+		"jz 333f\n\t" \
+		"222:\n\t" \
+		"movb (%[src]), %%al\n\t" \
+		"movb %%al, (%[dst])\n\t" \
+		"inc %[src]\n\t" \
+		"inc %[dst]\n\t" \
+		"dec %[len]\n\t" \
+		"jnz 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		"lock; addl $0,-128(%%esp)\n\t"
+		"movl %[newv], %%eax\n\t"
+		/* final store */
+		"movl %%eax, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"movl %[rseq_scratch2], %[len]\n\t"
+		"movl %[rseq_scratch1], %[dst]\n\t"
+		"movl %[rseq_scratch0], %[src]\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			abort)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error2)
+#endif
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"m" (expect),
+		  [newv]		"m" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
+
+#endif
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
