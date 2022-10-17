Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC82C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 12:27:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39E623CAFE0
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 14:27:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 695653CAFCB
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 14:26:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0AB2D200085
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 14:26:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B0B5E218B0;
 Mon, 17 Oct 2022 12:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666009611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3fo8I5fEH6GkLNIrI37EafaGG3cRlsQvr7F3r/+vY08=;
 b=2lfS+/WalzC6pi9Gy3mm4PO8SyG48rbhKiitDxfgwccjmRJF6gOO2sbaYVd2ieNDg5NNlM
 wBs+p+SNgnQb5MRUDeHxNnYHSpC0t+S54a1+9EPD+mRh/TugZYhmSlyEqPh9kYN67+mYrg
 ap3HN+N89Aicu0HPCZHgJ/N7cBRQDuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666009611;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3fo8I5fEH6GkLNIrI37EafaGG3cRlsQvr7F3r/+vY08=;
 b=dFY59oSaXBD+/ODQi2bYN3yv7nKcB8GBsg6+j3a5OaAxB4d6rWO0ZdOn6K8CYBPNDookpX
 PzYJJrRhWHTBEmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BA7013398;
 Mon, 17 Oct 2022 12:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pRVFJQtKTWPvMgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 17 Oct 2022 12:26:51 +0000
Date: Mon, 17 Oct 2022 14:28:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y01KcWOTpjs++fm7@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-6-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221016125731.249078-6-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/29] Hugetlb: Migrating libhugetlbfs directio
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
> Migrating the libhugetlbfs/testcases/direct.c test
> 
> Test Description: This Test perform Direct Write/Read from/To hugetlbfs
> file which is mapped to process address space. The test is checking if it
> succeeds and data written or read is not corrupted.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  | 111 ++++++++++++++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 8a56d52a3..b9ee7227d 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -7,6 +7,7 @@ hugemmap07 hugemmap07
>  hugemmap08 hugemmap08
>  hugemmap09 hugemmap09
>  hugemmap10 hugemmap10
> +hugemmap11 hugemmap11
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index e7def68cb..3e64b67be 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -8,6 +8,7 @@
>  /hugetlb/hugemmap/hugemmap08
>  /hugetlb/hugemmap/hugemmap09
>  /hugetlb/hugemmap/hugemmap10
> +/hugetlb/hugemmap/hugemmap11
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
> new file mode 100644
> index 000000000..c4dbe76e6
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + *
> + * Test Name: Direct I/O
> + *
> + * Test Description: This Test perform Direct Write/Read from/To hugetlbfs file
> + * which is mapped to process address space. The test is checking if it
> + * succeeds and data written or read is not corrupted.

Here as well, documentation comment.

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
> +#define P0 "ffffffff"
> +#define IOSZ 4096
> +#define NHFILE "ltp_nfile"
> +
> +static char buf[IOSZ] __attribute__((aligned(IOSZ)));

There is no need for this buffer to be global.

> +static int  fd = -1, nfd = -1;
> +static char hfile[MAXPATHLEN];
> +static long hpage_size;
> +
> +static void run_test(void)
> +{
> +	void *p;
> +
> +	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
> +	SAFE_UNLINK(hfile);
> +
> +	nfd = SAFE_OPEN(NHFILE, O_CREAT|O_EXCL|O_RDWR|O_DIRECT, 0600);
> +	SAFE_UNLINK(NHFILE);
> +
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
> +	memcpy(p, P0, 8);
> +
> +	/* Direct write from huge page */
> +	SAFE_WRITE(1, nfd, p, IOSZ);
> +	SAFE_LSEEK(nfd, 0, SEEK_SET);
> +
> +	/* Check for accuracy */
> +	SAFE_READ(1, nfd, buf, IOSZ);
> +	if (memcmp(P0, buf, 8)) {
> +		tst_res(TFAIL, "Memory mismatch after Direct-IO write");
> +		goto fail;
> +	}
> +	SAFE_LSEEK(nfd, 0, SEEK_SET);
> +
> +	/* Direct read to huge page */
> +	memset(p, 0, IOSZ);
> +	SAFE_READ(1, nfd, p, IOSZ);
> +
> +	/* Check for accuracy */
> +	if (memcmp(p, P0, 8)) {
> +		tst_res(TFAIL, "Memory mismatch after Direct-IO read");
> +		goto fail;
> +	}
> +	tst_res(TPASS, "Successfully tested Hugepage Direct I/O");
> +	SAFE_MUNMAP(p, hpage_size);
> +	SAFE_CLOSE(fd);
> +	SAFE_CLOSE(nfd);
> +	return;
> +fail:
> +	tst_brk(TBROK, "Once failed, No point in continuing the test");

Here as well.

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
> +	if (nfd >= 0)
> +		SAFE_CLOSE(nfd);
> +	umount2(Hopt, MNT_DETACH);

Here as well.

> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.options = (struct tst_option[]) {
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
