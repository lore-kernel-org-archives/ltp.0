Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A82C433FE
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 12:23:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13FA83CB071
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 14:23:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3108E3CA7C2
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:23:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 992CC1400B70
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:23:31 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C8D342078A;
 Tue, 18 Oct 2022 12:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666095810;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/70uBPh8tLHoJ0zVe+pw0sllUwKK7T+H9bSdkdxtwgk=;
 b=s83D7Z3MY9X+yulXgMzrXWv3WECco6K+F/Bn1MKR3eDMa2o7sR32+XPX4mctiIFLFIrRyG
 Q8T6asGzK7z1r+mJf2uab504FxdFNj2JTDbNxLm0JMIW1TE5Ml3zbNGTJB6069aA321JpN
 2ZbkVErhsLyA9j9vXyj0sAAdqisEgfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666095810;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/70uBPh8tLHoJ0zVe+pw0sllUwKK7T+H9bSdkdxtwgk=;
 b=d3B9f4CuC/93S/8WjIuLpoi5yJSR907zhAC8+zHAqxtBElOKv7nlDUM8RtW4CT3IM5Y/hk
 s5Th2WMEGgOoe4CA==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 222832C141;
 Tue, 18 Oct 2022 12:23:30 +0000 (UTC)
References: <20221006110642.12410-1-andrea.cervesato@suse.com>
 <20221006110642.12410-2-andrea.cervesato@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 18 Oct 2022 12:51:53 +0100
In-reply-to: <20221006110642.12410-2-andrea.cervesato@suse.com>
Message-ID: <87edv5jp6m.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/3] Add process_madvise01 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Test for checking MADV_COLD support in process_madvise syscall.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/cma/.gitignore      |   1 +
>  testcases/kernel/syscalls/cma/cma.h           | 101 ++++++++++++
>  .../kernel/syscalls/cma/process_madvise01.c   | 153
> ++++++++++++++++++

Needs to be added to a runtest file

>  3 files changed, 255 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/cma/cma.h
>  create mode 100644 testcases/kernel/syscalls/cma/process_madvise01.c
>
> diff --git a/testcases/kernel/syscalls/cma/.gitignore b/testcases/kernel/syscalls/cma/.gitignore
> index 1ee39d93e..846704294 100644
> --- a/testcases/kernel/syscalls/cma/.gitignore
> +++ b/testcases/kernel/syscalls/cma/.gitignore
> @@ -2,3 +2,4 @@
>  /process_vm_readv02
>  /process_vm_readv03
>  /process_vm_writev02
> +/process_madvise01
> diff --git a/testcases/kernel/syscalls/cma/cma.h b/testcases/kernel/syscalls/cma/cma.h
> new file mode 100644
> index 000000000..08a0d9319
> --- /dev/null
> +++ b/testcases/kernel/syscalls/cma/cma.h
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef CMA_H__
> +#define CMA_H__
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "tst_safe_stdio.h"
> +
> +struct addr_mapping {
> +	int size;
> +	int rss;
> +	int pss;
> +	int shared_clean;
> +	int shared_dirty;
> +	int private_clean;
> +	int private_dirty;
> +	int referenced;
> +	int anonymous;
> +	int anon_huge_pages;
> +	int shmem_huge_pages;
> +	int shmem_pmd_mapped;
> +	int swap;
> +	int kernel_page_size;
> +	int mmu_page_size;
> +	int locked;
> +	int protection_key;
> +};
> +
> +static inline void read_address_mapping(unsigned long address, struct addr_mapping *mapping)
> +{
> +	FILE *f;
> +	int found = 0;
> +	char label[BUFSIZ];
> +	char line[BUFSIZ];
> +	char smaps[BUFSIZ];
> +	char ptr_str[BUFSIZ];
> +	int value;
> +
> +	snprintf(smaps, BUFSIZ, "/proc/%i/smaps", getpid());
> +	snprintf(ptr_str, BUFSIZ, "%lx", address);
> +
> +	f = SAFE_FOPEN(smaps, "r");
> +
> +	while (fgets(line, BUFSIZ, f) != NULL) {
> +		if (strncmp(ptr_str, line, strlen(ptr_str)) == 0)
> +			found = 1;
> +
> +		if (!found)
> +			continue;
> +
> +		if (found && strcmp(line, "VmFlags") >= 0)
> +			break;
> +
> +		if (sscanf(line, "%31[^:]: %d", label, &value) > 0) {
> +			if (strcmp(label, "Size") == 0)
> +				mapping->size = value;
> +			else if (strcmp(label, "Rss") == 0)
> +				mapping->rss = value;
> +			else if (strcmp(label, "Pss") == 0)
> +				mapping->pss = value;
> +			else if (strcmp(label, "Shared_Clean") == 0)
> +				mapping->shared_clean = value;
> +			else if (strcmp(label, "Shared_Dirty") == 0)
> +				mapping->shared_dirty = value;
> +			else if (strcmp(label, "Private_Clean") == 0)
> +				mapping->private_clean = value;
> +			else if (strcmp(label, "Private_Dirty") == 0)
> +				mapping->private_dirty = value;
> +			else if (strcmp(label, "Referenced") == 0)
> +				mapping->referenced = value;
> +			else if (strcmp(label, "Anonymous") == 0)
> +				mapping->anonymous = value;
> +			else if (strcmp(label, "AnonHugePages") == 0)
> +				mapping->anon_huge_pages = value;
> +			else if (strcmp(label, "ShmemHugePages") == 0)
> +				mapping->shmem_huge_pages = value;
> +			else if (strcmp(label, "ShmemPmdMapped") == 0)
> +				mapping->shmem_pmd_mapped = value;
> +			else if (strcmp(label, "Swap") == 0)
> +				mapping->swap = value;
> +			else if (strcmp(label, "KernelPageSize") == 0)
> +				mapping->kernel_page_size = value;
> +			else if (strcmp(label, "MMUPageSize") == 0)
> +				mapping->mmu_page_size = value;
> +			else if (strcmp(label, "Locked") == 0)
> +				mapping->locked = value;
> +			else if (strcmp(label, "ProtectionKey") == 0)
> +				mapping->protection_key = value;
> +		}
> +	}
> +
> +	SAFE_FCLOSE(f);
> +}
> +
> +#endif
> diff --git a/testcases/kernel/syscalls/cma/process_madvise01.c b/testcases/kernel/syscalls/cma/process_madvise01.c
> new file mode 100644
> index 000000000..d907d982c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/cma/process_madvise01.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Spawn child inside cgroup and set max memory. Allocate anonymous memory
> + * pages inside child and deactivate them with MADV_COLD. Then apply memory
> + * pressure and check if memory pages have been swapped out.
> + *
> + * The advice might be ignored for some pages in the range when it is
> + * not applicable, so test passes if swap memory increases after
> + * reclaiming memory with MADV_COLD.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <sys/mman.h>
> +#include "tst_test.h"
> +#include "lapi/mmap.h"
> +#include "lapi/syscalls.h"
> +#include "cma.h"
> +
> +#define MEM_LIMIT	(50 * 1024 * 1024)
> +#define MEM_CHILD	(10 * 1024 * 1024)
> +#define MEM_PRESS	MEM_LIMIT
> +
> +static void **data_ptr;
> +
> +static void child_alloc(void)
> +{
> +	char *ptr;
> +	char *data;
> +	size_t cmem;
> +	size_t cswap;
> +	int freed = 1;
> +	struct addr_mapping map_before;
> +	struct addr_mapping map_after;
> +
> +	tst_res(TINFO, "Set memory limit");
> +
> +	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
> +	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);

