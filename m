Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05822C4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 15:09:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16BFE3CF40E
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 16:09:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B37C83CEAF9
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 16:09:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5735A1A0434D
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 16:09:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A0A61F7AB;
 Mon, 30 Oct 2023 15:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698678542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ET3ECB/QFqhtwv+j0qJGa/4F9VeNvaUHrw7ik/UzFkk=;
 b=l5QeR7QQbiS4zlX1aCR9+1vVmhJ1BHjoBj5VPndBMRIddNwevKhhmRrbLPnS/Dwm1D7mQ8
 O0QsnwPBbd06/InF0hTC6nyw7sloCbJZ0tqTdjPavutd3b5sq38uF1CzYQdez4xD1y8/O+
 oPKulHnTF5N+trZXUBgR/G6/HTfjXgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698678542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ET3ECB/QFqhtwv+j0qJGa/4F9VeNvaUHrw7ik/UzFkk=;
 b=rjSDbn9T9ZydILoKFzyYNPVcv/Q3w/GV6srBG302juENGI9sasdK7zGlInqWM+Nw0ho0gu
 G8s6xCU/g5sKhwAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22A7E138EF;
 Mon, 30 Oct 2023 15:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OoKTBw7HP2WsXAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 30 Oct 2023 15:09:02 +0000
Date: Mon, 30 Oct 2023 16:09:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Samir Mulani <samir@linux.vnet.ibm.com>
Message-ID: <ZT_HLEwCNlt1lDvB@yuki>
References: <20230912064126.3350-1-samir@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230912064126.3350-1-samir@linux.vnet.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Migrating the
 libhugetlbfs/testcases/alloc-instantiate-race.c test
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
First of all there are style problems, please run 'make check' and fix
all problems before resubmitting.

> +/*\
> + * [Description]
> + *
> + * Test Name: alloc-instantiate-race.c
          ^
	  This is no longer true and should be removed.
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
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <pthread.h>
> +#include "tst_safe_pthread.h"
> +#include "hugetlb.h"
> +#define SYSFS_CPU_ONLINE_FMT	"/sys/devices/system/cpu/cpu%d/online"
> +#define MNTPOINT "hugetlbfs/"

> +unsigned long totpages;
> +static long hpage_size;
> +char *str_op;
> +int race_type;

There are some missing static keywors here.

> +static int child1, child2;
> +static pthread_t thread1, thread2;
> +
> +struct racer_info {
> +	void *p; /* instantiation address */
> +	int cpu;
> +	int race_type;

Why do we have race type duplicated here? We can just use the global
variable race_type instead I suppose.

