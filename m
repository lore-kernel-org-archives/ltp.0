Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E00ACDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 09:31:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1EC43CD08A
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 11:31:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7598F3C84AB
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 11:30:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B0EFD600967
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 11:30:54 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 645351F88B;
 Thu, 19 Oct 2023 09:30:53 +0000 (UTC)
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 044452C4D6;
 Thu, 19 Oct 2023 09:30:52 +0000 (UTC)
References: <20231012033901.95289-1-geetika@linux.ibm.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Geetika <geetika@linux.ibm.com>
Date: Thu, 19 Oct 2023 09:45:14 +0100
Organization: Linux Private Site
In-reply-to: <20231012033901.95289-1-geetika@linux.ibm.com>
Message-ID: <87a5sfvu0k.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-2.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 VIOLATED_DIRECT_SPF(3.50)[]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 645351F88B
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Migrating the
 libhugetlbfs/testcases/fallocate_stress.c
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

> This test stress tests fallocate. This test starts three threads.
> First thread will continually punch/fill holes via falloc.
> Second thread will continually fault in those same pages.
> Third thread will continually mmap/munmap that page range.
>
> Signed-off-by: Geetika <geetika@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../hugetlb/hugefallocate/hugefallocate03.c   | 210 ++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..eb09c7598 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -1,5 +1,6 @@
>  hugefallocate01 hugefallocate01
>  hugefallocate02 hugefallocate02
> +hugefallocate03 hugefallocate03
>  
>  hugefork01 hugefork01
>  hugefork02 hugefork02
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 7258489ed..e9d3562cb 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -1,6 +1,7 @@
>  /cpuset/cpuset01
>  /hugetlb/hugefallocate/hugefallocate01
>  /hugetlb/hugefallocate/hugefallocate02
> +/hugetlb/hugefallocate/hugefallocate03
>  /hugetlb/hugefork/hugefork01
>  /hugetlb/hugefork/hugefork02
>  /hugetlb/hugemmap/hugemmap01
> diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
> new file mode 100644
> index 000000000..fc9f4e4b8
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2015 Oracle Corporation
> + * Author: Mike Kravetz
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Stress test fallocate.  This test starts three threads.
> + * Thread one will continually punch/fill holes via falloc.
> + * Thread two will continually fault in those same pages.
> + * Thread three will continually mmap/munmap that page range.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <pthread.h>
> +
> +#include "hugetlb.h"
> +#include "lapi/fallocate.h"
> +#include "tst_safe_pthread.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +#define min(a, b) (((a) < (b)) ? (a) : (b))
> +#define MAX_PAGES_TO_USE 100
> +#define FALLOCATE_ITERATIONS 100000
> +
> +static int  fd = -1;
> +static long nr_hpages_free;
> +static long max_hpages;
> +static int err;
> +static long hpage_size;
> +static unsigned long free_before, free_after;
> +static unsigned long rsvd_before, rsvd_after;
> +
> +static void *thread_fallocate(void *arg)

We never use arg so don't you get a compiler warning?

> +{
> +	int i, err;
> +	long tpage;
> +
> +	for (i = 0; i < FALLOCATE_ITERATIONS; i++) {
> +		tpage = ((long long)random()) % (max_hpages);
> +		err = fallocate(fd,
> +				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +				tpage * hpage_size, hpage_size);

You can use the TEST macro here with TST_RET and TST_ERRNO.

> +		if (err)
> +			tst_res(TFAIL, "fallocate(): %s",
> strerror(errno));

You can use TERRNO or TTERRNO (with the TEST macro).

This produces better output for log parsing and manual debugging.

> +		err = fallocate(fd, 0, tpage * hpage_size, hpage_size);
> +		if (err)
> +			tst_res(TFAIL, "fallocate(): %s", strerror(errno));
> +	}
> +	return NULL;
> +}
> +
> +static void *fault_mmap_addr;
> +
> +static void thread_fault_cleanup(void *arg)

Same with arg.

> +{
> +	if (fault_mmap_addr)
> +		munmap(fault_mmap_addr, max_hpages * hpage_size);
> +}
> +
> +static void *thread_fault(void *arg)

Same with arg

