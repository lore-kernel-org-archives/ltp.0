Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEFAC43458
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 08:32:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 139613E6A7B
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 10:32:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 780AB3E2E2B
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 10:32:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 453591400E4D
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 10:32:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E5037629C;
 Fri,  3 Jul 2026 08:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783067537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4wG/PFjnpErOx00Qf9jAzTRkgaOVc3CcRDLjOJ6XXGk=;
 b=H7AvokYiEObRy7gEKBQh66oi2/QyN5Iba4ETJgM93eEcYHVnwzKuQaw3aMIdq1Rzw5A+r6
 eY9tzjOTvqwe8d3pypnS5xg5hHlZlVeTr21Y/cm+JbsJWzneB+V7S+/Wp0Cqd6Kr4f49LB
 MjyozQbbL8wvJZLaQdvbfQdOH6nGhgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783067537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4wG/PFjnpErOx00Qf9jAzTRkgaOVc3CcRDLjOJ6XXGk=;
 b=W4em6SpdesgFJ2KDZrgNzXuN4BYl7iP/e3jg1UqFGPdUzg/3SC10QX2E9+3cgyWuR09PE3
 4zUQPBUyq6S/zLAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783067537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4wG/PFjnpErOx00Qf9jAzTRkgaOVc3CcRDLjOJ6XXGk=;
 b=H7AvokYiEObRy7gEKBQh66oi2/QyN5Iba4ETJgM93eEcYHVnwzKuQaw3aMIdq1Rzw5A+r6
 eY9tzjOTvqwe8d3pypnS5xg5hHlZlVeTr21Y/cm+JbsJWzneB+V7S+/Wp0Cqd6Kr4f49LB
 MjyozQbbL8wvJZLaQdvbfQdOH6nGhgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783067537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4wG/PFjnpErOx00Qf9jAzTRkgaOVc3CcRDLjOJ6XXGk=;
 b=W4em6SpdesgFJ2KDZrgNzXuN4BYl7iP/e3jg1UqFGPdUzg/3SC10QX2E9+3cgyWuR09PE3
 4zUQPBUyq6S/zLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2A5F779AA;
 Fri,  3 Jul 2026 08:32:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZMbOJpBzR2oNOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 03 Jul 2026 08:32:16 +0000
Date: Fri, 3 Jul 2026 10:32:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Michael Menasherov <mmenashe@redhat.com>
Message-ID: <20260703083215.GA377350@pevik>
References: <20260621150951.66407-1-mmenashe@redhat.com>
 <20260621150951.66407-2-mmenashe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260621150951.66407-2-mmenashe@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16 1/2] futex_wake05: Add EFAULT error coverage
 test
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

> futex(FUTEX_WAKE) has no existing test for EFAULT. Add coverage for
> unmapped, PROT_NONE, and kernel-space uaddr, each exercising a
> different code path in the kernel's address validation.

Generally LGTM, few comments below.

> diff --git a/testcases/kernel/syscalls/futex/futex_wake05.c b/testcases/kernel/syscalls/futex/futex_wake05.c
> new file mode 100644
> index 000000000..597426f0a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_wake05.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Red Hat, Inc.
> + * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
> + */
> +
> +/*\
> + * Check that futex(FUTEX_WAKE) returns EFAULT when uaddr points to
> + * unmapped, PROT_NONE, or kernel-space memory.
> + *
> + * For opflags=0 (no FUTEX_PRIVATE_FLAG) futex_wake() takes the
> + * shared-futex path in get_futex_key() which must resolve the physical
> + * page.
> + *
> + * The three cases exercise different code paths: a kernel-space address
> + * is rejected by the kernel's user-space address check before physical
> + * page resolution; unmapped memory fails at find_vma() (no VMA exists);
> + * PROT_NONE memory fails at get_user_pages_fast() (VMA exists but page
> + * is inaccessible).
nit: It'd be more readable using list:

 * The three cases exercise different code paths:

 * - a kernel-space address * is rejected by the kernel's user-space address
 *    check before physical page resolution
 * - unmapped memory fails at find_vma() (no VMA exists)
 * - PROT_NONE memory fails at get_user_pages_fast() (VMA exists but page
 *   is inaccessible)

> + */
> +
> +#include <errno.h>
> +#include <sys/mman.h>
> +
> +#include "futextest.h"
> +
> +static futex_t *unmapped_addr;
> +static futex_t *prot_none_addr;
> +static futex_t *kernel_addr = (futex_t *)-1L;
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
> +	futex_t **addr;
> +	int exp_errno;
> +} testcases[] = {
> +	{
> +		.desc = "uaddr unmapped",
> +		.addr = &unmapped_addr,
> +		.exp_errno = EFAULT,
> +	},
> +	{
> +		.desc = "uaddr PROT_NONE",
> +		.addr = &prot_none_addr,
> +		.exp_errno = EFAULT,
> +	},
> +	{
> +		.desc = "uaddr kernel address",
> +		.addr = &kernel_addr,
> +		.exp_errno = EFAULT,
nit: If all errors are EFAULT why not use it directly in TST_EXP_FAIL?

But more important is that I got a different errno (EINVAL) on 7.0.x kernel on
old kernel spec:

futex_wake05.c:77: TINFO: Testing variant: syscall with old kernel spec
futex_wake05.c:68: TFAIL: uaddr kernel address expected EFAULT: EINVAL (22)

When compiling 32 bit, I get error on both specs:

PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure
...
futex_wake05.c:77: TINFO: Testing variant: syscall with old kernel spec
futex_wake05.c:68: TPASS: uaddr unmapped : EFAULT (14)
futex_wake05.c:68: TPASS: uaddr PROT_NONE : EFAULT (14)
futex_wake05.c:68: TFAIL: uaddr kernel address expected EFAULT: EINVAL (22)
futex_wake05.c:77: TINFO: Testing variant: syscall time64 with kernel spec
futex_wake05.c:68: TPASS: uaddr unmapped : EFAULT (14)
futex_wake05.c:68: TPASS: uaddr PROT_NONE : EFAULT (14)
futex_wake05.c:68: TFAIL: uaddr kernel address expected EFAULT: EINVAL (22)

I tested very old kernel 4.4 (SLE12-SP3 we still support) and it behaves the
same. Do you really get EFAULT?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
