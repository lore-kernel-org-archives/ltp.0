Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF5AC636D4
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 10:31:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0205B3CBFA1
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 11:31:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F34A3C1047
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 11:30:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 822F1200756
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 11:30:48 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 444481F8CD;
 Mon, 13 Feb 2023 10:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676284248;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IdcVAFcJbMhHlltyu66n10Y2wgz9KYFcMCXI0lLF34U=;
 b=IoRGaXdbf/q4lCPy+b5enQNm0cvVHDTbDEs1lfVnerbV2MmSk0UHnlHdGKEnVs5cfve/n5
 3QAB8dzKj5NftZ18z1DzoW0oBIzoSVf6YPsgRkTPl+0FnwQeHN+dkDXKtHbcClngmUkbEe
 5rSA7m2BGtFCwQllYnslG/MpJ7xefyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676284248;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IdcVAFcJbMhHlltyu66n10Y2wgz9KYFcMCXI0lLF34U=;
 b=Ol5d2TOgrcHJxT0jX/f5aRzMoTGmjs3U1/OM3cL7FQKYJsNWTP87sAgj0rK6IdlTYsxJFo
 mURkLYDtS/vmL2Cg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D5C682C141;
 Mon, 13 Feb 2023 10:30:47 +0000 (UTC)
References: <87bksklax3.fsf@suse.de>
 <20230127100553.29986-1-william.roche@oracle.com>
 <20230127100553.29986-2-william.roche@oracle.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: william.roche@oracle.com
Date: Mon, 13 Feb 2023 10:00:01 +0000
Organization: Linux Private Site
In-reply-to: <20230127100553.29986-2-william.roche@oracle.com>
Message-ID: <87h6vpq2lk.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [LTP PATCH v2 1/1] madvise11: Add test for memory
 allocation / Soft-offlining possible race
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

william.roche@oracle.com writes:

> From: William Roche <william.roche@oracle.com>
>
> Test a possible race condition between mmap() allocating memory and
> madvise() used to Soft-offline an unrelated memory page.
> As fixed with the following kernel commit:
> d4ae9916ea29 mm: soft-offline: close the race against page allocation
>
> If everything works, restore all poisoned pages created by this test.

OK, I think there is just some LTP specific stuff left to fix and
setup/teardown issues.

