Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE50606A326
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=pEaNR8cX;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1+47DkgJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=pEaNR8cX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1+47DkgJ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF9C13C6BE6
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 12:44:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDF613C5607
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 12:44:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D87F610006AB
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 12:44:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 110AA1FBB0;
 Tue,  3 Nov 2026 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793706255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IpX4UXdQ05dxmVL1aW4Kcb+1Vk5zMEhudGw5OzlLn3c=;
 b=pEaNR8cXfkEkiQhWtB2S/+D/0YN4fiqi6btz3TE6B/riLhJ+07u3Oi8lybaQcUD8RLG3p6
 8zRza8hL/4ryA9pk5+4sXfEHgwh+2QaXmkISjD4liK9kO+VWkGup2zvyNQBbkjXWxlePfN
 zHWFoSTtuyBrbJCNm6Y1ZK8Eie6EHIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793706255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IpX4UXdQ05dxmVL1aW4Kcb+1Vk5zMEhudGw5OzlLn3c=;
 b=1+47DkgJkwP7xCbWtJE/RzowvBJXFf2N3mv1NzJ9UMQ7rODnNbJEUirHNtsBiafuz+ZoZO
 CFN8j11D5HJU38Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793706255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IpX4UXdQ05dxmVL1aW4Kcb+1Vk5zMEhudGw5OzlLn3c=;
 b=pEaNR8cXfkEkiQhWtB2S/+D/0YN4fiqi6btz3TE6B/riLhJ+07u3Oi8lybaQcUD8RLG3p6
 8zRza8hL/4ryA9pk5+4sXfEHgwh+2QaXmkISjD4liK9kO+VWkGup2zvyNQBbkjXWxlePfN
 zHWFoSTtuyBrbJCNm6Y1ZK8Eie6EHIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793706255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IpX4UXdQ05dxmVL1aW4Kcb+1Vk5zMEhudGw5OzlLn3c=;
 b=1+47DkgJkwP7xCbWtJE/RzowvBJXFf2N3mv1NzJ9UMQ7rODnNbJEUirHNtsBiafuz+ZoZO
 CFN8j11D5HJU38Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6418134B8;
 Tue,  3 Nov 2026 11:44:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xGsQLg7J6WriUgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 03 Nov 2026 11:44:14 +0000
Date: Tue, 3 Nov 2026 12:44:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wenyuan Li <2063309626@qq.com>
Message-ID: <aunJJv8EiUsMI2Dw@yuki.lan>
References: <tencent_B786C5458553D16AB70F62E3AAC3C5C9B306@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_B786C5458553D16AB70F62E3AAC3C5C9B306@qq.com>
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[qq.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FREEMAIL_ENVRCPT(0.00)[qq.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] syscalls/madvise: Check DONTNEED across an
 unmapped hole
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Link: https://man7.org/linux/man-pages/man2/madvise.2.html
> Signed-off-by: Wenyuan Li <2063309626@qq.com>
> ---
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/madvise/.gitignore  |   1 +
>  testcases/kernel/syscalls/madvise/madvise13.c | 145 ++++++++++++++++++
>  3 files changed, 147 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise13.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 4d3f53e..7e255c3 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1094,6 +1094,7 @@ madvise09 madvise09
>  madvise10 madvise10
>  madvise11 madvise11
>  madvise12 madvise12
> +madvise13 madvise13
>  
>  newuname01 newuname01
>  
> diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
> index 758e601..3e7dbe6 100644
> --- a/testcases/kernel/syscalls/madvise/.gitignore
> +++ b/testcases/kernel/syscalls/madvise/.gitignore
> @@ -9,3 +9,4 @@
>  /madvise10
>  /madvise11
>  /madvise12
> +/madvise13
> diff --git a/testcases/kernel/syscalls/madvise/madvise13.c b/testcases/kernel/syscalls/madvise/madvise13.c
> new file mode 100644
> index 0000000..eed99dc
> --- /dev/null
> +++ b/testcases/kernel/syscalls/madvise/madvise13.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Wenyuan Li <2063309626@qq.com>
> + */
> +
> +/*\
> + * Verify MADV_DONTNEED on a private anonymous range containing an unmapped
> + * page. The call must return ENOMEM but still discard the mapped pages on
> + * both sides of the hole, without changing data outside the requested range.
> + * Also test the same request with the middle page mapped.
> + *
> + * madvise(2), VERSIONS/Linux, specifies that Linux applies the advice to
> + * the mapped parts of a range containing holes, even though it returns
> + * ENOMEM.
> + */
> +
> +#include <sys/mman.h>
> +#include "tst_test.h"
> +#include "lapi/mmap.h"
> +
> +#define PAGES 8
> +#define HOLE_PAGE 3
> +#define FIRST_PAGE 2
> +#define LAST_PAGE 4
> +
> +static unsigned char *addr;
> +static size_t page_size;
> +
> +static void cleanup(void)
> +{
> +	if (addr) {
> +		SAFE_MUNMAP(addr, PAGES * page_size);
> +		addr = NULL;
> +	}
> +}
> +
> +static void check_page(unsigned int page, unsigned char expected, int prepare)
> +{
> +	unsigned char vec;
> +	unsigned char *ptr = addr + page * page_size;
> +	size_t i;
> +
> +	TEST(mincore(ptr, page_size, &vec));
> +	if (TST_RET == -1) {
> +		if (prepare || TST_ERR != ENOMEM)
> +			tst_brk(TBROK | TTERRNO, "mincore() on page %u", page);
> +
> +		tst_res(TFAIL, "Page %u is no longer mapped", page);
> +		return;
> +	}
> +
> +	for (i = 0; i < page_size; i++) {
> +		if (ptr[i] == expected)
> +			continue;
> +
> +		if (prepare)
> +			tst_brk(TBROK, "Page %u was not initialized", page);
> +
> +		tst_res(TFAIL, "Page %u byte %zu: expected %#x, got %#x",
> +			page, i, expected, ptr[i]);
> +		return;
> +	}
> +
> +	if (!prepare)
> +		tst_res(TPASS, "Page %u contains only %#x", page, expected);
> +}
> +
> +static void check_hole(int prepare)
> +{
> +	unsigned char vec;
> +
> +	TEST(mincore(addr + HOLE_PAGE * page_size, page_size, &vec));
> +	if (TST_RET == -1 && TST_ERR == ENOMEM) {
> +		if (!prepare)
> +			tst_res(TPASS, "The hole remains unmapped");
> +		return;
> +	}
> +
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "mincore() on the hole");
> +
> +	if (prepare)
> +		tst_brk(TBROK, "The hole was not created");
> +
> +	tst_res(TFAIL, "The hole is mapped after MADV_DONTNEED");
> +}

