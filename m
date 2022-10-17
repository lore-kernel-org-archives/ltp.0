Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63210C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 13:43:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED0FC3CAFC9
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 15:43:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F14C63CAFC9
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 15:43:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DA99A2005D2
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 15:43:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C42B034104;
 Mon, 17 Oct 2022 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666014201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8qCEFZDHJuAapWtL/D5h9oGLMe2gEpPlN2Bx8PRN6+s=;
 b=Cxt49r27cj060t2uLtnWTIopWOFCBnpelr8TdolJZq/g33FlXX1Eikp4gBezFLXLzqAgIn
 acECkIsut8TOT+SZDSMRLZCYMTAoA0Jt39kz13xWG3mGmO+hugcZ4o3ZN2H6Ki+iOK/e92
 cXw5BDHg4TNimnlOxMSjhUp1bw90zDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666014201;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8qCEFZDHJuAapWtL/D5h9oGLMe2gEpPlN2Bx8PRN6+s=;
 b=TqCqus+gecNP0n5CsQaJbbZzSG4uocbjPWkZ6gu6T8SLu4UV6nUclmdeb8wW/DGGz5wD0V
 1qe6USG+SvfUYLBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1949513398;
 Mon, 17 Oct 2022 13:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UCUABflbTWOmYAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 17 Oct 2022 13:43:21 +0000
