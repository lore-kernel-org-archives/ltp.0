Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41210EE7FE5
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 12:34:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54CCA3CC0FC
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 14:34:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 733373C89B6
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 14:34:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A7D9B6014E6
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 14:34:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B58621BB7;
 Fri,  8 Sep 2023 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694176464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rau8HmnZdRuvVInn6KsVVqS+J04BZ9XRLBQFj7stlzU=;
 b=MH9433P+jtHdzGQJREUYijzPJ1nRWGIFa4/fBHz+PlVTjjGZ0ZLqwA7oBEQEY0wOELTmd7
 /U52v20E28LyDi9aucK12W44BhZIIw795ghdbb8CGuD/w8lgZSYDlRt4VUpuBlw9/GZPNc
 t0ruiDyMi9DDIK3ILS9IhHh1exWW89Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694176464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rau8HmnZdRuvVInn6KsVVqS+J04BZ9XRLBQFj7stlzU=;
 b=dNHPPLOC5GyyZmUheR0V9YlA81Q9rPz+Cgn8nFDnZpDDwjYuqfQOGOiUZPIgtcKShU5sza
 /AYaJJOSZDANsZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87C83131FD;
 Fri,  8 Sep 2023 12:34:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hQhuINAU+2SUPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 08 Sep 2023 12:34:24 +0000
Date: Fri, 8 Sep 2023 14:35:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Message-ID: <ZPsU-bTNG8w_wys5@yuki>
References: <20230908121135.245296-1-sachinpb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230908121135.245296-1-sachinpb@linux.vnet.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Migrating the
 libhugetlbfs/testcases/shm-gettest.c test
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
Cc: geetika@linux.ibm.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugepage35.c b/testcases/kernel/mem/hugetlb/hugemmap/hugepage35.c
> new file mode 100644
> index 000000000..fb603b4ef
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugepage35.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test Name: shm-gettest.c
> + *
> + * This testcase creates shared memory segments backed by hugepages, 
                                                                       ^
		                                                Trailing
								space.

There are a few in the source and other coding style errors, please run
'make check' and fix all the reported problems.

> + * writes specific patterns to each segment, verifies pattern,
> + * and detaches a shared memory segments in a loop. 
> + * It ensures that the hugepage backed shared memory functionalities 
> + * works correctly by validating the data written to segment.
> + */
> +
> +#include "hugetlb.h"
> +#include "tst_safe_sysv_ipc.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +#define NR_HUGEPAGES 4
> +
> +static long hpage_size;
> +static unsigned int iter;
> +static int shmid = -1, key = -1;
> +
> +static void do_shmtest(size_t size) {
> +        size_t i, j;
> +        char pattern;
> +        char *shmaddr;
> +
> +        shmid = SAFE_SHMGET(key, size, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W);
> +        tst_res(TINFO, "shmid: 0x%x\n", shmid);
> +
> +        shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
> +        tst_res(TINFO, "shmaddr: %p\n", shmaddr);
> +
> +        for (i = 0; i < NR_HUGEPAGES; i++) {
> +                pattern = 65 + (i % 26);
> +                tst_res(TINFO, "Touching %p with %c\n",
> +                                shmaddr + (i * hpage_size), pattern);
> +                memset(shmaddr + (i * hpage_size), pattern, hpage_size);
> +        }
> +
> +        for (i = 0; i < NR_HUGEPAGES; i++) {
> +                pattern = 65 + (i % 26);
> +                tst_res(TINFO, "Verifying %p\n", (shmaddr + (i * hpage_size)));
> +                for (j = 0; j < (size_t)hpage_size; j++)
> +                        if (*(shmaddr + (i * hpage_size) + j) != pattern)
> +                                tst_res(TFAIL, "Verifying the segment failed."
> +                                        "Got %c, expected %c",
> +                                        *(shmaddr + (i * hpage_size) + j),
> +                                        pattern);
> +        }
> +        SAFE_SHMDT((const void *)shmaddr);
> +}
> +
> +static void run_test(void)
> +{
> +        int i;
> +        iter = 2;
> +        size_t size;
> +        size = NR_HUGEPAGES * hpage_size;
> +        for (i=0; i < (int)iter; i++)
> +                do_shmtest(size);
> +        tst_res(TPASS, "Successfully tested shared memory segment operations "
> +                        "backed by hugepages");

This is obviously wrong, you are reporting TPASS regardless if the
do_shmtest() reported failure or not. Ideally you should report TPASS
in the do_shmtest() function in a case that no failures have had
happened.

Also LTP test can run a number of iterations when passed -i parameter,
so instead of duplicating the functionality here the test should be
executed with -i 2 instead.

Also the test is not added into .gitignore and to runtest file
(runtest/hugetlb), which means that it wouldn't be executed at all.\

> +}
> +
> +static void setup(void)
> +{
> +        hpage_size = tst_get_hugepage_size();
> +        tst_res(TINFO, "hugepage size is  %ld", hpage_size);
> +}
> +
> +static void cleanup(void)
> +{
> +        if (shmid >= 0)
> +                // Remove the shared memory segment
> +                SAFE_SHMCTL(shmid, IPC_RMID, NULL);
> +}
> +
> +static struct tst_test test = {
> +        .needs_root = 1,
> +        .mntpoint = MNTPOINT,
> +        .needs_hugetlbfs = 1,
> +        .setup = setup,
> +        .cleanup = cleanup,
> +        .test_all = run_test,
> +        .hugepages = {NR_HUGEPAGES, TST_NEEDS},
> +};
> -- 
> 2.39.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
