Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBAEC433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 14:42:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1C0E3C9B0A
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 15:42:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 457D63C9B1B
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:42:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4868310005CD
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:41:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D3F341F386;
 Mon,  7 Feb 2022 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644244910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgmGy3siJ69E/VcHcDVpAlXTCnWcAHAhwTMAge0P5ro=;
 b=qG8xY4labhRd7lZo0ZK5A50WM7MmGTGmwSOi96/NXnZljUntH1nHrGp3EO709U/oF7ZAeg
 z3GdHmh6a9Rk8fbyHxGjJsJTjSXVbbcD8MHxtH7Ga7C/W6RydgN2uKdNZgjKeyHJkTc3Vi
 IJNSe0hnsitUPkHalwq4yxIxom4uPLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644244910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgmGy3siJ69E/VcHcDVpAlXTCnWcAHAhwTMAge0P5ro=;
 b=BDr9qvpV0LIdZmkJeeMIwiYvmYKcAu8IlcNp0Dj52DlB/3QYfodHYuVqVT4/CiYzyDm9vn
 s/vT2vDXVfpTVsAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A025713C33;
 Mon,  7 Feb 2022 14:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CBESJa4vAWJwSwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 07 Feb 2022 14:41:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon,  7 Feb 2022 15:41:47 +0100
Message-Id: <20220207144148.27033-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207144148.27033-1-andrea.cervesato@suse.de>
References: <20220207144148.27033-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/3] Update lapi/futex.h fallback
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

Added a complete futex.h definition with futex2 support

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 configure.ac                                  |   3 +
 include/lapi/futex.h                          | 180 ++++++++++++++++++
 include/lapi/syscalls/aarch64.in              |   1 +
 include/lapi/syscalls/arc.in                  |   1 +
 include/lapi/syscalls/arm.in                  |   1 +
 include/lapi/syscalls/hppa.in                 |   1 +
 include/lapi/syscalls/i386.in                 |   1 +
 include/lapi/syscalls/ia64.in                 |   1 +
 include/lapi/syscalls/mips_n32.in             |   1 +
 include/lapi/syscalls/mips_n64.in             |   1 +
 include/lapi/syscalls/mips_o32.in             |   1 +
 include/lapi/syscalls/powerpc.in              |   1 +
 include/lapi/syscalls/powerpc64.in            |   1 +
 include/lapi/syscalls/s390.in                 |   1 +
 include/lapi/syscalls/s390x.in                |   1 +
 include/lapi/syscalls/sh.in                   |   1 +
 include/lapi/syscalls/sparc.in                |   1 +
 include/lapi/syscalls/sparc64.in              |   1 +
 include/lapi/syscalls/x86_64.in               |   1 +
 lib/tst_checkpoint.c                          |   1 -
 testcases/kernel/syscalls/clone/clone08.c     |   1 -
 .../syscalls/futex/futex_cmp_requeue01.c      |   2 +-
 .../syscalls/futex/futex_cmp_requeue02.c      |   2 +-
 23 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index aeb486f69..b4a8427d0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -51,6 +51,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/close_range.h \
     linux/dccp.h \
     linux/fs.h \
+    linux/futex.h \
     linux/genetlink.h \
     linux/if_alg.h \
     linux/if_ether.h \
