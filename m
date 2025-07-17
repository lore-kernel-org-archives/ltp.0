Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB56DC83F1A
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 11:55:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17EDC3CC26B
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 13:55:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 246443CC16E
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 13:55:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 522FE14004EE
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 13:55:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 319BA1F7DD;
 Thu, 17 Jul 2025 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752753306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kTpxEN3Ctgq/q9uCKapi7Cg1ad8rchhY18d/lg7BYzw=;
 b=oolQfn697OImlVXkJInzXwFsZgYA1TnQjEuCrPWD84FP5Rvl4NKcMn5vVM5mK1hkpXXgob
 a2oPVIJSVXv69ffRDkYcHp7x7cbCTFCBmDKuxbHpeRAjXHEw7u7kgc2V9a19fBOTKyA0Dp
 Zum+6CpQEBHQCTLu5J96jFBFkPGvX+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752753306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kTpxEN3Ctgq/q9uCKapi7Cg1ad8rchhY18d/lg7BYzw=;
 b=TfYo0qHUUQAQdAYk9ikJN1AK5SWc+hmviyHl4zw9gxhGfBPgHXREy2ICk6VGkhoV8fDiYL
 e5GivJjbXbvd9kCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752753306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kTpxEN3Ctgq/q9uCKapi7Cg1ad8rchhY18d/lg7BYzw=;
 b=oolQfn697OImlVXkJInzXwFsZgYA1TnQjEuCrPWD84FP5Rvl4NKcMn5vVM5mK1hkpXXgob
 a2oPVIJSVXv69ffRDkYcHp7x7cbCTFCBmDKuxbHpeRAjXHEw7u7kgc2V9a19fBOTKyA0Dp
 Zum+6CpQEBHQCTLu5J96jFBFkPGvX+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752753306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kTpxEN3Ctgq/q9uCKapi7Cg1ad8rchhY18d/lg7BYzw=;
 b=TfYo0qHUUQAQdAYk9ikJN1AK5SWc+hmviyHl4zw9gxhGfBPgHXREy2ICk6VGkhoV8fDiYL
 e5GivJjbXbvd9kCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D83713A75;
 Thu, 17 Jul 2025 11:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PzJQBZrkeGg/BAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 17 Jul 2025 11:55:06 +0000
