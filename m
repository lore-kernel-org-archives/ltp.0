Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAB2C4332F
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 15:44:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 219493CAD49
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 16:44:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 210653CACB5
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 16:44:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 905411400768
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 16:44:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4C221F949;
 Wed,  2 Nov 2022 15:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667403884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fa+BC2Ly9aVOzLe/Bpfxx+4xFzu7gn7KjdwWHGfFEzo=;
 b=qW7CnWZs1yxgVBl+rhRZ3+H+XNeO/gf8zaSTcQkpEFONVxzzbmeg7FH8YU4f0GBkG1taIl
 SrF5F2M7RvAxbbl/m1hlyCfSxSOF4e2dDWDgRL94f9Kemz/4rl9TeSW9l8Am5QXoHUiDYM
 wGATRkmGwE4iewcjOhU+Wq9bz9h3B8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667403884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fa+BC2Ly9aVOzLe/Bpfxx+4xFzu7gn7KjdwWHGfFEzo=;
 b=TlyKr+x6KITs2tEk0NFaBRkP/o/pXCKk74OPwQvd0GbOkb0vSiYQ+E1+27O5MiqBuBasmD
 ke8eIKlbl71zCSAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB39F139D3;
 Wed,  2 Nov 2022 15:44:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4c1sLWyQYmOECwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 02 Nov 2022 15:44:44 +0000
Date: Wed, 2 Nov 2022 16:46:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y2KQy7ez6XUgRRcT@yuki>
References: <20221102114923.447871-1-tsahu@linux.ibm.com>
 <20221102114923.447871-3-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221102114923.447871-3-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/4] Hugetlb: Migrating libhugetlbfs
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> --- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> @@ -9,3 +9,8 @@ include $(abs_srcdir)/../Makefile.inc
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
>  
>  hugemmap06: CFLAGS+=-pthread
> +
> +hugemmap07:
> +ifeq ($(ARCH),ppc)
> +	CPPFLAGS += -DPPC_NO_SEGMENTS
> +endif

I do not think that ARCH is defined in LTP build system. Where does it
come from in the original test?

> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> new file mode 100644
> index 000000000..73ed4b0d6
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> @@ -0,0 +1,138 @@
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
           ^
	   I would just remove this, it does not render nicely in the
	   asciidoc and it's not useful either.

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
> +#define MNTPOINT "hugetlbfs/"
> +static long hpage_size;
> +static int huge_fd = -1;
> +
> +#ifdef __powerpc64__
> +static int arch_has_slice_support(void)
> +{
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
> +}
> +
> +static void *next_chunk(void *addr)
> +{
> +	if (!arch_has_slice_support())
> +		return PALIGN(addr, hpage_size);
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
> +	return PALIGN(addr, hpage_size);
> +}
> +#endif
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
> +			MAP_PRIVATE|MAP_FIXED, huge_fd, 0);
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
> +		/* Suceeding the brk() is acceptable if the new memory is
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
> +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> +	huge_fd = tst_creat_unlinked(MNTPOINT);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_CLOSE(huge_fd);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.taint_check = TST_TAINT_D | TST_TAINT_W,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {1, TST_NEEDS},
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

We do have a LTP_ALIGN() please make use of that one instead.

> +#define PALIGN(p, a) ((void *)ALIGN((unsigned long)(p), (a)))
> +
>  #define SHM_RD	0400
>  #define SHM_WR	0200
>  #define SHM_RW	(SHM_RD|SHM_WR)

Have you run 'make check-hugemmap07' in the respecive directory, did it
report any problems?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