Date: Mon, 17 Oct 2022 15:45:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y01cX7O/XiSNzAqa@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-10-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221016125731.249078-10-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 09/29] Hugetlb: Migrating libhugetlbfs fork-cow
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
> Migrating the libhugetlbfs/testcases/fork-cow.c test
> 
> Test Description: This checks copy-on-write semantics, specifically the
> semantics of a MAP_PRIVATE mapping across a fork().  Some versions of the
> powerpc kernel had a bug in huge_ptep_set_wrprotect() which would fail to
> flush the hash table after setting the write protect bit in the parent's
> page tables, thus allowing the parent to pollute the child's mapping.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   2 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugefork/Makefile      |  10 +
>  .../kernel/mem/hugetlb/hugefork/hugefork01.c  | 220 ++++++++++++++++++
>  4 files changed, 233 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugefork/Makefile
>  create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index ec1fc2515..4c16e1e7c 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -1,6 +1,8 @@
>  hugefallocate01 hugefallocate01
>  hugefallocate02 hugefallocate02
>  
> +hugefork01 hugefork01
> +
>  hugemmap01 hugemmap01
>  hugemmap02 hugemmap02
>  hugemmap04 hugemmap04
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index c0906f3d3..adea760c7 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -1,6 +1,7 @@
>  /cpuset/cpuset01
>  /hugetlb/hugefallocate/hugefallocate01
>  /hugetlb/hugefallocate/hugefallocate02
> +/hugetlb/hugefork/hugefork01
>  /hugetlb/hugemmap/hugemmap01
>  /hugetlb/hugemmap/hugemmap02
>  /hugetlb/hugemmap/hugemmap04
> diff --git a/testcases/kernel/mem/hugetlb/hugefork/Makefile b/testcases/kernel/mem/hugetlb/hugefork/Makefile
> new file mode 100644
> index 000000000..77ebb0aef
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugefork/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2009, Cisco Systems Inc.
> +# Ngie Cooper, July 2009
> +
> +top_srcdir		?= ../../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(abs_srcdir)/../Makefile.inc
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
> new file mode 100644
> index 000000000..096ff0c4d
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2008 David Gibson, IBM Corporation.
> + *
> + * Test Name: fork COW
> + *
> + * Test Description: This checks copy-on-write semantics, specifically the
> + * semantics of a MAP_PRIVATE mapping across a fork().  Some versions of the
> + * powerpc kernel had a bug in huge_ptep_set_wrprotect() which would fail to
> + * flush the hash table after setting the write protect bit in the parent's
> + * page tables, thus allowing the parent to pollute the child's mapping.
> + *
> + * HISTORY
> + *  Written by David Gibson
> + *
> + */
> +
> +#define _GNU_SOURCE
> +
> +
> +#include <sys/shm.h>
> +#include <sys/wait.h>
> +#include <sys/mman.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +
> +#include "hugetlb.h"
> +
> +#define RANDOM_CONSTANT		0x1234ABCD
> +#define OTHER_CONSTANT		0xfeef5678
> +
> +static int  fd = -1;
> +static char hfile[MAXPATHLEN];
> +static long hpage_size;
> +static char *verbose;
> +
> +/*
> + * The parent uses this to check if the child terminated badly.
> + */
> +static void sigchld_handler(int signum, siginfo_t *si, void *uc)
> +{
> +	(void)signum;
> +	(void)uc;
> +	if (WEXITSTATUS(si->si_status) != 0) {
> +		tst_res(TFAIL, "Child failed: %d", WEXITSTATUS(si->si_status));
> +		goto fail;
> +	}
> +	if (WIFSIGNALED(si->si_status)) {
> +		tst_res(TFAIL, "Child recived signal %s",
> +				strsignal(WTERMSIG(si->si_status)));
> +		goto fail;
> +	}
> +	return;
> +fail:
> +	tst_brk(TBROK, "Once failed, No point in continuing the test");

You cannot call tst_* functions from a signal handler, these are not
async-signal-safe.

The only sensible thing to use the value filled in by the waitpid() call
instead.

> +}
> +
> +static void run_test(void)
> +{
> +	int status;
> +	void *syncarea;
> +	volatile unsigned int *p;
> +	volatile unsigned int *trigger, *child_readback;
> +	int parent_readback;
> +	pid_t pid;
> +	struct sigaction sa = {
> +		.sa_sigaction = sigchld_handler,
> +		.sa_flags = SA_SIGINFO,
> +	};
> +
> +	/* Get a shared normal page for synchronization */
> +	if (verbose)
> +		tst_res(TINFO, "Mapping synchronization area..");
> +	syncarea = SAFE_MMAP(NULL, getpagesize(), PROT_READ|PROT_WRITE,
> +			MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> +	if (verbose)
> +		tst_res(TINFO, "done");
> +
> +	trigger = syncarea;
> +	*trigger = 0;
> +
> +	child_readback = trigger + 1;
> +	*child_readback = 0;
> +
> +	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
> +	SAFE_UNLINK(hfile);
> +
> +	if (verbose)
> +		tst_res(TINFO, "Mapping hugepage area...");
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
> +	if (verbose)
> +		tst_res(TINFO, "mapped at %p", p);
> +	/* Touch the page for write in parent */
> +	if (verbose)
> +		tst_res(TINFO, "Parent writes pre-fork...");
> +	*p = RANDOM_CONSTANT;
> +	if (verbose)
> +		tst_res(TINFO, "%x", RANDOM_CONSTANT);
> +
> +	SAFE_SIGACTION(SIGCHLD, &sa, NULL);
> +
> +	pid = SAFE_FORK();
> +
> +	if (pid != 0) {
> +		/* Parent */

Useless comment again.

> +		if (verbose)
> +			tst_res(TINFO, "Parent writes post-fork...");
> +		*p = ~RANDOM_CONSTANT;
> +		if (verbose)
> +			tst_res(TINFO, "~RANDOM_CONSTANT: %x", ~RANDOM_CONSTANT);
> +		*trigger = 1;

We do have checkpoint library exactly for synchronization between parent
and child make use of them, see TST_CHECKPOINT_*.

> +		while (*trigger != 2)
> +			;
> +
> +		if (verbose)
> +			tst_res(TINFO, "Parent reads..");

I would be inclined to remove these "Parent does xyz" and "Child does abc"
messages from test once we make use of the CHECKPOINTs the
synchronization is guaranteed to be right.

> +		parent_readback = *p;
> +		if (verbose)
> +			tst_res(TINFO, "Parent readback: %x", parent_readback);
> +		*trigger = 3;
> +	} else {
> +		/* Child */

Here as well.

> +		if (verbose)
> +			tst_res(TINFO, "Child starts..");
> +		while (*trigger != 1)
> +			;
> +
> +		if (verbose)
> +			tst_res(TINFO, "Child reads...");
> +		*child_readback = *p;
> +		if (verbose) {
> +			tst_res(TINFO, "child readback: %x", *child_readback);
> +			tst_res(TINFO, "Child writes...");
> +		}
> +		*p = OTHER_CONSTANT;
> +		if (verbose)
> +			tst_res(TINFO, "OTHER_CONSTANT: %x", OTHER_CONSTANT);
> +
> +		*trigger = 2;
> +
> +		while (*trigger != 3)
> +			;
> +		if (verbose)
> +			tst_res(TINFO, "Child exits...");
> +		exit(0);
> +	}
> +
> +	if (verbose)
> +		tst_res(TINFO, "child_readback = 0x%x, parent_readback = 0x%x\n",
> +		       *child_readback, parent_readback);
> +
> +	if (*child_readback != RANDOM_CONSTANT) {
> +		tst_res(TFAIL, "Child read back 0x%x instead of 0x%x",
> +		     *child_readback, RANDOM_CONSTANT);
> +		goto fail;
> +	}
> +	if (parent_readback != ~RANDOM_CONSTANT) {
> +		tst_res(TFAIL, "Parent read back 0x%x instead of 0x%x",
> +		     parent_readback, RANDOM_CONSTANT);
> +		goto fail;
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	tst_res(TPASS, "Successful");
> +	SAFE_MUNMAP((void *)p, hpage_size);
> +	SAFE_MUNMAP(syncarea, getpagesize());
> +	SAFE_CLOSE(fd);
> +	return;
> +fail:
> +	tst_brk(TBROK, "Once failed, No point in continuing the test");

Here as well.

> +}
> +
> +static void setup(void)
> +{
> +	int free_pages = SAFE_READ_MEMINFO("HugePages_Free:");
> +
> +	if (tst_hugepages < 2 || free_pages < 2)
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
> +	umount2(Hopt, MNT_DETACH);

Here as well.

> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.options = (struct tst_option[]) {
> +		{"v", &verbose, "Turns on verbose mode"},
> +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
> +		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
> +		{}
> +	},
> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {2, TST_REQUEST},
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