> +{
> +	long tpage;
> +	char foo;
> +	struct timespec ts;
> +
> +	fault_mmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
> +			PROT_READ | PROT_WRITE, MAP_SHARED,
> +			fd, 0);
> +
> +	pthread_cleanup_push(thread_fault_cleanup, NULL);
> +
> +	ts.tv_sec = 0;
> +	ts.tv_nsec = 0;
> +
> +	while (1) {
> +		tpage = ((long long)random()) % (max_hpages);
> +		foo = *((char *)(fault_mmap_addr + (tpage * hpage_size)));
> +		*((char *)(fault_mmap_addr + (tpage * hpage_size))) = foo;
> +
> +		nanosleep(&ts, NULL); /* thread cancellation point */

Could we just use sched_yield instead?

> +	}
> +
> +	pthread_cleanup_pop(1);
> +
> +	return NULL;
> +}
> +
> +static void *mmap_munmap_addr;
> +
> +static void thread_mmap_munmap_cleanup(void *arg)

and so on

> +{
> +	if (mmap_munmap_addr)
> +		munmap(mmap_munmap_addr, max_hpages * hpage_size);
> +}
> +
> +static void *thread_mmap_munmap(void *arg)
> +{
> +	int err;
> +	struct timespec ts;
> +
> +	pthread_cleanup_push(thread_mmap_munmap_cleanup, NULL);
> +
> +	ts.tv_sec = 0;
> +	ts.tv_nsec = 0;
> +
> +	while (1) {
> +		mmap_munmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
> +				PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +		SAFE_MUNMAP(mmap_munmap_addr, max_hpages * hpage_size);
> +		mmap_munmap_addr = NULL;
> +
> +		nanosleep(&ts, NULL);   /* thread cancellation point */
> +	}
> +	pthread_cleanup_pop(1);
> +	return NULL;
> +}
> +
> +static void run_test(void)
> +{
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
> +	pthread_t falloc_th, fault_th, mmap_munmap_th;
> +	void *falloc_th_ret, *fault_th_ret, *mmap_munmap_th_ret;
> +
> +	srandom((int)getpid() * time(NULL));

Does this need to be random? Would it be better if the test results were
reproducible?

If it does need to be random then we should print the seed. So that it
can be used when trying to reproduce a failure.

> +
> +	nr_hpages_free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	max_hpages = min(nr_hpages_free, MAX_PAGES_TO_USE);
> +	free_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	rsvd_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +	/* First preallocate file with max_hpages pages */
> +	err = fallocate(fd, 0, 0, hpage_size * max_hpages);

Also here; TEST and TTERRNO.

> +	if (err) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF, "fallocate() Operation is not supported");
> +		if (err) {
> +			tst_res(TFAIL, "fallocate(): %s", strerror(errno));
> +			goto windup;
> +		}
> +	}
> +
> +	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	if (free_before - free_after != max_hpages) {
> +		tst_res(TFAIL, "fallocate did not preallocate %ld huge pages\n",
> +				max_hpages);
> +		goto windup;
> +	}
> +
> +	SAFE_PTHREAD_CREATE(&falloc_th, NULL, thread_fallocate, NULL);
> +
> +	SAFE_PTHREAD_CREATE(&fault_th, NULL, thread_fault, NULL);
> +
> +	SAFE_PTHREAD_CREATE(&mmap_munmap_th, NULL, thread_mmap_munmap, NULL);
> +
> +	SAFE_PTHREAD_JOIN(falloc_th, &falloc_th_ret);
> +
> +	if (falloc_th_ret) {
> +		tst_res(TFAIL, "thread_fallocate unexpected exit code");
> +		goto windup;
> +	}

If it is worth checking this at all, we should print the exit code.

Note that we have the TST_EXP_* macro's in tst_test_macros.h to help
with this. These are incompatible with the goto, but I'm not sure that
is needed?

> +
> +	SAFE_PTHREAD_CANCEL(fault_th);
> +
> +	SAFE_PTHREAD_JOIN(fault_th, &fault_th_ret);
> +
> +	SAFE_PTHREAD_CANCEL(mmap_munmap_th);
> +
> +	SAFE_PTHREAD_JOIN(mmap_munmap_th, &mmap_munmap_th_ret);

Can't the exit code pointer just be NULL? We don't seem to check it.

> +
> +windup:
> +	SAFE_CLOSE(fd);
> +
> +	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	rsvd_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	if (free_after != free_before || rsvd_after != rsvd_before)
> +		tst_res(TFAIL, "free or reserve counts incorrect after fallocate stress test");
> +	else
> +		tst_res(TPASS, "fallocate stress test passed");
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;

Can we use tst_get_hugepage_size instead?

> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {2, TST_NEEDS},
> +};
> -- 
> 2.39.2 (Apple Git-143)


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
