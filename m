Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479F0F4384C
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 15:35:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B671B3E2985
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 17:35:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 508C63C52FE
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 17:34:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 30F8860082D
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 17:34:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 94D9B6A7F0;
 Wed, 15 Apr 2026 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776267294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obikUQTPwU9fz4/MWU3admDQ/0CMk/eO2zq854vxbi4=;
 b=eGLmLDHlO49deV7t95zmjRMbVYWDfmUMFQyE2WNiNn4Vt0gF5uAEYR2qIesaSbqUiv906u
 XlmC59JTK8YgRSMbKPGPyH7Yj7eDJWWr1J1AtxIBT3XOEiH8mQ7AVy7rTNBNL9Ob3njKcU
 lY4+Y05bIrIgxvefWmCyoU/oLewSj7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776267294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obikUQTPwU9fz4/MWU3admDQ/0CMk/eO2zq854vxbi4=;
 b=IhDkmb162qnqVOI8jksYmTXr8g4k4arJSCzTiqPIGhECxZIj3Vxi3D/rYuUSimPGPMWJud
 t8nW6l2bAgSBG/CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eGLmLDHl;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IhDkmb16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776267294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obikUQTPwU9fz4/MWU3admDQ/0CMk/eO2zq854vxbi4=;
 b=eGLmLDHlO49deV7t95zmjRMbVYWDfmUMFQyE2WNiNn4Vt0gF5uAEYR2qIesaSbqUiv906u
 XlmC59JTK8YgRSMbKPGPyH7Yj7eDJWWr1J1AtxIBT3XOEiH8mQ7AVy7rTNBNL9Ob3njKcU
 lY4+Y05bIrIgxvefWmCyoU/oLewSj7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776267294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obikUQTPwU9fz4/MWU3admDQ/0CMk/eO2zq854vxbi4=;
 b=IhDkmb162qnqVOI8jksYmTXr8g4k4arJSCzTiqPIGhECxZIj3Vxi3D/rYuUSimPGPMWJud
 t8nW6l2bAgSBG/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76E8C4BAA0;
 Wed, 15 Apr 2026 15:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xH8KHB6w32mKYgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 15 Apr 2026 15:34:54 +0000
Date: Wed, 15 Apr 2026 17:35:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Michael Menasherov <mmenashe@redhat.com>
Message-ID: <ad-wLMzLBVVIvUDA@yuki.lan>
References: <20260413134029.43754-1-mmenashe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260413134029.43754-1-mmenashe@redhat.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 94D9B6A7F0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
> Improve error handling coverage for futex syscalls by adding tests
> for missing error conditions that were previously untested.
> 
> futex_wait06 verifies EFAULT is returned when uaddr or timeout
> points to unmapped memory.
> 
> futex_wait07 verifies EINTR is returned when futex_wait() is
> interrupted by a signal.
> 
> futex_wake05 verifies EFAULT is returned when uaddr points to
> unmapped or PROT_NONE memory.
> 
> futex_cmp_requeue03 verifies EFAULT is returned when uaddr or
> uaddr2 points to unmapped memory, and EACCES or EFAULT when uaddr
> points to memory without read permission (PROT_NONE). The EACCES
> behavior was introduced in kernel 5.9.

Generally it would be probably easier to review and applly if you split
this into a series with one test per per patch.

