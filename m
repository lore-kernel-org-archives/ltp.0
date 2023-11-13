Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858E3C4167D
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 12:05:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 880053CE5BB
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 13:05:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 059F33CC318
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 13:05:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CF1DB6000BE
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 13:05:10 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D32D2218FA;
 Mon, 13 Nov 2023 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699877109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylcla69DSrHqpmIT0ruHXHjdcuZ11dke+fm+IOzdQg8=;
 b=XiURcM2GyTFEWr2/yMiCnbA0JCe5AUg+8ZTCi0JqfWalunAqWLX1blDSVgRKnd8D3Cqh+E
 fh0NVQFdBjegIwLOghyZrUjZQkyPedhgTeyzl9JnznkZnYl3hOjZkn37/uXiEZ8NirZSkf
 yPrknGFm4WCUdRoM2qKYOwTql2NF6cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699877109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylcla69DSrHqpmIT0ruHXHjdcuZ11dke+fm+IOzdQg8=;
 b=HPlKkJKoHKWlB9nA4mg3jYfzmTPCnqeHUdhCjqmAtMZFLMbl1ECQvXgeV9n2VHMTiIeiS+
 yObYea3p408nVSDA==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3CC712C8B2;
 Mon, 13 Nov 2023 12:05:09 +0000 (UTC)
References: <20230913082214.8453-1-samir@linux.vnet.ibm.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Samir Mulani <samir@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2023 11:28:55 +0000
Organization: Linux Private Site
In-reply-to: <20230913082214.8453-1-samir@linux.vnet.ibm.com>
Message-ID: <87cywdc0zv.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Migrating the
 libhugetlbfs/testcases/stack_grow_into_huge.c test
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

Samir Mulani <samir@linux.vnet.ibm.com> writes:

> Test Description:On PowerPC, the address space is divided into segments.
> These segments can contain either huge pages or normal pages, but not
> both.
> All segments are initially set up to map normal pages. When a huge page
> mapping is created within a set of empty segments, they are "enabled"
> for huge pages at that time. Once enabled for huge pages, they can
> not be used again for normal pages for the remaining lifetime of the
> process.
>
> If the segment immediately preceeding the segment containing the stack is
> converted to huge pages and the stack is made to grow into the this
> preceeding segment, some kernels may attempt to map normal pages into the
> huge page-only segment -- resulting in bugs.
>
> Signed-off-by: Samir Mulani <samir@linux.vnet.ibm.com>
> ---
> v2:
> Below are the requested changes in version 2:
> 1. Fixed "make check warnings"
> 2. Removed explicit calls to exit(1)
> 3.[To get the information about the child state], adapted the "tst_strstatus" implementation.
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  | 130 ++++++++++++++++++
>  3 files changed, 132 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..0c812c780 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>  hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
> +hugemmap34 hugemmap34
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 7258489ed..41f547edf 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -34,6 +34,7 @@
>  /hugetlb/hugemmap/hugemmap30
>  /hugetlb/hugemmap/hugemmap31
>  /hugetlb/hugemmap/hugemmap32
> +/hugetlb/hugemmap/hugemmap34
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
> new file mode 100644
> index 000000000..914a015bc
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test Name: stack_grow_into_huge
> + *
> + * On PowerPC, the address space is divided into segments.  These
> segments can

So does this test work on other architectures?

There don't seem to be any ifdefs to prevent it running on them. We may
need to limit it to PowerPC and call TST_TEST_TCONF otherwise.

