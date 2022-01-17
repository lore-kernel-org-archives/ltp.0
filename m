Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93991C433EF
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 20:24:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D51133C960F
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 21:24:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1B963C964E
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 21:24:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 326992000BC
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 21:23:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A9FF1F3A6;
 Mon, 17 Jan 2022 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642451036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUBsoXJETS4u2T2a9eCrqEp4NZJ3HvM4dhJ4GfwQp9I=;
 b=0wWMtvJG9HJSLeS9esQzEyhc7EH6nDkGVU1BrodGHJ+sba+9cQvWZkUKX1/zDserrQkscz
 ykXKIDDMS5FM6NNtoVFrlzraKIkBjR4+kCO62qH6iy2WqFkrIq7q1rbJhe+IObKURwV5vI
 usBfc43zgi9RNDIPY+XhCsJWD6A/rn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642451036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUBsoXJETS4u2T2a9eCrqEp4NZJ3HvM4dhJ4GfwQp9I=;
 b=etdOBbsjpb/qScKT3CL+bEpQXQDq9wycAx0Y81eTy2v+XKhUe89IRE06Mwswyjo4dA9lA3
 QoUx7X+mqoM+EhBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5646B13E9C;
 Mon, 17 Jan 2022 20:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +OtZElzQ5WHSUAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 17 Jan 2022 20:23:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 17 Jan 2022 21:23:53 +0100
Message-Id: <20220117202354.20785-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117202354.20785-1-andrea.cervesato@suse.de>
References: <20220117202354.20785-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] Update lapi/futex.h fallback
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 configure.ac                                  |   1 +
 include/lapi/futex.h                          | 178 ++++++++++++++++++
 lib/tst_checkpoint.c                          |   2 +-
 testcases/kernel/syscalls/clone/clone08.c     |   3 +-
 .../syscalls/futex/futex_cmp_requeue01.c      |   2 +-
 .../syscalls/futex/futex_cmp_requeue02.c      |   2 +-
 testcases/kernel/syscalls/futex/futextest.h   |  56 ++----
 7 files changed, 198 insertions(+), 46 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3c56d1922..d3fe4ce85 100644
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
diff --git a/include/lapi/futex.h b/include/lapi/futex.h
index 00b26c355..3ed0cdd10 100644
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
 
@@ -14,4 +16,180 @@ typedef volatile uint32_t futex_t;
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
 #endif /* LAPI_FUTEX_H__ */
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index b41986f0c..c884fde40 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -25,7 +25,7 @@
 #include <limits.h>
 #include <errno.h>
 #include <sys/syscall.h>
-#include <linux/futex.h>
+#include <lapi/futex.h>
 
 #include "test.h"
 #include "safe_macros.h"
diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index 3de1fe9bb..89ae93d59 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -11,12 +11,11 @@
 #include <errno.h>
 #include <sched.h>
 #include <sys/wait.h>
-#include <linux/futex.h>
+#include <lapi/futex.h>
 
 #include "tst_test.h"
 #include "clone_platform.h"
 #include "lapi/syscalls.h"
-#include "lapi/futex.h"
 
 static pid_t ptid, ctid, tgid;
 static void *child_stack;
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index 13e67c758..97c842c79 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -12,7 +12,7 @@
 #include <errno.h>
 #include <sys/wait.h>
 #include <stdlib.h>
-#include <linux/futex.h>
+#include <lapi/futex.h>
 #include <sys/time.h>
 
 #include "tst_timer_test.h"
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
index 0514b0ba4..4bdb6a1e7 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
@@ -13,7 +13,7 @@
  */
 
 #include <errno.h>
-#include <linux/futex.h>
+#include <lapi/futex.h>
 #include <sys/time.h>
 
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
index 3f2f36fef..fd2eaeb35 100644
--- a/testcases/kernel/syscalls/futex/futextest.h
+++ b/testcases/kernel/syscalls/futex/futextest.h
@@ -16,52 +16,11 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
-#include <linux/futex.h>
 #include "lapi/futex.h"
 #include "tst_timer.h"
 
 #define FUTEX_INITIALIZER 0
 
-#ifndef FUTEX_CMP_REQUEUE
-# define FUTEX_CMP_REQUEUE	4
-#endif
-#ifndef FUTEX_WAKE_OP
-# define FUTEX_WAKE_OP		5
-#endif
-#ifndef FUTEX_LOCK_PI
-# define FUTEX_LOCK_PI		6
-#endif
-#ifndef FUTEX_UNLOCK_PI
-# define FUTEX_UNLOCK_PI	7
-#endif
-#ifndef FUTEX_WAIT_BITSET
-# define FUTEX_WAIT_BITSET	9
-#endif
-#ifndef FUTEX_WAKE_BITSET
-# define FUTEX_WAKE_BITSET	10
-#endif
-#ifndef FUTEX_WAIT_REQUEUE_PI
-# define FUTEX_WAIT_REQUEUE_PI	11
-#endif
-#ifndef FUTEX_CMP_REQUEUE_PI
-# define FUTEX_CMP_REQUEUE_PI	12
-#endif
-#ifndef FUTEX_PRIVATE_FLAG
-# define FUTEX_PRIVATE_FLAG	128
-#endif
-#ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
-# define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
-					 FUTEX_PRIVATE_FLAG)
-#endif
-#ifndef FUTEX_REQUEUE_PI_PRIVATE
-# define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
-					 FUTEX_PRIVATE_FLAG)
-#endif
-
-#ifndef FUTEX_CLOCK_REALTIME
-# define FUTEX_CLOCK_REALTIME 256
-#endif
-
 enum futex_fn_type {
 	FUTEX_FN_FUTEX,
 	FUTEX_FN_FUTEX64,
@@ -74,6 +33,21 @@ struct futex_test_variants {
 	char *desc;
 };
 
+static inline struct futex_test_variants futex_variants(void)
+{
+	struct futex_test_variants variants[] = {
+	#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+		{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec" },
+	#endif
+
+	#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+		{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec" },
+	#endif
+	};
+
+	return variants[tst_variant];
+}
+
 static inline void futex_supported_by_kernel(enum futex_fn_type fntype)
 {
 	if (fntype != FUTEX_FN_FUTEX64)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