> +	volatile int *mytrigger;
> +	volatile int *othertrigger;
> +	int status;
> +};
> +
> +static int one_racer(void *p, int cpu,
> +		     volatile int *mytrigger, volatile int *othertrigger)
> +{
> +	volatile int *pi = p;
> +	cpu_set_t cpuset;
> +	int err;
> +
> +	/* Split onto different cpus to encourage the race */
> +	CPU_ZERO(&cpuset);
> +	CPU_SET(cpu, &cpuset);

This is the old API, the new API that should be used instead allocates
the mask dynamically with CPU_ALLOC().

> +	err = sched_setaffinity(gettid(), CPU_SETSIZE/8, &cpuset);
> +	if (err != 0)
> +		tst_res(TFAIL,"sched_setaffinity(cpu%d): %s", cpu, strerror(errno));
                                                                    ^
								    Use
								    TERRNO
								    instead.

Also what are we supposed to do here if the call fails?

Should we stop the test? If so this should be tst_brk(TBROK, ...).

If we should continue it should be warning, i.e. tst_res(TWARN, ...);

> +
> +	/* Ready.. */
> +	*mytrigger = 1;
> +	/* Set.. */
> +	while (! *othertrigger)
> +		;
> +
> +	/* Instantiate! */
> +	*pi = 1;
> +
> +	return 0;
> +}
> +
> +static void proc_racer(void *p, int cpu,
> +		       volatile int *mytrigger, volatile int *othertrigger)
> +{
> +	exit(one_racer(p, cpu, mytrigger, othertrigger));

There is no need to pass the return value from one_racer() to exit here
since one_racer() returns always 0, we should just do exit(0);
explicitly instead.

> +}
> +
> +static void *thread_racer(void *info)
> +{
> +	struct racer_info *ri = info;
> +	one_racer(ri->p, ri->cpu, ri->mytrigger, ri->othertrigger);
> +	return ri;
> +}
> +
> +void check_online_cpus(int online_cpus[], int nr_cpus_needed)
> +{
> +	char cpu_state, path_buf[64];
> +	int total_cpus, cpu_idx, fd, ret, i;
> +
> +	total_cpus = get_nprocs_conf();
> +	cpu_idx = 0;
> +
> +	if (get_nprocs() < nr_cpus_needed)
> +		tst_res(TFAIL,"Atleast online %d cpus are required", nr_cpus_needed);

This should be .min_cpus = 2 in tst_test.

> +	for (i = 0; i < total_cpus && cpu_idx < nr_cpus_needed; i++) {
> +		errno = 0;
> +		sprintf(path_buf, SYSFS_CPU_ONLINE_FMT, i);
> +		fd = open(path_buf, O_RDONLY);
> +		if (fd < 0) {
> +			/* If 'online' is absent, the cpu cannot be offlined */
> +			if (errno == ENOENT) {
> +				online_cpus[cpu_idx] = i;
> +				cpu_idx++;
> +				continue;
> +			} else {
> +				tst_res(TFAIL,"Unable to open %s: %s", path_buf,
> +				     strerror(errno));
> +			}
> +		}
> +
> +		ret = read(fd, &cpu_state, 1);
> +		if (ret < 1)
> +			tst_res(TFAIL,"Unable to read %s: %s", path_buf,
> +			     strerror(errno));
> +
> +		if (cpu_state == '1') {
> +			online_cpus[cpu_idx] = i;
> +			cpu_idx++;
> +		}
> +
> +		if (fd >= 0)
> +			SAFE_CLOSE(fd);

So all this is done to get two different CPU ids that could be used for
the affinity call.

I guess that it would be much easier to call sched_getaffinity() which
should fill the cpuset mask with cpus the thread is eligible to run on,
then we can simply find two non-zero bits in the mask.

> +	}
> +
> +	if (cpu_idx < nr_cpus_needed)
> +		tst_res(TFAIL,"Atleast %d online cpus were not found", nr_cpus_needed);
> +}
> +
> +static void run_race(void *syncarea, int race_type)
> +{
> +	volatile int *trigger1, *trigger2;
> +	int fd;
> +	void *p, *tret1, *tret2;
> +	int status1, status2;
> +	int online_cpus[2];
> +
> +	check_online_cpus(online_cpus, 2);
> +	memset(syncarea, 0, sizeof(*trigger1) + sizeof(*trigger2));
> +	trigger1 = syncarea;
> +	trigger2 = trigger1 + 1;
> +
> +	/* Get a new file for the final page */
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
> +	tst_res(TINFO,"Mapping final page.. ");
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, race_type, fd, 0);
> +	if (race_type == MAP_SHARED) {
> +		child1 = SAFE_FORK();
> +		if (child1 == 0)
> +			proc_racer(p, online_cpus[0], trigger1, trigger2);
> +
> +		child2 = SAFE_FORK();
> +		if (child2 == 0)
> +			proc_racer(p, online_cpus[1], trigger2, trigger1);
> +
> +		/* wait() calls */
> +		SAFE_WAITPID(child1, &status1, 0);
> +		tst_res(TINFO,"Child 1 status: %x\n", status1);
> +
> +
> +		SAFE_WAITPID(child2, &status2, 0);
> +		tst_res(TINFO,"Child 2 status: %x\n", status2);
> +
> +		if (WIFSIGNALED(status1))
> +			tst_res(TFAIL,"Child 1 killed by signal %s",
> +			strsignal(WTERMSIG(status1)));
> +		if (WIFSIGNALED(status2))
> +			tst_res(TFAIL,"Child 2 killed by signal %s",
> +			strsignal(WTERMSIG(status2)));
> +
> +		status1 = WEXITSTATUS(status1);
> +		status2 = WEXITSTATUS(status2);

We do always exit(0) in the proc_racer() this is useless.

> +	} else {
> +		struct racer_info ri1 = {
> +			.p = p,
> +			.cpu = online_cpus[0],
> +			.mytrigger = trigger1,
> +			.othertrigger = trigger2,
> +		};
> +		struct racer_info ri2 = {
> +			.p = p,
> +			.cpu = online_cpus[1],
> +			.mytrigger = trigger2,
> +			.othertrigger = trigger1,
> +		};
> +		
> +		SAFE_PTHREAD_CREATE(&thread1, NULL, thread_racer, &ri1);
> +		SAFE_PTHREAD_CREATE(&thread2, NULL, thread_racer, &ri2);
> +		SAFE_PTHREAD_JOIN(thread1, &tret1);
> +		if (tret1 != &ri1)
> +			tst_res(TFAIL,"Thread 1 returned %p not %p, killed?\n",
> +			     tret1, &ri1);
> +		SAFE_PTHREAD_JOIN(thread2, &tret2);
> +		if (tret2 != &ri2)
> +			tst_res(TFAIL,"Thread 2 returned %p not %p, killed?\n",
> +			     tret2, &ri2);
> +		status1 = ri1.status;
> +		status2 = ri2.status;

Here as well I do not see the status set anywhere.

> +	}
> +
> +	if (status1 != 0)
> +		tst_res(TFAIL,"Racer 1 terminated with code %d", status1);
> +
> +	if (status2 != 0)
> +		tst_res(TFAIL,"Racer 2 terminated with code %d", status2);
> +
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +
> +static void run_test(void)
> +{
> +	int fd;
> +	long unsigned int i;
> +	void *p, *q;
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
> +	/* Get a shared normal page for synchronization */
> +	tst_res(TINFO, "Mapping synchronization area..");

Useless comment and message.

> +	q = SAFE_MMAP(NULL, getpagesize(), PROT_READ|PROT_WRITE,
> +		 MAP_SHARED|MAP_ANONYMOUS, -1, 0);

This is never unmapped and should be done in the test setup instead.

> +	tst_res(TINFO,"done\n");

This is useless and also includes one more newline.

> +	tst_res(TINFO,"Mapping %ld/%ld pages.. ", totpages-1, totpages);
> +	
> +	p = SAFE_MMAP(NULL, (totpages-1)*hpage_size, PROT_READ|PROT_WRITE,
> +		 MAP_SHARED, fd, 0);
> +
> +	/* Allocate all save one of the pages up front */
> +	tst_res(TINFO,"instantiating.. ");
> +	for (i = 0; i < (totpages - 1); i++)
> +		memset(p + (i * hpage_size), 0, sizeof(int));
> +
> +	tst_res(TINFO,"done\n");

Here as well.

> +	run_race(q, race_type);
> +	tst_res(TPASS,"Test passed..!!");

This is useless, since we print the TPASS unconditionally.

> +	if (fd >= 0)

This is useless, as long as we got here the fd is >= 0.

> +		SAFE_CLOSE(fd);
> +}
> +
> +void setup(void)

Should be static.

> +{
> +	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	hpage_size = tst_get_hugepage_size();
> +	if (str_op)
> +	{	
> +		if (strcmp(str_op, "shared") == 0) {
> +			race_type = MAP_SHARED;
> +			} else if (strcmp(str_op, "private") == 0) {
> +				race_type = MAP_PRIVATE;
> +				} else {
> +					tst_res(TFAIL,"Usage: alloc-instantiate-race <private|shared>");
> +		}
> +	}
> +	else{
> +		tst_res(TFAIL,"Usage: alloc-instantiate-race <private|shared>");
> +	}	

The indentation here is broken here.

> +}
> +
> +void cleanup(void)

Here as well, static.

> +{
> +	if (child1)
> +		SAFE_KILL(child1, SIGKILL);
> +	if (child2)
> +		SAFE_KILL(child2, SIGKILL);
> +}
> +
> +
> +static struct tst_test test = {
> +	.options = (struct  tst_option[]){
> +		{"m:", &str_op, "Usage: alloc-instantiate-race <private|shared>"},
                                             ^
					     This is also wrong.
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
> +};
> -- 
> 2.39.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
