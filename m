Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A281C6FA8F
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 07:02:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFE6C3CC0D6
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 09:02:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 864773C925E
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 09:02:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C63A46009F0
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 09:02:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D89A2183F;
 Tue, 29 Aug 2023 07:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693292554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNwuq+xMFIILRnnkfG24qVtfdI8D7zf5xNHCpEdgP3k=;
 b=cr/d+qKG67bkuE032w6FJukTG34t14G0qosolpkK0x39u1ghNAKcHybQrVcbGzFSGcAGTb
 FTOCDOOieRFxKRIYYU20g74pcF2T1j94TxDbSpnD+MDBpqy4HZW8Ygvh/OeSKeSNpMXvuz
 Wc+YNQZFuEb3RM52vJA0KP9XzeEN9Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693292554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNwuq+xMFIILRnnkfG24qVtfdI8D7zf5xNHCpEdgP3k=;
 b=TncD7QOi9gU9krZSKL6lesTmtUWmHloB8CDCreJuUD2Ny1rdXoyOuYTIMrNuLkS4MMFzuX
 QPmpOQ3jVujWSSCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F59F13301;
 Tue, 29 Aug 2023 07:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id crixFQiY7WToDgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 29 Aug 2023 07:02:32 +0000
Date: Tue, 29 Aug 2023 09:02:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZO2X9KH7i5PtBaoo@rei>
References: <20230823071025.19625-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230823071025.19625-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add process_madvise01 test
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
> This test checks process_madvise support for MADV_PAGEOUT. It tests
> if memory pages have been swapped out by looking at smaps information
> after reclaiming memory using MADV_PAGEOUT.
> This test supports kernel 5.10 or later.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                              |   2 +
>  testcases/kernel/syscalls/cma/.gitignore      |   1 +
>  testcases/kernel/syscalls/cma/cma.h           | 101 ++++++++++++++
>  .../kernel/syscalls/cma/process_madvise01.c   | 124 ++++++++++++++++++

Shouldn't we put the process_madvise01.c into syscalls/process_madvise/
directory instead?

>  4 files changed, 228 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/cma/cma.h
>  create mode 100644 testcases/kernel/syscalls/cma/process_madvise01.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 119710d63..64907ff53 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1046,6 +1046,8 @@ process_vm_readv03 process_vm_readv03
>  process_vm_writev01 process_vm01
>  process_vm_writev02 process_vm_writev02
>  
> +process_madvise01 process_madvise01
> +
>  prot_hsymlinks prot_hsymlinks
>  dirtyc0w dirtyc0w
>  dirtyc0w_shmem dirtyc0w_shmem
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
>
> diff --git a/testcases/kernel/syscalls/cma/process_madvise01.c b/testcases/kernel/syscalls/cma/process_madvise01.c
> new file mode 100644
> index 000000000..ea3e0270d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/cma/process_madvise01.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Allocate anonymous memory pages inside child and reclaim it with
> + * MADV_PAGEOUT. Then check if memory pages have been swapped out by looking
> + * at smaps information.
> + *
> + * The advice might be ignored for some pages in the range when it is
> + * not applicable, so test passes if swap memory increases after
> + * reclaiming memory with MADV_PAGEOUT.
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
> +#define MEM_CHILD	(1 * TST_MB)
> +
> +static void **data_ptr;
> +
> +static void child_alloc(void)
> +{
> +	char data[MEM_CHILD];
> +	struct addr_mapping map_before;
> +	struct addr_mapping map_after;
> +
> +	memset(data, 'a', MEM_CHILD);
> +
> +	tst_res(TINFO, "Allocate memory: %d bytes", MEM_CHILD);
> +
> +	*data_ptr = SAFE_MMAP(NULL, MEM_CHILD,
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +
> +	memset(*data_ptr, 'a', MEM_CHILD);
> +
> +	memset(&map_before, 0, sizeof(struct addr_mapping));
> +	read_address_mapping((unsigned long)*data_ptr, &map_before);
> +
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +
> +	memset(&map_after, 0, sizeof(struct addr_mapping));
> +	read_address_mapping((unsigned long)*data_ptr, &map_after);
> +
> +	if (memcmp(*data_ptr, data, MEM_CHILD) != 0) {
> +		tst_res(TFAIL, "Dirty memory after reclaiming it");
> +		return;
> +	}
> +
> +	SAFE_MUNMAP(*data_ptr, MEM_CHILD);
> +	*data_ptr = NULL;
> +
> +    TST_EXP_EXPR(map_before.swap < map_after.swap,

Wrong indentation.

> +        "Most of the memory has been swapped out: %dkB",
> +        map_after.swap);

Shouldn't we print the difference here instead? What's the point of
printing the absolute value.

> +}
> +
> +static void setup(void)
> +{
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
> +	tst_res(TINFO, "Reclaim memory using MADV_PAGEOUT");
> +
> +	pidfd = SAFE_PIDFD_OPEN(pid_alloc, 0);
> +
> +	vec.iov_base = *data_ptr;
> +	vec.iov_len = MEM_CHILD;
> +
> +	ret = tst_syscall(__NR_process_madvise, pidfd, &vec, 1UL,
> +			MADV_PAGEOUT, 0UL);


Without root this fails for me with EPERM, do we need .needs_root = 1 in
the test structure?

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
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
