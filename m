Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07E8C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 19:36:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DFEB3CB001
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 21:36:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B9633CA2B5
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 21:35:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9CF61600055
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 21:35:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 54BBA33AE3;
 Mon, 17 Oct 2022 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666035349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30hgZiX/ONDd1KUoI5S5inoap78nFqh2zMe/zCJV8Ho=;
 b=CGeCGlVKsIjBWDGNyqdYDkacdSXO35Ldl64mCXn4gsOoFVkS+/PsL+NURHQURzHOM4GyFg
 f/BSdZ86Tu00RFAIILfDDXXzA4uvg5i0MMjW1fRFIQGDZu3ox8Ai/y+bE5uNEF6d7i3jlY
 pdkbWUQdMZky9pfir2HYFkUJsW1N2Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666035349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30hgZiX/ONDd1KUoI5S5inoap78nFqh2zMe/zCJV8Ho=;
 b=Lq2nfnyJFhEv96qJ3lLV8oMHTdGFJs84qIawoOrnW9piKKJGCvUDlddocbXk4Fwxv3JtXg
 D49bGJZ9xWUGmqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3616313ABE;
 Mon, 17 Oct 2022 19:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XJ89DJWuTWO4GQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 17 Oct 2022 19:35:49 +0000
Date: Mon, 17 Oct 2022 21:37:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y02u+uzMWnP64NUv@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-13-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221016125731.249078-13-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 12/29] Hugetlb: Migrating libhugetlbfs
 icache-hygiene
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, ltp@lists.linux.it,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Migrating the libhugetlbfs/testcases/icache-hygiene.c test
> 
> Test Description: Older ppc64 kernels don't properly flush dcache to
> icache before giving a cleared page to userspace.  With some exceedingly
> hairy code, this attempts to test for this bug.
> 
> This test will never trigger (obviously) on machines with coherent
> icache and dcache (including x86 and POWER5).  On any given run,
> even on a buggy kernel there's a chance the bug won't trigger -
> either because we don't get the same physical page back when we
> remap, or because the icache happens to get flushed in the interim.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  | 250 ++++++++++++++++++
>  3 files changed, 252 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 796ebe7fa..0714ed34c 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -16,6 +16,7 @@ hugemmap11 hugemmap11
>  hugemmap12 hugemmap12
>  hugemmap13 hugemmap13
>  hugemmap14 hugemmap14
> +hugemmap15 hugemmap15
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 3106579ce..d59b60fd4 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -15,6 +15,7 @@
>  /hugetlb/hugemmap/hugemmap12
>  /hugetlb/hugemmap/hugemmap13
>  /hugetlb/hugemmap/hugemmap14
> +/hugetlb/hugemmap/hugemmap15
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> new file mode 100644
> index 000000000..cf1cd96ea
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + *
> + * Test Name: icache hygiene
> + *
> + * Test Description: Older ppc64 kernels don't properly flush dcache to
> + * icache before giving a cleared page to userspace.  With some exceedingly
> + * hairy code, this attempts to test for this bug.
> + *
> + * This test will never trigger (obviously) on machines with coherent
> + * icache and dcache (including x86 and POWER5).  On any given run,
> + * even on a buggy kernel there's a chance the bug won't trigger -
> + * either because we don't get the same physical page back when we
> + * remap, or because the icache happens to get flushed in the interim.
> + *
> + * HISTORY
> + *  Written by David Gibson & Adam Litke
> + *
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <setjmp.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <sys/mman.h>
> +#include <ucontext.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +
> +#include "hugetlb.h"
> +
> +static int  fd = -1;
> +static char hfile[MAXPATHLEN];
> +
> +#define COPY_SIZE	128
> +#define NUM_REPETITIONS	64	/* Seems to be enough to trigger reliably */
> +
> +static char *verbose;
> +static long hpage_size;
> +
> +static void cacheflush(void *p)
> +{
> +	(void)p;
> +#if defined(__powerpc__)
> +	asm volatile("dcbst 0,%0; sync; icbi 0,%0; isync" : : "r"(p));
> +#elif defined(__arm__) || defined(__aarch64__)
> +	__clear_cache(p, p + COPY_SIZE);
> +#endif
> +}
> +
> +static void jumpfunc(int copy, void *p)
> +{
> +	/* gcc bug workaround: if there is exactly one &&label
> +	 * construct in the function, gcc assumes the computed goto
> +	 * goes there, leading to the complete elision of the goto in
> +	 * this case
> +	 */
> +	void *l = &&dummy;
> +
> +	l = &&jumplabel;
> +
> +	if (copy) {
> +		memcpy(p, l, COPY_SIZE);
> +		cacheflush(p);
> +	}
> +
> +	goto *p;
> + dummy:
> +	tst_res(TWARN, "unreachable?");
> +
> + jumplabel:
> +	return;
> +}
> +
> +static sigjmp_buf sig_escape;
> +static void *sig_expected;
> +
> +static void sig_handler(int signum, siginfo_t *si, void *uc)
> +{
> +#if defined(__powerpc__) || defined(__powerpc64__) || defined(__ia64__) || \
> +	defined(__s390__) || defined(__s390x__) || defined(__sparc__) || \
> +	defined(__aarch64__) || (defined(__riscv) && __riscv_xlen == 64)
> +	/* On powerpc, ia64, s390 and Aarch64, 0 bytes are an illegal
> +	 * instruction, so, if the icache is cleared properly, we SIGILL
> +	 * as soon as we jump into the cleared page
> +	 */
> +	if (signum == SIGILL) {
> +		if (verbose)
> +			tst_res(TINFO, "SIGILL at %p (sig_expected=%p)", si->si_addr,
> +				       sig_expected);
> +		if (si->si_addr == sig_expected)
> +			siglongjmp(sig_escape, 1);
> +		tst_res(TFAIL, "SIGILL somewhere unexpected");
> +		goto fail;
> +	}
> +#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)
> +	/* On x86, zero bytes form a valid instruction:
> +	 *	add %al,(%eax)		(i386)
> +	 * or	add %al,(%rax)		(x86_64)
> +	 *
> +	 * So, behaviour depends on the contents of [ER]AX, which in
> +	 * turn depends on the details of code generation.  If [ER]AX
> +	 * contains a valid pointer, we will execute the instruction
> +	 * repeatedly until we run off that hugepage and get a SIGBUS
> +	 * on the second, truncated page.  If [ER]AX does not contain
> +	 * a valid pointer, we will SEGV on the first instruction in
> +	 * the cleared page.  We check for both possibilities
> +	 * below.
> +	 *
> +	 * On 32 bit ARM, zero bytes are interpreted as follows:
> +	 *  andeq	r0, r0, r0	(ARM state, 4 bytes)
> +	 *  movs	r0, r0		(Thumb state, 2 bytes)
> +	 *
> +	 * So, we only expect to run off the end of the huge page and
> +	 * generate a SIGBUS.
> +	 */
> +	if (signum == SIGBUS) {
> +		if (verbose)
> +			tst_res(TINFO, "SIGBUS at %p (sig_expected=%p)", si->si_addr,
> +				       sig_expected);
> +		if (sig_expected
> +		    && (ALIGN((unsigned long)sig_expected, hpage_size)
> +			== (unsigned long)si->si_addr)) {
> +			siglongjmp(sig_escape, 2);
> +		}
> +		tst_res(TFAIL, "SIGBUS somewhere unexpected");
> +		goto fail;
> +	}
> +#if defined(__x86_64__) || defined(__i386__)
> +	if (signum == SIGSEGV) {
> +#ifdef __x86_64__
> +		void *pc = (void *)((ucontext_t *)uc)->uc_mcontext.gregs[REG_RIP];
> +#else
> +		void *pc = (void *)((ucontext_t *)uc)->uc_mcontext.gregs[REG_EIP];
> +#endif
> +		if (verbose)
> +			tst_res(TINFO, "SIGSEGV at %p, PC=%p (sig_expected=%p)\n",
> +				       si->si_addr, pc, sig_expected);
> +		if (sig_expected == pc)
> +			siglongjmp(sig_escape, 1);
> +		tst_res(TFAIL, "SIGSEGV somewhere unexpected");
> +		goto fail;
> +	}
> +#endif
> +#else
> +#error "Need to setup signal conditions for this arch"
> +#endif
> +	return;
> +fail:
> +	tst_brk(TBROK, "Once Failed, No Need to continue the next iteration.");
> +}

Again no tst_res() or tst_brk() is allowed inside a signal handler, the
best we can is to propagate different values for pass/fail in the return
value from siglongjmp().


And the usuall comments apply to this test as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