I find these functions with prepare parameter rather confusing to read.
I guess that it would make more sense to return if the page is
mapped/unmapped and produce the TPASS/TFAIL in the caller.

> +static void run(unsigned int hole)
> +{
> +	unsigned int page;
> +	unsigned char expected;
> +
> +	tst_res(TINFO, "MADV_DONTNEED %s a hole", hole ? "across" : "without");
> +	addr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +	/* EINVAL is also returned when THP support is not configured. */
> +	if (madvise(addr, PAGES * page_size, MADV_NOHUGEPAGE) &&
> +	    errno != EINVAL)
> +		tst_brk(TBROK | TERRNO, "madvise(MADV_NOHUGEPAGE)");

Why do we need this? I suppose that even if kernel allocated a hugepage
it will be broken apart once we modify the middle. The THP stays for
transparent huge pages, hence it shouldn't be visible to the userspace
in any way.

> +	for (page = 0; page < PAGES; page++) {
> +		memset(addr + page * page_size, 0x40 + page, page_size);
> +		check_page(page, 0x40 + page, 1);
> +	}
> +
> +	if (hole) {
> +		SAFE_MUNMAP(addr + HOLE_PAGE * page_size, page_size);
> +		check_hole(1);
> +		TST_EXP_FAIL(madvise(addr + FIRST_PAGE * page_size,
> +			3 * page_size, MADV_DONTNEED), ENOMEM);
> +	} else {
> +		TST_EXP_PASS(madvise(addr + FIRST_PAGE * page_size,
> +			3 * page_size, MADV_DONTNEED));

Here we hardcode 3 as a number of pages to drop, but we define both
FIRST_PAGE and LAST_PAGE. It would make sense to define it as:

#define MADV_FIRST 2
#define MADV_LAST 4
#define MADV_LEN (MADV_LAST-MADV_FIRST+1)

> +	}
> +
> +	for (page = 0; page < PAGES; page++) {
> +		if (hole && page == HOLE_PAGE)
> +			continue;
> +
> +		expected = 0x40 + page;
> +		if (page >= FIRST_PAGE && page <= LAST_PAGE)
> +			expected = 0;
> +		check_page(page, expected, 0);
> +	}
> +
> +	if (hole)
> +		check_hole(0);
> +
> +	cleanup();
> +}
> +
> +static void setup(void)
> +{
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> +	if (!page_size)
> +		tst_brk(TBROK, "Invalid page size");

This hardening should go directly into the safe_sysconf() in the
library. There are at least 30 tests that call SAFE_SYSCONF() with
_SC_PAGESIZE and it does not make sense to add these kind of checks into
each of them. And when we are at it we should probably check that the
page size is power of two as well.

Also safe_sysconf() should check for negative values other than -1.

> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = 2,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> -- 
> 2.43.0
> 
> base-commit: 46688815513714a28fd2ae300adae6b6e68b838b
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
