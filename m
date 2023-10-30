Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0ADC4167B
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 16:12:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E7053CF745
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 17:12:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF0913CF3DB
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 17:12:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3AA3C1000993
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 17:12:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C8EC1FEE7;
 Mon, 30 Oct 2023 16:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698682323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTP9nM9tW01TKQwL7b/D3Pj8UAQkcbo+uAG/wKx9UzM=;
 b=cc83X5kt47uckGQCZ0kalNpEVBX93yNNlacn3P8umBclkyQiwcSggvvJ55IdTjdN/vA+b8
 6F0jCDmjhHsnnPYDppOAZLTBbRHWnmncNc7cCZvij/xWkt5b0Cl6Hs9g50FnoxyA1lE8vI
 7bY9ZAuksLeTvz+ZInlMZWoHWIeeD1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698682323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTP9nM9tW01TKQwL7b/D3Pj8UAQkcbo+uAG/wKx9UzM=;
 b=gnvwRYuoeisbSWt9OLy27sp3byQ0e9C7dQd93O7Q0OKWgsMjSEY2XyTk8drU8CJVy65pw1
 eUFqdhaa00Ke7YBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28622138F8;
 Mon, 30 Oct 2023 16:12:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BQRgCNPVP2VhBQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 30 Oct 2023 16:12:03 +0000
Date: Mon, 30 Oct 2023 17:12:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Spoorthy <spoorthy@linux.ibm.com>
Message-ID: <ZT_V8Z02VCvz_qiM@yuki>
References: <20230912121238.64692-1-spoorthy@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230912121238.64692-1-spoorthy@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Hugetlb: Migrating libhugetlbfs shm-perms
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

Hi!
> Migrating the libhugetlbfs/tests/shm-perms.c test
> 
> Test Description: Test shared memory behavior when multiple threads are attached
> to a segment with different permissions. A segment is created
> and children attach read-only to check reservation accounting.

First of all there are style problems in the patchset, please run
'make check' and fix all reported problems.

> Signed-off-by: Spoorthy <spoorthy@linux.ibm.com>
> ---
>  runtest/hugetlb                               |  1 +
>  testcases/kernel/mem/.gitignore               |  1 +
>  .../mem/hugetlb/hugeshmat/hugeshmat06.c       | 86 +++++++++++++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..240701b2b 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -44,6 +44,7 @@ hugeshmat02 hugeshmat02 -i 5
>  hugeshmat03 hugeshmat03 -i 5
>  hugeshmat04 hugeshmat04 -i 5
>  hugeshmat05 hugeshmat05 -i 5
> +hugeshmat06 hugeshmat06
>  
>  hugeshmctl01 hugeshmctl01 -i 5
>  hugeshmctl02 hugeshmctl02 -i 5
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 7258489ed..9f7fb1e76 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -39,6 +39,7 @@
>  /hugetlb/hugeshmat/hugeshmat03
>  /hugetlb/hugeshmat/hugeshmat04
>  /hugetlb/hugeshmat/hugeshmat05
> +/hugetlb/hugeshmat/hugeshmat06
>  /hugetlb/hugeshmctl/hugeshmctl01
>  /hugetlb/hugeshmctl/hugeshmctl02
>  /hugetlb/hugeshmctl/hugeshmctl03
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
> new file mode 100644
> index 000000000..ca36ae2f4
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test shared memory behavior when multiple threads are attached  
> + * to a segment with different permissions.  A segment is created  
> + * and children attach read-only to check reservation accounting.  
> + */
> +
> +
> +#include "tst_safe_sysv_ipc.h"
> +#include "hugetlb.h"
> +
> +#define SEGMENT_SIZE ((size_t) 0x4000000)
> +#define SEGMENT_KEY (0x82ba15ff)
> +#define STRIDE (0x200000)
> +#define MNTPOINT "hugetlbfs/"
> +
> +static int global_shmid = -1;
> +
> +void *shm_addr = NULL;

should be static

> +static long hpage_size;
> +
> +int attach_segment(size_t segsize, int shmflags, int shmperms)

here as well.

> +{
> +    int shmid;
> +    shmid = SAFE_SHMGET(SEGMENT_KEY, segsize, shmflags);
> +    shm_addr = SAFE_SHMAT(shmid, shm_addr, shmperms); 
> +    global_shmid = shmid;

I do not thint that this works as intended. The test cleanup() is not
executed for child processes.

> +    return shmid;
> +}
> +
> +static void setup(void)
> +{
> +    hpage_size = tst_get_hugepage_size();
> +}
> +
> +static void run_test(void)
> +{
> +    char *p;
> +    int i, iterations;
> +    long total_hpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
> +    if (hpage_size > SEGMENT_SIZE)
> +        tst_res(TCONF,"Page size is too large for configured SEGMENT_SIZE");

Why do we set static sement size? Why can't we just use multiple of
hugepage size instead?

> +    iterations = (total_hpages * hpage_size) / SEGMENT_SIZE + 1;
> +    SAFE_MALLOC(sizeof(pid_t) * iterations);
> +    attach_segment(SEGMENT_SIZE, IPC_CREAT | SHM_HUGETLB | 0640, 0);
> +    p = (char *)shm_addr;
> +    for (i = 0; i < 4; i++, p += STRIDE)
> +        memset(p, 0x55, STRIDE);
> +    
> +    SAFE_SHMDT((const void *)shm_addr);
> +    for (i = 0; i < iterations; i++)
> +    {
> +        SAFE_FORK();
> +        attach_segment(0, 0, SHM_RDONLY);
> +        SAFE_SHMDT((const void *)shm_addr);

This code runs both for child and parent, this looks like a mistake.

Also at which point should the child exit?

> +    }
> +    tst_reap_children();

Here as well all children gets here.

> +    tst_res(TPASS, "Successfully tested shared memory behavior when multiple threads are attached");

What did we actually validated here? What is the purpose of the test?

My guess is that we are trying to check that we can attach shm hugepages
several times and the number of hugepages in use does not grow, but the
code does not seem to match that expecation.

> +}
> +
> +static void cleanup(void)
> +{
> +    if (global_shmid >= 0)
> +        SAFE_SHMCTL(global_shmid, IPC_RMID, NULL);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {32, TST_NEEDS},
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
