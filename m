Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD104C624C6
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 13:34:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A48113E96E9
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 15:34:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 144633C74FD
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 15:34:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 296611400BF0
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 15:34:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 405C322361;
 Mon, 31 Aug 2026 13:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788183264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqDpthG5drfD57n8GlPob2JzK152mxSC83ICSC23Ya8=;
 b=E/VIFsBR+l6OkzFaUBKWYQ3AiHEnEArKyUboIG7NIKH0irHw9FerlW6L9UmsnMOb57npAb
 BwWP6QatrJX618WMxtzS6LIyjkL4g+R1XRuKeQ99RNBcHWvGUB0TKO5JmnDtBiTujGTrdv
 qAGuA1qFhRuV2XkvoYTKviI1uxHnF6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788183264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqDpthG5drfD57n8GlPob2JzK152mxSC83ICSC23Ya8=;
 b=g8Tib3YRjLr9h1Oe1p2qKWTZoOAXrWvx+DUDeSLLZzy8AHe4jrkpEpbUrs/QyYWQP55+Fq
 5gdmloRR76bjEbCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ijSW3Hmv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/tVzQHnX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788183260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqDpthG5drfD57n8GlPob2JzK152mxSC83ICSC23Ya8=;
 b=ijSW3Hmvfd/PLCnJTzkXhb+/4friB273auOAFe0XtdfuOyLvlOwoHjnvxPFPjNP5ltKU75
 PwMiirK3HDH9v/g8XMdtrbKJM0MGVZZp4ADFhokJ723TSJe/lKQ1Dcnv+0jyTmUK7LN+mD
 AV160oYDyGNXWaxEV7o1n/fc/wWh7V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788183260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqDpthG5drfD57n8GlPob2JzK152mxSC83ICSC23Ya8=;
 b=/tVzQHnXeauicNXFOyUsqERWSsaZ6UmDjENykBrEdWkLmYqXGr415eMixosezhHHzo73V6
 0lydiAk815q1MYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C3BB13515;
 Mon, 31 Aug 2026 13:34:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j9nxAtyClWplRgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 31 Aug 2026 13:34:20 +0000
Date: Mon, 31 Aug 2026 15:34:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Samir Mulani <samir@linux.ibm.com>
Message-ID: <apWC47N-QwCs8kXb@yuki.lan>
References: <20260821121239.50594-1-samir@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260821121239.50594-1-samir@linux.ibm.com>
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 405C322361
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.79 / 50.00];
 ABUSE_SURBL(5.00)[linux.ibm.com:email];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; BAD_REP_POLICIES(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] hugemmap: Migrate alloc-instantiate-race test
 from libhugetlbfs
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
> This test is designed to detect a kernel allocation race introduced
> with hugepage demand-faulting.  The problem is that no lock is held
> between allocating a hugepage and instantiating it in the
> pagetables or page cache index.  In between the two, the (huge)
> page is cleared, so there's substantial time.  Thus two processes
> can race instantiating the (same) last available hugepage - one
> will fail on the allocation, and thus cause an OOM fault even
> though the page it actually wants is being instantiated by the
> other racing process.
> 
> [1] https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/alloc-instantiate-race.c
> 
> Signed-off-by: Samir Mulani <samir@linux.ibm.com>
> ---
> v7:
> - Fix commit message: s/hugemmap36/hugemmap42/
> - Add hugemmap42_private runtest entry to exercise the MAP_PRIVATE
>   pthread path (-m private)
> - Pass 0 instead of getpid() to sched_setaffinity() so each racer
>   thread pins itself, not the thread-group leader
> - Fault in all p_sync pages before run_race() so hugepages are
>   actually consumed from the pool before the race starts
> - Save sync_mapping_size at mmap() time and reuse it in cleanup()
>   instead of re-reading MEMINFO_HPAGE_FREE
> - Use {} instead of {NULL, NULL, NULL} as options array sentinel
> 
> Link: https://lore.kernel.org/all/20250928030721.3537869-1-samir@linux.ibm.com/ #v3
> Link: https://lore.kernel.org/ltp/20260317095559.5766-1-samir@linux.ibm.com/ #v4
> Link: https://lore.kernel.org/ltp/20260504132405.333588-1-samir@linux.ibm.com/ #v5
> Link: https://lore.kernel.org/ltp/20260818143106.43797-1-samir@linux.ibm.com/ #v6
> 
>  runtest/hugetlb                               |   2 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap42.c  | 317 ++++++++++++++++++
>  3 files changed, 320 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 6b35c1f42..b7872368d 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -40,6 +40,8 @@ hugemmap35 hugemmap35
>  hugemmap36 hugemmap36
>  hugemmap37 hugemmap37
>  hugemmap38 hugemmap38
> +hugemmap42 hugemmap42
> +hugemmap42_private hugemmap42 -m private