This is a hard limit, memory.high would probably be better (for V1 that
could be mapped to soft_limit_in_bytes).

> +
> +	tst_res(TINFO, "Allocate memory");
> +
> +	*data_ptr = SAFE_MMAP(NULL, MEM_CHILD,
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +	memset(*data_ptr, 'a', MEM_CHILD);
> +
> +	read_address_mapping((unsigned long)*data_ptr, &map_before);
> +
> +	SAFE_CG_SCANF(tst_cg, "memory.current", "%zu", &cmem);
> +	tst_res(TINFO, "Allocated %lu / %d bytes", cmem, MEM_LIMIT);
> +
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +
> +	tst_res(TINFO, "Apply memory pressure");
> +
> +	data = SAFE_MMAP(NULL, MEM_PRESS,
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);

This should cause swap to increase in any case. On a system with no swap
it causes the process to be killed by OOM (Unless we use memory.high).

Thinking about it, it may be better to create two mappings, one with the
advice and one without. Then check that the one with the advice is
swapped more than the one without (after applying pressure).

However we shouldn't use more than memory.high in any case.

> +	memset(data, 'b', MEM_PRESS);
> +	SAFE_MUNMAP(data, MEM_PRESS);
> +
> +	SAFE_CG_SCANF(tst_cg, "memory.swap.current", "%zu", &cswap);
> +	tst_res(TINFO, "Swap now contains %lu bytes", cswap);
> +
> +	for (ptr = *data_ptr; *ptr != '\0'; ptr++) {
> +		if (*ptr == 'a') {
> +			freed = 0;
> +			break;
> +		}
> +	}
> +
> +	if (freed) {
> +		tst_res(TFAIL, "Memory has been freed");
> +		return;
> +	}
> +
> +	read_address_mapping((unsigned long)*data_ptr, &map_after);
> +
> +	SAFE_MUNMAP(*data_ptr, MEM_CHILD);
> +
> +	if (map_before.swap < map_after.swap)
> +		tst_res(TPASS, "Memory has been swapped out");
> +	else
> +		tst_res(TFAIL, "Swap memory has decreased");
> +}
> +
> +static void setup(void)
> +{

We need to check if the system has swap available here (see madvise06)
and/or create a device to use as swap (see swapon test/syscall).

I suppose this could be useful for other tests and metadata so could be
added to the test struct.

> +	data_ptr = SAFE_MMAP(NULL, sizeof(void *),
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (*data_ptr)
> +		SAFE_MUNMAP(*data_ptr, MEM_CHILD);
> +
> +	if (data_ptr)
> +		SAFE_MUNMAP(data_ptr, sizeof(void *));
> +}
> +
> +static void run(void)
> +{
> +	int ret;
> +	int pidfd;
> +	pid_t pid_alloc;
> +	struct iovec vec;
> +
> +	pid_alloc = SAFE_FORK();
> +	if (!pid_alloc) {
> +		child_alloc();
> +		return;
> +	}
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	tst_res(TINFO, "Apply MADV_COLD advise rule");
> +
> +	pidfd = SAFE_PIDFD_OPEN(pid_alloc, 0);
> +
> +	vec.iov_base = *data_ptr;
> +	vec.iov_len = MEM_CHILD;
> +
> +	ret = tst_syscall(__NR_process_madvise, pidfd, &vec, 1UL,
> +			MADV_COLD, 0UL);
> +
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "process_madvise failed");
> +
> +	if (ret != MEM_CHILD)
> +		tst_brk(TBROK, "process_madvise reclaimed only %d bytes", ret);
> +
> +	TST_CHECKPOINT_WAKE(0);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.forks_child = 1,
> +	.min_kver = "5.10",
> +	.needs_checkpoints = 1,
> +	.needs_cgroup_ver = TST_CG_V2,
> +	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
