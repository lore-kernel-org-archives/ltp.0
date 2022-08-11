Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41800C19F2D
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 07:34:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98CFE3C9539
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 09:34:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0FFA3C9485
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 09:34:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E94891000A10
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 09:34:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFA135CB9A;
 Thu, 11 Aug 2022 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660203265;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IRfUwsnWrcRQ3/n/juoTA8VTwa0cPv3LxO0hA+2gkpA=;
 b=yudrOCTckD+n/yPgbMe0gsxG8QscM60UxO/3mfpdtmwmhfPUvx5gRoT4RxIBDTG73zX18d
 BNiTnv6fzOm28u8xL3d0QNkRt7YVIEGTg0k0W8G+AOAqsrZ5GCL1VL9MfUXSHXaxb26SB+
 ZLlyMp6v34z5R+P7hml8+o7kqlmYJAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660203265;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IRfUwsnWrcRQ3/n/juoTA8VTwa0cPv3LxO0hA+2gkpA=;
 b=TRosbvVDwkP8GbocV+F+VoDpgLObX/bMCF9rMNqipyODKcysbHAkF/5rHnI+9qnOo7qzBz
 yTFTHg6dwmoHx+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB2C11342A;
 Thu, 11 Aug 2022 07:34:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TKPpKwGx9GJvOgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 11 Aug 2022 07:34:25 +0000
Date: Thu, 11 Aug 2022 09:34:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: William Roche <william.roche@oracle.com>
Message-ID: <YvSw/xDxNRRLKw8g@pevik>
References: <1659975072-29808-1-git-send-email-william.roche@oracle.com>
 <1659975072-29808-2-git-send-email-william.roche@oracle.com>
 <YvPkOHRgUGx0QVMi@pevik>
 <cedb3470-8351-2fe1-7719-4e3515692a4b@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cedb3470-8351-2fe1-7719-4e3515692a4b@oracle.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [LTP PATCH v1 1/1] syscalls/madvise11: Add some memory
 page soft-offlining control
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi William,

> Thank you very much Petr for your feedback.

> The 2 failure cases you told me about look very different:

> Fedora is failing on the cleanup phase, and I need to investigate that.
> But SLE12-SP2 kernel makes the test-case fail in a way that seems to
> indicate it has a problem dealing with soft-offlined pages and may need some
> fixes.

> Please let me try out Fedora 5.13.16-200.fc34.x86_64, and if you have a
> pointer where I could find it (?) that could help.

Unfortunately I have no pointer, maybe others on the list might know.

Kind regards,
Petr

> Thanks,
> William.


> On 10/08/2022 19:00, Petr Vorel wrote:
> > Hi William,

> > I tested your madvise11 on various x86_64 VMs and it fails on two:

> > # ./madvise11 # Fedora 5.13.16-200.fc34.x86_64
> > madvise11.c:136: TINFO: Thread [18]: allocate_offline() returned 0, succeeded.  Thread exiting
> > madvise11.c:175: TPASS: soft-offline/alloc stress test finished successfully
> > madvise11.c:316: TINFO: Restore 900 Soft-offlined pages
> > tst_test.c:1583: TBROK: Test killed by SIGSEGV!

> > # ./madvise11 # SLE12-SP2 4.4.21-69-default
> > tst_test.c:1528: TINFO: Timeout per run is 0h 05m 30s
> > madvise11.c:56: TFAIL: SIGBUS Received

