Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE01C282C1
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 15:35:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 598923C9E83
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 16:35:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B35A93C9E6D
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 16:34:51 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 833FE230EF0
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 16:34:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF3711F38F;
 Fri, 28 Feb 2025 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740756888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9x6j6zt809y20xDJfyfGyI3Aoqsrqw5lnLEWOR6SKlw=;
 b=emLvyM5wq7ULXBG98aJEANnGsD9zrohAECo6MIWEVHCV1kRQaCcs7P6EsgoM8vPh8sQXJD
 NwM+V6tFOXwhcxzNR3/i+1QLQILI8v7FU7MLDuMXPhZ2+zqLgQxeR0e1/EW6DFEaOYNYfp
 fgcgnoj0IItilJzX/kJJz36oEM5kApA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740756888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9x6j6zt809y20xDJfyfGyI3Aoqsrqw5lnLEWOR6SKlw=;
 b=ZTHkpI3liJM35HbjZQVi8fL3CmQkOI7ws/XZaotopgP8UHk8fbnhGv+uUiNWVh704pcQ8V
 IPN9jGDJUUU3uTDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=emLvyM5w;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZTHkpI3l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740756888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9x6j6zt809y20xDJfyfGyI3Aoqsrqw5lnLEWOR6SKlw=;
 b=emLvyM5wq7ULXBG98aJEANnGsD9zrohAECo6MIWEVHCV1kRQaCcs7P6EsgoM8vPh8sQXJD
 NwM+V6tFOXwhcxzNR3/i+1QLQILI8v7FU7MLDuMXPhZ2+zqLgQxeR0e1/EW6DFEaOYNYfp
 fgcgnoj0IItilJzX/kJJz36oEM5kApA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740756888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9x6j6zt809y20xDJfyfGyI3Aoqsrqw5lnLEWOR6SKlw=;
 b=ZTHkpI3liJM35HbjZQVi8fL3CmQkOI7ws/XZaotopgP8UHk8fbnhGv+uUiNWVh704pcQ8V
 IPN9jGDJUUU3uTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C3731344A;
 Fri, 28 Feb 2025 15:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xSFpJZjXwWc7TQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Feb 2025 15:34:48 +0000
Date: Fri, 28 Feb 2025 16:34:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.vnet.ibm.com>
Message-ID: <Z8HXnd1myL8er-x3@yuki.lan>
References: <20241125142932.760643-1-pavrampu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241125142932.760643-1-pavrampu@linux.vnet.ibm.com>
X-Rspamd-Queue-Id: AF3711F38F
X-Spamd-Result: default: False [-2.62 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 LONG_SUBJ(1.89)[252]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] This test stress tests fallocate. This test
 starts three threads. First thread will continually punch/fill holes via
 falloc. Second thread will continually fault in those same pages. Third
 thread will continually mmap/munmap that page range.
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
Cc: ltp@lists.linux.it, rnsastry@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
First of all the format for git commit is:

```
short description

long description composing of several lines
second lined of the long descrption
...

Signed-off-by: ...
```

This patch is missing the short description and because of that the
email has absurdly long subject.

