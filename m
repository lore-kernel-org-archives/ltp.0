Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9C1EBFD2D
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 09:56:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1299E3E2699
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 11:56:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 167653CD98D
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 11:55:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 424556002C4
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 11:55:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A16775BD32;
 Mon, 13 Apr 2026 09:55:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBF194AE10;
 Mon, 13 Apr 2026 09:55:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FYMxL5293GlzagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Apr 2026 09:55:41 +0000
Date: Mon, 13 Apr 2026 11:55:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Michael Menasherov <mmenashe@redhat.com>
Message-ID: <20260413095540.GA112666@pevik>
References: <20260412134046.31161-1-mmenashe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260412134046.31161-1-mmenashe@redhat.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A16775BD32
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] futex: Add error coverage tests for wait,
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

> Improve error handling coverage for futex syscalls by adding tests
> for missing error conditions that were previously untested.

> futex_wait06 verifies EFAULT is returned when uaddr or timeout
> points to unmapped memory.

> futex_wait07 verifies EINTR is returned when futex_wait() is
> interrupted by a signal.

> futex_wake05 verifies EFAULT is returned when uaddr points to
> unmapped or PROT_NONE memory.

Thanks for sending this on ML (instead of continuing in GitHub PR).
It would help if you looked into some recently converted tests to new LTP API to
avoid common errors.