> > # strace -ff ./madvise11
> > ...
> > [pid  3463] mprotect(0x7fcda9ff9000, 4096, PROT_NONE) = 0
> > [pid  3463] clone(child_stack=0x7fcdaa7f8ff0, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, parent_tidptr=0x7fcdaa7f99d0, tls=0x7fcdaa7f9700, child_tidptr=0x7fcdaa7f99d0) = 3523
> > [pid  3463] futex(0x7fcdc881301c, FUTEX_WAKE, 2147483647 <unfinished ...>
> > [pid  3480] <... futex resumed> )       = 0
> > [pid  3480] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc8812000
> > [pid  3480] madvise(0x7fcdc8812000, 4096, MADV_SOFT_OFFLINE <unfinished ...>
> > [pid  3478] <... futex resumed> )       = 0
> > [pid  3478] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc8811000
> > [pid  3478] madvise(0x7fcdc8811000, 4096, MADV_SOFT_OFFLINE <unfinished ...>
> > [pid  3476] <... futex resumed> )       = 0
> > [pid  3476] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc8810000
> > [pid  3476] madvise(0x7fcdc8810000, 4096, MADV_SOFT_OFFLINE <unfinished ...>
> > [pid  3474] <... futex resumed> )       = 0
> > [pid  3474] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc880f000
> > [pid  3474] madvise(0x7fcdc880f000, 4096, MADV_SOFT_OFFLINE <unfinished ...>
> > [pid  3469] <... futex resumed> )       = 0
> > [pid  3469] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc880e000
> > [pid  3469] madvise(0x7fcdc880e000, 4096, MADV_SOFT_OFFLINE <unfinished ...>
> > [pid  3467] <... futex resumed> )       = 0
> > [pid  3480] <... madvise resumed> )     = 0
> > [pid  3480] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc880d000
> > [pid  3480] --- SIGBUS {si_signo=SIGBUS, si_code=0x4, si_addr=0x7fcdc880d000} ---
> > [pid  3480] write(2, "madvise11.c:56: \33[1;31mTFAIL: \33["..., 50madvise11.c:56: TFAIL: SIGBUS Received
> > ) = 50
> > [pid  3480] exit_group(7)               = ?
> > [pid  3480] +++ exited with 7 +++
> > [pid  3478] +++ exited with 7 +++
> > [pid  3476] +++ exited with 7 +++
> > [pid  3474] +++ exited with 7 +++
> > [pid  3469] +++ exited with 7 +++
> > [pid  3468] +++ exited with 7 +++
> > [pid  3467] +++ exited with 7 +++
> > [pid  3466] +++ exited with 7 +++
> > [pid  3465] +++ exited with 7 +++
> > strace: Exit of unknown pid 3492 ignored
> > strace: Exit of unknown pid 3491 ignored
> > strace: Exit of unknown pid 3489 ignored
> > strace: Exit of unknown pid 3488 ignored
> > strace: Exit of unknown pid 3497 ignored
> > strace: Exit of unknown pid 3500 ignored
> > [pid  3464] +++ exited with 7 +++

> > I would not be too concerned about old SLE12-SP2 kernel, but at least failure on
> > relatively new Fedora 34 kernel would be good to fix.

