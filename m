Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4432EB8FB0
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 11:29:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A03B73CE9A9
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 13:29:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A2B73CB589
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 13:29:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 712AB600718
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 13:29:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C59721869;
 Thu,  7 Sep 2023 11:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694086178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wg4MEtiuczG+Ihxn8FJ1joWa6/bcXaWf75DWhb6R9p0=;
 b=Oi5NfDduNBMkzFv4rx0HRdi+oF61RTbXQEPaVz3zEJzIYaUHsL0zEkUo2o6xXVgZEvK3JL
 OSX/iCNwrMffHfeOCa5pdZX4JNrbewJ3Ns182JZCxCgX+er/sIJ740e4JmOUvnr9Fyk5Df
 /qo4EtRHqG2perSkAMExAlOcOaCfCbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694086178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wg4MEtiuczG+Ihxn8FJ1joWa6/bcXaWf75DWhb6R9p0=;
 b=k28xD7GqRAUDIZpCPuCmpUBXGWYAaKV/hM4v6Qx+kOVbHGlb94JdgjSDCrV90Jqyio27X3
 1eoQZEvt3KjxEwCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B992138F9;
 Thu,  7 Sep 2023 11:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KmZiESK0+WR/eQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 07 Sep 2023 11:29:38 +0000
Date: Thu, 7 Sep 2023 13:30:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZPm0St324pYfmCzj@yuki>
References: <20230524093930.43971-1-liwang@redhat.com>
 <20230524093930.43971-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230524093930.43971-2-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] hugemmap33: Test to detect bug with
 migrating gigantic pages
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

On Wed, May 24, 2023 at 05:39:30PM +0800, Li Wang wrote:
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 143 ++++++++++++++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..3576e063d 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>  hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
> +hugemmap32 hugemmap33
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 7258489ed..d130d4dcd 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -34,6 +34,7 @@
>  /hugetlb/hugemmap/hugemmap30
>  /hugetlb/hugemmap/hugemmap31
>  /hugetlb/hugemmap/hugemmap32
> +/hugetlb/hugemmap/hugemmap33
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
> new file mode 100644
> index 000000000..12a470193
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Linux Test Project, 2023
> + * Copyright (C) 2023, Red Hat, Inc.
> + *
> + * Author: David Hildenbrand <david@redhat.com>
> + * Port-to-LTP: Li Wang <liwang@redhat.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Migration code will first unmap the old page and replace the present PTE
> + * by a migration entry. Then migrate the page. Once that succeeded (and there
> + * are no unexpected page references), we replace the migration entries by
> + * proper present PTEs pointing at the new page.
> + *
> + * For ordinary pages we handle PTEs. For 2 MiB hugetlb/THP, it's PMDs.
> + * For 1 GiB hugetlb, it's PUDs.
> + *
> + * So without below commit, GUP-fast code was simply not aware that we could
> + * have migration entries stored in PUDs. Migration + GUP-fast code should be
> + * able to handle any such races.
> + *
> + * For example, GUP-fast will re-verify the PUD after pinning to make sure it
> + * didn't change. If it did change, it backs off.
> + *
> + * Migration code should detect the additional page references and back off
> + * as well.
> + *
> + *  commit 15494520b776aa2eadc3e2fefae524764cab9cea
> + *  Author: Qiujun Huang <hqjagain@gmail.com>
> + *  Date:   Thu Jan 30 22:12:10 2020 -0800
> + *
> + *      mm: fix gup_pud_range
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <stdbool.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <sys/ioctl.h>
> +#include <linux/mempolicy.h>
> +#include <linux/mman.h>
> +
> +#include "lapi/syscalls.h"
> +#include "numa_helper.h"
> +#include "hugetlb.h"
> +#if HAVE_NUMA_H
> +#include <numa.h>
> +#endif

This is a bit strange, do we actually use anything from numa.h?

Because:

- if we do it should be ifdefed as well, otherwise the test will not
  build without libnuma-devel

- if we do not, why do we include that header in the first place

> +static char *mem;
> +static size_t pagesize;
> +static size_t hugetlbsize;
> +static volatile int looping = 1;
> +
> +static void *migration_thread_fn(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	while (looping) {
> +		TST_EXP_PASS_SILENT(syscall(__NR_mbind, mem, hugetlbsize,
> +			MPOL_LOCAL, NULL, 0x7fful, MPOL_MF_MOVE));
> +	}
> +
> +	return NULL;
> +}
> +
> +static void run_test(void)
> +{
> +	ssize_t transferred;
> +	struct iovec iov;
> +	int fds[2];
> +
> +	pthread_t migration_thread;
> +
> +	if (!is_numa(NULL, NH_MEMS, 1))
> +		tst_brk(TCONF, "requires NUMA with at least 1 node");

I guess that everything as at least 1 numa node, unless CONFIG_NUMA is
off, so I wonder if we just need needs_kconfig CONFIG_NUMA=y instead.

> +	pagesize = getpagesize();
> +	hugetlbsize = 1 * 1024 * 1024 * 1024u;
> +
> +	mem = mmap(NULL, hugetlbsize, PROT_READ|PROT_WRITE,
> +		   MAP_PRIVATE|MAP_ANON|MAP_HUGETLB|MAP_HUGE_1GB,
> +		   -1, 0);
> +	if (mem == MAP_FAILED)
> +		tst_brk(TBROK | TERRNO, "mmap() failed");
> +
> +	memset(mem, 1, hugetlbsize);
> +
> +	/* Keep migrating the page around ... */
> +	TEST(pthread_create(&migration_thread, NULL, migration_thread_fn, NULL));
> +	if (TST_RET)
> +		tst_brk(TBROK | TRERRNO, "pthread_create failed");

We do have SAFE_PTHREAD_CREATE()

> +	while (looping) {
> +		if (pipe(fds) < 0)
> +			tst_brk(TBROK | TERRNO, "pipe() failed");

SAFE_PIPE()

> +		iov.iov_base = mem;
> +		iov.iov_len = pagesize;
> +		transferred = vmsplice(fds[1], &iov, 1, 0);
> +		if (transferred <= 0)
> +			tst_brk(TBROK | TERRNO, "vmsplice() failed");
> +
> +		close(fds[0]);
> +		close(fds[1]);

SAFE_CLOSE() ?

> +		if (!tst_remaining_runtime()) {
> +			tst_res(TINFO, "Runtime exhausted, exiting");
> +			looping = 0;
> +		}
> +	}
> +
> +	TEST(pthread_join(migration_thread, NULL));
> +	if (TST_RET)
> +		tst_brk(TBROK | TRERRNO, "pthread_join failed");

SAFE_PTHREAD_...()

> +	if (tst_taint_check())
> +		tst_res(TFAIL, "Test resulted in kernel tainted");
> +	else
> +		tst_res(TPASS, "Test completed successfully");

tst_test.taint_check ?


> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.test_all = run_test,
> +	.max_runtime = 60,
> +	.hugepages = {2, TST_NEEDS, 1048576},
                                    ^
				    So this is 1GB hugepage?

				    I wonder if it would be bettter to
				    define constants for these, or at
				    least write it as 1024 * 1024
> +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> +	.tags = (struct tst_tag[]) {
> +	    {"linux-git", "15494520b776"},
> +	    {}
> +	},
> +	.supported_archs = (const char *const []) {
> +		"x86",
> +		"x86_64",
> +		NULL

I do not see anything x86 specific in the test code, or did I miss
something?

I guess that we can leave the test enabled for all architectures as long
as we check for the existente of the hugepages of the requested size in
the library.

> +	},
> +};
> -- 
> 2.40.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