Date: Thu, 17 Jul 2025 13:55:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: chunfuwen <chwen@redhat.com>
Message-ID: <aHjkw9PhCeyByVcZ@yuki.lan>
References: <20250613081409.2391948-1-chwen@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250613081409.2391948-1-chwen@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,suse.cz:email,linux-test-project.readthedocs.io:url];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10] Add tls parameter and flag:CLONE_SETTLS cover
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
> tls parameter and related flag:CLONE_SETTLS are missed in the testing,
> so add them into existed test case
> 
> Signed-off-by: chunfuwen <chwen@redhat.com>
> ---
> Changes in v10:
> - Fix fedora42 failure by adding tcb
> - Add missing usleep(1000) in free_tls
> 
> Changes in v9:
> - allow small delay by using usleep before call free_tls
> - validate ./clone10 -i 10 on aarch64 and x86_64, both pass 
> 
> Changes in v8:
> - call free_tls() in touch_tls_in_child instead of cleanup
> - remove CFLAGS += -fsanitize=address in Makefile to fix memory double free
>   issue
> 
> Changes in v7:
> - remove unnecessary in verify_tls()
> - add CFLAGS += -fsanitize=address in Makefile to fix memory double free
>   issue
> 
> Changes in v6:
> - update flag to effective combination
> - combine x86_64 with other arches
> - rename child function
> - remove inproper exit
> - remove unused code lines
> - remove sleep statement
> 
> Changes in v5:
> - wrap duplicate code into one single methold
> - remove duplicately malloc
> 
> Changes in v4:
> - remove riscv and loongarch definition
> 
> Changes in v3:
> - fix missing head file for x86
> 
> Changes in v2:
> - create separate files for clone and clone3
> 
> ---
>  runtest/syscalls                            |   2 +
>  testcases/kernel/syscalls/clone/.gitignore  |   1 +
>  testcases/kernel/syscalls/clone/clone10.c   | 170 ++++++++++++++++++++
>  testcases/kernel/syscalls/clone3/.gitignore |   1 +
>  testcases/kernel/syscalls/clone3/clone304.c | 158 ++++++++++++++++++
>  5 files changed, 332 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/clone/clone10.c
>  create mode 100644 testcases/kernel/syscalls/clone3/clone304.c
> 
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
> index 000000000..badcf263d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone/clone10.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
> + * Author: Chunfu Wen <chwen@redhat.com>
> + */
> +
> +/*\
> + * Add tls parameter and flag:CLONE_SETTLS cover for clone
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
> +
> +#define TLS_EXP 100
> +#define TLS_SIZE 4096
> +#define TLS_ALIGN 16
> +
> +#ifndef ARCH_SET_FS
> +#define ARCH_SET_FS 0x1002
> +#endif
> +
> +#if defined(__x86_64__)
> +
> +// Structure mimicking glibc's TCB to be simplified for x86_64
> +typedef struct {
> +    void *tcb;
> +    void *dtv;
> +    void *self;
> +    int multiple_threads;
> +    char padding[64];
> +} tcb_t;
> +
> +#endif /* __x86_64__ */
> +
> +static __thread int tls_var = 0;
> +
> +static void *tls_ptr;
> +static struct user_desc *tls_desc;
> +static char *child_stack;
> +static volatile int child_done = 0;
> +
> +static int flags = CLONE_THREAD |  CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_SETTLS;
> +
> +static void *allocate_tls_area(void)
> +{
> +	void *tls_area = aligned_alloc(TLS_ALIGN, TLS_SIZE);
> +	if (!tls_area)
> +		tst_brk(TBROK | TERRNO, "aligned_alloc failed");
> +	memset(tls_area, 0, TLS_SIZE);
> +
> +#if defined(__x86_64__)
> +	// Set up a minimal TCB for x86_64
> +	tcb_t *tcb = (tcb_t *)tls_area;
> +	tcb->tcb = tls_area;
> +	tcb->self = tls_area;
> +	tcb->multiple_threads = 1;
> +#endif
> +
> +	return tls_area;
> +}
> +
> +static void init_tls(void)
> +{
> +#if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__)
> +	tls_ptr = allocate_tls_area();
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
> +static void free_tls(void)
> +{
> +	usleep(1000);
> +#if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__)
> +	if (tls_ptr) {
> +		free(tls_ptr);
> +		tls_ptr = NULL;
> +	}
> +#elif defined(__i386__)
> +	if (tls_desc) {
> +		free((void *)(uintptr_t)tls_desc->base_addr);
> +		free(tls_desc);
> +		tls_desc = NULL;
> +	}
> +#endif
> +
> +}

All these functions seems to be duplicated in both tests. It should be
better if we put the tls init/alloc/free functions into a common header
in lapi/tls.h

> +static int touch_tls_in_child(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +#if defined(__x86_64__)
> +	// Set the %fs register to point to the TCB
> +	if (syscall(SYS_arch_prctl, ARCH_SET_FS, tls_ptr) == -1) {
> +	    exit(EXIT_FAILURE);
> +	}
> +#endif
> +	tls_var = TLS_EXP + 1;
> +	tst_res(TINFO, "Child (PID: %d, TID: %d): TLS value set to: %d", getpid(),  gettid(), tls_var);
> +
> +	child_done = 1;
> +	free_tls();
> +	return 0;
> +}
> +
> +static void verify_tls(void)
> +{
> +	tls_var = TLS_EXP;
> +
> +	TEST(ltp_clone7(flags, touch_tls_in_child, NULL, CHILD_STACK_SIZE, child_stack, NULL, tls_ptr, NULL));
> +
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "clone() failed");
> +
> +	while (!child_done)
> +		sched_yield();

We have TST_CHECKPOINT_* for parent/child synchronization:

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#checkpoints


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