This is ugly. The modern way how to run two subtests in LTP is to set
.tcnt = 2 and switch on the index in the run() function.

>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index e63a6dde7..a0a877a58 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -40,6 +40,7 @@
>  /hugetlb/hugemmap/hugemmap36
>  /hugetlb/hugemmap/hugemmap37
>  /hugetlb/hugemmap/hugemmap38
> +/hugetlb/hugemmap/hugemmap42
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c
> new file mode 100644
> index 000000000..901ea07ab
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap42.c
> @@ -0,0 +1,317 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006, 2026 IBM Corporation
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * This test is designed to detect a kernel allocation race introduced
> + * with hugepage demand-faulting.  The problem is that no lock is held
> + * between allocating a hugepage and instantiating it in the
> + * pagetables or page cache index.  In between the two, the (huge)
> + * page is cleared, so there's substantial time.  Thus two processes
> + * can race instantiating the (same) last available hugepage - one
> + * will fail on the allocation, and thus cause an OOM fault even
> + * though the page it actually wants is being instantiated by the
> + * other racing process.
> + */

That sounds like a regression test, do we have a kernel commit for the
fix for the race?

> +#define _GNU_SOURCE
> +#include <pthread.h>
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
> +#include "hugetlb.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +
> +static char *str_op;
> +static int child1, child2, race_type;
> +static int fd_sync = -1;
> +static int fd_race = -1;
> +static void *p_race = MAP_FAILED;
> +static void *p_sync = MAP_FAILED;
> +static size_t sync_mapping_size;
> +
> +struct racer_info {
> +	void *p;
> +	int cpu;
> +	int status;
> +};
> +
> +static int one_racer(void *p, int cpu)
> +{
> +	volatile int *pi = p;
> +	cpu_set_t *cpuset;
> +	size_t mask_size;
> +	int err;
> +
> +	cpuset = CPU_ALLOC(cpu + 1);
> +	if (!cpuset)
> +		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");
> +
> +	mask_size = CPU_ALLOC_SIZE(cpu + 1);
> +
> +	/* Split onto different CPUs to encourage the race */
> +	CPU_ZERO_S(mask_size, cpuset);
> +	CPU_SET_S(cpu, mask_size, cpuset);
> +
> +	/*
> +	 * Use pid 0 so that sched_setaffinity() applies to the calling
> +	 * thread rather than the thread-group leader.  getpid() returns
> +	 * the same TGID for every pthread in the process, so passing it
> +	 * would pin the main thread instead of the racer.
> +	 */
> +	err = sched_setaffinity(0, mask_size, cpuset);
> +	CPU_FREE(cpuset);
> +	if (err == -1)
> +		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
> +
> +	/* Wait for parent to signal both racers to start */
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	/* Fault in the hugepage - triggers the race */
> +	*pi = 1;

If this is the actual race, it would probably make sense to actually
unmap/map and fault the page in a loop. We do have a tst_fuzzy_sync.h
that has a machinery for synchronizing two processes to hit a race.
Maybe it would make sense to use it.

> +	return 0;
> +}
> +
> +static void proc_racer(void *p, int cpu)
> +{
> +	exit(one_racer(p, cpu));
> +}
> +
> +static void *thread_racer(void *info)
> +{
> +	struct racer_info *ri = info;
> +
> +	ri->status = one_racer(ri->p, ri->cpu);
> +	return ri;
> +}
> +
> +static void check_online_cpus(int online_cpus[], int nr_cpus_needed)
> +{
> +	cpu_set_t cpuset;
> +	int total_cpus, cpu_idx;
> +
> +	CPU_ZERO(&cpuset);
> +
> +	total_cpus = get_nprocs_conf();
> +
> +	if (sched_getaffinity(0, sizeof(cpu_set_t), &cpuset) == -1)
> +		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
> +
> +	tst_res(TINFO, "Online CPUs needed: %d, available: %d",
> +		nr_cpus_needed, CPU_COUNT(&cpuset));
> +
> +	if (CPU_COUNT(&cpuset) < nr_cpus_needed)
> +		tst_brk(TCONF, "At least %d online CPUs are required",
> +			nr_cpus_needed);
> +
> +	cpu_idx = 0;
> +	for (int i = 0; i < total_cpus && cpu_idx < nr_cpus_needed; i++) {
> +		if (CPU_ISSET(i, &cpuset))
> +			online_cpus[cpu_idx++] = i;
> +	}
> +
> +	if (cpu_idx < nr_cpus_needed)
> +		tst_brk(TBROK, "Unable to find enough online CPUs");
> +}
> +
> +static void run_race(int rtype)
> +{
> +	void *tret1, *tret2;
> +	int status1 = 0, status2 = 0;
> +	int online_cpus[2];
> +	long hpage_size;
> +	pthread_t thread1, thread2;
> +
> +	check_online_cpus(online_cpus, 2);
> +
> +	hpage_size = tst_get_hugepage_size();
> +
> +	/* Get a new file for the final page */
> +	fd_race = tst_creat_unlinked(MNTPOINT, 0, 0600);
> +	tst_res(TINFO, "Mapping final page..");
> +
> +	p_race = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE,
> +			   rtype, fd_race, 0);
> +
> +	if (rtype == MAP_SHARED) {
> +		child1 = SAFE_FORK();
> +		if (child1 == 0)
> +			proc_racer(p_race, online_cpus[0]);
> +
> +		child2 = SAFE_FORK();
> +		if (child2 == 0)
> +			proc_racer(p_race, online_cpus[1]);
> +
> +		/* Wake both children to start the race simultaneously */
> +		TST_CHECKPOINT_WAKE2(0, 2);
> +
> +		SAFE_WAITPID(child1, &status1, 0);
> +		child1 = 0;
> +		tst_res(TINFO, "Child 1 status: %x", status1);
> +
> +		SAFE_WAITPID(child2, &status2, 0);
> +		child2 = 0;
> +		tst_res(TINFO, "Child 2 status: %x", status2);
> +
> +		if (WIFSIGNALED(status1))
> +			tst_res(TFAIL, "Child 1 killed by signal %s",
> +				strsignal(WTERMSIG(status1)));
> +		if (WIFSIGNALED(status2))
> +			tst_res(TFAIL, "Child 2 killed by signal %s",
> +				strsignal(WTERMSIG(status2)));
> +	} else {
> +		struct racer_info ri1 = {
> +			.p = p_race,
> +			.cpu = online_cpus[0],
> +			.status = -1,
> +		};
> +		struct racer_info ri2 = {
> +			.p = p_race,
> +			.cpu = online_cpus[1],
> +			.status = -1,
> +		};
> +
> +		SAFE_PTHREAD_CREATE(&thread1, NULL, thread_racer, &ri1);
> +		SAFE_PTHREAD_CREATE(&thread2, NULL, thread_racer, &ri2);
> +
> +		/* Wake both threads to start the race simultaneously */
> +		TST_CHECKPOINT_WAKE2(0, 2);
> +
> +		SAFE_PTHREAD_JOIN(thread1, &tret1);
> +		if (tret1 != &ri1)
> +			tst_res(TFAIL, "Thread 1 returned %p not %p, killed?",
> +				tret1, &ri1);
> +
> +		SAFE_PTHREAD_JOIN(thread2, &tret2);
> +		if (tret2 != &ri2)
> +			tst_res(TFAIL, "Thread 2 returned %p not %p, killed?",
> +				tret2, &ri2);
> +
> +		status1 = ri1.status;
> +		status2 = ri2.status;

Here the ri1.status and ri2.status is completely bogus, since that
either stays initialize to -1 or is set to 0 by clean exit of the
functions. Since the description says that the bug triggers OOM all
threads of the process would be killed if we reproduce the bug and we
will never get to this place anyways.

I suppose that you need to actually fork and then run the two threads in
the forked process in order to isolate it from the main test process.



Also the two different test modes does not have nearly any code in
common, so these two should be in two different functions.

> +	}
> +
> +	if (status1 != 0)
> +		tst_res(TFAIL, "Racer 1 terminated with code %d", status1);
> +
> +	if (status2 != 0)
> +		tst_res(TFAIL, "Racer 2 terminated with code %d", status2);
> +
> +	if (status1 == 0 && status2 == 0)
> +		tst_res(TPASS, "Test completed successfully");
> +
> +	SAFE_MUNMAP(p_race, hpage_size);
> +	p_race = MAP_FAILED;
> +
> +	SAFE_CLOSE(fd_race);
> +	fd_race = -1;
> +}
> +
> +static void run_test(void)
> +{
> +	unsigned long totpages;
> +	long hpage_size;
> +
> +	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	if (totpages < 2)
> +		tst_brk(TCONF, "Not enough free hugepages, need at least 2");

This is done by the .hugepages = {2, TST_NEEDS} in the tst_test
structure.

> +	hpage_size = tst_get_hugepage_size();
> +
> +	tst_res(TINFO, "Instantiating..");
> +
> +	fd_sync = tst_creat_unlinked(MNTPOINT, 0, 0600);
> +
> +	tst_res(TINFO, "Mapping %lu/%lu pages..", totpages - 1, totpages);
> +	sync_mapping_size = (totpages - 1) * hpage_size;
> +	p_sync = SAFE_MMAP(NULL, sync_mapping_size,
> +			   PROT_READ | PROT_WRITE, MAP_SHARED, fd_sync, 0);
> +
> +	/*
> +	 * Fault in every sync page to consume them from the hugepage pool.
> +	 * Without touching each page, mmap() does not allocate hugepages
> +	 * (no MAP_POPULATE), so all free hugepages remain available to the
> +	 * racers and the allocation race is never exercised.
> +	 */
> +	for (unsigned long i = 0; i < totpages - 1; i++) {
> +		volatile char *cp = (volatile char *)p_sync + i * hpage_size;
> +
> +		*cp = 0;
> +	}
> +
> +	run_race(race_type);
> +
> +	SAFE_MUNMAP(p_sync, sync_mapping_size);
> +	p_sync = MAP_FAILED;
> +
> +	SAFE_CLOSE(fd_sync);
> +	fd_sync = -1;

The fd is set to -1 by the SAFE_CLOSE()

> +}
> +
> +static void setup(void)
> +{
> +	if (str_op) {
> +		if (strcmp(str_op, "shared") == 0)
> +			race_type = MAP_SHARED;
> +		else if (strcmp(str_op, "private") == 0)
> +			race_type = MAP_PRIVATE;
> +		else
> +			tst_brk(TBROK,
> +				"Invalid parameter: use -m <private|shared>");
> +	} else {
> +		/* Default to shared if no option is passed */
> +		race_type = MAP_SHARED;
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (p_race != MAP_FAILED)
> +		SAFE_MUNMAP(p_race, tst_get_hugepage_size());
> +
> +	if (fd_race >= 0)

fd_race != -1

> +		SAFE_CLOSE(fd_race);
> +
> +	/*
> +	 * Use the saved sync_mapping_size rather than re-reading
> +	 * MEMINFO_HPAGE_FREE: the current free count differs from the
> +	 * mapping length and could cause munmap() to remove an adjacent
> +	 * mapping or leave part of p_sync mapped.
> +	 */
> +	if (p_sync != MAP_FAILED)
> +		SAFE_MUNMAP(p_sync, sync_mapping_size);
> +
> +	if (fd_sync >= 0)
> +		SAFE_CLOSE(fd_sync);
> +
> +	if (child1 > 0) {
> +		if (kill(child1, 0) == 0)
> +			SAFE_KILL(child1, SIGKILL);
> +	}
> +
> +	if (child2 > 0) {
> +		if (kill(child2, 0) == 0)
> +			SAFE_KILL(child2, SIGKILL);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.options = (struct tst_option[]) {
> +		{"m:", &str_op, "Type of mmap() mapping <private|shared>"},
> +		{}
> +	},
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {2, TST_NEEDS},
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.min_cpus = 2,
> +};
> -- 
> 2.52.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