> > Also adding .min_kver = "2.6.33" is IMHO not necessary, it's old enough
> > (LTP wouldn't be even compiled on such old kernel).

> > Kind regards,
> > Petr

> > > Stress the soft-offlining code while allocating memory to verify
> > > the replaced pages use and content. If everything works fine,
> > > retore all soft-offlined pages and exit.
> > > Signed-off-by: William Roche <william.roche@oracle.com>
> > > Acked-by: Liam Merwick <liam.merwick@oracle.com>
> > > ---
> > >   testcases/kernel/syscalls/madvise/.gitignore  |   1 +
> > >   testcases/kernel/syscalls/madvise/Makefile    |   2 +
> > >   testcases/kernel/syscalls/madvise/madvise11.c | 381 ++++++++++++++++++
> > >   3 files changed, 384 insertions(+)
> > >   create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c
> > > diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
> > > index 002d8e5d9..6e5b92ab7 100644
> > > --- a/testcases/kernel/syscalls/madvise/.gitignore
> > > +++ b/testcases/kernel/syscalls/madvise/.gitignore
> > > @@ -6,3 +6,4 @@
> > >   /madvise08
> > >   /madvise09
> > >   /madvise10
> > > +/madvise11
> > > diff --git a/testcases/kernel/syscalls/madvise/Makefile b/testcases/kernel/syscalls/madvise/Makefile
> > > index 044619fb8..78613df11 100644
> > > --- a/testcases/kernel/syscalls/madvise/Makefile
> > > +++ b/testcases/kernel/syscalls/madvise/Makefile
> > > @@ -6,3 +6,5 @@ top_srcdir		?= ../../../..
> > >   include $(top_srcdir)/include/mk/testcases.mk
> > >   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > > +
> > > +madvise11: CFLAGS += -pthread
> > > diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
> > > new file mode 100644
> > > index 000000000..9ea745aca
> > > --- /dev/null
> > > +++ b/testcases/kernel/syscalls/madvise/madvise11.c
> > > @@ -0,0 +1,381 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Copyright (c) 2022 Oracle and/or its affiliates.
> > > + */
> > > +
> > > +/*\
> > > + * [Description]
> > > + * Stress the VMM and soft-offline code by spawning N threads which
> > > + * allocate memory pages and soft-offline them repeatedly.
> > > + * Control that soft-offlined pages get correctly replaced: with the
> > > + * same content and without SIGBUS generation when accessed.
> > > + * Could be used for example as a regression test-case for the
> > > + * poisoned soft-offlined pages case fixed by upstream commit
> > > + * d4ae9916ea29 (mm: soft-offline: close the race against page allocation)
> > > + */
> > > +
> > > +#include <stdio.h>
> > > +#include <pthread.h>
> > > +#include <stdlib.h>
> > > +#include <unistd.h>
> > > +#include <math.h>
> > > +#include <assert.h>
> > > +#include <errno.h>
> > > +#include <stdint.h>
> > > +#include <sys/types.h>
> > > +#include <sys/mman.h>
> > > +#include <sys/klog.h>
> > > +#include <time.h>
> > > +
> > > +#include "tst_test.h"
> > > +#include "tst_safe_pthread.h"
> > > +#include "tst_safe_clocks.h"
> > > +#include "tst_safe_stdio.h"
> > > +#include "lapi/mmap.h"
> > > +
> > > +#define NUM_THREADS	60	/* Number of threads to create */
> > > +#define NUM_LOOPS	 3	/* Number of loops per-thread */
> > > +#define NUM_PAGES	 5	/* Max number of allocated pages for each loop */
> > > +
> > > +/* needed module to online back pages */
> > > +#define HW_MODULE	"hwpoison_inject"
> > > +
> > > +static pthread_t *thread_id;		/* ptr to an array of spawned threads */
> > > +static long PAGESIZE;
> > > +static char beginningTag[BUFSIZ];	/* kmsg tag indicating our test start */
> > > +static int hwpoison_probe = 0;		/* do we have to probe hwpoison_inject? */
> > > +
> > > +static void my_yield(void)
> > > +{
> > > +	static const struct timespec t0 = { 0, 0 };
> > > +	nanosleep(&t0, NULL);
> > > +}
> > > +
> > > +/* a SIGBUS received is a confirmation of test failure */
> > > +static void sigbus_handler(int signum) {
> > > +	tst_res(TFAIL, "SIGBUS Received");
> > > +	_exit(signum);
> > > +}
> > > +
> > > +/*
> > > + * allocate_offline() - Allocate and offline test called per-thread
> > > + *
> > > + * This function does the allocation and offline by mmapping an
> > > + * anonymous page and offlining it.
> > > + *
> > > + * Return:
> > > + *  0: success
> > > + *  1: failure
> > > + */
> > > +static int allocate_offline(int tnum)
> > > +{
> > > +	int loop;
> > > +	const int MAXPTRS = NUM_PAGES;
> > > +
> > > +	for (loop = 0; loop < NUM_LOOPS; loop++) {
> > > +		long *ptrs[MAXPTRS];
> > > +		int num_alloc;
> > > +		int i;
> > > +
> > > +		/* loop terminates in one of two ways:
> > > +		 * 1. after MAXPTRS iterations
> > > +		 * 2. if page alloc fails
> > > +		 */
> > > +		for (num_alloc = 0; num_alloc < MAXPTRS; num_alloc++) {
> > > +
> > > +			/* alloc the next page - the problem is more rapidly reproduced with MAP_SHARED */
> > > +			ptrs[num_alloc] = mmap(NULL, PAGESIZE, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> > > +			/* terminate loop if alloc fails */
> > > +			if (!ptrs[num_alloc])
> > > +				break;
> > > +			/* write a uniq content */
> > > +			ptrs[num_alloc][0] = num_alloc;
> > > +			ptrs[num_alloc][1] = tnum;
> > > +
> > > +			/* soft-offline requested */
> > > +			if (madvise(ptrs[num_alloc], PAGESIZE, MADV_SOFT_OFFLINE) == -1) {
> > > +				if (errno != EINVAL && errno != EBUSY)
> > > +					tst_res(TFAIL | TERRNO, "madvise failed");
> > > +				if (errno == EINVAL)
> > > +					tst_res(TCONF, "madvise() didn't support MADV_SOFT_OFFLINE");
> > > +				return errno;
> > > +			}
> > > +		}
> > > +
> > > +		/* verify if the offlined pages content has changed */
> > > +		for (i = 0; i < num_alloc; i++) {
> > > +			if (ptrs[i][0] != i || ptrs[i][1] != tnum) {
> > > +				tst_res(TFAIL,
> > > +					"pid[%d] tnum[%d]: fail: bad sentinel value\n",
> > > +					getpid(), tnum);
> > > +				return 1;
> > > +			}
> > > +			munmap(ptrs[i], PAGESIZE);
> > > +		}
> > > +
> > > +		my_yield();
> > > +		if (!tst_remaining_runtime()) {
> > > +			tst_res(TINFO, "Thread [%d]: Test runtime is over, exiting", tnum);
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	/* Success! */
> > > +	return 0;
> > > +}
> > > +
> > > +static void *alloc_mem(void *threadnum)
> > > +{
> > > +	int err;
> > > +	int tnum = (int)(uintptr_t)threadnum;
> > > +
> > > +	/* waiting for other threads starting */
> > > +	TST_CHECKPOINT_WAIT(0);
> > > +
> > > +	err = allocate_offline(tnum);
> > > +	tst_res(TINFO,
> > > +		"Thread [%d]: allocate_offline() returned %d, %s.  Thread exiting",
> > > +		tnum, err, (err ? "failed" : "succeeded"));
> > > +	return (void *)(uintptr_t) (err ? -1 : 0);
> > > +}
> > > +
> > > +static void stress_alloc_offl(void)
> > > +{
> > > +	struct sigaction my_sigaction;
> > > +	int thread_index;
> > > +	int thread_failure = 0;
> > > +
> > > +	/* SIGBUS is a failure criteria */
> > > +	my_sigaction.sa_handler = sigbus_handler;
> > > +	if (sigaction(SIGBUS, &my_sigaction, NULL) == -1)
> > > +		tst_res(TFAIL | TERRNO, "Signal handler attach failed");
> > > +
> > > +	/* create all threads */
> > > +	for (thread_index = 0; thread_index < NUM_THREADS; thread_index++) {
> > > +		SAFE_PTHREAD_CREATE(&thread_id[thread_index], NULL, alloc_mem,
> > > +				    (void *)(uintptr_t)thread_index);
> > > +	}
> > > +
> > > +	/* wake up all threads */
> > > +	TST_CHECKPOINT_WAKE2(0, NUM_THREADS);
> > > +
> > > +	/* wait for all threads to finish */
> > > +	for (thread_index = 0; thread_index < NUM_THREADS; thread_index++) {
> > > +		void *status;
> > > +
> > > +		SAFE_PTHREAD_JOIN(thread_id[thread_index], &status);
> > > +		if ((intptr_t)status != 0) {
> > > +			tst_res(TFAIL, "thread [%d] - exited with errors",
> > > +				thread_index);
> > > +			thread_failure++;
> > > +		}
> > > +	}
> > > +
> > > +	if (thread_failure == 0)
> > > +		tst_res(TPASS, "soft-offline/alloc stress test finished successfully");
> > > +}
> > > +
> > > +/*
> > > + * ------------
> > > + * Cleanup code:
> > > + * The idea is to retrieve all the pfn numbers that have been soft-offined
> > > + * (generating a "Soft offlining pfn 0x..." message in the kernel ring buffer)
> > > + * by the current test (since a "beginningTag" message we write when starting).
> > > + * And to put these pages back online by writing the pfn number to the
> > > + * <debugfs>/hwpoison/unpoison-pfn special file.
> > > + * ------------
> > > + */
> > > +#define OFFLINE_PATTERN "Soft offlining pfn 0x"
> > > +#define OFFLINE_PATTERN_LEN sizeof(OFFLINE_PATTERN)
> > > +
> > > +/* return the pfn if the kmsg msg is a soft-offline indication*/
> > > +static unsigned long parse_kmsg_soft_offlined_pfn(char *line, ssize_t len)
> > > +{
> > > +	char *pos;
> > > +	unsigned long addr = 0UL;
> > > +
> > > +	pos = strstr(line, OFFLINE_PATTERN);
> > > +	if (pos == NULL)
> > > +		return 0UL;
> > > +
> > > +	pos += OFFLINE_PATTERN_LEN-1;
> > > +	if (pos > (line + len))
> > > +		return 0UL;
> > > +
> > > +	addr = strtoul(pos, NULL, 16);
> > > +	if ((addr == ULONG_MAX) && (errno == ERANGE))
> > > +		return 0UL;
> > > +
> > > +	return addr;
> > > +}
> > > +
> > > +/* return the pfns seen in kernel message log */
> > > +static int populate_from_klog(char* beginTag, unsigned long *pfns, int max)
> > > +{
> > > +	int found = 0, fd, beginningTag_found = 0;
> > > +	ssize_t sz;
> > > +	unsigned long pfn;
> > > +	char buf[BUFSIZ];
> > > +
> > > +	fd = SAFE_OPEN("/dev/kmsg", O_RDONLY|O_NONBLOCK);
> > > +
> > > +	while (found < max) {
> > > +		sz = read(fd, buf, sizeof(buf));
> > > +		/* kmsg returns EPIPE if record was modified while reading */
> > > +		if (sz < 0 && errno == EPIPE)
> > > +			continue;
> > > +		if (sz <= 0)
> > > +			break;
> > > +		if (!beginningTag_found) {
> > > +			if (strstr(buf, beginTag))
> > > +				beginningTag_found = 1;
> > > +			continue;
> > > +		}
> > > +		pfn = parse_kmsg_soft_offlined_pfn(buf, sz);
> > > +		if (pfn)
> > > +			pfns[found++] = pfn;
> > > +	}
> > > +	SAFE_CLOSE(fd);
> > > +	return found;
> > > +}
> > > +
> > > +/*
> > > + * Read the given file to search for the key.
> > > + * If a valuePtr is given, copy the remaining of the line right
> > > + * after the found key to the given location.
> > > + * Return 1 if the key is found.
> > > + */
> > > +static int find_in_file(char *path, char *key, char *valuePtr)
> > > +{
> > > +	char line[4096];
> > > +	char *pos = NULL;
> > > +	int found = 0;
> > > +	FILE *file = SAFE_FOPEN(path, "r");
> > > +	while (fgets(line, sizeof(line), file)) {
> > > +		pos = strstr(line, key);
> > > +		if (pos) {
> > > +			found = 1;
> > > +			if (valuePtr)
> > > +				strncpy(valuePtr, pos + strlen(key),
> > > +					line + strlen(line) - pos);
> > > +			break;
> > > +		}
> > > +	}
> > > +	SAFE_FCLOSE(file);
> > > +	return found;
> > > +}
> > > +
> > > +static void unpoison_this_pfn(unsigned long pfn, int fd)
> > > +{
> > > +	char pfn_str[19]; /* unsigned long to ascii: 0x...\0 */
> > > +
> > > +	snprintf(pfn_str, sizeof(pfn_str), "0x%lx", pfn);
> > > +	SAFE_WRITE(0, fd, pfn_str, strlen(pfn_str));
> > > +}
> > > +
> > > +/* Find and open the <debugfs>/hwpoison/unpoison-pfn special file */
> > > +static int open_unpoison_pfn(void)
> > > +{
> > > +	char *added_file_path = "/hwpoison/unpoison-pfn";
> > > +	const char *const cmd_modprobe[] = {"modprobe", HW_MODULE, NULL};
> > > +	char debugfs_fp[4096];
> > > +
> > > +	if (!find_in_file("/proc/modules", HW_MODULE, NULL))
> > > +		hwpoison_probe = 1;
> > > +
> > > +	/* probe hwpoison only if it isn't already there */
> > > +	if (hwpoison_probe)
> > > +		SAFE_CMD(cmd_modprobe, NULL, NULL);
> > > +
> > > +	/* debugfs mount point */
> > > +	if (find_in_file("/etc/mtab", "debugfs ", debugfs_fp) == 0)
> > > +		return -1;
> > > +	strcpy(strstr(debugfs_fp, " "), added_file_path);
> > > +
> > > +	return (SAFE_OPEN(debugfs_fp, O_WRONLY));
> > > +}
> > > +
> > > +/*
> > > + * Get all the Offlined PFNs indicated in the dmesg output
> > > + * starting after the given beginning tag, and request a debugfs
> > > + * hwpoison/unpoison-pfn for each of them.
> > > + */
> > > +static void unpoison_pfn(char* beginTag)
> > > +{
> > > +
> > > +	/* maximum of pages to deal with */
> > > +	const int MAXPFN = NUM_THREADS*NUM_LOOPS*NUM_PAGES;
> > > +	unsigned long pfns[MAXPFN];
> > > +	const char *const cmd_rmmod[] = {"rmmod", HW_MODULE, NULL};
> > > +	int found_pfns, fd;
> > > +
> > > +	fd = open_unpoison_pfn();
> > > +	if (fd >= 0) {
> > > +		found_pfns = populate_from_klog(beginTag, pfns, MAXPFN);
> > > +
> > > +		tst_res(TINFO,"Restore %d Soft-offlined pages", found_pfns);
> > > +		/* unpoison in reverse order */
> > > +		while (found_pfns-- > 0)
> > > +			unpoison_this_pfn(pfns[found_pfns], fd);
> > > +
> > > +		SAFE_CLOSE(fd);
> > > +	}
> > > +	/* remove hwpoison only if we probed it */
> > > +	if (hwpoison_probe)
> > > +		SAFE_CMD(cmd_rmmod, NULL, NULL);
> > > +}
> > > +
> > > +/*
> > > + * Create and write a beginning tag to the kernel buffer to be used on cleanup
> > > + * when trying to restore the soft-offlined pages of our test run.
> > > + */
> > > +static void write_beginningTag_to_kmsg(void)
> > > +{
> > > +	int fd;
> > > +
> > > +	fd = SAFE_OPEN("/dev/kmsg", O_WRONLY);
> > > +	if (fd < 0) {
> > > +		tst_res(TCONF | TERRNO,"/dev/kmsg not available for writing");
> > > +		return;
> > > +	}
> > > +	snprintf(beginningTag, sizeof(beginningTag),
> > > +		 "Soft-offlining pages test starting (pid: %ld)",
> > > +		 (long)getpid());
> > > +	SAFE_WRITE(1, fd, beginningTag, strlen(beginningTag));
> > > +	SAFE_CLOSE(fd);
> > > +}
> > > +
> > > +static void setup(void)
> > > +{
> > > +	thread_id = SAFE_MALLOC(sizeof(pthread_t) * NUM_THREADS);
> > > +	PAGESIZE = sysconf(_SC_PAGESIZE);
> > > +	write_beginningTag_to_kmsg();
> > > +}
> > > +
> > > +static void cleanup(void)
> > > +{
> > > +	if (thread_id) {
> > > +		free(thread_id);
> > > +		thread_id = NULL;
> > > +	}
> > > +	unpoison_pfn(beginningTag);
> > > +}
> > > +
> > > +static struct tst_test test = {
> > > +	.min_kver = "2.6.33",
> > > +	.needs_root = 1,
> > > +	.needs_drivers = (const char *const []) {
> > > +		HW_MODULE,
> > > +		NULL
> > > +	},
> > > +	.needs_cmds = (const char *[]) {
> > > +		"modprobe",
> > > +		"rmmod",
> > > +		NULL
> > > +	},
> > > +	.max_runtime = 300,
> > > +	.needs_checkpoints = 1,
> > > +	.setup = setup,
> > > +	.cleanup = cleanup,
> > > +	.test_all = stress_alloc_offl,
> > > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
