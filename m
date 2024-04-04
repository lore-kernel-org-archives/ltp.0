Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390CACD1292
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 12:09:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 283E03CE3BE
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 14:09:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EB153CE2C6
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 14:09:13 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0D4371B61045
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 14:09:11 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF87637B5B;
 Thu,  4 Apr 2024 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712232548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqHx3IggTqZPQBuvDGiroIgM95UZj9X6wfb6QKLfptc=;
 b=CtMAY9OiU/g/2MGkHfAc5+2rKYx6AtWumVoMFmonyTymXFNHvLH4ZtlmB8tBxdCSlz4mt6
 fJZRvP8TOhnrsonNYCo/8k0wUkLAvUF2az8qc66YgDjKWSVG4z/wR3cNv3tDqLbE6TTIum
 x4DOVR3rXRJufgfqhFtzmHkceyKnmMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712232548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqHx3IggTqZPQBuvDGiroIgM95UZj9X6wfb6QKLfptc=;
 b=1F3k49PxsZlZuLASkJYEKf5wSIOo+rCIRPQoa1rSrVbBahbPzGl6e7JTG98H2y6WgVHLbf
 gOH/UcI0PXtAsIBw==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FF9713298;
 Thu,  4 Apr 2024 12:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id vDfxJWSYDma9WQAAn2gu4w
 (envelope-from <chrubis@suse.cz>); Thu, 04 Apr 2024 12:09:08 +0000
Date: Thu, 4 Apr 2024 14:08:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Geetika <geetika@linux.ibm.com>
Message-ID: <Zg6YLwXmggjN2l51@yuki>
References: <20240403163419.90388-1-geetika@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240403163419.90388-1-geetika@linux.ibm.com>
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,
 imap2.dmz-prg2.suse.org:helo, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add hugemmap42,
 migrated task-size-overrun.c from libhugetlbfs
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
Cc: donettom@linux.ibm.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + */
> +
> +/*\
> + *[Descripiton]
> + *
> + * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/task-size-overrun.c
> + *
> + * This test verifies the behavior of mmap across the TASK_SIZE boundary.
> + * It checks whether mmap with and without MAP_FIXED correctly handles
> + * mappings that straddle the TASK_SIZE boundary.
> + *
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <errno.h>
> +#include <assert.h>
> +
> +#include "hugetlb.h"
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "tst_safe_macros.h"
> +
> +#define MAPS_BUF_SZ 4096
> +#define _LARGEFILE64_SOURCE
> +#define MNTPOINT "hugetlbfs/"
> +#define ALIGN(x, a) (((x) + (a) - 1) & ~((a) - 1))
> +
> +static long hpage_size;
> +static int fd;
> +static char line[MAPS_BUF_SZ];
> +static char *tmp;
> +static unsigned long start, end, off, ino;
> +static FILE *f;
> +static void *p;
> +static unsigned long task_size;
> +static unsigned long straddle_addr;

Most of these are used only in a single function, some even shadowed by
another declaration inside of these functions. We should really create
global variables only for things that are used in several functions. As
far as I can these are only hpage_size and fd.

> +static unsigned long find_last_mapped(void)
> +{
> +	f = SAFE_FOPEN("/proc/self/maps", "r");
> +	do {
> +		tmp = fgets(line, MAPS_BUF_SZ, f);
                                   ^
				   sizeof(line) is a bit better
> +	} while (tmp);
> +	SAFE_FCLOSE(f);
> +
> +	tst_res(TINFO, "Last map: %s", line);
> +	SAFE_SSCANF(line, "%lx-%lx %*s %lx %*s %ld %*s", &start, &end, &off, &ino);
> +	tst_res(TINFO, "Last map: at 0x%lx-0x%lx\n", start, end);
> +	return end;
> +}
> +
> +static unsigned long find_task_size(void)
> +{
> +	unsigned long low, high; /* PFNs */
> +	void *p;
> +
> +	low = find_last_mapped();
> +	if (!low || ((low % getpagesize()) != 0))
> +		tst_brk(TBROK, "Bogus stack end address, 0x%lx!?", low);
> +	low = low / getpagesize();
> +
> +	/* This sum should get us (2^(wordsize) - 2 pages) */
> +	high = (unsigned long)(-2 * getpagesize()) / tst_get_hugepage_size();
> +	tst_res(TINFO, "Binary searching for task size PFNs 0x%lx..0x%lx\n", low, high);
> +
> +	while (high > low + 1) {
> +		unsigned long pfn = (low + high) / 2;
> +		unsigned long addr = pfn * getpagesize();
> +
> +		assert((pfn >= low) && (pfn <= high));
> +
> +		p = mmap((void *)addr, getpagesize(), PROT_READ,
> +			   MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
> +		if (p == MAP_FAILED) {
> +			tst_res(TINFO | TERRNO, "Map failed at 0x%lx", addr);
> +			high = pfn;
> +		} else {
> +			tst_res(TINFO, "Map succeeded at 0x%lx\n", addr);
> +			SAFE_MUNMAP(p, getpagesize());
> +			low = pfn;
> +		}
> +	}
> +
> +	return low * getpagesize();
> +}
> +
> +static void run_test(void)
> +{
> +	task_size = find_task_size();
> +	tst_res(TINFO, "TASK_SIZE = 0x%lx\n", task_size);
> +
> +	straddle_addr = task_size - hpage_size;
> +	straddle_addr = ALIGN(straddle_addr, hpage_size);
> +
> +	tst_res(TINFO, "Mapping without MAP_FIXED at %lx...", straddle_addr);
> +	errno = 0;
> +	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
> +		 MAP_SHARED, fd, 0);
> +	tst_res(TINFO | TERRNO, "Error encountered");

This is misleading, we are printing "error" encountered even that the
call is supposed to work.

> +	if (p == (void *)straddle_addr) {
> +		tst_res(TFAIL, "Apparently suceeded in mapping across TASK_SIZE boundary");
> +		goto windup;
> +	}
> +
> +	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
> +	errno = 0;
> +	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
> +		 MAP_SHARED|MAP_FIXED, fd, 0);
> +	tst_res(TINFO | TERRNO, "Error encountered");
> +	if (p != MAP_FAILED) {
> +		tst_res(TFAIL, "Apparently suceeded in mapping across TASK_SIZE boundary");
> +		goto windup;
> +	}

We should use the newly indroduced macro TST_EXP_FAIL_PTR_VOID() from:

http://patchwork.ozlabs.org/project/ltp/patch/20240403032859.3826-2-wegao@suse.com/

I will have a look at that patchset later on, but I guess that it will
be accepted soon enough so that you can use it here.

Also I will have a look into adding TST_EXP_PASS_PTR_VOID() so that we
can use it in the first case above.

> +
> +	tst_res(TPASS, "Test passed!");
> +
> +windup:
> +	tst_res(TINFO, "Test Completed.");

Can we please not to print this message, it's a bit useless.

> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = getpagesize();
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
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
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {3, TST_NEEDS},
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
