Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4492AC5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 12:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786624936; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=D9sKQ95Rpvjsm6nlJwe+wbQiI4UR8NTvFov7pC1R+fo=;
 b=fvBl00GGm2biqoOBywsRpRkQqr9mRDlST+x2jWU3r2DTEHQu1j5f80ViUiWraeMmtiDTq
 Z2c2BCeqT64jxRPoDU75lQiq476h0bMtmK8ZsCv9t50x9QZSZkZ8nyy6Fo2kx8upNF2r/6u
 YIoEgoU7rnw/JXgkYUdAR1OWkwdC9ks=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 588AE3E6BFE
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 14:42:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B09643E188A
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 14:41:54 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 71EB9200764
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 14:41:54 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so467318f8f.2
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786624914; x=1787229714; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3c1qXcTU3F6EBth0vO1RDFBoO5qP+E2DZWqm+A3cwjI=;
 b=H6/nerSZDaaFAmWTehZoGeARD8prj1UsFyOpWFjahczTImKl9ioLVIdMKnr9opl6rl
 fedS4cU4pPFNmVo2QzfmHGWFHMXg+TzRlH/2ErWKxBuqDkJVW8TAHC1H16CAORfSbHAX
 8WdBUnZHPFMRq2aW1eb7V0SWJa07DsXaaX6igvqp/UuUwR8Cs95pNEmLUmcNEEht4QXZ
 jRc0qOIPAPti8LcYz2iM67QYUckPARx0jA5Euh76YT6g1j7Jg0z+XGQ8ow0EgscPMA5S
 hhKaBevQ0XcmP7eJKfbQuBquCdBINdmGfa+q8HrsSvJONp2kdHsfD/qj1ly/GE+ClZv2
 m3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786624914; x=1787229714;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3c1qXcTU3F6EBth0vO1RDFBoO5qP+E2DZWqm+A3cwjI=;
 b=GYphV7eHgVrc2COdJu/LGwAuWO91QpK8f1Eiad9v71Q4A+Zzkymvhk60+FAyblaS6H
 pA4nrSJy0q7lAnZPwlzrjF+YVTWnbkB7uFpTCwtjBuNZ8KVH8wjBrP/t/oLDrR9qeNvs
 M+r+3gLhy2bH3RJU/JACmXpL4sKVh3VC4jIySLgXIpVLBukZQfHS/e0xaxHS5lP8zx33
 IvogsgdPe41PKFah+4QQoX9opTzejo1qBaA/+9CBmDxZCjWVNoZn9ftbziq14ROJs3X0
 qhjBhb8K/6u86sFYDtqS88Vc3IHD7EHmNEhgbCTyQ2ZpnILxuUNrCWce7OPAD5mMraRy
 Svzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqWITWKHKXLbaEm2RDtKDKmOCQomJlqs8gwh8HKDOBzC3dnIcCuxGrxkH+ipQoygLJgwM=@lists.linux.it
X-Gm-Message-State: AOJu0YyaQpsntgQJvnPf2gYryK5VA9OeTmxrTKAArfmGeXTWgNYjpDZU
 IAei4/uYzLPuB1QmSvNZ3n69wqX4ulZUVweMw/w0QAMKMnEk5VpamcK1mmatU3oBRFM=
X-Gm-Gg: AR+sD11L6rYbvx2sIr+Vc185YlTMywAEwS+t8/Bqb1SZtIEOhTFIFIf5/sBu/ZoRejn
 kLGk7drex2Irc3TQCUo9M1KLwBxhLvIdiJ4wbJCWcpgYXx6c9PZtmwAQmzIJa/zybK8Acvrm2Mx
 5AgzZHI/Pb5c+uHBfVVujZsAETxrVM6KacpXqeWWsqDAS423OskWzNRdOzBpCQ1eXi7xAmMGu9z
 VwBLjDeyyUdcBEDueGhQhaJxOA1C8QzCY0YKyvnr4P9bqVjBVk9yA1d8a33GZR6trjM8EZGEL7K
 B7udVWdYiXXZtex/QtQtvPXeXsZgHyoMNKzZoUz47OswGt5V8XGMDXN8Q8dg9KMrYo/so0mOt7h
 mw/vvgKUQzpenvnac0o6pYNd27snkXNSFvPnSdY2CKtRMZ1n99WHmr/ecnIWESGUmn0oxPcynDn
 Hnh9KyRiH/KZDjolneo50inuT/xr8FqJ8/Y33AKdmJMQWpzJLm7zeM1vaT4W0zAs6MayCj+PQ=
X-Received: by 2002:a05:6000:647:b0:47f:8b1f:efa2 with SMTP id
 ffacd0b85a97d-48159ecf4a7mr7108969f8f.8.1786624913699; 
 Thu, 13 Aug 2026 05:41:53 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5af441sm7112992f8f.22.2026.08.13.05.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 05:41:53 -0700 (PDT)
Message-ID: <6a7dbb91.9099b29d.af1f2.8590@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260813121355.GE1843300@pevik>
Date: Thu, 13 Aug 2026 12:41:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> 
> tst_test.c:2047: TINFO: LTP version: 20260529-202-ga91c5b6036
> tst_test.c:2050: TINFO: Tested kernel: 7.2.0-rc6-3.g1b28f10-default #1 SMP PREEMPT_DYNAMIC Thu Aug  6 23:49:19 UTC 2026 (1b28f10) x86_64
> tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:756: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
> tst_test.c:1875: TINFO: Overall timeout per run is 0h 05m 00s
> ghostlock.c:191: TINFO: Triggering PI deadlock and stack spray
> Test timeouted, sending SIGKILL!
> tst_test.c:1947: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1949: TBROK: Test killed! (timeout?)

