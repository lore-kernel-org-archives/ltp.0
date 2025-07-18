Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAF8C83F1A
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 15:26:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A8BD3CC90F
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 17:26:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08A3A3CB4CC
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 17:25:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0E4062009A1
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 17:25:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8619321236;
 Fri, 18 Jul 2025 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752852351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XaxKfE9VQ9iDvC6mAjMJZeG6byqRGQL6cJQAu+ibaok=;
 b=3ahpUJQs5kEZqgi5J+6FDGLsVSQX2QBNKg2faJZWpfij0DHJEcG/zqHZe2tjos5UFlUwOY
 SF3jdIDOPP1St2kSruQEG08epBCdx4o9Crf4jzdsqyM490NaE6G3yMB1X0Ed4Bw6Hjx9G0
 CeANxcX2IT4OKIcnqN6CoDmdqHZT4tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752852351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XaxKfE9VQ9iDvC6mAjMJZeG6byqRGQL6cJQAu+ibaok=;
 b=EJWeOCO8YNvJZAnVK06yYolHcJnhAJfaciC5vSnmJlew9xZT7vMcIehGtok8S6p/U5HFjr
 h2jy6cpUgxSlGNCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752852351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XaxKfE9VQ9iDvC6mAjMJZeG6byqRGQL6cJQAu+ibaok=;
 b=3ahpUJQs5kEZqgi5J+6FDGLsVSQX2QBNKg2faJZWpfij0DHJEcG/zqHZe2tjos5UFlUwOY
 SF3jdIDOPP1St2kSruQEG08epBCdx4o9Crf4jzdsqyM490NaE6G3yMB1X0Ed4Bw6Hjx9G0
 CeANxcX2IT4OKIcnqN6CoDmdqHZT4tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752852351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XaxKfE9VQ9iDvC6mAjMJZeG6byqRGQL6cJQAu+ibaok=;
 b=EJWeOCO8YNvJZAnVK06yYolHcJnhAJfaciC5vSnmJlew9xZT7vMcIehGtok8S6p/U5HFjr
 h2jy6cpUgxSlGNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69BA1138D2;
 Fri, 18 Jul 2025 15:25:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DnJxGX9nemiORAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 18 Jul 2025 15:25:51 +0000
Date: Fri, 18 Jul 2025 17:26:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: chunfuwen <chwen@redhat.com>
Message-ID: <aHpnqXdFCSHwImaO@yuki.lan>
References: <20250718090321.3632996-1-chwen@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250718090321.3632996-1-chwen@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v11] Add tls parameter and flag:CLONE_SETTLS cover
 for clone and clone3 syscall
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  include/lapi/tls.h                          | 102 ++++++++++++++++++
>  runtest/syscalls                            |   2 +
>  testcases/kernel/syscalls/clone/.gitignore  |   1 +
>  testcases/kernel/syscalls/clone/clone10.c   |  98 ++++++++++++++++++
>  testcases/kernel/syscalls/clone3/.gitignore |   1 +
>  testcases/kernel/syscalls/clone3/clone304.c | 108 ++++++++++++++++++++

There a few couple of things to fix. Please run make check in the
directories this patch adds files (include/lapi/ syscalls/clone/ and
syscalls/clone3/) and fix the errors and warnings reported for the newly
added files.

