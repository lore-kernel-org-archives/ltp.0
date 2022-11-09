Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591B7C4332F
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 13:24:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 112A83CD76B
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 14:24:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B56533CD725
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 14:24:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E1DFF601191
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 14:24:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B3711F9FE;
 Wed,  9 Nov 2022 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668000242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4aJXCvWKbtAu8d+EBGcr/sct2mxIgXgcKfYj4D/Llk=;
 b=0NNWaGU/dpIFQYfDeJAkXtVSJt7VzYPb6MkKb0VhJuqoLenewyCK4pRG90JLoCFmRdogBl
 KGpi6ixQPSABK3jUGP9XX0W/m/wQC8OiYosOMZLuyfr4OTfSMKlPxuu0yW86fRXeZeQKMm
 +QHLuwVFqho2Or4/d+kkpag5gWw2hzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668000242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4aJXCvWKbtAu8d+EBGcr/sct2mxIgXgcKfYj4D/Llk=;
 b=zYVSs2e0uss5nqOeyqw0X2SwuO4QQdL3sgn3CCKKYDhyYPPd1ryPgJpAd7k7foI+m9uJQP
 Aupc7lspP03X6qDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 081CC1331F;
 Wed,  9 Nov 2022 13:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lszgAPKpa2OkAwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 09 Nov 2022 13:24:02 +0000
Date: Wed, 9 Nov 2022 14:25:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y2uqS3gKG8FbS0s5@yuki>
References: <20221108195207.232115-1-tsahu@linux.ibm.com>
 <20221108195207.232115-3-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221108195207.232115-3-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] Hugetlb: Migrating libhugetlbfs directio
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Migrating the libhugetlbfs/testcases/direct.c test
> 
> Test Description: This Test perform Direct Write/Read from/To hugetlbfs
> file which is mapped to process address space. The test is checking if it
> succeeds and data written or read is not corrupted.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |  1 +
>  testcases/kernel/mem/.gitignore               |  1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  | 87 +++++++++++++++++++
>  3 files changed, 89 insertions(+)
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
> index 000000000..357c61ab9
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This Test perform Direct Write/Read from/To hugetlbfs file
> + * which is mapped to process address space. The test is checking if it
> + * succeeds and data written or read is not corrupted.
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
> +#define NORMAL_PATH ""
> +#define MNTPOINT "hugetlbfs/"
> +
> +static long hpage_size;
> +static int fd = -1, nfd = -1;
> +
> +static void run_test(void)
> +{
> +	void *p;
> +	char buf[IOSZ] __attribute__((aligned(IOSZ)));
> +
> +	fd = tst_creat_unlinked(MNTPOINT);
> +	nfd = tst_creat_unlinked(NORMAL_PATH);
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
> +	memcpy(p, P0, 8);
> +
> +	SAFE_WRITE(1, nfd, p, IOSZ);
> +	SAFE_LSEEK(nfd, 0, SEEK_SET);
> +
> +	SAFE_READ(1, nfd, buf, IOSZ);
> +	if (memcmp(P0, buf, 8)) {
> +		tst_res(TFAIL, "Memory mismatch after Direct-IO write");
> +		goto cleanup;
> +	}
> +	SAFE_LSEEK(nfd, 0, SEEK_SET);
> +
> +	memset(p, 0, IOSZ);
> +	SAFE_READ(1, nfd, p, IOSZ);
> +
> +	if (memcmp(p, P0, 8))
> +		tst_res(TFAIL, "Memory mismatch after Direct-IO read");
> +	else
> +		tst_res(TPASS, "Successful");
                                ^
				We shoudl write something more
				meaningful. Something as:

				"All data were read and written correctly"

Other than this the rest looks good.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
