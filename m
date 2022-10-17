Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE9AC4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 11:44:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D38D03CAF9F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 13:44:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E83F3CAF9F
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 13:44:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C93860008E
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 13:44:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A96933A87;
 Mon, 17 Oct 2022 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666007060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ujxwgU9XoA3BjO2hM+699gVjd9KAwFveXK92S7FvMQ=;
 b=yP2SSdtZ5HY73KsDJBTYVJsLau3pUu6PYLZMu335xBGWe9NOE7sXUlGJe9Bue/uoTKg+bY
 h1JJDm1NQe5+PfNsRduEPZQQ+JedheBB789OTFoluxJzDaVUWQa2ahKNYqtephkwOojUOB
 1eFtqd0K+AXB+cNnFdU+a7gqDD941NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666007060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ujxwgU9XoA3BjO2hM+699gVjd9KAwFveXK92S7FvMQ=;
 b=ELRVa8tA2+iHfGTGa7iovKFMLI4ji/wZXp3terJUFdzsxZrJdu/ZBPSghCuFlq9pjhcG6C
 EmRkF3NPK+fhpvBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFF0413398;
 Mon, 17 Oct 2022 11:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ME0hLhNATWPcGAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 17 Oct 2022 11:44:19 +0000
Date: Mon, 17 Oct 2022 13:46:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y01AeqaHiTIzAquv@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-4-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221016125731.249078-4-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/29] Hugetlb: Migrating libhugetlbfs
 corrupt-by-cow-opt
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
> Migrating the libhugetlbfs/testcases/corrupt-by-cow-opt.c test
> 
> Test Description: Test sanity of cow optimization on page cache. If a page
> in page cache has only 1 ref count, it is mapped for a private mapping
> directly and is overwritten freely, so next time we access the page, we
> can see corrupt data.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  | 102 ++++++++++++++++++
>  3 files changed, 104 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 664f18827..e2ada7a97 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -5,6 +5,7 @@ hugemmap05 hugemmap05
>  hugemmap06 hugemmap06
>  hugemmap07 hugemmap07
>  hugemmap08 hugemmap08
> +hugemmap09 hugemmap09
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 003ce422b..1a242ffe0 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -6,6 +6,7 @@
>  /hugetlb/hugemmap/hugemmap06
>  /hugetlb/hugemmap/hugemmap07
>  /hugetlb/hugemmap/hugemmap08
> +/hugetlb/hugemmap/hugemmap09
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> new file mode 100644
> index 000000000..eeacf68a2
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2013 Joonsoo Kim, LG Electronics.
> + *
> + * Test Name: Corrupt by COW optimization
> + *
> + * Test Description: Test sanity of cow optimization on page cache. If a page
> + * in page cache has only 1 ref count, it is mapped for a private mapping
> + * directly and is overwritten freely, so next time we access the page, we
> + * can see corrupt data.

Here as well.

> + * HISTORY
> + *  Written by Joonsoo Kim
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
> +static char *verbose;
> +static int  fd = -1;
> +static char hfile[MAXPATHLEN];
> +static long hpage_size;
> +
> +static void run_test(void)
> +{
> +	char *p;
> +	char c;
> +
> +	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
> +	SAFE_UNLINK(hfile);

This SAFE_OPEN() and SAFE_UNLINK() should be in setup()

> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +	*p = 's';
> +	if (verbose)
> +		tst_res(TINFO, "Write %c to %p via shared mapping", *p, p);
> +	SAFE_MUNMAP(p, hpage_size);
> +
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
> +	*p = 'p';
> +	if (verbose)
> +		tst_res(TINFO, "Write %c to %p via private mapping", *p, p);
> +	SAFE_MUNMAP(p, hpage_size);
> +
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +	c = *p;
> +	if (verbose)
> +		tst_res(TINFO, "Read %c from %p via shared mapping", *p, p);
> +	SAFE_MUNMAP(p, hpage_size);

Also I'm not keen on the verbose flag, I would just print these messages
by default. It does not make sense to have verbose flag because in
practice it's not enabled on production testing and these days we got
reports from various automated systems so we better include anything
useful by default.

> +	/* Direct write from huge page */
> +	if (c != 's') {
> +		tst_res(TFAIL, "Data got corrupted.");
> +		goto fail;
> +	}
> +	tst_res(TPASS, "Successful");

Here the cleanest code would just be:

	if (c != 's')
		tst_res(TFAIL, "Data are corrupted");
	else
		tst_res(TPASS, "Data are correct");

> +	SAFE_CLOSE(fd);

And this SAFE_CLOSE() is already in cleanup() so we just need to move
the SAFE_OPEN() into the setup() and remove this one.

> +	return;
> +fail:
> +	tst_brk(TBROK, "Once failed, No point in continuing the test");
> +}
> +
> +static void setup(void)
> +{
> +	if (tst_hugepages < 2)
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

Here as well, umount only what was mounted.

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
> +	.hugepages = {2, TST_REQUEST},
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
