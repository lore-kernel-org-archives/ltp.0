Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67073C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 14:23:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9244F3CBE62
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:23:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C219F3CA4DD
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:23:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1199D200347
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:23:32 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 67F0E22180;
 Mon, 12 Dec 2022 14:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670855012;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rFGY/X08fpvka2UQBboU9l2DyxcIIAK2qa0Ib3EXuls=;
 b=UjHD24xkaDr+mTY6Jqw7RxKN36yKAUd18RZhjdFFA/6mlXtdO1oqCXsBo4KibBkZWqZ1+h
 N727phcAdHFD6FynEwDUNTQjI2C7AEvv3dZykp5+bmJTpP9MeAV8QWHCsWoExnfdwIw5hJ
 VlRVt2tksJnjgGHCcLhXv8aHDWMmcB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670855012;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rFGY/X08fpvka2UQBboU9l2DyxcIIAK2qa0Ib3EXuls=;
 b=SVoXYyvsD158Avf1anl7Gbp66o9b6zBbNkl8H5DvO1AdbrqhZHy3gzXzdHJtsACty2G5w3
 nquhZ7vUPG3jzeBQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 177F22C141;
 Mon, 12 Dec 2022 14:23:32 +0000 (UTC)
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-6-tsahu@linux.ibm.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Mon, 12 Dec 2022 14:22:55 +0000
Organization: Linux Private Site
In-reply-to: <20221201122844.142062-6-tsahu@linux.ibm.com>
Message-ID: <874ju0vgyk.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/8] Hugetlb: Migrating libhugetlbfs
 madvise_reserve
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
Cc: aneesh.kumar@linux.ibm.com, ltp@lists.linux.it, sbhat@linux.ibm.com,
 geetika@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Looks good,

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Tarun Sahu <tsahu@linux.ibm.com> writes:

> Migrating the libhugetlbfs/testcases/madvise_reserve.c test
>
> Test Description: madvise() on some kernels can cause the reservation
> counter to get corrupted. The problem is that the patches are allocated
> for the reservation but not faulted in at the time of allocation. The
> counters do not get updated and effectively "leak". This test
> identifies whether the kernel is vulnerable to the problem or not.
> It is fixed in kernel by 'commit f2deae9d4e70
> ("Remove implementation of readpage from the hugetlbfs_aops")'.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |  1 +
>  testcases/kernel/mem/.gitignore               |  1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap16.c  | 83 +++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 0714ed34c..1691ce37d 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -17,6 +17,7 @@ hugemmap12 hugemmap12
>  hugemmap13 hugemmap13
>  hugemmap14 hugemmap14
>  hugemmap15 hugemmap15
> +hugemmap16 hugemmap16
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index d59b60fd4..eb8e87c40 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -16,6 +16,7 @@
>  /hugetlb/hugemmap/hugemmap13
>  /hugetlb/hugemmap/hugemmap14
>  /hugetlb/hugemmap/hugemmap15
> +/hugetlb/hugemmap/hugemmap16
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
> new file mode 100644
> index 000000000..ea940e90c
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation.
> + * Author: Eric B Munson and Mel Gorman
> + */
> +
> +/*\
> + * [Description]
> + *
> + * madvise() on some kernels can cause the reservation counter to get
> + * corrupted. The problem is that the patches are allocated
> + * for the reservation but not faulted in at the time of allocation. The
> + * counters do not get updated and effectively "leak". This test
> + * identifies whether the kernel is vulnerable to the problem or not.
> + * It is fixed in kernel by commit f2deae9d4e70793568ef9e85d227abb7bef5b622
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
> +#define MNTPOINT "hugetlbfs/"
> +static int  fd = -1;
> +static long hpage_size;
> +
> +static void run_test(void)
> +{
> +	void *p;
> +	unsigned long initial_rsvd, map_rsvd, madvise_rsvd, end_rsvd;
> +
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
> +
> +	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count before map: %lu", initial_rsvd);
> +
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +		 fd, 0);
> +	map_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count after map: %lu", map_rsvd);
> +
> +	if (madvise(p, hpage_size, MADV_WILLNEED) == -1)
> +		tst_brk(TBROK|TERRNO, "madvise()");
> +	madvise_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count after madvise: %lu", madvise_rsvd);
> +
> +	SAFE_MUNMAP(p, hpage_size);
> +	SAFE_CLOSE(fd);
> +	end_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count after close(): %lu", end_rsvd);
> +
> +	TST_EXP_EQ_LU(end_rsvd, initial_rsvd);
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
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
> +		{"linux-git", "f2deae9d4e70"},
> +		{}
> +	},
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {1, TST_NEEDS},
> +};
> -- 
> 2.31.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
