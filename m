Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44F3C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 09:08:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B0303C987A
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 10:08:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E35BB3C9879
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:12 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3F033605628
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1DBA21153;
 Mon, 10 Feb 2025 09:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibxwXfk1yhG2gQUQJtRd35XMiNzahG+08pOizztsjgE=;
 b=qSABeaAEVORQLYzWInZprn1ZjmD5/agHqlcawTQPU30raKkwkB4bC9IAw/ykYOW2OV+oT6
 5moLEzWYH57Y3NA0NeU9yRzNQwS/8Nkov+jHAKVlWcvmVkPQBS8EFlNpy79dDV5T3ry5Dd
 2LKxjORiyoX0/JiM6Rh7QrGR8eyhZfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibxwXfk1yhG2gQUQJtRd35XMiNzahG+08pOizztsjgE=;
 b=Lq83lEyRqbZjchMwsiu/AG+OMYVsJLEpqvxADqybS2fSP570daYsz8WWOBkNjlLhAtszEU
 t8NL73AsGL99cIDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qSABeaAE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Lq83lEyR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibxwXfk1yhG2gQUQJtRd35XMiNzahG+08pOizztsjgE=;
 b=qSABeaAEVORQLYzWInZprn1ZjmD5/agHqlcawTQPU30raKkwkB4bC9IAw/ykYOW2OV+oT6
 5moLEzWYH57Y3NA0NeU9yRzNQwS/8Nkov+jHAKVlWcvmVkPQBS8EFlNpy79dDV5T3ry5Dd
 2LKxjORiyoX0/JiM6Rh7QrGR8eyhZfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibxwXfk1yhG2gQUQJtRd35XMiNzahG+08pOizztsjgE=;
 b=Lq83lEyRqbZjchMwsiu/AG+OMYVsJLEpqvxADqybS2fSP570daYsz8WWOBkNjlLhAtszEU
 t8NL73AsGL99cIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80E3F13AF6;
 Mon, 10 Feb 2025 09:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QNhOG7/BqWdQLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Feb 2025 09:07:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Feb 2025 10:07:10 +0100
MIME-Version: 1.0
Message-Id: <20250210-mmap_suite_refactoring-v2-5-6edea3a4363a@suse.com>
References: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
In-Reply-To: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739178429; l=6207;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=j0B0c4Ot7Cm/R/dAXSpAFv2G3vJr1d0w78yaBykIiKk=;
 b=o2349iUaWcdbm39M0ybA+/Orv9gfpjLrO3so8cGFry3NsH+5+aw5fwBsie5Tg60PKmhIKmfPY
 HqcaoZERCEWBtStmcxk3ZTwPY0PNaCCcGb4D/+vAkmRh//fb2osPZE/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: D1DBA21153
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/8] Cleanup mmap18 test
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
Cc: rbm@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap18.c | 96 ++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 49 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap18.c b/testcases/kernel/syscalls/mmap/mmap18.c
index b37b29890ca009ea671b29e81e02fc1e42b44dbb..d920a50ae33badfb005143eb06c5aad17c1e72a3 100644
--- a/testcases/kernel/syscalls/mmap/mmap18.c
+++ b/testcases/kernel/syscalls/mmap/mmap18.c
@@ -1,74 +1,72 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Zilogic Systems Pvt. Ltd., 2020
- * Email: code@zilogic.com
+ *	Email: code@zilogic.com
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Test mmap() MAP_GROWSDOWN flag
+/*\
+ * [Description]
+ *
+ * Verify mmap() syscall using MAP_GROWSDOWN flag.
  *
- * # Test1:
+ * [Algorithm]
  *
- *   We assign the memory region partially allocated with MAP_GROWSDOWN flag to
- *   a thread as a stack and expect the mapping to grow when we touch the
- *   guard page by calling a recusive function in the thread that uses the
- *   growable mapping as a stack.
+ * **Test 1**
  *
- *   The kernel only grows the memory region when the stack pointer is within
- *   guard page when the guard page is touched so simply faulting the guard
- *   page will not cause the mapping to grow.
+ * We assign the memory region partially allocated with MAP_GROWSDOWN flag to
+ * a thread as a stack and expect the mapping to grow when we touch the
+ * guard page by calling a recusive function in the thread that uses the
+ * growable mapping as a stack.
  *
- *   Newer kernels does not allow a MAP_GROWSDOWN mapping to grow closer than
- *   'stack_guard_gap' pages to an existing mapping. So when we map the stack we
- *   make sure there is enough of free address space before the lowest stack
- *   address.
+ * The kernel only grows the memory region when the stack pointer is within
+ * guard page when the guard page is touched so simply faulting the guard
+ * page will not cause the mapping to grow.
  *
- *   Kernel default 'stack_guard_gap' size is '256 * getpagesize()'.
+ * Newer kernels does not allow a MAP_GROWSDOWN mapping to grow closer than
+ * 'stack_guard_gap' pages to an existing mapping. So when we map the stack we
+ * make sure there is enough of free address space before the lowest stack
+ * address.
  *
- *   The stack memory map would look like:
+ * Kernel default `stack_guard_gap` size is `256 * getpagesize()`.
  *
- *   |  -  -  -   reserved  size   -  -  -  |
+ * The stack memory map would look like:
  *
- *   +-- - - - --+------------+-------------+
- *   | 256 pages |  unmapped  |   mapped    |
- *   +-- - - - --+------------+-------------+
- *                            | mapped size |
- *   ^           |  -  -  stack size  -  -  |
- *   start
- *               ^                          ^
- *               stack bottom       stack top
+ * |  -  -  -   reserved  size   -  -  -  |
  *
- * # Test2:
+ * +-- - - - --+------------+-------------+
+ * | 256 pages |  unmapped  |   mapped    |
+ * +-- - - - --+------------+-------------+
+ *                          | mapped size |
+ * ^           |  -  -  stack size  -  -  |
+ * start
+ *             ^                          ^
+ *             stack bottom       stack top
  *
- *   We allocate stack as we do in the first test but we mmap a page in the
- *   space the stack is supposed to grow into and we expect the thread to
- *   segfault when the guard page is faulted.
+ * **Test 2**
+ *
+ * We allocate stack as we do in the first test but we mmap a page in the
+ * space the stack is supposed to grow into and we expect the thread to
+ * segfault when the guard page is faulted.
  */
 