> Changes in v3:
> - Used MIN() macro instead of defining min function.
> - struch ts initialization done at the declaration.
> - Added memory unmap before pthread_cleanup_pop.
> - Removed if (falloc_th_ret)
> 
> Signed-off-by: Pavithra <pavrampu@linux.vnet.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../hugetlb/hugefallocate/hugefallocate03.c   | 204 ++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index f294e9aaa..bba2460ff 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -1,5 +1,6 @@
>  hugefallocate01 hugefallocate01
>  hugefallocate02 hugefallocate02
> +hugefallocate03 hugefallocate03
>  
>  hugefork01 hugefork01
>  hugefork02 hugefork02
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index d88484fa1..2b84ac3b9 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -1,6 +1,7 @@
>  /cpuset/cpuset01
>  /hugetlb/hugefallocate/hugefallocate01
>  /hugetlb/hugefallocate/hugefallocate02
> +/hugetlb/hugefallocate/hugefallocate03
>  /hugetlb/hugefork/hugefork01
>  /hugetlb/hugefork/hugefork02
>  /hugetlb/hugemmap/hugemmap01
> diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
> new file mode 100644
> index 000000000..824816161
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate03.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2015 Oracle Corporation
> + * Author: Mike Kravetz
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Stress test fallocate.  This test starts three threads.
> + * Thread one will continually punch/fill holes via falloc.
> + * Thread two will continually fault in those same pages.
> + * Thread three will continually mmap/munmap that page range.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <pthread.h>
> +
> +#include "hugetlb.h"
> +#include "lapi/fallocate.h"
> +#include "tst_safe_pthread.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +#define MAX_PAGES_TO_USE 100
> +#define FALLOCATE_ITERATIONS 100000
> +
> +static int fd = -1;
> +static long nr_hpages_free;
> +static unsigned long max_hpages;
> +static int err;
> +static long hpage_size;
> +static unsigned long free_before, free_after;
> +static unsigned long rsvd_before, rsvd_after;
> +
> +static void *thread_fallocate(void *)
> +{
> +	int i, err;
> +	long tpage;
> +
> +	for (i = 0; i < FALLOCATE_ITERATIONS; i++) {

This loop has to be made runtime aware, that means that we have to put
an upper time limit into .runtime in the tst_test structure and exit
this loop if runtime has been exhausted. That means we have to break
from this loop if tst_remaining_runtime() returned zero.


> +		tpage = ((long long)random()) % (max_hpages);
> +		err = fallocate(fd,
> +				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +				tpage * hpage_size, hpage_size);
> +		if (err)
> +			tst_res(TFAIL|TERRNO, "fallocate():");
> +		err = fallocate(fd, 0, tpage * hpage_size, hpage_size);
> +		if (err)
> +			tst_res(TFAIL|TERRNO, "fallocate():");
> +	}
> +	return NULL;
> +}
> +
> +static void *fault_mmap_addr;
> +
> +static void thread_fault_cleanup(void *)
> +{
> +	if (fault_mmap_addr)
> +		munmap(fault_mmap_addr, max_hpages * hpage_size);
> +}
> +
> +static void *thread_fault(void *)
> +{
> +	long tpage;
> +	char foo;
> +	struct timespec ts = {};
> +
> +	fault_mmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
> +			PROT_READ | PROT_WRITE, MAP_SHARED,
> +			fd, 0);
> +
> +	pthread_cleanup_push(thread_fault_cleanup, NULL);
> +
> +	while (1) {
> +		tpage = ((long long)random()) % (max_hpages);
> +		foo = *((char *)(fault_mmap_addr + (tpage * hpage_size)));
> +		*((char *)(fault_mmap_addr + (tpage * hpage_size))) = foo;
> +
> +		nanosleep(&ts, NULL); /* thread cancellation point */
> +	}
> +
> +	thread_fault_cleanup(NULL);
> +
> +	pthread_cleanup_pop(1);
> +
> +	return NULL;
> +}
> +
> +static void *mmap_munmap_addr;
> +
> +static void thread_mmap_munmap_cleanup(void *)
> +{
> +	if (mmap_munmap_addr)
> +		munmap(mmap_munmap_addr, max_hpages * hpage_size);
> +}
> +
> +static void *thread_mmap_munmap(void *)
> +{
> +	struct timespec ts = {};
> +
> +	pthread_cleanup_push(thread_mmap_munmap_cleanup, NULL);
> +
> +	while (1) {
> +		mmap_munmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
> +				PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +		SAFE_MUNMAP(mmap_munmap_addr, max_hpages * hpage_size);
> +		mmap_munmap_addr = NULL;
> +
> +		nanosleep(&ts, NULL);   /* thread cancellation point */
> +	}
> +
> +	thread_mmap_munmap_cleanup(NULL);
> +
> +	pthread_cleanup_pop(1);
> +	return NULL;
> +}
> +
> +static void run_test(void)
> +{
> +	fd = tst_creat_unlinked(MNTPOINT, 0);

This should go after the variables.

> +	pthread_t falloc_th, fault_th, mmap_munmap_th;
> +	void *falloc_th_ret, *fault_th_ret, *mmap_munmap_th_ret;
> +
> +	unsigned int seed = (int)getpid() * time(NULL);
> +
> +	srandom(seed);
> +	tst_res(TINFO, "Seed = %d", seed);
> +	nr_hpages_free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	max_hpages = MIN(nr_hpages_free, MAX_PAGES_TO_USE);
> +	free_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	rsvd_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +	/* First preallocate file with max_hpages pages */

This comment is useless, please remove.

> +	err = fallocate(fd, 0, 0, hpage_size * max_hpages);
> +	if (err) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF, "fallocate() Operation is not supported");
> +		if (err) {
> +			tst_res(TFAIL|TERRNO, "fallocate():");
> +			goto windup;
> +		}
> +	}
> +
> +	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	if (free_before - free_after != max_hpages) {
> +		tst_res(TFAIL, "fallocate did not preallocate %ld huge pages\n",

No newlines in tst_res() messages.

> +				max_hpages);
> +		goto windup;
> +	}
> +
> +	SAFE_PTHREAD_CREATE(&falloc_th, NULL, thread_fallocate, NULL);
> +
> +	SAFE_PTHREAD_CREATE(&fault_th, NULL, thread_fault, NULL);
> +
> +	SAFE_PTHREAD_CREATE(&mmap_munmap_th, NULL, thread_mmap_munmap, NULL);
> +
> +	SAFE_PTHREAD_JOIN(falloc_th, &falloc_th_ret);
> +
> +	SAFE_PTHREAD_CANCEL(fault_th);
> +
> +	SAFE_PTHREAD_JOIN(fault_th, &fault_th_ret);
> +
> +	SAFE_PTHREAD_CANCEL(mmap_munmap_th);
> +
> +	SAFE_PTHREAD_JOIN(mmap_munmap_th, &mmap_munmap_th_ret);
> +
> +windup:
> +	SAFE_CLOSE(fd);
> +
> +	free_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	rsvd_after = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	if (free_after != free_before || rsvd_after != rsvd_before)
> +		tst_res(TFAIL, "free or reserve counts incorrect after fallocate stress test");
> +	else
> +		tst_res(TPASS, "fallocate stress test passed");
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = tst_get_hugepage_size();
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
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {2, TST_NEEDS},
> +};
> -- 
> 2.43.5
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
