Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B246DC4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 14:45:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE0793CAFFB
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 16:45:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDBAF3CAEA8
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 16:45:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ABA77600186
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 16:44:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 855CF204E2;
 Mon, 17 Oct 2022 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666017899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=knbQiegi0DP5egdvTEy+Pchi1pFGkwz2oeCQWP6hJEc=;
 b=hA3Lo0VH0OyY1lgCkMQVDwPxyukOTjsR632EZFoaqffkgLdulEwYyb6tnyy9Ey52HdCPme
 h55SkHbrk4QUQSbfiW7KrFia8wiOQnuueaUNSNPexP70hrFmiWKYtaQ0e3YBkGRhN6ATl5
 L0cCdECe+NxxJQIpu1T5oRbwyxIuP1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666017899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=knbQiegi0DP5egdvTEy+Pchi1pFGkwz2oeCQWP6hJEc=;
 b=IZNZ+WVzPBwazLH3+k7CO8pW986QyxclFC0mOR9ov4OIgDnhZfCCPc4rx8OgtSaQEhsGDh
 +f5Ry+T3Ke1D2dCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 639FD13398;
 Mon, 17 Oct 2022 14:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JSNJGGtqTWN9CAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 17 Oct 2022 14:44:59 +0000
Date: Mon, 17 Oct 2022 16:46:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y01q0V36fLlnMAIB@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-11-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221016125731.249078-11-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 10/29] Hugetlb: Migrating libhugetlbfs
 huge_at_4GB_normal_below
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, ltp@lists.linux.it,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> Migrating the libhugetlbfs/testcases/huge_at_4GB_normal_below.c test
> 
> Test Description: Designed to pick up a bug on ppc64 where
> touches_hugepage_high_range() falsely reported true for ranges reaching
> below 4GB
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  | 160 ++++++++++++++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 4c16e1e7c..2029ee4b3 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -14,6 +14,7 @@ hugemmap09 hugemmap09
>  hugemmap10 hugemmap10
>  hugemmap11 hugemmap11
>  hugemmap12 hugemmap12
> +hugemmap13 hugemmap13
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index adea760c7..5955ed613 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -13,6 +13,7 @@
>  /hugetlb/hugemmap/hugemmap10
>  /hugetlb/hugemmap/hugemmap11
>  /hugetlb/hugemmap/hugemmap12
> +/hugetlb/hugemmap/hugemmap13
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
> new file mode 100644
> index 000000000..0eae937ab
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + *
> + * Test Name: Huge at 4GB normal below
> + *
> + * Test Description: Designed to pick up a bug on ppc64 where
> + * touches_hugepage_high_range() falsely reported true for ranges reaching
> + * below 4GB
> + *
> + * WARNING: The offsets and addresses used within are specifically
> + * calculated to trigger the bug as it existed.  Don't mess with them
> + * unless you *really* know what you're doing.
> + *
> + * HISTORY
> + *  Written by David Gibson & Adam Litke
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +
> +#include "hugetlb.h"
> +
> +#define FOURGB (1UL << 32)
> +
> +static int  fd = -1;
> +static char hfile[MAXPATHLEN];
> +static unsigned long hpage_size;
> +static char *verbose;
> +
> +static void run_test(void)
> +{
> +	int page_size;
> +	int fd;
> +	void *p, *q;
> +	unsigned long lowaddr;
> +	int err;
> +
> +	page_size = getpagesize();
> +
> +	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
> +	SAFE_UNLINK(hfile);
> +
> +	p = mmap((void *)FOURGB, hpage_size, PROT_READ|PROT_WRITE,
> +		 MAP_SHARED | MAP_FIXED, fd, 0);
> +	if (p == MAP_FAILED) {
> +		/* slice 0 (high) spans from 4G-1T */
> +		unsigned long below_start = FOURGB;
> +		unsigned long above_end = 1024L*1024*1024*1024;
> +
> +		if (range_is_mapped(below_start, above_end) == 1) {
> +			if (verbose) {
> +				tst_res(TINFO, "region 4G-IT is not free");
> +				tst_res(TINFO|TERRNO, "mmap() failed");

This should be single TINFO message.

> +			}
> +			tst_res(TPASS, "Successful but inconclusive");
> +			SAFE_CLOSE(fd);
> +			return;
> +		}
> +		tst_res(TFAIL|TERRNO, "mmap() huge");
> +		goto fail;
> +	}
> +	if (p != (void *)FOURGB) {
> +		tst_res(TFAIL, "Wrong address with MAP_FIXED huge");
> +		goto fail;
> +	}
> +
> +	if (verbose)
> +		tst_res(TINFO, "Mapped hugetlb at %p", p);
> +
> +	memset(p, 0, hpage_size);
> +
> +	err = test_addr_huge(p);
> +	if (err != 1) {
> +		tst_res(TFAIL, "Mapped address is not hugepage");
> +		goto fail;
> +	}

Again I fail to see how this is useful. This check looks to me like a
circular definition at best. We create file on hugetlbfs, stat() it and
check that the magic matches.

> +	/* Test just below 4GB to check for off-by-one errors */
> +	lowaddr = FOURGB - page_size;
> +	q = mmap((void *)lowaddr, page_size, PROT_READ|PROT_WRITE,
> +		 MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0);
> +	if (p == MAP_FAILED) {
> +		unsigned long below_start = FOURGB - page_size;
> +		unsigned long above_end = FOURGB;
> +
> +		if (range_is_mapped(below_start, above_end) == 1) {
> +			if (verbose) {
> +				tst_res(TINFO, "region (4G-page)-4G is not free\n");
> +				tst_res(TINFO|TERRNO, "mmap() failed");

Here as well, single message.

> +			}
> +			tst_res(TPASS, "Successful but inconclusive");
> +			SAFE_MUNMAP(p, hpage_size);
> +			SAFE_CLOSE(fd);
> +			return;
> +		}
> +		tst_res(TFAIL|TERRNO, "mmap() normal");
> +		goto fail;
> +	}
> +	if (q != (void *)lowaddr) {
> +		tst_res(TFAIL, "Wrong address with MAP_FIXED normal");
> +		goto fail;
> +	}
> +
> +	memset(q, 0, page_size);
> +
> +	tst_res(TPASS, "Successful");
> +	SAFE_MUNMAP(p, hpage_size);
> +	SAFE_MUNMAP(q, page_size);
> +	SAFE_CLOSE(fd);
> +	return;
> +fail:
> +	tst_brk(TBROK, "Once failed, No point in continuing the test");
> +}

And the usuall comments apply as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
