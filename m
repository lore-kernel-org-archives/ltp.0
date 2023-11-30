Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFD9C4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 09:47:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C4AE3CD759
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:47:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5A8A3CD5A6
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:46:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D5C03207CCF
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:46:51 +0100 (CET)
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A97621AB8;
 Thu, 30 Nov 2023 09:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701337610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7aBID9PS6kC5042KwDVIHq8BKwoJlM4AtEvWE4Nbfpk=;
 b=R3gByxFT3srWRtKTCGhbuvVBTZCMKMG51P0SVjKra4oNuH3SooUeybnbhHZlvi33rh1UTI
 zr0HLYTysBObP5GS7wIURpN4AbRAqNv6SB++wjmyzU1oGcZmlUFIeP7O5NJT3XBthT8ep0
 N3+YH4fZ/X/OG9FEUbMLd5FgbJ197Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701337610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7aBID9PS6kC5042KwDVIHq8BKwoJlM4AtEvWE4Nbfpk=;
 b=na+hoekeAUhgdDnEpEn6lY3g+w2/Zow0jKSEJ5shsxptvkBYWValV+1tLQcwyq6JYz9FOU
 /aeg/+Ni0cndZhAQ==
References: <20230929083916.72813-1-geetika@linux.ibm.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Geetika <geetika@linux.ibm.com>
Date: Thu, 30 Nov 2023 09:03:26 +0000
Organization: Linux Private Site
In-reply-to: <20230929083916.72813-1-geetika@linux.ibm.com>
Message-ID: <87leaf7euv.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.78 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-0.98)[-0.977]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; HAS_ORG_HEADER(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_ZERO(0.00)[0]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Migrating the
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Geetika <geetika@linux.ibm.com> writes:

> Test Description:
>
> A misconversion of hugetlb_vmtruncate_list to a prio_tree meant that
> on 32-bit machines, truncates at or above 4GB could truncate lower pages,
> resulting in BUG_ON()s. This kernel bug was fixed with
> 'commit 856fc2950555'.
>
> The purpose of this test is to check whether huge pages are handled correctly
> when a file is truncated above the 4GB boundary. It ensures that the memory is
> not corrupted or lost during the truncation process, and that the expected data
> is still present in the memory after truncation.
>
> Signed-off-by: Geetika <geetika@linux.ibm.com>
> ---
> v2:
>  -Corrected typo
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap39.c  | 171 ++++++++++++++++++
>  3 files changed, 173 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap39.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..26587ecc0 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>  hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
> +hugemmap39 hugemmap39
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 7258489ed..4c55d5c8c 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -34,6 +34,7 @@
>  /hugetlb/hugemmap/hugemmap30
>  /hugetlb/hugemmap/hugemmap31
>  /hugetlb/hugemmap/hugemmap32
> +/hugetlb/hugemmap/hugemmap39
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap39.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap39.c
> new file mode 100644
> index 000000000..be5cba69f
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap39.c
> @@ -0,0 +1,171 @@
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
> +static void sigbus_handler_fail(int signum, siginfo_t *si, void *uc)
> +{
> +	siglongjmp(sig_escape, 17);
> +}
> +
> +static void sigbus_handler_pass(int signum, siginfo_t *si, void *uc)
> +{
> +	test_pass = 1;
> +	siglongjmp(sig_escape, 17);
> +}
> +
> +static void run_test(void)
> +{
> +	long long buggy_offset, truncate_point;
> +	void *p, *q;
> +	volatile unsigned int *pi, *qi;
> +
> +	struct sigaction sa_pass = {
> +		.sa_sigaction = sigbus_handler_pass,
> +		.sa_flags = SA_SIGINFO,
> +	};
> +
> +	struct sigaction sa_fail = {
> +		.sa_sigaction = sigbus_handler_pass,
> +		.sa_flags = SA_SIGINFO,
> +	};
> +
> +	sigbus_count = 0;
> +	test_pass = 0;
> +
> +	buggy_offset = truncate_point / (hpage_size / page_size);
> +	buggy_offset = PALIGN(buggy_offset, hpage_size);
> +
> +	/* First get arena of three hpages size, at file offset 4GB */
> +	q = mmap64(NULL, 3*hpage_size, PROT_READ|PROT_WRITE,
> +		 MAP_PRIVATE, fd, truncate_point);
> +	if (q == MAP_FAILED)
> +		tst_brk(TBROK, "mmap() offset 4GB: %s", strerror(errno));

In musl mmap64 is just defined as mmap or not at all if _GNU_SOURCE is
absent. So do we really need it? It seems likely to cause compilation
failures.

Instead we could just use SAFE_MMAP.

Same goes for truncate64 etc.

There are a lot of warnings when compiling this, we don't want to
introduce more warnings.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