>
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/madvise/.gitignore  |   1 +
>  testcases/kernel/syscalls/madvise/Makefile    |   3 +
>  testcases/kernel/syscalls/madvise/madvise11.c | 405 ++++++++++++++++++
>  4 files changed, 410 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ae37a1192..54098c4d9 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -947,6 +947,7 @@ madvise07 madvise07
>  madvise08 madvise08
>  madvise09 madvise09
>  madvise10 madvise10
> +madvise11 madvise11
>  
>  newuname01 newuname01
>  
> diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
> index f4bfdfefe..722ac3c34 100644
> --- a/testcases/kernel/syscalls/madvise/.gitignore
> +++ b/testcases/kernel/syscalls/madvise/.gitignore
> @@ -7,3 +7,4 @@
>  /madvise08
>  /madvise09
>  /madvise10
> +/madvise11
> diff --git a/testcases/kernel/syscalls/madvise/Makefile b/testcases/kernel/syscalls/madvise/Makefile
> index 044619fb8..9664c9ae2 100644
> --- a/testcases/kernel/syscalls/madvise/Makefile
> +++ b/testcases/kernel/syscalls/madvise/Makefile
> @@ -6,3 +6,6 @@ top_srcdir		?= ../../../..
>  include $(top_srcdir)/include/mk/testcases.mk
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +madvise11: CFLAGS += -pthread
> +
> diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
> new file mode 100644
> index 000000000..d55a69457
> --- /dev/null
> +++ b/testcases/kernel/syscalls/madvise/madvise11.c
> @@ -0,0 +1,405 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Oracle and/or its affiliates.
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Stress a possible race condition between memory pages allocation
> + * and soft-offline of unrelated pages as explained in the commit:
> + *   d4ae9916ea29 (mm: soft-offline: close the race against page allocation)
> + *
> + * Control that soft-offlined pages get correctly replaced: with the
> + * same content and without SIGBUS generation when accessed.
> + */
> +
> +#include <errno.h>
> +#include <pthread.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/mman.h>
> +#include <sys/klog.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
> +#include "tst_safe_stdio.h"
> +#include "lapi/mmap.h"
> +
> +#define NUM_LOOPS	5
> +#define NUM_PAGES	32
> +#define NUM_PAGES_OFFSET	5
> +
> +/* Needed module to online back memory pages */
> +#define HW_MODULE	"hwpoison_inject"
> +
> +static pthread_t *thread_ids;
> +static int number_threads;
> +static int run_iterations;
> +static int maximum_pfns;
> +
> +static long pagesize;
> +static char beginning_tag[BUFSIZ];
> +static int hwpoison_probe;
> +
> +
> +static void my_yield(void)
> +{
> +	static const struct timespec t0 = { 0, 0 };
> +
> +	nanosleep(&t0, NULL);
> +}
> +
> +/* a SIGBUS received is a confirmation of test failure */
> +static void sigbus_handler(int signum)
> +{
> +	tst_res(TFAIL, "SIGBUS Received");

Using tst_res in a signal handler is not safe although it usually
works. Possibly it will result in some confusing output on some systems.

Could we just set a global and read it later or drop it?

> +	_exit(signum);
> +}
> +
> +/*
> + * Allocate a page and write a sentinel value into it.
> + */
> +static void *allocate_write(int sentinel)
> +{
> +	void *p;
> +	int *s;
> +
> +	p = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
> +		 MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> +	if (p == MAP_FAILED) {
> +		tst_brk(TBROK | TTERRNO, "mmap unexpected error");
> +		return NULL;
> +	}

Is this duplicating SAFE_MMAP?

I think mmap and the if statement can be replaced with it.

> +	s = (int *)p;
> +	*s = sentinel;
> +	return p;
> +}
> +
> +/*
> + * Verify and unmap the given page.
> + */
> +static int verif_unmap(void *page, int sentinel)
> +{
> +	int *s = (int *)page;
> +	int ret;
> +
> +	if (*s != sentinel) {
> +		tst_res(TFAIL, "pid[%d]: fail: bad sentinel value seen: %d expected: %d\n", getpid(), *s, sentinel);
> +		return 1;
> +	}
> +
> +	ret = munmap(page, pagesize);
> +	if (ret == -1)
> +		tst_res(TINFO | TTERRNO, "munmap unexpected error");

Same here with munmap and SAFE_MUNMAP.

> +
> +	return ret;
> +}
> +
> +/*
> + * allocate_offline() - Allocate and offline test called per-thread
> + *
> + * This function does the allocation and offline by mmapping an
> + * anonymous page and offlining it.
> + */
> +static int allocate_offline(int tnum)
> +{
> +	int loop;
> +
> +	for (loop = 0; loop < NUM_LOOPS; loop++) {
> +		long *ptrs[NUM_PAGES];
> +		int num_alloc;
> +		int i;
> +
> +		for (num_alloc = 0; num_alloc < NUM_PAGES; num_alloc++) {
> +
> +			ptrs[num_alloc] = allocate_write((tnum << NUM_PAGES_OFFSET) | num_alloc);
> +			if (ptrs[num_alloc] == NULL)
> +				return -1;
> +
> +			if (madvise(ptrs[num_alloc], pagesize, MADV_SOFT_OFFLINE) == -1) {
> +				if (errno != EINVAL)
> +					tst_res(TFAIL | TERRNO, "madvise failed");
> +				if (errno == EINVAL)
> +					tst_res(TCONF, "madvise() didn't support MADV_SOFT_OFFLINE");
> +				return errno;
> +			}
> +		}
> +
> +		for (i = 0; i < num_alloc; i++) {
> +			if (verif_unmap(ptrs[i], (tnum << NUM_PAGES_OFFSET) | i) != 0)
> +				return 1;
> +		}
> +
> +		my_yield();
> +		if (!tst_remaining_runtime()) {
> +			tst_res(TINFO, "Thread [%d]: Test runtime is over, exiting", tnum);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void *alloc_mem(void *threadnum)
> +{
> +	int err;
> +	int tnum = (int)(uintptr_t)threadnum;
> +
> +	/* waiting for other threads starting */
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	err = allocate_offline(tnum);
> +	tst_res(TINFO,
> +		"Thread [%d] returned %d, %s.", tnum, err, (err ? "failed" : "succeeded"));
> +	return (void *)(uintptr_t) (err ? -1 : 0);
> +}
> +
> +static void stress_alloc_offl(void)
> +{
> +	int thread_index;
> +	int thread_failure = 0;
> +
> +	run_iterations++;
> +
> +	for (thread_index = 0; thread_index < number_threads; thread_index++) {
> +		SAFE_PTHREAD_CREATE(&thread_ids[thread_index], NULL, alloc_mem,
> +				    (void *)(uintptr_t)thread_index);
> +	}
> +
> +	TST_CHECKPOINT_WAKE2(0, number_threads);
> +
> +	for (thread_index = 0; thread_index < number_threads; thread_index++) {
> +		void *status;
> +
> +		SAFE_PTHREAD_JOIN(thread_ids[thread_index], &status);
> +		if ((intptr_t)status != 0) {
> +			tst_res(TFAIL, "thread [%d] - exited with errors",
> +				thread_index);
> +			thread_failure++;
> +		}
> +	}
> +
> +	if (thread_failure == 0)
> +		tst_res(TPASS, "soft-offline / mmap race still clean");
> +}
> +
> +/*
> + * ------------
> + * Cleanup code:
> + * The idea is to retrieve all the pfn numbers that have been soft-offined
> + * (generating a "Soft offlining pfn 0x..." message in the kernel ring buffer)
> + * by the current test (since a "beginning_tag" message we write when starting).
> + * And to put these pages back online by writing the pfn number to the
> + * <debugfs>/hwpoison/unpoison-pfn special file.
> + * ------------
> + */
> +#define OFFLINE_PATTERN "Soft offlining pfn 0x"
> +#define OFFLINE_PATTERN_LEN sizeof(OFFLINE_PATTERN)
> +
> +/* return the pfn if the kmsg msg is a soft-offline indication*/
> +static unsigned long parse_kmsg_soft_offlined_pfn(char *line, ssize_t len)
> +{
> +	char *pos;
> +	unsigned long addr = 0UL;
> +
> +	pos = strstr(line, OFFLINE_PATTERN);
> +	if (pos == NULL)
> +		return 0UL;
> +
> +	pos += OFFLINE_PATTERN_LEN-1;
> +	if (pos > (line + len))
> +		return 0UL;
> +
> +	addr = strtoul(pos, NULL, 16);
> +	if ((addr == ULONG_MAX) && (errno == ERANGE))
> +		return 0UL;
> +
> +	return addr;
> +}
> +
> +/* return the pfns seen in kernel message log */
> +static int populate_from_klog(char *begin_tag, unsigned long *pfns, int max)
> +{
> +	int found = 0, fd, beginning_tag_found = 0;
> +	ssize_t sz;
> +	unsigned long pfn;
> +	char buf[BUFSIZ];
> +
> +	fd = SAFE_OPEN("/dev/kmsg", O_RDONLY|O_NONBLOCK);
> +
> +	while (found < max) {
> +		sz = read(fd, buf, sizeof(buf));
> +		/* kmsg returns EPIPE if record was modified while reading */
> +		if (sz < 0 && errno == EPIPE)
> +			continue;
> +		if (sz <= 0)
> +			break;
> +		if (!beginning_tag_found) {
> +			if (strstr(buf, begin_tag))
> +				beginning_tag_found = 1;
> +			continue;
> +		}
> +		pfn = parse_kmsg_soft_offlined_pfn(buf, sz);
> +		if (pfn)
> +			pfns[found++] = pfn;
> +	}
> +	SAFE_CLOSE(fd);
> +	return found;
> +}
> +
> +/*
> + * Read the given file to search for the key.
> + * If a valuePtr is given, copy the remaining of the line right
> + * after the found key to the given location.
> + * Return 1 if the key is found.
> + */
> +static int find_in_file(char *path, char *key, char *valuePtr)

nit: we don't use camel case. Although I think this function can be
replaced, see below.

> +{
> +	char line[4096];
> +	char *pos = NULL;
> +	int found = 0;
> +	FILE *file = SAFE_FOPEN(path, "r");
> +
> +	while (fgets(line, sizeof(line), file)) {
> +		pos = strstr(line, key);
> +		if (pos) {
> +			found = 1;
> +			if (valuePtr)
> +				strncpy(valuePtr, pos + strlen(key),
> +					line + strlen(line) - pos);
> +			break;
> +		}
> +	}
> +	SAFE_FCLOSE(file);
> +	return found;
> +}
> +
> +static void unpoison_this_pfn(unsigned long pfn, int fd)
> +{
> +	char pfn_str[19];
> +
> +	snprintf(pfn_str, sizeof(pfn_str), "0x%lx", pfn);
> +	SAFE_WRITE(0, fd, pfn_str, strlen(pfn_str));
> +}
> +
> +/* Find and open the <debugfs>/hwpoison/unpoison-pfn special file */
> +static int open_unpoison_pfn(void)
> +{
> +	char *added_file_path = "/hwpoison/unpoison-pfn";
> +	const char *const cmd_modprobe[] = {"modprobe", HW_MODULE, NULL};
> +	char debugfs_fp[4096];
> +
> +	if (!find_in_file("/proc/modules", HW_MODULE, NULL))
> +		hwpoison_probe = 1;
> +
> +	/* probe hwpoison only if it isn't already there */
> +	if (hwpoison_probe)
> +		SAFE_CMD(cmd_modprobe, NULL, NULL);
> +
> +	/* debugfs mount point */
> +	if (find_in_file("/etc/mtab", "debugfs ", debugfs_fp) == 0)

Scanning mtab with strstr is fragile, at the least "debugfs" can appear
in a path. Instead please use setmntent and getmntent (you can copy &
paste from tst_device or tst_cgroup). Or scanf the whole line etc.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
