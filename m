Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A45C433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:11:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B5123CB378
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:11:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 514193CB505
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BFE181000541
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 10:36:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2F88218DF;
 Fri,  4 Nov 2022 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667554599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eaOmw5qWJRaaeDKc8YPXpiNLRBYVR2HIiMyNVdeiMnQ=;
 b=UZPisqy20h76IjE//n+UFoDJ+S462hqcBQKdqQ4dr230oNFgi/AxTOU98EMwjhCwvMF3z4
 c5Vzhta/XAJP3+zzuVJt3Hy6C8HhioG2rkDdvonAcUibWKBLT8LIzMc5W6/7jLFzSz2yBN
 yAV243E+f3KQt8VCCY3V8YJeBEFfXbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667554599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eaOmw5qWJRaaeDKc8YPXpiNLRBYVR2HIiMyNVdeiMnQ=;
 b=zC7az8BhNQfvM72/QAui4M8gB5x4nfDGL+rDZL26lCY3v24bfXGCjt9Lat1ojFM3/c0ATq
 +YRaQjMxkvxdDuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EF791346F;
 Fri,  4 Nov 2022 09:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eEyQISfdZGPJBwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 04 Nov 2022 09:36:39 +0000
Date: Fri, 4 Nov 2022 10:36:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y2TdNaxOzpaaCaPL@rei>
References: <20221104062716.615021-1-tsahu@linux.ibm.com>
 <20221104062716.615021-4-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221104062716.615021-4-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 3/4] Hugetlb: Migrating libhugetlbfs
 chunk-overcommit
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
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> new file mode 100644
> index 000000000..3efabc4aa
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Some kernel versions after hugepage demand allocation was added used a
> + * dubious heuristic to check if there was enough hugepage space available
> + * for a given mapping.  The number of not-already-instantiated pages in
> + * the mapping was compared against the total hugepage free pool. It was
> + * very easy to confuse this heuristic into overcommitting by allocating
> + * hugepage memory in chunks, each less than the total available pool size
> + * but together more than available.  This would generally lead to OOM
> + * SIGKILLs of one process or another when it tried to instantiate pages
> + * beyond the available pool.
> + *
> + * HISTORY

This looks like a leftover.

> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <signal.h>
> +
> +#include "hugetlb.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +#define WITH_OVERCOMMIT 0
> +#define WITHOUT_OVERCOMMIT 1
> +
> +static long hpage_size;
> +static int huge_fd = -1;
> +
> +static void test_chunk_overcommit(void)
> +{
> +	unsigned long totpages, chunk1, chunk2;
> +	void *p, *q;
> +	pid_t child;
> +	int status;
> +
> +	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +
> +	chunk1 = (totpages / 2) + 1;
> +	chunk2 = totpages - chunk1 + 1;
> +
> +	tst_res(TINFO, "Free: %ld hugepages available: "
> +	       "chunk1=%ld chunk2=%ld", totpages, chunk1, chunk2);
> +
> +	p = SAFE_MMAP(NULL, chunk1*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +		 huge_fd, 0);
> +
> +	q = mmap(NULL, chunk2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +		 huge_fd, chunk1*hpage_size);
> +	if (q == MAP_FAILED) {
> +		if (errno != ENOMEM) {
> +			tst_res(TFAIL | TERRNO, "mmap() chunk2");
> +			goto cleanup1;
> +		} else {
> +			tst_res(TPASS, "Successful without overcommit pages");
> +			goto cleanup1;
> +		}
> +	}
> +
> +	tst_res(TINFO, "Looks like we've overcommitted, testing...");
> +	/* Looks like we're overcommited, but we need to confirm that
> +	 * this is bad.  We touch it all in a child process because an
> +	 * overcommit will generally lead to a SIGKILL which we can't
> +	 * handle, of course.
> +	 */
> +	child = SAFE_FORK();
> +
> +	if (child == 0) {
> +		memset(p, 0, chunk1*hpage_size);
> +		memset(q, 0, chunk2*hpage_size);
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(child, &status, 0);
> +
> +	if (WIFSIGNALED(status)) {
> +		tst_res(TFAIL, "Killed by signal '%s' due to overcommit",
> +		     tst_strsig(WTERMSIG(status)));
> +		goto cleanup2;
> +	}
> +
> +	tst_res(TPASS, "Successful with overcommit pages");
> +
> +cleanup2:
> +	SAFE_MUNMAP(q, chunk2*hpage_size);
> +
> +cleanup1:
> +	SAFE_MUNMAP(p, chunk1*hpage_size);
> +	SAFE_FTRUNCATE(huge_fd, 0);
> +}
> +
> +static void run_test(unsigned int test_type)
> +{
> +	switch (test_type) {
> +	case WITHOUT_OVERCOMMIT:
> +		tst_res(TINFO, "Without overcommit testing...");
> +		SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%d", 0);
> +		break;
> +	case WITH_OVERCOMMIT:
> +		tst_res(TINFO, "With overcommit testing...");
> +		SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%d", 2);
> +		break;
> +	}
> +	test_chunk_overcommit();
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> +	huge_fd = tst_creat_unlinked(MNTPOINT);

Shouldn't we open a file under the MNTPOINT?

Something as:

#define HUGEFILE MNTPOINT "hugefile"

...
	huge_fd = tst_creat_unlinked(HUGEFILE);
...


The rest looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
