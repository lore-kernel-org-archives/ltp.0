Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A389FC4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 11:08:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 241CE3CAFE6
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 13:08:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0192C3CAFBB
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 13:08:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 758CD20092B
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 13:08:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8BF3533A26;
 Mon, 17 Oct 2022 11:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666004896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4pNOl9mpbMvujOo9Ta1bpxGYSQMzKoWXSLJcjuO464=;
 b=QFjelb/fgM3fZi5+iJZZYj/D7LUJOi8DPZNFielnke4Ov5H7OJyDur8Zf6WOhxlT3y8Fjp
 Oa/T2+m1taJJqhAYqZ8dfLOt8E1Ocq/Tj9U3y7kM8FoouZfYicpmjxBNavZvujsuAG5Qmo
 wULD0clU1XK4H647o+ttd/euddQUhWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666004896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4pNOl9mpbMvujOo9Ta1bpxGYSQMzKoWXSLJcjuO464=;
 b=4TgHArBd/vkcLQtmy3Mi4/3h5BtzmWKlg/8JKXT+8fxbMEyxfg6G24QR7riFePmtQKsFGX
 BIDeKaXs4P+WdNAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36F4213ABE;
 Mon, 17 Oct 2022 11:08:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ijneDKA3TWNOAwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 17 Oct 2022 11:08:16 +0000
Date: Mon, 17 Oct 2022 13:09:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y004BleDPQgfnyw7@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-3-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221016125731.249078-3-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 02/29] Hugetlb: Migrating libhugetlbfs
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, ltp@lists.linux.it,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Test Description: Some kernel versions after hugepage demand allocation was
> added used a dubious heuristic to check if there was enough hugepage space
> available for a given mapping.  The number of not-already-instantiated
> pages in the mapping was compared against the total hugepage free pool. It
> was very easy to confuse this heuristic into overcommitting by allocating
> hugepage memory in chunks, each less than the total available pool size but
> together more than available.  This would generally lead to OOM SIGKILLs of
> one process or another when it tried to instantiate pages beyond the
> available pool.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  | 173 ++++++++++++++++++
>  3 files changed, 175 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index f7ff81cb3..664f18827 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -4,6 +4,7 @@ hugemmap04 hugemmap04
>  hugemmap05 hugemmap05
>  hugemmap06 hugemmap06
>  hugemmap07 hugemmap07
> +hugemmap08 hugemmap08
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index df5256ec8..003ce422b 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -5,6 +5,7 @@
>  /hugetlb/hugemmap/hugemmap05
>  /hugetlb/hugemmap/hugemmap06
>  /hugetlb/hugemmap/hugemmap07
> +/hugetlb/hugemmap/hugemmap08
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> new file mode 100644
> index 000000000..63a731e09
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + *
> + * Test Name: Chunk Overcommit
> + *
> + * Test Description: Some kernel versions after hugepage demand allocation was
> + * added used a dubious heuristic to check if there was enough hugepage space
> + * available for a given mapping.  The number of not-already-instantiated pages
> + * in the mapping was compared against the total hugepage free pool. It was
> + * very easy to confuse this heuristic into overcommitting by allocating
> + * hugepage memory in chunks, each less than the total available pool size but
> + * together more than available.  This would generally lead to OOM SIGKILLs of
> + * one process or another when it tried to instantiate pages beyond the
> + * available pool.

Here as well.