You should add your SOB:
Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
(or whatever email address you prefer)
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
(That is even in .github/pull_request_template.md, which content you have seen
when opening your previous effort https://github.com/linux-test-project/ltp/pull/1301.)

> futex_cmp_requeue03 verifies EFAULT is returned when uaddr or
> uaddr2 points to unmapped memory, and EACCES or EFAULT when uaddr
> points to memory without read permission (PROT_NONE). The EACCES
> behavior was introduced in kernel 5.9.
> ---
>  runtest/syscalls                              |   4 +
>  testcases/kernel/syscalls/futex/.gitignore    |   4 +
>  .../syscalls/futex/futex_cmp_requeue03.c      | 102 ++++++++++++++++
>  .../kernel/syscalls/futex/futex_wait06.c      |  81 +++++++++++++
>  .../kernel/syscalls/futex/futex_wait07.c      | 114 ++++++++++++++++++
>  .../kernel/syscalls/futex/futex_wake05.c      |  85 +++++++++++++
>  6 files changed, 390 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
>  create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
>  create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
>  create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

...
> diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
> new file mode 100644
> index 000000000..66b18614d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Red Hat, Inc.
nit: Not sure why 2024, maybe you base it on older code. But there should be
2026 as it's also new code, right?

> + *
Please use this to start comment:

/*\

That helps to add the test in test catalog.
https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html

> + * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
> + * uaddr2 points to unmapped memory, and EACCES when uaddr points to
> + * memory without read permission (PROT_NONE).
NOTE: we always want to match error to exact errno, even on a different kernel
version.

> + */
> +
> +#include <errno.h>
> +#include <sys/mman.h>
> +
> +#include "futextest.h"
> +
> +static futex_t futex = FUTEX_INITIALIZER;
> +static void *unmapped_addr;
> +static void *prot_none_addr;
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
> +	/* 1 = uaddr is bad, 0 = uaddr2 is bad */
> +	int bad_uaddr;
> +	/* 1 = PROT_NONE address, 0 = unmapped address */
> +	int use_prot_none;
Why don't define directly pointers to futex_t andd assign static address to it?

static struct testcase {
	const char *desc;
	futex_t *uaddr;
	futex_t *uaddr2;
	int exp_errno;
} testcases[] = {
	{ .desc = "uaddr unmapped", .uaddr = (futex_t *)&unmapped_addr, .uaddr2 = &futex, .exp_errno = EFAULT },
	{ .desc = "uaddr2 unmapped", .uaddr = &futex, .uaddr2 = (futex_t *)&unmapped_addr, .exp_errno = EFAULT },
	{ .desc = "uaddr PROT_NONE", .uaddr = (futex_t *)&prot_none_addr, .uaddr2 = &futex, .exp_errno = EACCES },
}

You specify in the commit message that EACCES behavior changed for kernel 5.9
from EFAULT to EACCES. Therefore in setup() you should check for a kernel
versions, have look at testcases/kernel/syscalls/listmount/listmount04.c.

> +} testcases[] = {
> +	{ "uaddr unmapped", 1, 0 },
> +	{ "uaddr2 unmapped", 0, 0 },
> +	{ "uaddr PROT_NONE", 1, 1 },

Please use designated initializers, that allows avoid having to specify 0 or NULL.


> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct futex_test_variants *tv = &variants[tst_variant];
> +	struct testcase *tc = &testcases[n];
> +	futex_t *bad;
> +	futex_t *uaddr, *uaddr2;
> +	int res;
> +
> +	if (tc->use_prot_none)
> +		bad = (futex_t *)prot_none_addr;
> +	else
> +		bad = (futex_t *)unmapped_addr;
> +
> +	/* Assign bad address to uaddr or uaddr2, keep the other valid. */
> +	if (tc->bad_uaddr) {
> +		uaddr = bad;
> +		uaddr2 = &futex;
> +	} else {
> +		uaddr = &futex;
> +		uaddr2 = bad;
> +	}
All this will not be needed once you just pass the pointers in test struct.
> +
> +	res = futex_cmp_requeue(tv->fntype, uaddr, futex, uaddr2, 1, 1, 0);
> +	if (res != -1) {
> +		tst_res(TFAIL, "futex_cmp_requeue() succeeded unexpectedly for '%s'", tc->desc);
> +		return;
> +	}
> +	if (errno != EFAULT && errno != EACCES) {
> +		tst_res(TFAIL | TERRNO, "futex_cmp_requeue() failed with unexpected error for '%s', expected EFAULT or EACCES",tc->desc);
> +		return;
> +	}
> +	tst_res(TPASS | TERRNO, "futex_cmp_requeue() failed as expected for '%s'", tc->desc);
This should be shortened by using TST_EXP_FAIL().
https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#macro-tst-exp-fail

We want to specify single errno, but FYI we have also TST_EXP_FAIL_ARR().
https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#macro-tst-exp-fail-arr

> +}
> +
> +static void setup(void)
> +{
> +	struct futex_test_variants *tv = &variants[tst_variant];
> +	size_t pagesize = getpagesize();
> +
> +	tst_res(TINFO, "Testing variant: %s", tv->desc);
> +	futex_supported_by_kernel(tv->fntype);
> +
> +	unmapped_addr = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	SAFE_MUNMAP(unmapped_addr, pagesize);
> +	/* PROT_NONE = mapped but no read permission, triggers EACCES or EFAULT */
> +	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (prot_none_addr) {
> +		SAFE_MUNMAP(prot_none_addr, getpagesize());
> +	}
You probably used make check for errors.
Please run it on rebased master, it will ask you to remove { }.

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
> index 000000000..1b9db0241
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_wait06.c

Most of previous comments apply to other tests as well.

> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Red Hat, Inc.
> + *
> + * Check that futex(FUTEX_WAIT) returns EFAULT when:
You need to add blank space here to fix formatting of the doc.

To test generated doc you can:
$ make -C doc/ setup # creates doc/.venv/
$ make -C doc/
=> see doc/html/users/test_catalog.html

Unfortunately we don't any CI check for it (yet).

> + * 1) uaddr points to unmapped memory
> + * 2) timeout points to unmapped memory
> + */

> +#include <errno.h>
> +#include <sys/mman.h>
> +
> +#include "futextest.h"
> +
> +static futex_t futex = FUTEX_INITIALIZER;
> +static void *bad_addr;
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
> +} testcases[] = {
> +	{ "uaddr points to unmapped memory" },
> +	{ "timeout points to unmapped memory" },

If only desc was needed, it could be printed directly (no need for struct).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
