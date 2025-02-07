Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C467EC02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 14:53:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57FBE3C93B7
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 15:53:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B26413C9396
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 15:50:38 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C5C851034D53
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 15:50:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 990312111F
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibxwXfk1yhG2gQUQJtRd35XMiNzahG+08pOizztsjgE=;
 b=P6G5uao4AW2o5SNZMwnMu4lLL1XgxHfWSq3OehHHasvauBUBicIj48m43kcjUGVdVtkK+O
 2bD75tpPl49dPKRb4bKBlyBPeuc7lmPPlgadETAPx0CSSu6A0+7gRVJEGI6ahruZZfhckR
 qNyBwxQClP4GouLM44tj6HdOaYl95/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibxwXfk1yhG2gQUQJtRd35XMiNzahG+08pOizztsjgE=;
 b=2lOnwsC+TKMJIT3rf4FBGtd/I0W1Zf7YpAu0gdaO0lbtRa+O84LJcVIPslWnzj6MOJj/QZ
 E8bo8utLgxNhT4Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibxwXfk1yhG2gQUQJtRd35XMiNzahG+08pOizztsjgE=;
 b=P6G5uao4AW2o5SNZMwnMu4lLL1XgxHfWSq3OehHHasvauBUBicIj48m43kcjUGVdVtkK+O
 2bD75tpPl49dPKRb4bKBlyBPeuc7lmPPlgadETAPx0CSSu6A0+7gRVJEGI6ahruZZfhckR
 qNyBwxQClP4GouLM44tj6HdOaYl95/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibxwXfk1yhG2gQUQJtRd35XMiNzahG+08pOizztsjgE=;
 b=2lOnwsC+TKMJIT3rf4FBGtd/I0W1Zf7YpAu0gdaO0lbtRa+O84LJcVIPslWnzj6MOJj/QZ
 E8bo8utLgxNhT4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8453313AC1
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kDehHrwdpmcdQgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 07 Feb 2025 14:50:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Feb 2025 15:50:34 +0100
MIME-Version: 1.0
Message-Id: <20250207-mmap_suite_refactoring-v1-5-d006d921e4d5@suse.com>
References: <20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com>
In-Reply-To: <20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738939835; l=6207;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=j0B0c4Ot7Cm/R/dAXSpAFv2G3vJr1d0w78yaBykIiKk=;
 b=6KHlgAwTUG6y+qwfLHbT/8hG5ujJ9HSHP9wuTNWXykOTFeySi7lPspupv2arggI+SgJIJeygH
 4MiOIXp4Gw6C08IM3kyvft1pdqB31DC8P8WPBTXmzZKGvX38Zey1zVu
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/8] Cleanup mmap18 test
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