>  6 files changed, 312 insertions(+)
>  create mode 100644 include/lapi/tls.h
>  create mode 100644 testcases/kernel/syscalls/clone/clone10.c
>  create mode 100644 testcases/kernel/syscalls/clone3/clone304.c
> 
> diff --git a/include/lapi/tls.h b/include/lapi/tls.h
> new file mode 100644
> index 000000000..f433fc392
> --- /dev/null
> +++ b/include/lapi/tls.h
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
> + * Author: Chunfu Wen <chwen@redhat.com>
> + */
> +
> +/*\
> + * tls init/alloc/free common functions
> + */
> +
> +#ifndef _LAPI_TLS_H
> +#define _LAPI_TLS_H
> +
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +#if defined(__i386__)
> +#include <asm/ldt.h>
> +#endif
> +
> +#include "tst_test.h"
> +
> +#define TLS_SIZE 4096
> +#define TLS_ALIGN 16
> +
> +#if defined(__x86_64__)
> +// Structure mimicking glibc's TCB to be simplified for x86_64
> +typedef struct {
> +    void *tcb;
> +    void *dtv;
> +    void *self;
> +    int multiple_threads;
> +    char padding[64];
> +} tcb_t;
> +#endif
> +
> +// Global pointers for TLS management
> +extern void *tls_ptr;
> +extern struct user_desc *tls_desc;
> +
> +static inline void *allocate_tls_area(void)
> +{
> +        void *tls_area = aligned_alloc(TLS_ALIGN, TLS_SIZE);
> +	if (!tls_area)
> +	        tst_brk(TBROK | TERRNO, "aligned_alloc failed");
> +	memset(tls_area, 0, TLS_SIZE);
> +
> +#if defined(__x86_64__)
> +	// Set up a minimal TCB for x86_64
> +	tcb_t *tcb = (tcb_t *)tls_area;
> +	tcb->tcb = tls_area;
> +	tcb->self = tls_area;
> +	tcb->multiple_threads = 1;
> +#endif
> +	return tls_area;
> +}
> +
> +static inline void init_tls(void)
> +{
> +#if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__)
> +        tls_ptr = allocate_tls_area();
> +
> +#elif defined(__i386__)
> +	tls_ptr = allocate_tls_area();
> +	tls_desc = SAFE_MALLOC(sizeof(*tls_desc));
> +	memset(tls_desc, 0, sizeof(*tls_desc));
> +	tls_desc->entry_number = -1;
> +	tls_desc->base_addr = (unsigned long)tls_ptr;
> +	tls_desc->limit = TLS_SIZE;
> +	tls_desc->seg_32bit = 1;
> +	tls_desc->contents = 0;
> +	tls_desc->read_exec_only = 0;
> +	tls_desc->limit_in_pages = 0;
> +	tls_desc->seg_not_present = 0;
> +	tls_desc->useable = 1;
> +
> +#else
> +	tst_brk(TCONF, "Unsupported architecture for TLS");
> +#endif
> +}
> +
> +static inline void free_tls(void)
> +{
> +	usleep(1000);

Why is this sleep needed here?

> +#if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__)
> +	if (tls_ptr) {
> +                free(tls_ptr);
> +		tls_ptr = NULL;
> +	}
> +#elif defined(__i386__)
> +	if (tls_desc) {
> +		free((void *)(uintptr_t)tls_desc->base_addr);
> +		free(tls_desc);
> +		tls_desc = NULL;
> +	}
> +#endif
> +}
> +
> +#endif // _LAPI_TLS_H
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 844ae7a13..10f64270a 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -122,10 +122,12 @@ clone06 clone06
>  clone07 clone07
>  clone08 clone08
>  clone09 clone09
> +clone10 clone10
>  
>  clone301 clone301
>  clone302 clone302
>  clone303 clone303
> +clone304 clone304
>  
>  close01 close01
>  close02 close02
> diff --git a/testcases/kernel/syscalls/clone/.gitignore b/testcases/kernel/syscalls/clone/.gitignore
> index 900cac19c..adfb8257d 100644
> --- a/testcases/kernel/syscalls/clone/.gitignore
> +++ b/testcases/kernel/syscalls/clone/.gitignore
> @@ -7,3 +7,4 @@
>  /clone07
>  /clone08
>  /clone09
> +/clone10
> diff --git a/testcases/kernel/syscalls/clone/clone10.c b/testcases/kernel/syscalls/clone/clone10.c
> new file mode 100644
> index 000000000..b0899a6b8
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone/clone10.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
> + * Author: Chunfu Wen <chwen@redhat.com>
> + */
> +
> +/*\
> + * Add tls parameter and flag:CLONE_SETTLS cover for clone


This should explain what the test is doing better. As far as I can tell
we do:

Test that in a thread started by clone() that runs in the same address
space (CLONE_VM) but with a different TLS (CLONE_SETTLS) writtes to a
thread local variables are not propagated back from the cloned thread.

> + */
> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <sched.h>
> +#include <sys/wait.h>
> +
> +#if defined(__i386__)
> +#include <asm/ldt.h>
> +#endif
> +
> +#include "tst_test.h"
> +#include "clone_platform.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/tls.h"
> +
> +#define TLS_EXP 100
> +
> +#ifndef ARCH_SET_FS
> +#define ARCH_SET_FS 0x1002
> +#endif
> +
> +// Global pointers for TLS management
> +void *tls_ptr = NULL;
> +struct user_desc *tls_desc = NULL;
> +
> +static __thread int tls_var = 0;
> +
> +static char *child_stack;
> +static volatile int child_done = 0;
> +
> +static int flags = CLONE_THREAD |  CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_SETTLS;
> +
> +static int touch_tls_in_child(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +#if defined(__x86_64__)
> +	// Set the %fs register to point to the TCB
> +	if (syscall(SYS_arch_prctl, ARCH_SET_FS, tls_ptr) == -1) {
> +	        exit(EXIT_FAILURE);
> +	}

So this is stil needed despite the tst_ptr passed to the kernel in the
clone() call?

Can we move this to a function in the lapi header as well? Something as
"child_init_tls()" and call it here?

> +#endif
> +	tls_var = TLS_EXP + 1;
> +	tst_res(TINFO, "Child (PID: %d, TID: %d): TLS value set to: %d", getpid(),  gettid(), tls_var);
> +
> +	TST_CHECKPOINT_WAKE(0);
> +	free_tls();
> +	return 0;

Shouldn't we call the __NR_exit here as well?

> +}
> +
> +static void verify_tls(void)
> +{
> +	tls_var = TLS_EXP;
> +
> +	TEST(ltp_clone7(flags, touch_tls_in_child, NULL, CHILD_STACK_SIZE, child_stack, NULL, tls_ptr, NULL));
> +
> +	if (TST_RET == -1)
> +	        tst_brk(TBROK | TTERRNO, "clone() failed");
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	if (TLS_EXP == tls_var) {
> +		tst_res(TPASS,
> +			"Parent (PID: %d, TID: %d): TLS value correct: %d",
> +			getpid(), gettid(), tls_var);
> +	} else {
> +		tst_res(TFAIL,
> +			"Parent (PID: %d, TID: %d): TLS value mismatch: got %d, expected %d",
> +			getpid(), gettid(), tls_var, TLS_EXP);
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
> +	init_tls();
> +}
> +
> +static void cleanup(void)
> +{
> +	free(child_stack);
> +}
> +
> +static struct tst_test test = {
> +	    .setup = setup,
> +	    .cleanup = cleanup,
> +	    .needs_checkpoints = 1,
> +	    .test_all = verify_tls,
> +};
> diff --git a/testcases/kernel/syscalls/clone3/.gitignore b/testcases/kernel/syscalls/clone3/.gitignore
> index 10369954b..e9b5312f4 100644
> --- a/testcases/kernel/syscalls/clone3/.gitignore
> +++ b/testcases/kernel/syscalls/clone3/.gitignore
> @@ -1,3 +1,4 @@
>  clone301
>  clone302
>  clone303
> +clone304
> diff --git a/testcases/kernel/syscalls/clone3/clone304.c b/testcases/kernel/syscalls/clone3/clone304.c
> new file mode 100644
> index 000000000..d45ac2395
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone3/clone304.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
> + * Author: Chunfu Wen <chwen@redhat.com>
> + */
> +
> +/*\
> + * Add tls parameter and flag:CLONE_SETTLS cover for clone3

The description here should be the same as in the previous one but it
should say clone3 instead of clone

> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +
> +#if defined(__i386__)
> +#include <asm/ldt.h>
> +#endif
> +
> +#include "tst_test.h"
> +#include "lapi/sched.h"
> +#include "lapi/pidfd.h"
> +#include "lapi/tls.h"
> +
> +#define TLS_EXP 100
> +
> +#define CHILD_STACK_SIZE (1024*1024)
> +
> +// Global pointers for TLS management
> +void *tls_ptr = NULL;
> +struct user_desc *tls_desc = NULL;
> +
> +static int pidfd, child_tid, parent_tid;
> +static struct clone_args *args;
> +static void *child_stack;
> +
> +/* TLS variable to validate in child */
> +static __thread int tls_var = 0;
> +
> +static int test_flags = CLONE_THREAD |  CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_SETTLS;
> +
> +static int check_tls_in_child(void)
> +{
> +	tls_var = TLS_EXP + 1;
> +	tst_res(TINFO, "Child (PID: %d, TID: %d): TLS value set to: %d", getpid(),  gettid(), tls_var);
> +
> +	TST_CHECKPOINT_WAKE(0);
> +	tst_syscall(__NR_exit, 0);
> +	return 0;
> +}
> +
> +static void run(void)
> +{
> +	pid_t pid;
> +	tls_var = TLS_EXP;
> +
> +	args->flags = test_flags;
> +	args->pidfd = (uint64_t)(&pidfd);
> +	args->child_tid = (uint64_t)(&child_tid);
> +	args->parent_tid = (uint64_t)(&parent_tid);
> +	args->stack = (uint64_t)(child_stack);
> +	args->stack_size = CHILD_STACK_SIZE;
> +	args->tls = (uint64_t)tls_ptr;
> +
> +	TEST(pid = clone3(args, sizeof(*args)));
> +
> +	if (TST_RET == -1)
> +	        tst_brk(TBROK | TTERRNO, "clone() failed");
> +
> +	if (!pid)
> +		check_tls_in_child();
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	if (TLS_EXP == tls_var) {
> +		tst_res(TPASS,
> +			"Parent (PID: %d, TID: %d): TLS value correct: %d",
> +			getpid(), gettid(), tls_var);
> +	} else {
> +		tst_res(TFAIL,
> +			"Parent (PID: %d, TID: %d): TLS value mismatch: got %d, expected %d",
> +			getpid(), gettid(), tls_var, TLS_EXP);
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	clone3_supported_by_kernel();
> +	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
> +	init_tls();
> +}
> +
> +static void cleanup(void)
> +{
> +	free(child_stack);
> +	free_tls();
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_checkpoints = 1,
> +	.test_all = run,
> +	.bufs = (struct tst_buffers []) {
> +		{&args, .size = sizeof(*args)},
> +		{},
> +	}
> +};
> -- 
> 2.43.5
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
