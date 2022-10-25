Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FE8C38A2D
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 11:03:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B33E83CA4D0
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 13:03:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FA003C9641
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 13:03:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 19F7B140016D
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 13:03:15 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 15F8722079;
 Tue, 25 Oct 2022 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666695795;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlToyWPWvcDPT9EWp6SgQcLEIN8eBGOb+jvTH9Fd3f8=;
 b=TAWRZ8en4h7Wm5a6O09p8Cj5CDGB6MGyRfaCq/Vsz1BYdV5g3g0GxUB3mQ+XhfGVxwTJ65
 +bxWjPs4Nm9OiI5hDcgRVh//IQ96vZfaxmx1YY4JSajLrp/BUDtPssHlug+C1QD/VAqacD
 68JCo+8LUtHKE9kI86OMFTwHE31k/II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666695795;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlToyWPWvcDPT9EWp6SgQcLEIN8eBGOb+jvTH9Fd3f8=;
 b=I05bLjci+APkj+KQMWRKsDl5lrI7rzQ3w0xdyZQbACWqDsonOEZnWQbkFoMSiBiBsNM17k
 yE0Ks2jMlJemQjCg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F37752C141;
 Tue, 25 Oct 2022 11:03:13 +0000 (UTC)
References: <20221019184846.89318-1-tsahu@linux.ibm.com>
 <20221019184846.89318-2-tsahu@linux.ibm.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Tue, 25 Oct 2022 10:57:59 +0100
In-reply-to: <20221019184846.89318-2-tsahu@linux.ibm.com>
Message-ID: <877d0oxj0v.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] Hugetlb: Migrating libhugetlbfs
 brk_near_huge
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
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Tarun Sahu <tsahu@linux.ibm.com> writes:

> Migrating the libhugetlbfs/testcases/brk_near_huge.c test
>
> Test Description:
> Certain kernels have a bug where brk() does not perform the same
> checks that a MAP_FIXED mmap() will, allowing brk() to create a
> normal page VMA in a hugepage only address region. This can lead
> to oopses or other badness.

The actual test looks good, but it seems that the existing LTP library
functions which you are using need some work. It looks like this test
could be much smaller.

>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 156 ++++++++++++++++++
>  testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   3 +
>  4 files changed, 161 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index f719217ab..f7ff81cb3 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -3,6 +3,7 @@ hugemmap02 hugemmap02
>  hugemmap04 hugemmap04
>  hugemmap05 hugemmap05
>  hugemmap06 hugemmap06
> +hugemmap07 hugemmap07
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index ff2910533..df5256ec8 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -4,6 +4,7 @@
>  /hugetlb/hugemmap/hugemmap04
>  /hugetlb/hugemmap/hugemmap05
>  /hugetlb/hugemmap/hugemmap06
> +/hugetlb/hugemmap/hugemmap07
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> new file mode 100644
> index 000000000..bd33d9816
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + *
> + * [Description]
> + *
> + * brk() near hugepage:
> + * Certain kernels have a bug where brk() does not perform the same
> + * checks that a MAP_FIXED mmap() will, allowing brk() to create a
> + * normal page VMA in a hugepage only address region. This can lead
> + * to oopses or other badness.
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
> +#include "tst_safe_stdio.h"
> +
> +static int  fd = -1;
> +static char hfile[MAXPATHLEN];
> +static long hpage_size;
> +
> +static int arch_has_slice_support(void)

This only appears to be used on __powerpc64__ in next_chunk. So it can
be defined in the ifdef for next_chunk.

Otherwise we could get unused function warnings and IMO it is more
readable.

