Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD7DC5CFEB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 12:14:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96C093E6C06
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 14:14:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 294E93DA1BE
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 14:14:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D1E4360070A
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 14:14:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A5103E83;
 Thu, 13 Aug 2026 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786623245;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+tsts6Ad4rSuOazF9tBT1bAmw743eVZvueWYo2lvSk=;
 b=HQa9mfr2owj2RX4FG1ROma9WgoMBiGK4gODf8ajakWCoypw1BR+lQKbXADeFegCq4pwL/9
 4c87Jpy6jdPLn5z1eJEPp9Q6Xx0X1NoFtVeRVLnJ8NwK0jjVj/+mZlize6AzZ56elMFlWB
 8lP0Vjy2ws+wnalR4QphJm7B9yHusf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786623245;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+tsts6Ad4rSuOazF9tBT1bAmw743eVZvueWYo2lvSk=;
 b=bOaxjDlrWtvVwuB/L7LHpyG74DvBUxa8caI9NHQd94RxoD6GK/RGcxpdvdGmoJ68/60Ufh
 Ivn41GNt/G7DAJBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786623241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+tsts6Ad4rSuOazF9tBT1bAmw743eVZvueWYo2lvSk=;
 b=KsGwueo6a+55ZDZiF+mzj75SXRJoLRCY83rIYMcefLyFd+aIYxWtlpgTz20d5hODxCjgvh
 B/tSf5OE2k4y118XXIl0eGiybpNIPHks2YM1hfm1ruT8AuKaEWqmFvRug2dKD7+mD0dJB8
 gwwLK6vsS6Euj5crM2PfoKrLeLiGGjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786623241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+tsts6Ad4rSuOazF9tBT1bAmw743eVZvueWYo2lvSk=;
 b=41BCfbpjZxOTInuprvAVbUdcwV9TvGAzMORDIDvl4xuEBiTJX1DZQHYz4DSu6JFSqBnwfx
 Fqka8BfpxIBQYpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E097477DF1;
 Thu, 13 Aug 2026 12:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dKrpNAi1fWrdQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 13 Aug 2026 12:14:00 +0000
Date: Thu, 13 Aug 2026 14:13:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260813121355.GE1843300@pevik>
References: <20260803-cve-ghostlock-v3-0-cde83fa429b7@suse.com>
 <20260803-cve-ghostlock-v3-2-cde83fa429b7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803-cve-ghostlock-v3-2-cde83fa429b7@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_DN_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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

FYI on some of my Tumbleweed VM with 7.2.0-rc6-3.g1b28f10-default
test timeouts:

tst_test.c:2047: TINFO: LTP version: 20260529-202-ga91c5b6036
tst_test.c:2050: TINFO: Tested kernel: 7.2.0-rc6-3.g1b28f10-default #1 SMP PREEMPT_DYNAMIC Thu Aug  6 23:49:19 UTC 2026 (1b28f10) x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:756: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1875: TINFO: Overall timeout per run is 0h 05m 00s
ghostlock.c:191: TINFO: Triggering PI deadlock and stack spray
Test timeouted, sending SIGKILL!
tst_test.c:1947: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1949: TBROK: Test killed! (timeout?)

> +static int futex_wait_requeue_pi(uint32_t *uaddr, uint32_t *uaddr2,
> +				 struct timespec *ts)
> +{
> +	return tst_syscall(__NR_futex, uaddr, FUTEX_WAIT_REQUEUE_PI, 0, ts,
> +			   uaddr2, 0);
> +}
> +
> +static int futex_cmp_requeue_pi(uint32_t *uaddr, uint32_t *uaddr2)
> +{
> +	return tst_syscall(__NR_futex, uaddr, FUTEX_CMP_REQUEUE_PI, 1, 1,
> +			   uaddr2, 0);
> +}
> +
> +static int futex_lock_pi(uint32_t *uaddr)
> +{
> +	return tst_syscall(__NR_futex, uaddr, FUTEX_LOCK_PI, 0, 0, 0, 0);
> +}
> +
> +static int futex_unlock_pi(uint32_t *uaddr)
> +{
> +	return tst_syscall(__NR_futex, uaddr, FUTEX_UNLOCK_PI, 0, 0, 0, 0);
> +}
nit: we already have sys_futex() in include/tst_timer.h, maybe using it?

> +
> +static void *waiter_fn(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	struct timespec ts;
> +	struct prctl_mm_map mm_map = {
> +		.start_code  = (uint64_t)(uintptr_t)&waiter_fn,
> +		.end_code    = (uint64_t)(uintptr_t)&waiter_fn + 0x1000,
> +		.start_data  = (uint64_t)(uintptr_t)auxv & ~0xfffUL,
> +		.end_data    = ((uint64_t)(uintptr_t)auxv & ~0xfffUL) + 0x1000,
> +		.start_brk   = (uint64_t)(uintptr_t)sbrk(0),
> +		.brk         = (uint64_t)(uintptr_t)sbrk(0),
> +		.start_stack = (uint64_t)(uintptr_t)&mm_map,
> +		.arg_start   = (uint64_t)(uintptr_t)&mm_map,
> +		.arg_end     = (uint64_t)(uintptr_t)&mm_map,
> +		.env_start   = (uint64_t)(uintptr_t)&mm_map,
> +		.env_end     = (uint64_t)(uintptr_t)&mm_map,
> +		.auxv        = (void *)auxv,
> +		.auxv_size   = valid_auxv_size,
> +		.exe_fd      = (uint32_t)-1,
> +	};

nice magic :).
> +
> +	waiter_tid = tst_syscall(__NR_gettid);
> +
> +	futex_lock_pi(&f_pi_chain);
> +
> +	TST_CHECKPOINT_WAKE2(CP_CHAIN_HELD, 2);
> +	TST_CHECKPOINT_WAIT(CP_OWNER_BLOCKED);
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &ts);
> +	ts = tst_timespec_add(ts, (struct timespec){ .tv_sec = 10, .tv_nsec = 0 });
> +	futex_wait_requeue_pi(&f_wait, &f_pi_target, &ts);
> +
> +	TST_CHECKPOINT_WAKE(CP_SPRAYED);
> +
> +	while (!tst_atomic_load(&stop_spray)) {
> +		prctl(PR_SET_MM, PR_SET_MM_MAP, (unsigned long)&mm_map,
> +		      sizeof(mm_map), 0);

Maybe SAFE_PRCTL() ?
> +	}
> +
> +	TST_CHECKPOINT_WAIT(CP_SETATTR_DONE);
> +
> +	futex_unlock_pi(&f_pi_chain);
> +
> +	return NULL;
> +}
> +
> +static void *owner_fn(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	owner_tid = tst_syscall(__NR_gettid);
> +
> +	TST_CHECKPOINT_WAIT(CP_CHAIN_HELD);
> +
> +	futex_lock_pi(&f_pi_target);
> +	TST_CHECKPOINT_WAKE(CP_TARGET_HELD);
> +
> +	futex_lock_pi(&f_pi_chain);
> +
> +	futex_unlock_pi(&f_pi_chain);
> +	futex_unlock_pi(&f_pi_target);
> +
> +	return NULL;
> +}
> +
> +static void setup(void)
> +{
> +	static const int try_sizes[] = {
very nit: why static?

> +		MAX_AUXV_WORDS,
> +		MAX_AUXV_WORDS - 4,
> +		MAX_AUXV_WORDS - 8
I wonder why these other 2?

Code LGTM, but I'd like to have at least brief look at the original reproducers.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
