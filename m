Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE2CEB7EAC
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 10:00:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75F433DAEFA
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 11:00:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B81B3CA8E9
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 11:00:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 50B571000953
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 11:00:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0F843F8D3;
 Wed,  4 Mar 2026 10:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772618405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lFVSR1yVRIzhKAlnQN8FWw7Ejg8a+0CBZUAZTwbvv5k=;
 b=fos5i7vWl9mlM+6Tu5nnJRldrVjSi6rugphmCpaj2b+TPQSdRzowtN0VXZKKk3/zzO8N2y
 uAeskM6UzxXpaUTZi0tSgUVK1+raGQblloVgz0syVYRiuW5uD3RxIXGWV/sArwfsCrzdWQ
 o6U0LSOvS8Hxhz/5D7AZLhNLqfWlJe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772618405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lFVSR1yVRIzhKAlnQN8FWw7Ejg8a+0CBZUAZTwbvv5k=;
 b=rMwjH28WBVV9nwMAWojP876SOix8oJWSy43De6J910odoIvM/TP+iaGOEKspWKK/cSkTlg
 hwBUV0vzwBvatNAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772618404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lFVSR1yVRIzhKAlnQN8FWw7Ejg8a+0CBZUAZTwbvv5k=;
 b=1DMoMp7k2Zy1sWGydakCfAXNazPhtWPJPvOVmoq3ns1F0bAXCm3E+pBMiyc/MCV3SIiwun
 HSXM7hKe7ffrERUnx3YbwurnMd9cnjTEeYntxUcR15kpAUweQu6XqVxsms5mO4/PPYQEFB
 0LEJRAWXDnLJBlki/wKH/S9r6VaHhT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772618404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lFVSR1yVRIzhKAlnQN8FWw7Ejg8a+0CBZUAZTwbvv5k=;
 b=GaytLb4J9BkvHmds+fSKYpRGxkB7/q2Hfrbn2OlbGGGJ77sq+BvuDmCHFJzSbtffOAUInx
 YYN8n9LSqKtNs0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DED783EA69;
 Wed,  4 Mar 2026 10:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cGBhNqQCqGlkbQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Mar 2026 10:00:04 +0000
Date: Wed, 4 Mar 2026 11:00:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <aagCqno56xMCixO-@yuki.lan>
References: <20250925060730.1010196-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250925060730.1010196-1-pavrampu@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [PATCH v3] Migrating the
 libhugetlbfs/testcases/truncate_above_4GB.c test
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
Cc: ltp@lists.linux.it, Pavithra <pavrampu@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Pavithra <pavrampu@linux.vnet.ibm.com>
> ---
> Changes in v3:
> - Fixed Warnings
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  | 170 ++++++++++++++++++
>  3 files changed, 172 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 0896d3c94..bd40a7a30 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -36,6 +36,7 @@ hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
>  hugemmap34 hugemmap34
> +hugemmap36 hugemmap36
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index b4455de51..2ddef6bf1 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -36,6 +36,7 @@
>  /hugetlb/hugemmap/hugemmap31
>  /hugetlb/hugemmap/hugemmap32
>  /hugetlb/hugemmap/hugemmap34
> +/hugetlb/hugemmap/hugemmap36
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
> new file mode 100644
> index 000000000..a575d601e
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + * Copyright (C) 2006 Hugh Dickins <hugh@veritas.com>
> + */
> +
> +/*\
> + *[Descripiton]
> + *
> + * At one stage, a misconversion of hugetlb_vmtruncate_list to a
> + * prio_tree meant that on 32-bit machines, truncates at or above 4GB
> + * could truncate lower pages, resulting in BUG_ON()s.
> + *
> + * WARNING: The offsets and addresses used within are specifically
> + * calculated to trigger the bug as it existed.  Don't mess with them
> + * unless you *really* know what you're doing.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#define _LARGEFILE64_SOURCE
> +#define FOURGIG ((off64_t)0x100000000ULL)
> +#define MNTPOINT "hugetlbfs/"
> +
> +#include <signal.h>
> +#include <setjmp.h>
> +#include "hugetlb.h"
> +
> +static int page_size;
> +static long hpage_size;
> +static int fd = -1;
> +static volatile int test_pass;
> +static int err;
> +static int sigbus_count;
> +static sigjmp_buf sig_escape;
> +
> +static void sigbus_handler_fail(void)
> +{
> +	siglongjmp(sig_escape, 17);
> +}
> +
> +static void sigbus_handler_pass(void)
> +{
> +	test_pass = 1;
> +	siglongjmp(sig_escape, 17);
> +}
> +
> +static void run_test(void)
> +{
> +	static long long buggy_offset, truncate_point;
> +	void *p, *q;
> +	volatile unsigned int *pi, *qi;
> +
> +	struct sigaction sa_pass = {
> +		.sa_sigaction = sigbus_handler_pass,
> +		.sa_flags = SA_SIGINFO,
> +	};
> +
> +	struct sigaction sa_fail = {
> +    		.sa_sigaction = sigbus_handler_fail,
> +    		.sa_flags = SA_SIGINFO,
> +	};

There are wrong whitespaces here. Have you done 'make check' in the test
directory to find common problems?

> +	sigbus_count = 0;
> +	test_pass = 0;
> +
> +	buggy_offset = truncate_point / (hpage_size / page_size);
> +	buggy_offset = (long long)PALIGN(buggy_offset, hpage_size);
> +
> +	/* First get arena of three hpages size, at file offset 4GB */
> +	q = mmap64(NULL, 3*hpage_size, PROT_READ|PROT_WRITE,
> +		 MAP_PRIVATE, fd, truncate_point);
> +	if (q == MAP_FAILED)
> +		tst_brk(TBROK, "mmap() offset 4GB: %s", strerror(errno));