> +{
> +#ifdef __powerpc64__
> +	char mmu_type[16];
> +	FILE *fp;
> +	int ret;
> +
> +	fp = SAFE_POPEN("cat /proc/cpuinfo | grep MMU | awk '{ print $3}'", "r");
> +	ret = fscanf(fp, "%s", mmu_type);
> +	pclose(fp);
> +
> +	if (ret < 0)
> +		tst_brk(TBROK, "Failed to determine MMU type");
> +
> +	return strcmp(mmu_type, "Hash") == 0;
> +#elif defined(__powerpc__) && !defined(PPC_NO_SEGMENTS)

This elif doesn't appear to be applicable.

> +	return 1;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +#ifdef __powerpc64__
> +static void *next_chunk(void *addr)
> +{
> +	if (!arch_has_slice_support())
> +		return PALIGN(addr,
> SAFE_READ_MEMINFO("Hugepagesize:")*1024);

In setup we set hpage_size, but then keep reading it.

> +
> +	if ((unsigned long)addr < 0x100000000UL)
> +		/* 256M segments below 4G */
> +		return PALIGN(addr, 0x10000000UL);
> +	/* 1TB segments above */
> +	return PALIGN(addr, 0x10000000000UL);
> +}
> +#elif defined(__powerpc__) && !defined(PPC_NO_SEGMENTS)
> +static void *next_chunk(void *addr)
> +{
> +	return PALIGN(addr, 0x10000000UL);
> +}
> +#elif defined(__ia64__)
> +static void *next_chunk(void *addr)
> +{
> +	return PALIGN(addr, 0x8000000000000000UL);
> +}
> +#else
> +static void *next_chunk(void *addr)
> +{
> +	return PALIGN(addr, SAFE_READ_MEMINFO("Hugepagesize:")*1024);
> +}
> +#endif

If these functions are used in later tests I guess they should go in
tst_hugepages.h

> +
> +static void run_test(void)
> +{
> +	void *brk0, *hugemap_addr, *newbrk;
> +	char *p;
> +	int err;
> +
> +	brk0 = sbrk(0);
> +	tst_res(TINFO, "Initial break at %p", brk0);
> +
> +	hugemap_addr = next_chunk(brk0) + hpage_size;
> +
> +	p = SAFE_MMAP(hugemap_addr, hpage_size, PROT_READ|PROT_WRITE,
> +			MAP_PRIVATE|MAP_FIXED, fd, 0);
> +	if (p != hugemap_addr) {
> +		tst_res(TFAIL, "mmap() at unexpected address %p instead of %p\n", p,
> +		     hugemap_addr);
> +		goto cleanup;
> +	}
> +
> +	newbrk = next_chunk(brk0) + getpagesize();
> +	err = brk((void *)newbrk);
> +	if (err == -1) {
> +		/* Failing the brk() is an acceptable kernel response */
> +		tst_res(TPASS, "Failing the brk is an acceptable response");
> +	} else {
> +		/* Suceeding the brk() is acceptable iff the new memory is
> +		 * properly accesible and we don't have a kernel blow up when
> +		 * we touch it.
> +		 */
> +		tst_res(TINFO, "New break at %p", newbrk);
> +		memset(brk0, 0, newbrk-brk0);
> +		tst_res(TPASS, "memory is accessible, hence successful brk() is "
> +				"an acceptable response");
> +	}
> +cleanup:
> +	SAFE_MUNMAP(p, hpage_size);
> +	err = brk(brk0);
> +	if (err == -1)
> +		tst_brk(TBROK, "Failed to set break at the original position");
> +}
> +
> +static void setup(void)
> +{
> +	if (!Hopt)
> +		Hopt = tst_get_tmpdir();
> +	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> +
> +	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
> +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> +
> +	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
> +	SAFE_UNLINK(hfile);

I'm guessing opening this file and using it with mmap is a very common
pattern. If so, it should be encapsulated in tst_hugepage.c.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
> +	SAFE_UMOUNT(Hopt);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.options = (struct tst_option[]) {
> +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},

This is a source of confusion. This description suggests we pass in an
existing hugetlb mount. However it's actually where it will be mounted.

Perhaps instead we could use set/getmntent to find an existing hugetlb
mount?  Then if it is not there, try mounting it. This is what we do for
CGroups.

I'm not sure what difference it makes where the FS is mounted
anyway. Why is it even an option?

> +		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
> +		{}
> +	},
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {1, TST_NEEDS},

When we set this tst_hugepages.c could fill Hopt (which should be
something like tst_hugepages_mount) with the location of the mount
point. It could also open the hfile fd and store it in a static
variable like tst_hugepage_fd.

Also .taint_check should be added here to check for the type of Ooops
that are caused by this test. This makes debugging easier if the kernel
doesn't kill the test process or freeze immediately.

> +};
> diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> index f75109f3e..1cfeca95a 100644
> --- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> @@ -20,6 +20,9 @@
>  #include "old_tmpdir.h"
>  #include "mem.h"
>  
> +#define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
> +#define PALIGN(p, a) ((void *)ALIGN((unsigned long)(p), (a)))
> +
>  #define SHM_RD	0400
>  #define SHM_WR	0200
>  #define SHM_RW	(SHM_RD|SHM_WR)
> -- 
> 2.31.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
