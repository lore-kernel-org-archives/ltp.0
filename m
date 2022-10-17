Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE07C4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 12:33:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A06493CAFF0
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 14:33:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB1303CAEA5
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 14:33:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6EC891A003D6
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 14:33:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5FB6F20372;
 Mon, 17 Oct 2022 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666010000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSdzhC+lKtkgNTYr4mUxq/XzbwwA7o23sMCmrH/aBbc=;
 b=x8GzBCuw2/dS8cPk09UpYr5rG6fWIHRXN7AjFbt+UnZaLt6BSeUR2Pl/DfOiUQu7OQ1qVC
 6kW5bmde7+vc8XmDH6Bycm1Eu7oGuNiAwrcRJM4n1ln3S4mS4gxnFCFNAKeSvF6S2IcrzW
 oBrN9aaQl7Q6UsHGH4mA7jzPHjRJu6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666010000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSdzhC+lKtkgNTYr4mUxq/XzbwwA7o23sMCmrH/aBbc=;
 b=L9obIpOzaI7Y5HqoaWi5dsNZfRbP4jwdoKMa8CyffG1BW4vExsTO1RGukA4IlLD7NAqs+l
 1M7wfa4uXOA35zCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CA9A13ABE;
 Mon, 17 Oct 2022 12:33:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LHOaEpBLTWPiNgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 17 Oct 2022 12:33:20 +0000
Date: Mon, 17 Oct 2022 14:35:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y01L9saNNLWfUMiO@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-7-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221016125731.249078-7-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 06/29] Hugetlb: Migrating libhugetlbfs
 fadvise_reserve
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

Hi!
> Test Description: fadvise() on some kernels can cause the reservation
> counter to get corrupted. The problem is that the patches are allocated for
> the reservation but not faulted in at the time of allocation. The counters
> do not get updated and effectively "leak". This test identifies whether the
> kernel is vulnerable to the problem or not. It's fixed in kernel by 'commit
> f2deae9d4e70 ("Remove implementation of readpage from the hugetlbfs_aops")'
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap12.c  | 114 ++++++++++++++++++
>  3 files changed, 116 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index b9ee7227d..b019c4195 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -8,6 +8,7 @@ hugemmap08 hugemmap08
>  hugemmap09 hugemmap09
>  hugemmap10 hugemmap10
>  hugemmap11 hugemmap11
> +hugemmap12 hugemmap12
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 3e64b67be..ec250592d 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -9,6 +9,7 @@
>  /hugetlb/hugemmap/hugemmap09
>  /hugetlb/hugemmap/hugemmap10
>  /hugetlb/hugemmap/hugemmap11
> +/hugetlb/hugemmap/hugemmap12
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
> new file mode 100644
> index 000000000..9773199ca
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation.
> + *
> + * Test Name: fadvise_reserve
> + *
> + * Test Description: fadvise() on some kernels can cause the reservation
> + * counter to get corrupted. The problem is that the patches are allocated for
> + * the reservation but not faulted in at the time of allocation. The counters
> + * do not get updated and effectively "leak". This test identifies whether the
> + * kernel is vulnerable to the problem or not. It's fixed in kernel by commit

Here as well.

> + * f2deae9d4e70793568ef9e85d227abb7bef5b622.

This hash should be added into .tags in the tst_test structure instead.

> + * HISTORY
> + *  Written by Mel Gorman
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
> +static long hpage_size;
> +static int  fd = -1;
> +static char hfile[MAXPATHLEN];
> +static char *verbose;
> +
> +static void run_test(void)
> +{
> +	void *p;
> +	unsigned long initial_rsvd, map_rsvd, fadvise_rsvd, end_rsvd;
> +
> +	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
> +	SAFE_UNLINK(hfile);
> +
> +	initial_rsvd = SAFE_READ_MEMINFO("HugePages_Rsvd:");
> +	if (verbose)
> +		tst_res(TINFO, "Reserve count before map: %lu", initial_rsvd);

Here as well, not keen on the verbose flag.

> +	/* mmap a region and record reservations */

Here as well, no useless comments.

> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +		 fd, 0);
> +	map_rsvd = SAFE_READ_MEMINFO("HugePages_Rsvd:");
> +	if (verbose)
> +		tst_res(TINFO, "Reserve count after map: %lu", map_rsvd);
> +
> +	/* fadvise the region and record reservations */
> +	if (posix_fadvise(fd, 0, hpage_size, POSIX_FADV_WILLNEED) == -1) {
> +		tst_res(TFAIL|TERRNO, "fadvise()");
> +		goto fail;
> +	}
> +	fadvise_rsvd = SAFE_READ_MEMINFO("HugePages_Rsvd:");
> +	if (verbose)
> +		tst_res(TINFO, "Reserve count after fadvise: %lu", fadvise_rsvd);
> +
> +	/* Write the region */

Here as well.

> +	memset(p, 1, hpage_size);
> +
> +	/* Free region */

And here as well.

> +	SAFE_MUNMAP(p, hpage_size);
> +	SAFE_CLOSE(fd);
> +	end_rsvd = SAFE_READ_MEMINFO("HugePages_Rsvd:");
> +	if (verbose)
> +		tst_res(TINFO, "Reserve count after close: %lu", end_rsvd);
> +
> +	/* Reserve count should match initial reserve count */

And here.

> +	if (end_rsvd != initial_rsvd) {
> +		tst_res(TFAIL, "Reserve leaked: %lu != %lu", end_rsvd, initial_rsvd);
> +		goto fail;
> +	}
> +	tst_res(TPASS, "Successful");

Just TST_EXP_EQ_LU(end_rsvd, initial_rsvd);

> +	return;
> +fail:
> +	tst_brk(TBROK, "Once failed, No point in continuing the test");

Here as well, no tst_brk() like this.

> +}
> +
> +static void setup(void)
> +{
> +	if (tst_hugepages < 1)
> +		tst_brk(TCONF, "Not enough hugepages for testing.");
> +
> +	if (!Hopt)
> +		Hopt = tst_get_tmpdir();
> +	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> +
> +	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
> +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
> +	umount2(Hopt, MNT_DETACH);

Here as well.

> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.options = (struct tst_option[]) {
> +		{"v", &verbose, "Turns on verbose mode"},
> +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
> +		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
> +		{}
> +	},
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {1, TST_REQUEST},
> +};
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