You shouldn't call mmap64() directly. WIth LFS enabled the 64bit variant
is choosen automatically and this can be SAFE_MMAP().

> +	qi = q;
> +	/* Touch the high page */
> +	*qi = 0;
> +
> +	/* This part of the test makes the problem more obvious, but
> +	 * is not essential.  It can't be done on segmented powerpc, where
> +	 * segment restrictions prohibit us from performing such a
> +	 * mapping, so skip it there. Similarly, ia64's address space
> +	 * restrictions prevent this.
> +	 */
> +#if (defined(__powerpc__) && defined(PPC_NO_SEGMENTS)) \
> +	|| !defined(__powerpc__) && !defined(__powerpc64__) \
> +	&& !defined(__ia64__)
> +	/* Replace middle hpage by tinypage mapping to trigger
> +	 * nr_ptes BUG
> +	 */
> +	p = mmap64(q + hpage_size, hpage_size, PROT_READ|PROT_WRITE,
> +		   MAP_FIXED|MAP_PRIVATE|MAP_ANON, -1, 0);
> +	if (p != q + hpage_size)
> +		tst_brk(TBROK, "mmap() offset 4GB: %s", strerror(errno));

Here as well.

> +	pi = p;
> +	/* Touch one page to allocate its page table */
> +	*pi = 0;
> +#endif
> +
> +	/* Replace top hpage by hpage mapping at confusing file offset */
> +	p = mmap64(q + 2*hpage_size, hpage_size, PROT_READ|PROT_WRITE,
> +		 MAP_FIXED|MAP_PRIVATE, fd, buggy_offset);
> +	if (p != q + 2*hpage_size)
> +		tst_brk(TBROK, "mmap() buggy offset 0x%llx", buggy_offset);

Here as well.

> +	pi = p;
> +	/* Touch the low page with something non-zero */
> +	*pi = 1;
> +
> +	err = ftruncate64(fd, truncate_point);
> +	if (err) {
> +		tst_res(TFAIL, "ftruncate failed");
> +		goto cleanup;
> +	}

And here as well.

> +	SAFE_SIGACTION(SIGBUS, &sa_fail, NULL);
> +	if (sigsetjmp(sig_escape, 1) == 0)
> +		if (*pi != 1) {
> +			tst_res(TFAIL, "Data 1 has changed!");
> +			goto cleanup;
> +		}
> +
> +	SAFE_SIGACTION(SIGBUS, &sa_pass, NULL);
> +	if (sigsetjmp(sig_escape, 1) == 0)
> +		*qi;
> +	else
> +		sigbus_count++;
> +	if (sigbus_count != 1)
> +		/* Should have SIGBUSed above */
> +		tst_res(TFAIL, "Didn't SIGBUS on truncated page.");
> +	if (test_pass == 1)
> +		tst_res(TPASS, "Expected SIGBUS");

Why do we have both test_pass and sigbus count here?

Shouldn't be a single flag set from the signal handler enough?

> +cleanup:
> +	SAFE_MUNMAP(q, 3*hpage_size);
> +	SAFE_MUNMAP(p, hpage_size);
> +}
> +
> +static void setup(void)
> +{
> +	long long truncate_point;
> +
> +	page_size = getpagesize();
> +	hpage_size = tst_get_hugepage_size();
> +	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
> +	truncate_point = FOURGIG;
> +	if (hpage_size > truncate_point)
> +		tst_brk(TCONF, "Huge page size is too large!");
> +	if (truncate_point % hpage_size > 0)
> +		tst_brk(TCONF, "Truncation point is not aligned to huge page size!");

Hmm, I find this unlinkely to ever happen. As far as I can tell all
currently supported hugepage sizes are multiples of two and as such they
by definition divide 4GB without reminder.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.tags = (struct tst_tag[]) {
> +		{"linux-git", "856fc2950555"},
> +		{}
> +	},
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.hugepages = {4, TST_NEEDS},
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +};
> -- 
> 2.43.5
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