did you try with LTP_TIMEOUT_MUL > 1? It's possible that CVE is simply
not triggered.

> 
> > +static int futex_wait_requeue_pi(uint32_t *uaddr, uint32_t *uaddr2,
> > +				 struct timespec *ts)
> > +{
> > +	return tst_syscall(__NR_futex, uaddr, FUTEX_WAIT_REQUEUE_PI, 0, ts,
> > +			   uaddr2, 0);
> > +}
> > +
> > +static int futex_cmp_requeue_pi(uint32_t *uaddr, uint32_t *uaddr2)
> > +{
> > +	return tst_syscall(__NR_futex, uaddr, FUTEX_CMP_REQUEUE_PI, 1, 1,
> > +			   uaddr2, 0);
> > +}
> > +
> > +static int futex_lock_pi(uint32_t *uaddr)
> > +{
> > +	return tst_syscall(__NR_futex, uaddr, FUTEX_LOCK_PI, 0, 0, 0, 0);
> > +}
> > +
> > +static int futex_unlock_pi(uint32_t *uaddr)
> > +{
> > +	return tst_syscall(__NR_futex, uaddr, FUTEX_UNLOCK_PI, 0, 0, 0, 0);
> > +}
> nit: we already have sys_futex() in include/tst_timer.h, maybe using it?

isn't it exactly the same?

> 
> > +
> > +static void *waiter_fn(void *arg LTP_ATTRIBUTE_UNUSED)
> > +{
> > +	struct timespec ts;
> > +	struct prctl_mm_map mm_map = {
> > +		.start_code  = (uint64_t)(uintptr_t)&waiter_fn,
> > +		.end_code    = (uint64_t)(uintptr_t)&waiter_fn + 0x1000,
> > +		.start_data  = (uint64_t)(uintptr_t)auxv & ~0xfffUL,
> > +		.end_data    = ((uint64_t)(uintptr_t)auxv & ~0xfffUL) + 0x1000,
> > +		.start_brk   = (uint64_t)(uintptr_t)sbrk(0),
> > +		.brk         = (uint64_t)(uintptr_t)sbrk(0),
> > +		.start_stack = (uint64_t)(uintptr_t)&mm_map,
> > +		.arg_start   = (uint64_t)(uintptr_t)&mm_map,
> > +		.arg_end     = (uint64_t)(uintptr_t)&mm_map,
> > +		.env_start   = (uint64_t)(uintptr_t)&mm_map,
> > +		.env_end     = (uint64_t)(uintptr_t)&mm_map,
> > +		.auxv        = (void *)auxv,
> > +		.auxv_size   = valid_auxv_size,
> > +		.exe_fd      = (uint32_t)-1,
> > +	};
> 
> nice magic :).
> > +
> > +	waiter_tid = tst_syscall(__NR_gettid);
> > +
> > +	futex_lock_pi(&f_pi_chain);
> > +
> > +	TST_CHECKPOINT_WAKE2(CP_CHAIN_HELD, 2);
> > +	TST_CHECKPOINT_WAIT(CP_OWNER_BLOCKED);
> > +
> > +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &ts);
> > +	ts = tst_timespec_add(ts, (struct timespec){ .tv_sec = 10, .tv_nsec = 0 });
> > +	futex_wait_requeue_pi(&f_wait, &f_pi_target, &ts);
> > +
> > +	TST_CHECKPOINT_WAKE(CP_SPRAYED);
> > +
> > +	while (!tst_atomic_load(&stop_spray)) {
> > +		prctl(PR_SET_MM, PR_SET_MM_MAP, (unsigned long)&mm_map,
> > +		      sizeof(mm_map), 0);
> 
> Maybe SAFE_PRCTL() ?

I also thought about it, but that's the syscall that poison the buffer
and we don't care if it fails. Actually, if it fails during SAFE_PRCTL(),
the test will break and we can't reproduce the bug, so it's ok to leave
it raw.

> > +	}
> > +
> > +	TST_CHECKPOINT_WAIT(CP_SETATTR_DONE);
> > +
> > +	futex_unlock_pi(&f_pi_chain);
> > +
> > +	return NULL;
> > +}
> > +
> > +static void *owner_fn(void *arg LTP_ATTRIBUTE_UNUSED)
> > +{
> > +	owner_tid = tst_syscall(__NR_gettid);
> > +
> > +	TST_CHECKPOINT_WAIT(CP_CHAIN_HELD);
> > +
> > +	futex_lock_pi(&f_pi_target);
> > +	TST_CHECKPOINT_WAKE(CP_TARGET_HELD);
> > +
> > +	futex_lock_pi(&f_pi_chain);
> > +
> > +	futex_unlock_pi(&f_pi_chain);
> > +	futex_unlock_pi(&f_pi_target);
> > +
> > +	return NULL;
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	static const int try_sizes[] = {
> very nit: why static?

I can even move it wit hthe other static variables.

> 
> > +		MAX_AUXV_WORDS,
> > +		MAX_AUXV_WORDS - 4,
> > +		MAX_AUXV_WORDS - 8
> I wonder why these other 2?

according to the kernel version, we might have different words sizes.
Especially for older kernels, MAX_AUXV_WORDS is rejected and we might
need a smaller value.

> 
> Code LGTM, but I'd like to have at least brief look at the original reproducers.
> 
> Kind regards,
> Petr

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
