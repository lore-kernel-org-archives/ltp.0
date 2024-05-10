Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920F1C25B10
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 16:09:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 971533CE4EF
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 18:09:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE0E53CE499
 for <ltp@lists.linux.it>; Fri, 10 May 2024 18:09:38 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 888B8100C21C
 for <ltp@lists.linux.it>; Fri, 10 May 2024 18:09:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5FCC866DEC;
 Fri, 10 May 2024 16:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715357376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cp7JpMVpznBRQrcKx/GSva4Am59aVBRt6qw5sUOCNF4=;
 b=XawZZ9ZbqLMsUh7YJZ52zfSVk0olZevlF6InWJDnbXKxs+HI3FwlDd/5wlEHbnr68QucEw
 nU0xN5eb/fjodOz4nU95DmBZpmWDQFnabeByfGdHX8WtoYJnIweyE8ad9cwu8Xocxttevt
 XB/Nx6YOMls6TJTBlC71/ViyczySqNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715357376;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cp7JpMVpznBRQrcKx/GSva4Am59aVBRt6qw5sUOCNF4=;
 b=yztR7VhTtwwan2vpoPfOn56NvSZbtPWkRmtoiL8ZGb6xpVsyuZKa0YcryZPgTdnWZ7Nnig
 Zezj2umNc32mH1Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715357376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cp7JpMVpznBRQrcKx/GSva4Am59aVBRt6qw5sUOCNF4=;
 b=XawZZ9ZbqLMsUh7YJZ52zfSVk0olZevlF6InWJDnbXKxs+HI3FwlDd/5wlEHbnr68QucEw
 nU0xN5eb/fjodOz4nU95DmBZpmWDQFnabeByfGdHX8WtoYJnIweyE8ad9cwu8Xocxttevt
 XB/Nx6YOMls6TJTBlC71/ViyczySqNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715357376;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cp7JpMVpznBRQrcKx/GSva4Am59aVBRt6qw5sUOCNF4=;
 b=yztR7VhTtwwan2vpoPfOn56NvSZbtPWkRmtoiL8ZGb6xpVsyuZKa0YcryZPgTdnWZ7Nnig
 Zezj2umNc32mH1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FC5A1386E;
 Fri, 10 May 2024 16:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lBFtEsBGPmbvOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 May 2024 16:09:36 +0000
Date: Fri, 10 May 2024 18:08:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Geetika <geetika@linux.ibm.com>
Message-ID: <Zj5GkgilzCDx3D2m@yuki>
References: <20240327145925.18922-1-geetika@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240327145925.18922-1-geetika@linux.ibm.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[3]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Migrating the
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
Cc: rpalethorpe@suse.de, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
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
> index 000000000..e5848a3b3
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
> @@ -0,0 +1,211 @@
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

LTP has MIN() macro please use that instead.

> +#define MAX_PAGES_TO_USE 100
> +#define FALLOCATE_ITERATIONS 100000
> +
> +static int  fd = -1;
              ^
	      just single space here

> +static long nr_hpages_free;
> +static unsigned long max_hpages;
> +static int err;
> +static long hpage_size;
> +static unsigned long free_before, free_after;
> +static unsigned long rsvd_before, rsvd_after;
> +
> +static void *thread_fallocate(void *)
> +{
> +	int i, err;
> +	long tpage;
> +
> +	for (i = 0; i < FALLOCATE_ITERATIONS; i++) {
> +		tpage = ((long long)random()) % (max_hpages);
> +		err = fallocate(fd,
> +				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +				tpage * hpage_size, hpage_size);
> +		if (err)
> +			tst_res(TFAIL|TERRNO, "fallocate():");
> +		err = fallocate(fd, 0, tpage * hpage_size, hpage_size);
> +		if (err)
> +			tst_res(TFAIL|TERRNO, "fallocate():");
> +	}
> +	return NULL;
> +}
> +
> +static void *fault_mmap_addr;
> +
> +static void thread_fault_cleanup(void *)
> +{
> +	if (fault_mmap_addr)
> +		munmap(fault_mmap_addr, max_hpages * hpage_size);
> +}
> +
> +static void *thread_fault(void *)
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

This could be done at the declaration with:

	struct timespec ts = {};

> +	while (1) {
> +		tpage = ((long long)random()) % (max_hpages);
> +		foo = *((char *)(fault_mmap_addr + (tpage * hpage_size)));
> +		*((char *)(fault_mmap_addr + (tpage * hpage_size))) = foo;
> +
> +		nanosleep(&ts, NULL); /* thread cancellation point */
> +	}
> +
> +	pthread_cleanup_pop(1);

So we pop the cleanup but do not unmap the memory?

> +	return NULL;
> +}
> +
> +static void *mmap_munmap_addr;
> +
> +static void thread_mmap_munmap_cleanup(void *)
> +{
> +	if (mmap_munmap_addr)
> +		munmap(mmap_munmap_addr, max_hpages * hpage_size);
> +}
> +
> +static void *thread_mmap_munmap(void *)
> +{
> +	struct timespec ts;
> +
> +	pthread_cleanup_push(thread_mmap_munmap_cleanup, NULL);
> +
> +	ts.tv_sec = 0;
> +	ts.tv_nsec = 0;

Here as well.

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
> +	unsigned int seed = (int)getpid() * time(NULL);
> +
> +	srandom(seed);
> +	tst_res(TINFO, "Seed = %d", seed);
> +	nr_hpages_free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	max_hpages = min(nr_hpages_free, MAX_PAGES_TO_USE);
> +	free_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	rsvd_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +	/* First preallocate file with max_hpages pages */
> +	err = fallocate(fd, 0, 0, hpage_size * max_hpages);
> +	if (err) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF, "fallocate() Operation is not supported");
> +		if (err) {
> +			tst_res(TFAIL|TERRNO, "fallocate():");
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

We do not propagate a failure via the return value anymore, so this part
is never true.

> +	SAFE_PTHREAD_CANCEL(fault_th);
> +
> +	SAFE_PTHREAD_JOIN(fault_th, &fault_th_ret);
> +
> +	SAFE_PTHREAD_CANCEL(mmap_munmap_th);
> +
> +	SAFE_PTHREAD_JOIN(mmap_munmap_th, &mmap_munmap_th_ret);
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
> +	hpage_size = tst_get_hugepage_size();
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
> 2.39.3 (Apple Git-146)
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
