Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D337C28B28
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 11:16:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9BDD3CABCB
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 12:16:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F3373CABD5
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:14:21 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DE5701400BF8
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:14:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9BCF721B87;
 Tue, 18 Mar 2025 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742296443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNNWfXN2LyZwRgsqj7kw4/yTkLmxbpQhq+b6ijwoF88=;
 b=SQVuDoAxWXZuiVeN36Xur3GxtwrvVd2qLnCTy1qYEhAjFSCXWboVBZ2xJzdrz5OQfZOOVE
 OE/W7jwOmzeAvie+s4RiR0/pK8eO3p04c9R5FHS6mmCrAyeM+MmyPYaL/pCu7gNd9dfP2E
 SXEI27gdA4KiShSEhhfAeP2K/6uUAWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742296443;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNNWfXN2LyZwRgsqj7kw4/yTkLmxbpQhq+b6ijwoF88=;
 b=KaNSNyZ1Zbm+x9H0DX/5Rg9JR1tsDLwkM7lu9HQcOKyTT4ap1UDtuHwzun1qHHzDxI7joV
 +UJFKo5TUw1pD/BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742296443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNNWfXN2LyZwRgsqj7kw4/yTkLmxbpQhq+b6ijwoF88=;
 b=SQVuDoAxWXZuiVeN36Xur3GxtwrvVd2qLnCTy1qYEhAjFSCXWboVBZ2xJzdrz5OQfZOOVE
 OE/W7jwOmzeAvie+s4RiR0/pK8eO3p04c9R5FHS6mmCrAyeM+MmyPYaL/pCu7gNd9dfP2E
 SXEI27gdA4KiShSEhhfAeP2K/6uUAWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742296443;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNNWfXN2LyZwRgsqj7kw4/yTkLmxbpQhq+b6ijwoF88=;
 b=KaNSNyZ1Zbm+x9H0DX/5Rg9JR1tsDLwkM7lu9HQcOKyTT4ap1UDtuHwzun1qHHzDxI7joV
 +UJFKo5TUw1pD/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35565139D2;
 Tue, 18 Mar 2025 11:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CIfiBntV2WdGRgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 18 Mar 2025 11:14:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 18 Mar 2025 12:13:57 +0100
MIME-Version: 1.0
Message-Id: <20250318-mmap_suite_refactoring-v5-5-1b087988f1c9@suse.com>
References: <20250318-mmap_suite_refactoring-v5-0-1b087988f1c9@suse.com>
In-Reply-To: <20250318-mmap_suite_refactoring-v5-0-1b087988f1c9@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742296439; l=5891;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=YEwfJuJHdcrHFPlzDThKLotF1elAg3+B/oz2c6N04Qs=;
 b=lQfo1/o0V2Nz1iKmm/f+4UD6JkYW8s6NgjH3VZ+SmRbWwYfez8CcSY3os68fWpDNoaBHt4rEE
 YpVY7t3+WWVChsD+2WGcp7jz/B/d6+KiEoV71dA/hUTwQao3OBq5Kda
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 5/8] Cleanup mmap18 test
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap18.c | 90 ++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 47 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap18.c b/testcases/kernel/syscalls/mmap/mmap18.c
index b37b29890ca009ea671b29e81e02fc1e42b44dbb..3de524ecc60b53ec352f58a00620dc39f3f787a5 100644
--- a/testcases/kernel/syscalls/mmap/mmap18.c
+++ b/testcases/kernel/syscalls/mmap/mmap18.c
@@ -1,58 +1,54 @@
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
+ * Verify mmap() syscall using MAP_GROWSDOWN flag.
+ *
+ * [Algorithm]
  *
- * # Test1:
+ * **Test 1**
  *
- *   We assign the memory region partially allocated with MAP_GROWSDOWN flag to
- *   a thread as a stack and expect the mapping to grow when we touch the
- *   guard page by calling a recusive function in the thread that uses the
- *   growable mapping as a stack.
+ * We assign the memory region partially allocated with MAP_GROWSDOWN flag to
+ * a thread as a stack and expect the mapping to grow when we touch the
+ * guard page by calling a recusive function in the thread that uses the
+ * growable mapping as a stack.
  *
- *   The kernel only grows the memory region when the stack pointer is within
- *   guard page when the guard page is touched so simply faulting the guard
- *   page will not cause the mapping to grow.
+ * The kernel only grows the memory region when the stack pointer is within
+ * guard page when the guard page is touched so simply faulting the guard
+ * page will not cause the mapping to grow.
  *
- *   Newer kernels does not allow a MAP_GROWSDOWN mapping to grow closer than
- *   'stack_guard_gap' pages to an existing mapping. So when we map the stack we
- *   make sure there is enough of free address space before the lowest stack
- *   address.
+ * Newer kernels does not allow a MAP_GROWSDOWN mapping to grow closer than
+ * 'stack_guard_gap' pages to an existing mapping. So when we map the stack we
+ * make sure there is enough of free address space before the lowest stack
+ * address.
  *
- *   Kernel default 'stack_guard_gap' size is '256 * getpagesize()'.
+ * Kernel default `stack_guard_gap` size is `256 * getpagesize()`.
  *
- *   The stack memory map would look like:
+ * The stack memory map would look like:
  *
- *   |  -  -  -   reserved  size   -  -  -  |
+ * |  -  -  -   reserved  size   -  -  -  |
  *
- *   +-- - - - --+------------+-------------+
- *   | 256 pages |  unmapped  |   mapped    |
- *   +-- - - - --+------------+-------------+
- *                            | mapped size |
- *   ^           |  -  -  stack size  -  -  |
- *   start
- *               ^                          ^
- *               stack bottom       stack top
+ * +-- - - - --+------------+-------------+
+ * | 256 pages |  unmapped  |   mapped    |
+ * +-- - - - --+------------+-------------+
+ *                          | mapped size |
+ * ^           |  -  -  stack size  -  -  |
+ * start
+ *             ^                          ^
+ *             stack bottom       stack top
  *
- * # Test2:
+ * **Test 2**
  *
- *   We allocate stack as we do in the first test but we mmap a page in the
- *   space the stack is supposed to grow into and we expect the thread to
- *   segfault when the guard page is faulted.
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
 
@@ -63,12 +59,12 @@ static bool __attribute__((noinline)) check_stackgrow_up(void)
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
@@ -90,7 +86,7 @@ static void *allocate_stack(size_t stack_size, size_t mapped_size)
 	long reserved_size = 256 * page_size + stack_size;
 
 	start = SAFE_MMAP(NULL, reserved_size, PROT_READ | PROT_WRITE,
-	                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	SAFE_MUNMAP(start, reserved_size);
 
 	SAFE_MMAP((start + reserved_size - mapped_size), mapped_size, PROT_READ | PROT_WRITE,
@@ -103,7 +99,7 @@ static void *allocate_stack(size_t stack_size, size_t mapped_size)
 	tst_res(TINFO, "start = %p, stack_top = %p, stack bottom = %p",
 		start, stack_top, stack_bottom);
 	tst_res(TINFO, "mapped pages %zu, stack pages %zu",
-	        mapped_size/page_size, stack_size/page_size);
+		mapped_size/page_size, stack_size/page_size);
 
 	return stack_bottom;
 }
@@ -192,10 +188,10 @@ static void grow_stack_fail(size_t stack_size, size_t mapped_size)
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
