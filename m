Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B618BC38142
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 01:11:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06FEF3CD439
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 02:11:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09A863CB39D
 for <ltp@lists.linux.it>; Wed, 25 Jan 2023 02:11:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D20E81000968
 for <ltp@lists.linux.it>; Wed, 25 Jan 2023 02:11:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71F64211E1;
 Wed, 25 Jan 2023 01:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674609072;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQoTMy+BlFcajZRQzerS/gjc48STYuzjc6z9LM6VdlQ=;
 b=o3o3+FlG+me2fpPytRx+TGE0IPtqM9SqVaC41XvnRg4CLEhJBlrvTqFKKSLvhCmT68e7C6
 Kmxdrvd1XMg547i8rYb80BxZvBKHg6R2PcN4v3ENxVyhTkpeztFb5PkssvP/jxRAqHw4nb
 D40F4StFJ6nmkxsfxUukB2fzp/Xssek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674609072;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQoTMy+BlFcajZRQzerS/gjc48STYuzjc6z9LM6VdlQ=;
 b=gc1LZnnW4HWwV6xi75RlYETQWoRlwymvJTs8uqAAwMNpBz2P5lXwkPmqkOmC0wQ7RcO0kl
 3wRl55UqlFyOjrAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF491139B3;
 Wed, 25 Jan 2023 01:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ii+qN6+B0GOuOAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Jan 2023 01:11:11 +0000
Date: Wed, 25 Jan 2023 02:11:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y9CBrSjw5pDu9Xa6@pevik>
References: <20221220063109.279007-1-tsahu@linux.ibm.com>
 <20221220063109.279007-5-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221220063109.279007-5-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] Hugetlb: Migrating libhugetlbfs
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tarun, all,

> Migrating the libhugetlbfs/testcases/icache-hygiene.c test

> Test Description: Older ppc64 kernels don't properly flush dcache to
> icache before giving a cleared page to userspace.  With some exceedingly
> hairy code, this attempts to test for this bug.

> This test will never trigger (obviously) on machines with coherent
> icache and dcache (including x86 and POWER5).  On any given run,
> even on a buggy kernel there's a chance the bug won't trigger -
> either because we don't get the same physical page back when we
> remap, or because the icache happens to get flushed in the interim.

> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
...
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
...
> +static void sig_handler(int signum, siginfo_t *si, void *uc)
> +{
> +#if defined(__powerpc__) || defined(__powerpc64__) || defined(__ia64__) || \
> +	defined(__s390__) || defined(__s390x__) || defined(__sparc__) || \
> +	defined(__aarch64__) || (defined(__riscv) && __riscv_xlen == 64)
NOTE: do we consider riscv32 and mipsel32 as dead?

> +	/* On powerpc, ia64, s390 and Aarch64, 0 bytes are an illegal
> +	 * instruction, so, if the icache is cleared properly, we SIGILL
> +	 * as soon as we jump into the cleared page
> +	 */
> +	if (signum == SIGILL) {
> +		tst_res(TINFO, "SIGILL at %p (sig_expected=%p)", si->si_addr,
> +				sig_expected);
> +		if (si->si_addr == sig_expected)
> +			siglongjmp(sig_escape, SUCC_JMP);
> +		siglongjmp(sig_escape, FAIL_JMP + SIGILL);
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
> +		tst_res(TINFO, "SIGBUS at %p (sig_expected=%p)", si->si_addr,
> +				sig_expected);
> +		if (sig_expected
> +		    && (PALIGN(sig_expected, hpage_size)
> +			== si->si_addr)) {
> +			siglongjmp(sig_escape, SUCC_JMP);
> +		}
> +		siglongjmp(sig_escape, FAIL_JMP + SIGBUS);
> +	}
> +#if defined(__x86_64__) || defined(__i386__)
> +	if (signum == SIGSEGV) {
> +#ifdef __x86_64__
> +		void *pc = (void *)((ucontext_t *)uc)->uc_mcontext.gregs[REG_RIP];
> +#else
> +		void *pc = (void *)((ucontext_t *)uc)->uc_mcontext.gregs[REG_EIP];
> +#endif
> +		tst_res(TINFO, "SIGSEGV at %p, PC=%p (sig_expected=%p)",
> +				si->si_addr, pc, sig_expected);
> +		if (sig_expected == pc)
> +			siglongjmp(sig_escape, SUCC_JMP);
> +		siglongjmp(sig_escape, FAIL_JMP + SIGSEGV);
> +	}
> +#endif
> +#else
> +#error "Need to setup signal conditions for this arch"

Because this, merged as 15625f6185 ("Hugetlb: Migrating libhugetlbfs
icache-hygiene") broke upcoming LTP release for these archs in Buildroot
toolchains. mipsel32 is quite old, but maybe some other distros still play
with riscv32.

IMHO instead of this there should have been using TST_TEST_TCONF() for
unsupported archs, I'll send patch tomorrow.

Kind regards,
Petr

> +#endif
> +}

...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