-#include <unistd.h>
 #include <pthread.h>
-#include <sys/mman.h>
-#include <sys/wait.h>
-#include <sys/types.h>
-#include <stdlib.h>
-#include <stdbool.h>
-
 #include "tst_test.h"
 #include "tst_safe_pthread.h"
 
 static long page_size;
 
-static bool __attribute__((noinline)) check_stackgrow_up(void)
+static bool __attribute_noinline__ check_stackgrow_up(void)
 {
 	char local_var;
 	static char *addr;
 
-       if (!addr) {
-               addr = &local_var;
-               return check_stackgrow_up();
-       }
+	if (!addr) {
+		addr = &local_var;
+		return check_stackgrow_up();
+	}
 
-       return (addr < &local_var);
+	return (addr < &local_var);
 }
 
 static void setup(void)
@@ -90,7 +88,7 @@ static void *allocate_stack(size_t stack_size, size_t mapped_size)
 	long reserved_size = 256 * page_size + stack_size;
 
 	start = SAFE_MMAP(NULL, reserved_size, PROT_READ | PROT_WRITE,
-	                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	SAFE_MUNMAP(start, reserved_size);
 
 	SAFE_MMAP((start + reserved_size - mapped_size), mapped_size, PROT_READ | PROT_WRITE,
@@ -103,12 +101,12 @@ static void *allocate_stack(size_t stack_size, size_t mapped_size)
 	tst_res(TINFO, "start = %p, stack_top = %p, stack bottom = %p",
 		start, stack_top, stack_bottom);
 	tst_res(TINFO, "mapped pages %zu, stack pages %zu",
-	        mapped_size/page_size, stack_size/page_size);
+		mapped_size/page_size, stack_size/page_size);
 
 	return stack_bottom;
 }
 
-static __attribute__((noinline)) void *check_depth_recursive(void *limit)
+static __attribute_noinline__ void *check_depth_recursive(void *limit)
 {
 	if ((off_t) &limit < (off_t) limit) {
 		tst_res(TINFO, "&limit = %p, limit = %p", &limit, limit);
@@ -192,10 +190,10 @@ static void grow_stack_fail(size_t stack_size, size_t mapped_size)
 	}
 
 	SAFE_WAIT(&wstatus);
-        if (WIFSIGNALED(wstatus) && WTERMSIG(wstatus) == SIGSEGV)
+	if (WIFSIGNALED(wstatus) && WTERMSIG(wstatus) == SIGSEGV)
 		tst_res(TPASS, "Child killed by %s as expected", tst_strsig(SIGSEGV));
-        else
-                tst_res(TFAIL, "Child: %s", tst_strstatus(wstatus));
+	else
+		tst_res(TFAIL, "Child: %s", tst_strstatus(wstatus));
 }
 
 static void run_test(void)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