> ---
> v2: Use TST_EXP_FAIL macro as requested.
>     Store address directly in testcase structs and not using flags.
>     Use SAFE_MMAP and not raw as requested, also added a sign off.
>  runtest/syscalls                              |   4 +
>  testcases/kernel/syscalls/futex/.gitignore    |   4 +
>  .../syscalls/futex/futex_cmp_requeue03.c      |  96 ++++++++++++++
>  .../kernel/syscalls/futex/futex_wait06.c      |  73 +++++++++++
>  .../kernel/syscalls/futex/futex_wait07.c      | 117 ++++++++++++++++++
>  .../kernel/syscalls/futex/futex_wake05.c      |  86 +++++++++++++
>  6 files changed, 380 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
>  create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
>  create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
>  create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 6ba0227a8..6c12dc225 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1859,11 +1859,14 @@ perf_event_open02 perf_event_open02
>  
>  futex_cmp_requeue01 futex_cmp_requeue01
>  futex_cmp_requeue02 futex_cmp_requeue02
> +futex_cmp_requeue03 futex_cmp_requeue03
>  futex_wait01 futex_wait01
>  futex_wait02 futex_wait02
>  futex_wait03 futex_wait03
>  futex_wait04 futex_wait04
>  futex_wait05 futex_wait05
> +futex_wait06 futex_wait06
> +futex_wait07 futex_wait07
>  futex_waitv01 futex_waitv01
>  futex_waitv02 futex_waitv02
>  futex_waitv03 futex_waitv03
> @@ -1871,6 +1874,7 @@ futex_wake01 futex_wake01
>  futex_wake02 futex_wake02
>  futex_wake03 futex_wake03
>  futex_wake04 futex_wake04
> +futex_wake05 futex_wake05
>  futex_wait_bitset01 futex_wait_bitset01
>  
>  memfd_create01 memfd_create01
> diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
> index 9d08ba7d3..c47d39b5b 100644
> --- a/testcases/kernel/syscalls/futex/.gitignore
> +++ b/testcases/kernel/syscalls/futex/.gitignore
> @@ -1,15 +1,19 @@
>  /futex_cmp_requeue01
>  /futex_cmp_requeue02
> +/futex_cmp_requeue03
>  /futex_wait01
>  /futex_wait02
>  /futex_wait03
>  /futex_wait04
>  /futex_wait05
> +/futex_wait06
> +/futex_wait07
>  /futex_wait_bitset01
>  /futex_wake01
>  /futex_wake02
>  /futex_wake03
>  /futex_wake04
> +/futex_wake05
>  /futex_waitv01
>  /futex_waitv02
>  /futex_waitv03
> diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
> new file mode 100644
> index 000000000..099d5e35c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Red Hat, Inc.
> + */
> +
> +/*\
> + * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
> + * uaddr2 points to unmapped memory, and EACCES (or EFAULT on older kernels)
> + * when uaddr points to memory without read permission (PROT_NONE).
> + *
> + * The EACCES behavior for PROT_NONE was introduced in kernel 5.9.
> + */
> +
> +#include <errno.h>
> +#include <sys/mman.h>
> +
> +#include "futextest.h"
> +
> +static futex_t futex_var = FUTEX_INITIALIZER;
> +static futex_t *prot_none_addr;
> +
> +static struct futex_test_variants variants[] = {
> +#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
> +	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
> +#endif
> +
> +#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
> +	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec"},
> +#endif
> +};
> +
> +static struct testcase {
> +	const char *desc;
> +	futex_t *uaddr;
> +	futex_t *uaddr2;
> +	int exp_errno;
> +} testcases[3];
> +
> +static void run(unsigned int n)
> +{
> +	struct futex_test_variants *tv = &variants[tst_variant];
> +	struct testcase *tc = &testcases[n];
> +
> +	TST_EXP_FAIL(futex_cmp_requeue(tv->fntype, tc->uaddr, futex_var,
> +		tc->uaddr2, 1, 1, 0), tc->exp_errno, "%s", tc->desc);
> +}
> +
> +static void setup(void)
> +{
> +	struct futex_test_variants *tv = &variants[tst_variant];
> +	size_t pagesize = getpagesize();
> +	futex_t *unmapped;
> +
> +	tst_res(TINFO, "Testing variant: %s", tv->desc);
> +	futex_supported_by_kernel(tv->fntype);
> +
> +	unmapped = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
> +		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	SAFE_MUNMAP(unmapped, pagesize);
> +
> +	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE,
> +		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +	testcases[0] = (struct testcase){
> +		.desc = "uaddr unmapped",
> +		.uaddr = unmapped,
> +		.uaddr2 = &futex_var,
> +		.exp_errno = EFAULT,
> +	};
> +	testcases[1] = (struct testcase){
> +		.desc = "uaddr2 unmapped",
> +		.uaddr = &futex_var,
> +		.uaddr2 = unmapped,
> +		.exp_errno = EFAULT,
> +	};
> +	testcases[2] = (struct testcase){
> +		.desc = "uaddr PROT_NONE",
> +		.uaddr = prot_none_addr,
> +		.uaddr2 = &futex_var,
> +		.exp_errno = tst_kvercmp(5, 9, 0) >= 0 ? EACCES : EFAULT,
> +	};
> +}
> +
> +static void cleanup(void)
> +{
> +	if (prot_none_addr)
> +		SAFE_MUNMAP(prot_none_addr, getpagesize());
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(testcases),
> +	.test_variants = ARRAY_SIZE(variants),
> +};
> diff --git a/testcases/kernel/syscalls/futex/futex_wait06.c b/testcases/kernel/syscalls/futex/futex_wait06.c
> new file mode 100644
> index 000000000..8bb563fb2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_wait06.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Red Hat, Inc.
> + */
> +
> +/*\
> + * Check that futex(FUTEX_WAIT) returns EFAULT when:
> + *
> + * 1) uaddr points to unmapped memory
> + * 2) timeout points to unmapped memory
> + */
> +#include <errno.h>
> +#include <sys/mman.h>
> +
> +#include "futextest.h"
> +
> +static futex_t futex = FUTEX_INITIALIZER;
> +
> +static struct futex_test_variants variants[] = {
> +#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
> +	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
> +#endif
> +
> +#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
> +	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
> +#endif
> +};
> +
> +static struct testcase {
> +	const char *desc;
> +	futex_t *uaddr;
> +	void *timeout;
> +} testcases[2];
> +
> +static void run(unsigned int n)
> +{
> +	struct futex_test_variants *tv = &variants[tst_variant];
> +	struct testcase *tc = &testcases[n];
> +
> +	TST_EXP_FAIL(futex_syscall(tv->fntype, tc->uaddr, FUTEX_WAIT, futex,
> +		tc->timeout, NULL, 0, 0), EFAULT, "%s", tc->desc);
> +}
> +
> +static void setup(void)
> +{
> +	struct futex_test_variants *tv = &variants[tst_variant];
> +	void *bad;
> +
> +	tst_res(TINFO, "Testing variant: %s", tv->desc);
> +	futex_supported_by_kernel(tv->fntype);
> +
> +	bad = SAFE_MMAP(NULL, getpagesize(), PROT_READ | PROT_WRITE,
> +		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	SAFE_MUNMAP(bad, getpagesize());
> +
> +	testcases[0] = (struct testcase){
> +		.desc = "uaddr points to unmapped memory",
> +		.uaddr = bad,
> +		.timeout = NULL,
> +	};
> +	testcases[1] = (struct testcase){
> +		.desc = "timeout points to unmapped memory",
> +		.uaddr = &futex,
> +		.timeout = bad,
> +	};
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(testcases),
> +	.test_variants = ARRAY_SIZE(variants),
> +};
> diff --git a/testcases/kernel/syscalls/futex/futex_wait07.c b/testcases/kernel/syscalls/futex/futex_wait07.c
> new file mode 100644
> index 000000000..a3c1c153d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_wait07.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Red Hat, Inc.
> + */
> +
> +/*\
> + * Check that futex(FUTEX_WAIT) returns EINTR when interrupted by a signal.
> + * A child process blocks on futex_wait() with a long timeout. The parent
> + * waits for the child to enter sleep state, then sends SIGUSR1 to it.
> + * The child verifies it received EINTR and exits accordingly.
> + */
> +
> +#include <errno.h>
> +#include <signal.h>
> +#include <sys/wait.h>
> +
> +#include "futextest.h"
> +
> +static futex_t *futex;
> +
> +static struct futex_test_variants variants[] = {
> +#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
> +	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
> +#endif
> +
> +#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
> +	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
> +#endif
> +};
> +
> +/* We need a handler so SIGUSR1 is caught instead of killing the process.
> + * The empty body is needed, just receiving the signal is enough to
> + * interrupt futex_wait() and make it return into EINTR -1 status.
> + */
> +static void sigusr1_handler(int sig LTP_ATTRIBUTE_UNUSED)
> +{
> +}

We have SIG_IGN for this purpose.

> +static void do_child(void)
> +{
> +	struct futex_test_variants *tv = &variants[tst_variant];
> +	struct sigaction sa;
> +	struct tst_ts timeout;
> +	int res;
> +
> +	/* Set up the signal handler for SIGUSR1 */

Please avoid commenting obvious such as this comment. There is plenty of
obvious comments that does not help at all.

> +	sa.sa_handler = sigusr1_handler;
> +	sa.sa_flags = 0;
> +	SAFE_SIGEMPTYSET(&sa.sa_mask);
> +	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
> +
> +	/* Create a timeout for 5 sec for this variant.
> +	 * if no one wakes the child before 5 sec, futex_wait() will return
> +	 * on its own with ETIMEDOUT and will not wait any longer
> +	 */
> +	timeout = tst_ts_from_ms(tv->tstype, 5000);
> +	res = futex_wait(tv->fntype, futex, *futex, &timeout, 0);
> +
> +	if (res != -1) {
> +		tst_res(TFAIL, "futex_wait() should have failed with EINTR but returned success instead");
> +		exit(1);
> +	}
> +	if (errno != EINTR) {
> +		tst_res(TFAIL | TERRNO, "futex_wait() expected EINTR but got something else, errno");
> +		exit(1);
> +	}
> +	tst_res(TPASS | TERRNO, "futex_wait() returned EINTR as expected");

This could be another TST_EXP_FAIL macro, right?

> +	exit(0);
> +}
> +
> +static void run(void)
> +{
> +	pid_t child;
> +	int status;
> +
> +	child = SAFE_FORK();
> +
> +	if (child == 0) {
> +		do_child();
> +	}

LKML does prefer not having curly braces around single line statements.

> +	/* Wait until child is sleeping before sending signal */
> +	TST_PROCESS_STATE_WAIT(child, 'S', 0);
> +	/* Wake up the child so it will return EINTR -1 status */
> +	SAFE_KILL(child, SIGUSR1);
> +	SAFE_WAITPID(child, &status, 0);
> +	/* Check if the child finished everything as it should */
> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
> +		tst_res(TFAIL, "child exited abnormally");
> +	}

You can let the test library collect the child, no need to do that
manually here.

> +}
> +
> +static void setup(void)
> +{
> +	struct futex_test_variants *tv = &variants[tst_variant];
> +
> +	tst_res(TINFO, "Testing variant: %s", tv->desc);
> +	futex_supported_by_kernel(tv->fntype);
> +
> +	/* Futex needs to be in a shared memory so the parent and the child can access into it */
> +	futex = SAFE_MMAP(NULL, sizeof(*futex), PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> +	*futex = FUTEX_INITIALIZER;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (futex) {
> +		SAFE_MUNMAP((void *)futex, sizeof(*futex));
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.test_variants = ARRAY_SIZE(variants),
> +	.forks_child = 1,
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