> + * contain either huge pages or normal pages, but not both.  All segments are
> + * initially set up to map normal pages.  When a huge page mapping is created
> + * within a set of empty segments, they are "enabled" for huge pages at that
> + * time.  Once enabled for huge pages, they can not be used again for normal
> + * pages for the remaining lifetime of the process.
> + *
> + * If the segment immediately preceeding the segment containing the stack is
> + * converted to huge pages and the stack is made to grow into the this
> + * preceeding segment, some kernels may attempt to map normal pages into the
> + * huge page-only segment -- resulting in bugs.
> + */
> +
> +#include "hugetlb.h"
> +
> +#ifdef __LP64__
> +#define STACK_ALLOCATION_SIZE	(256*1024*1024)
> +#else
> +#define STACK_ALLOCATION_SIZE	(16*1024*1024)
> +#endif
> +#define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
> +#define MNTPOINT "hugetlbfs/"
> +static int  fd = -1;
> +static unsigned long long hpage_size;
> +static int page_size;
> +
> +
> +void do_child(void *stop_address)
> +{
> +	struct rlimit r;
> +	volatile int *x;
> +
> +	/* corefile from this process is not interesting and limiting
> +	 * its size can save a lot of time. '1' is a special value,
> +	 * that will also abort dumping via pipe, which by default
> +	 * sets limit to RLIM_INFINITY.
> +	 */
> +	r.rlim_cur = 1;
> +	r.rlim_max = 1;
> +	SAFE_SETRLIMIT(RLIMIT_CORE, &r);
> +
> +	do {
> +		x = alloca(STACK_ALLOCATION_SIZE);
> +		*x = 1;
> +	} while ((void *)x >= stop_address);
> +}
> +
> +static void run_test(void)
> +{
> +	int pid, status;
> +	void *stack_address, *mmap_address, *heap_address;
> +
> +	stack_address = alloca(0);
> +	heap_address = sbrk(0);
> +
> +	/*
> +	 * paranoia: start mapping two hugepages below the start of the stack,
> +	 * in case the alignment would cause us to map over something if we
> +	 * only used a gap of one hugepage.
> +	 */
> +	mmap_address = PALIGN(stack_address - 2 * hpage_size, hpage_size);
> +	do {
> +		SAFE_MMAP(mmap_address, hpage_size, PROT_READ|PROT_WRITE,
> +				MAP_FIXED|MAP_SHARED, fd, 0);

I think this will fail if CGroup limits are in effect as well. It could
also hit other limits, but probably not on systems where hugepages are
important.

In any case I think if mmap fails with ENOMEM (at least), then it should
exit with TCONF.

> +		mmap_address -= hpage_size;
> +		/*
> +		 * if we get all the way down to the heap, stop trying
> +		 */
> +	} while (mmap_address <= heap_address);

Won't this clobber the heap and any other mappings the LTP libs or
compiler instrumentations have (if any)?

Could we use MAP_FIXED_NOREPLACE instead?

Looking at the description we only need a single mapping to set the
segment to a hugepage segment. It's not clear why such a large mapping
is needed?

> +	pid = SAFE_FORK();
> +	if (pid == 0)
> +		do_child(mmap_address);
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
> +		tst_res(TPASS, "Child killed by %s as expected", tst_strsig(SIGSEGV));
> +	else
> +		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
> +}
> +
> +void setup(void)
> +{
> +	struct rlimit r;
> +
> +	page_size = getpagesize();
> +	hpage_size = tst_get_hugepage_size();
> +	/*
> +	 * Setting the stack size to unlimited.
> +	 */
> +	r.rlim_cur = RLIM_INFINITY;
> +	r.rlim_max = RLIM_INFINITY;
> +	SAFE_SETRLIMIT(RLIMIT_STACK, &r);
> +	SAFE_GETRLIMIT(RLIMIT_STACK, &r);
> +	if (r.rlim_cur != RLIM_INFINITY)
> +		tst_brk(TCONF, "Stack rlimit must be 'unlimited'");
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
> +}
> +
> +void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.tags = (struct tst_tag[]) {
> +		{"linux-git", "0d59a01bc461"},
> +		{}
> +	},
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {2, TST_NEEDS},

It looks like the test could map a lot more than 2 pages.

> +	.forks_child = 1,
> +};
> -- 
> 2.39.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