@@ -216,6 +217,8 @@ AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
 AC_CHECK_TYPES([struct __kernel_old_timeval, struct __kernel_old_timespec, struct __kernel_timespec,
                 struct __kernel_old_itimerspec, struct __kernel_itimerspec],,,[#include <sys/socket.h>])
 
+AC_CHECK_TYPES([struct futex_waitv],,,[#include <linux/futex.h>])
+
 # Tools knobs
 
 # Bash
diff --git a/include/lapi/futex.h b/include/lapi/futex.h
index 00b26c355..a05fcb89c 100644
--- a/include/lapi/futex.h
+++ b/include/lapi/futex.h
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Linux Test Project
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 #ifndef LAPI_FUTEX_H__
 #define LAPI_FUTEX_H__
 
 #include <stdint.h>
+#include "config.h"
 
 typedef volatile uint32_t futex_t;
 
@@ -14,4 +16,182 @@ typedef volatile uint32_t futex_t;
 #define SYS_futex SYS_futex_time64
 #endif
 
+#ifdef HAVE_LINUX_FUTEX_H
+# include <linux/futex.h>
+#else
+#include <unistd.h>
+
+#define FUTEX_WAIT		0
+#define FUTEX_WAKE		1
+#define FUTEX_FD		2
+#define FUTEX_REQUEUE		3
+#define FUTEX_CMP_REQUEUE	4
+#define FUTEX_WAKE_OP		5
+#define FUTEX_LOCK_PI		6
+#define FUTEX_UNLOCK_PI		7
+#define FUTEX_TRYLOCK_PI	8
+#define FUTEX_WAIT_BITSET	9
+#define FUTEX_WAKE_BITSET	10
+#define FUTEX_WAIT_REQUEUE_PI	11
+#define FUTEX_CMP_REQUEUE_PI	12
+#define FUTEX_LOCK_PI2		13
+
+#define FUTEX_PRIVATE_FLAG	128
+#define FUTEX_CLOCK_REALTIME	256
+#define FUTEX_CMD_MASK		~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+
+#define FUTEX_WAIT_PRIVATE	(FUTEX_WAIT | FUTEX_PRIVATE_FLAG)
+#define FUTEX_WAKE_PRIVATE	(FUTEX_WAKE | FUTEX_PRIVATE_FLAG)
+#define FUTEX_REQUEUE_PRIVATE	(FUTEX_REQUEUE | FUTEX_PRIVATE_FLAG)
+#define FUTEX_CMP_REQUEUE_PRIVATE (FUTEX_CMP_REQUEUE | FUTEX_PRIVATE_FLAG)
+#define FUTEX_WAKE_OP_PRIVATE	(FUTEX_WAKE_OP | FUTEX_PRIVATE_FLAG)
+#define FUTEX_LOCK_PI_PRIVATE	(FUTEX_LOCK_PI | FUTEX_PRIVATE_FLAG)
+#define FUTEX_LOCK_PI2_PRIVATE	(FUTEX_LOCK_PI2 | FUTEX_PRIVATE_FLAG)
+#define FUTEX_UNLOCK_PI_PRIVATE	(FUTEX_UNLOCK_PI | FUTEX_PRIVATE_FLAG)
+#define FUTEX_TRYLOCK_PI_PRIVATE (FUTEX_TRYLOCK_PI | FUTEX_PRIVATE_FLAG)
+#define FUTEX_WAIT_BITSET_PRIVATE	(FUTEX_WAIT_BITSET | FUTEX_PRIVATE_FLAG)
+#define FUTEX_WAKE_BITSET_PRIVATE	(FUTEX_WAKE_BITSET | FUTEX_PRIVATE_FLAG)
+#define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
+					 FUTEX_PRIVATE_FLAG)
+#define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
+					 FUTEX_PRIVATE_FLAG)
+
+/*
+ * Support for robust futexes: the kernel cleans up held futexes at
+ * thread exit time.
+ */
+
+/*
+ * Per-lock list entry - embedded in user-space locks, somewhere close
+ * to the futex field. (Note: user-space uses a double-linked list to
+ * achieve O(1) list add and remove, but the kernel only needs to know
+ * about the forward link)
+ *
+ * NOTE: this structure is part of the syscall ABI, and must not be
+ * changed.
+ */
+struct robust_list {
+	struct robust_list *next;
+};
+
+/*
+ * Per-thread list head:
+ *
+ * NOTE: this structure is part of the syscall ABI, and must only be
+ * changed if the change is first communicated with the glibc folks.
+ * (When an incompatible change is done, we'll increase the structure
+ *  size, which glibc will detect)
+ */
+struct robust_list_head {
+	/*
+	 * The head of the list. Points back to itself if empty:
+	 */
+	struct robust_list list;
+
+	/*
+	 * This relative offset is set by user-space, it gives the kernel
+	 * the relative position of the futex field to examine. This way
+	 * we keep userspace flexible, to freely shape its data-structure,
+	 * without hardcoding any particular offset into the kernel:
+	 */
+	long futex_offset;
+
+	/*
+	 * The death of the thread may race with userspace setting
+	 * up a lock's links. So to handle this race, userspace first
+	 * sets this field to the address of the to-be-taken lock,
+	 * then does the lock acquire, and then adds itself to the
+	 * list, and then clears this field. Hence the kernel will
+	 * always have full knowledge of all locks that the thread
+	 * _might_ have taken. We check the owner TID in any case,
+	 * so only truly owned locks will be handled.
+	 */
+	struct robust_list *list_op_pending;
+};
+
+/*
+ * Are there any waiters for this robust futex:
+ */
+#define FUTEX_WAITERS		0x80000000
+
+/*
+ * The kernel signals via this bit that a thread holding a futex
+ * has exited without unlocking the futex. The kernel also does
+ * a FUTEX_WAKE on such futexes, after setting the bit, to wake
+ * up any possible waiters:
+ */
+#define FUTEX_OWNER_DIED	0x40000000
+
+/*
+ * The rest of the robust-futex field is for the TID:
+ */
+#define FUTEX_TID_MASK		0x3fffffff
+
+/*
+ * This limit protects against a deliberately circular list.
+ * (Not worth introducing an rlimit for it)
+ */
+#define ROBUST_LIST_LIMIT	2048
+
+/*
+ * bitset with all bits set for the FUTEX_xxx_BITSET OPs to request a
+ * match of any bit.
+ */
+#define FUTEX_BITSET_MATCH_ANY	0xffffffff
+
+
+#define FUTEX_OP_SET		0	/* *(int *)UADDR2 = OPARG; */
+#define FUTEX_OP_ADD		1	/* *(int *)UADDR2 += OPARG; */
+#define FUTEX_OP_OR		2	/* *(int *)UADDR2 |= OPARG; */
+#define FUTEX_OP_ANDN		3	/* *(int *)UADDR2 &= ~OPARG; */
+#define FUTEX_OP_XOR		4	/* *(int *)UADDR2 ^= OPARG; */
+
+#define FUTEX_OP_OPARG_SHIFT	8	/* Use (1 << OPARG) instead of OPARG.  */
+
+#define FUTEX_OP_CMP_EQ		0	/* if (oldval == CMPARG) wake */
+#define FUTEX_OP_CMP_NE		1	/* if (oldval != CMPARG) wake */
+#define FUTEX_OP_CMP_LT		2	/* if (oldval < CMPARG) wake */
+#define FUTEX_OP_CMP_LE		3	/* if (oldval <= CMPARG) wake */
+#define FUTEX_OP_CMP_GT		4	/* if (oldval > CMPARG) wake */
+#define FUTEX_OP_CMP_GE		5	/* if (oldval >= CMPARG) wake */
+
+/* FUTEX_WAKE_OP will perform atomically
+   int oldval = *(int *)UADDR2;
+   *(int *)UADDR2 = oldval OP OPARG;
+   if (oldval CMP CMPARG)
+     wake UADDR2;  */
+
+#define FUTEX_OP(op, oparg, cmp, cmparg) \
+  (((op & 0xf) << 28) | ((cmp & 0xf) << 24)		\
+   | ((oparg & 0xfff) << 12) | (cmparg & 0xfff))
+
+#endif /* HAVE_LINUX_FUTEX_H */
+
+#ifndef HAVE_STRUCT_FUTEX_WAITV
+/*
+ * Flags to specify the bit length of the futex word for futex2 syscalls.
+ * Currently, only 32 is supported.
+ */
+#define FUTEX_32		2
+
+/*
+ * Max numbers of elements in a futex_waitv array
+ */
+#define FUTEX_WAITV_MAX		128
+
+/**
+ * struct futex_waitv - A waiter for vectorized wait
+ * @val:	Expected value at uaddr
+ * @uaddr:	User address to wait on
+ * @flags:	Flags for this waiter
+ * @__reserved:	Reserved member to preserve data alignment. Should be 0.
+ */
+struct futex_waitv {
+	uint64_t val;
+	uint64_t uaddr;
+	uint32_t flags;
+	uint32_t __reserved;
+};
+#endif /* HAVE_STRUCT_FUTEX_WAITV */
+
 #endif /* LAPI_FUTEX_H__ */
diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 89b63ee4b..de4ed5fb1 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -295,4 +295,5 @@ openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 72420754a..9f11381db 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -315,3 +315,4 @@ openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 2a78d7c3c..4b0f63a28 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -393,3 +393,4 @@ openat2 (__NR_SYSCALL_BASE+437)
 pidfd_getfd (__NR_SYSCALL_BASE+438)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
 quotactl_fd (__NR_SYSCALL_BASE+443)
+futex_waitv (__NR_SYSCALL_BASE+449)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 2f0fc8153..b6d32d386 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -42,3 +42,4 @@ pidfd_open 434
 close_range 436
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 34a8a621f..d0e6e9a4b 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -429,3 +429,4 @@ openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index b729cd3f0..123200624 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -342,3 +342,4 @@ openat2 1461
 pidfd_getfd 1462
 epoll_pwait2 1465
 quotactl_fd 1467
+futex_waitv 1473
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index 46098a616..e818c9d92 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -370,3 +370,4 @@ process_madvise 6440
 epoll_pwait2 6441
 mount_setattr 6442
 quotactl_fd 6443
+futex_waitv 6449
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index 07f96ac5d..6e15f43b3 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -346,3 +346,4 @@ process_madvise 5440
 epoll_pwait2 5441
 mount_setattr 5442
 quotactl_fd 5443
+futex_waitv 5449
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 5e64a4a1c..921d5d331 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -416,3 +416,4 @@ process_madvise 4440
 epoll_pwait2 4441
 mount_setattr 4442
 quotactl_fd 4443
+futex_waitv 4449
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index f4e85940c..d5de621e1 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -422,3 +422,4 @@ openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index f4e85940c..d5de621e1 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -422,3 +422,4 @@ openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 3e16d8475..6505f3822 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -409,3 +409,4 @@ openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index beb0819af..bc5d2b34c 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -357,3 +357,4 @@ openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index a81cf8297..316ffe5f1 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -403,3 +403,4 @@ openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 6a7817ae5..e0c60a360 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -408,3 +408,4 @@ openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index d3995181c..0acde6856 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -373,3 +373,4 @@ openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index a5b2a24fe..1863e1df7 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -350,6 +350,7 @@ openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
+futex_waitv 449
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index b41986f0c..6a294b28b 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -25,7 +25,6 @@
 #include <limits.h>
 #include <errno.h>
 #include <sys/syscall.h>
-#include <linux/futex.h>
 
 #include "test.h"
 #include "safe_macros.h"
diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index 3de1fe9bb..ad285a497 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -11,7 +11,6 @@
 #include <errno.h>
 #include <sched.h>
 #include <sys/wait.h>
-#include <linux/futex.h>
 
 #include "tst_test.h"
 #include "clone_platform.h"
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index 13e67c758..bef44838e 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -12,12 +12,12 @@
 #include <errno.h>
 #include <sys/wait.h>
 #include <stdlib.h>
-#include <linux/futex.h>
 #include <sys/time.h>
 
 #include "tst_timer_test.h"
 #include "tst_test.h"
 #include "futextest.h"
+#include "lapi/futex.h"
 
 struct shared_data {
 	futex_t futexes[2];
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
index 0514b0ba4..073ea3bf6 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
@@ -13,11 +13,11 @@
  */
 
 #include <errno.h>
-#include <linux/futex.h>
 #include <sys/time.h>
 
 #include "tst_test.h"
 #include "futextest.h"
+#include "lapi/futex.h"
 
 static futex_t *futexes;
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