> + * HISTORY
> + *  Written by David Gibson & Adam Litke
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
> +#define PROC_OVERCOMMIT "/proc/sys/vm/nr_overcommit_hugepages"
> +#define WITH_OVERCOMMIT 0
> +#define WITHOUT_OVERCOMMIT 1
> +
> +static char *verbose;
> +static char hfile[MAXPATHLEN];
> +static int fd = -1;
> +static long hpage_size;
> +
> +static void test_chunk_overcommit(void)
> +{
> +	unsigned long totpages, chunk1, chunk2;
> +	void *p, *q;
> +	pid_t child;
> +	int status;
> +
> +	totpages = SAFE_READ_MEMINFO("HugePages_Free:");
> +
> +	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
> +	SAFE_UNLINK(hfile);
> +
> +	chunk1 = (totpages / 2) + 1;
> +	chunk2 = totpages - chunk1 + 1;
> +
> +	if (verbose)
> +		tst_res(TINFO, "overcommit: %ld hugepages available: "
> +		       "chunk1=%ld chunk2=%ld", totpages, chunk1, chunk2);
> +
> +	p = SAFE_MMAP(NULL, chunk1*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +		 fd, 0);
> +
> +	/* Can't use SAFE_MMAP here, as test needs to process the output of mmap */

No comments like this plase.

> +	q = mmap(NULL, chunk2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +		 fd, chunk1*hpage_size);
> +	if (q == MAP_FAILED) {
> +		if (errno != ENOMEM) {
> +			tst_res(TFAIL | TERRNO, "mmap() chunk2");
> +			goto fail;

Again just return here. In case of cleanup below it should be:

			goto cleanup1;

> +		} else {
> +			tst_res(TPASS, "Successful without overcommit pages");
> +			goto pass;

If you want to use kernel-like goto cleanup do it at least properly as:

	} else {
		tst_res(TPASS, "Successful without overcommit pages");
		goto cleanup1;
	}

	...

cleanup2:
	SAFE_MUNMAP(q);
cleanup1:
	SAFE_MUNMAP(p);
cleanup0:
	SAFE_CLOSE(fd);
}

> +		}
> +	}
> +
> +	if (verbose)
> +		tst_res(TINFO, "Looks like we've overcommitted, testing...");
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
> +		tst_res(TFAIL, "Killed by signal \"%s\" due to overcommit",
                                                   ^
						   Single quotes ('')
						   here plase
> +		     strsignal(WTERMSIG(status)));
                      ^
		      Please use tst_strsig()

> +		goto fail;

Here as well.

> +	}
> +
> +	tst_res(TPASS, "Successful with overcommit pages");
> +
> +pass:
> +	SAFE_MUNMAP(p, chunk1*hpage_size);
> +	if (q && q != MAP_FAILED)
> +		SAFE_MUNMAP(q, chunk2*hpage_size);
> +	SAFE_CLOSE(fd);
> +	return;
> +fail:
> +	tst_brk(TBROK, "Once failed, No point in continuing the test");
> +}
> +
> +static void run_test(unsigned int test_type)
> +{
> +	long saved_oc_hugepages;
> +
> +	SAFE_FILE_LINES_SCANF(PROC_OVERCOMMIT, "%ld", &saved_oc_hugepages);

This is wrong function, the LINES_SCANF function is supposed to be used
for files that have more than one line. For this case SAFE_FILE_SCANF()
should be used instead.

> +	switch (test_type) {
> +	case WITH_OVERCOMMIT:
> +		if (saved_oc_hugepages > 0)
> +			SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 0);
> +		break;

This case says WITH_OVERCOMMIT but we disable the overcommit by writing 0?

> +	case WITHOUT_OVERCOMMIT:
> +		if (saved_oc_hugepages < 0)
> +			tst_brk(TCONF, "Kernel appears to lack dynamic hugetlb pool "
> +					"support");

I do not think that saved_oc_hugepages can even be < 0, kernel handles
the number as long unsigned.

> +		else if (saved_oc_hugepages == 0)
> +			SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 2);
> +		break;
> +	default:
> +		tst_brk(TCONF, "Not a proper test type");
> +		break;

This never happens, there is no need to handle this case.

> +	}
> +	test_chunk_overcommit();

And the PROC_OVERCOMMIT should be properly restored after the test.
Ideally by setting up .save_restore field in tst_test structure.

> +}
> +
> +static void setup(void)
> +{
> +	if (tst_hugepages < 3)
> +		tst_brk(TCONF, "Not enough hugepages for testing.");
> +
> +	if (!Hopt)
> +		Hopt = tst_get_tmpdir();
> +	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> +
> +	snprintf(hfile, sizeof(hfile), "%s/ltp_huetlbfile%d", Hopt, getpid());
> +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
> +	umount2(Hopt, MNT_DETACH);

Here as well.

> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.options = (struct tst_option[]) {
> +		{"v", &verbose, "Turns on verbose mode"},
> +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
> +		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
> +		{}
> +	},
> +	.tcnt = 2,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = run_test,
> +	.hugepages = {5, TST_REQUEST},
> +};
> +
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
