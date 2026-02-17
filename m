Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F6EE909B6
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771339059; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=K/US480wLMCLGZbISpo3tZfGPKvK4gQHJG4daF7MaIM=;
 b=qZSSJ2BUjp0CwIpinSPURbpy7G7wKqJuF3albNL+c8greUT3KTg90Yl9d9O/rDD8aYfre
 J7EAzhkRs+bbHkzeb3IoFZhwbIAhsieHWOmkK8lPgqEb4t8kLsEmzEimuLMTgZtKiNMOvAp
 eqWEdYvxyDltGjBrNlQh+A1VvysaVhM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD01D3D0648
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 15:37:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD0EB3D0623
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 15:37:16 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2F70A2009FE
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 15:37:16 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48068127f00so45781995e9.3
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 06:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771339035; x=1771943835; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXj5GIa0pgwVaNaSfeOqSFWWPBO8MLm8SWtN0oQGvcw=;
 b=K+9QJFlUcprS/UpMKVnHSWS9qBzy/NhQv8OwZMICpq6klyRb12rIqaOO2z5CVFTvCm
 zWymdBKW3eg1oDndOp9MmjSx2AD8x97YTBKMJUft086nbCOlMSsfdm0FZK2DIM/wC6Ae
 0xk6bn6QF1hAtri9c9gHExatUD5jxztQ8acRV5yS+KKVKSKD72m4tJQpSG34+NeZPHYW
 ckYAHorfx8R277qtWcOj+tflUh1jUDLmsNGARtM+0p03InYT8WxjzamDCvIfeTvcDttV
 CQdt2G4nKaHnCoKTDK9fo2WNf5czHrYaIkWXp+mto4JQS6lqxp8WbMAkUJqG+Uf6af7z
 z34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771339035; x=1771943835;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zXj5GIa0pgwVaNaSfeOqSFWWPBO8MLm8SWtN0oQGvcw=;
 b=Mx8s5tncGKoKoKqlBmkVYVYzlU7GzNU2QuI3wX8toumJNwciWJhv0jELZ7tAISXyfd
 PEbrD+KZ+nxVwpPQjvesf9Y84cb+q4VRDGdYVkN1K0bNNS3aOpoO7alCafRd54YgbEbW
 +0rtI+jmHO41D4jGQ32A/6t630HLaqzt3TNOSL1hoa5aNANbx1ZSgPpawGRmuul9rtkN
 8+HpLO4UwAgEUYGCbyA7nBGpX0T+SxoK29XXOs29Ek0dS95zMv7qMD3BcGwoik3ezHk3
 QD+OMy8W1IGc9jzcTSZfrcWTGwGO1wVq2V8zSxc0juwx+I0/Z18eJvW7mCoeDbxa2Iga
 5r4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOnu0HfV16A53Xp53RwDx6lw0Wi1NGMsWtz5XgK+fkd7WELWbtEzl0uYKl9nxxvb/9eVQ=@lists.linux.it
X-Gm-Message-State: AOJu0YywIHTI7LpSxoEMouHDmJjXeJ17NQdMKhx3AD4GgvjkYEgqSGZu
 Tm/bhoIMSeq/1iX7DzN90LjBbFOd+ep3hGrqiqo4Yg6zQJ8H8KGzca/pGLNeB5+KOTuBhgZrMoN
 Xut9voT4=
X-Gm-Gg: AZuq6aLlMAd1Ivce5rVXDfJB4Fdj2PXm2lFSmAyyrnA5Aejsj0r7Zxs4cD1Ko94ZXoh
 6LRsrGln4NVqD9pOfE7gLmICIevcGm5nF6ZS+KncbSx3F4HwUXd8g5z/YUb1V7QdlwJ2Kgzn6wL
 14IsaMc61e5c/+dsOQjys5gkAQtIMZ9VSkWH0NBJVkHifKKiDalHpEW9kY3kP36mujlFHWkUKl5
 3V4aXRT/6UIvCNZsj3QWwEnl+GF8kuJGYGRdQRPnccFVMqkxTzyfzHOiFVCDC2pMNBrBCKm/atl
 VpUsWzu+Xysdk8Aj7M6Gvex0k2xKdhwnnVgTD/lAOB751WNTT8qghwu91RTNj6xr8a012XQIqo3
 Gl+ia3LMSwjq4I6RZm7I11i00PKulTkP/iIk6nXMKG3h4mL3vpYSVMdUxdlBB3SXGwyltJAsp69
 yqs6NEdZsuXqo5Ylm874u6geEp7RgQL/4lJ/WPgaOpewzy+3CdnW8ljOcmkROrxCNd8XQVJSpDC
 5LMZ/sOpOHi14OWGMFyb+xfD3VvpQ==
X-Received: by 2002:a05:600c:8a16:10b0:483:8e43:6dce with SMTP id
 5b1f17b1804b1-4838e436e43mr53275595e9.29.1771339035339; 
 Tue, 17 Feb 2026 06:37:15 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm37067782f8f.24.2026.02.17.06.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 06:37:15 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 17 Feb 2026 15:37:14 +0100
Message-Id: <DGHBA6LWLRD7.2XSPOLAKKKMCX@suse.com>
To: "Samir Mulani" <samir@linux.ibm.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20250928030721.3537869-1-samir@linux.ibm.com>
In-Reply-To: <20250928030721.3537869-1-samir@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Migrating the
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On Sun Sep 28, 2025 at 5:07 AM CEST, Samir Mulani wrote:
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
> Signed-off-by: Samir Mulani <samir@linux.ibm.com>
> ---
> v3: --Addressed the below requested changes
> 1. Added support to run test cases multiple times using the -iN or -IN option.
> 2. Removed unnecessary comments.
> 3. Set "shared" mode as the default for mmap when the user does not specify
>    <shared/private> with the -m option.
> 4. Updated user-facing help messages to clarify how to use the -m option.
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  | 300 ++++++++++++++++++
>  3 files changed, 302 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 0896d3c94..bd40a7a30 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -36,6 +36,7 @@ hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
>  hugemmap34 hugemmap34
> +hugemmap36 hugemmap36
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index b4455de51..2ddef6bf1 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -36,6 +36,7 @@
>  /hugetlb/hugemmap/hugemmap31
>  /hugetlb/hugemmap/hugemmap32
>  /hugetlb/hugemmap/hugemmap34
> +/hugetlb/hugemmap/hugemmap36
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
> new file mode 100644
> index 000000000..14ca6db52
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]

Description tag not needed.

> + *
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

missing static definition. also it's used only in run() so there's no
need to have it here. Please verify the same for the other variables as
well.

> +static long hpage_size;
> +static char *str_op;
> +static int child1, child2, race_type, fd_sync, test_flag;
> +static pthread_t thread1, thread2;
> +static void *p_sync, *q_sync;
> +
> +struct racer_info {
> +	void *p; /* instantiation address */
> +	int cpu;
> +	volatile int *mytrigger;
> +	volatile int *othertrigger;
> +	int status;
> +};
> +
> +static int one_racer(void *p, int cpu,
> +		     volatile int *mytrigger, volatile int *othertrigger)
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
> +	err = sched_setaffinity(getpid(), mask_size, cpuset);
> +	if (err == -1)
> +		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
> +
> +	/* Ready */
> +	*mytrigger = 1;
> +	/* Wait for the other trigger to be set */
> +	while (!*othertrigger)
> +		;

This is a busy loop that is gonna create many issues. You probably need
to take a look at the checkpoints if you need to synchronize threads.

> +
> +	/* Set the shared value */
> +	*pi = 1;
> +
> +	CPU_FREE(cpuset);
> +	return 0;
> +}
> +
> +static void proc_racer(void *p, int cpu,
> +		       volatile int *mytrigger, volatile int *othertrigger)
> +{
> +	exit(one_racer(p, cpu, mytrigger, othertrigger));
> +}
> +
> +static void *thread_racer(void *info)
> +{
> +	struct racer_info *ri = info;
> +ri->status = one_racer(ri->p, ri->cpu, ri->mytrigger, ri->othertrigger);

indentation.

> +	return ri;
> +}
> +
> +void check_online_cpus(int online_cpus[], int nr_cpus_needed)

should be a static function

> +{
> +	cpu_set_t cpuset;
> +	int total_cpus, cpu_idx, i;

i can be declared inside the loop.

> +	// Initialize the CPU set
> +	CPU_ZERO(&cpuset);
> +
> +	for (int i = 0; i < CPU_SETSIZE; i++)

> +		CPU_SET(i, &cpuset);
> +	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) == -1)
> +		tst_brk(TBROK | TERRNO, "sched_setaffinity() reset failed");
> +	// Get the total number of configured CPUs
> +	total_cpus = get_nprocs_conf();
> +	// Get the CPU affinity mask of the calling process
> +	if (sched_getaffinity(0, sizeof(cpu_set_t), &cpuset) == -1)
> +		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
> +
> +	int available = CPU_COUNT(&cpuset);

Just use CPU_COUNT() it in the tst_res(..), there's no need to have a
variable here.

> +tst_res(TINFO, "Online CPUs needed: %d, available: %d", nr_cpus_needed, available);

Wrong indentation.

> +
> +	// Check if there are enough online CPUs
> +	if (CPU_COUNT(&cpuset) < nr_cpus_needed)
> +		tst_brk(TBROK | TERRNO, "At least %d online CPUs are required ", nr_cpus_needed);
> +
> +	cpu_idx = 0;
> +	// Find the first `nr_cpus_needed` CPUs in the affinity mask
> +	for (i = 0; i < total_cpus && cpu_idx < nr_cpus_needed; i++) {
> +		if (CPU_ISSET(i, &cpuset))
> +			online_cpus[cpu_idx++] = i;
> +	}
> +	if (cpu_idx < nr_cpus_needed)
> +		tst_brk(TBROK | TERRNO, "Unable to find enough online CPUs");
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
> +	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
> +	tst_res(TINFO, "Mapping final page.. ");
> +
> +
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
> +		tst_res(TINFO, "Child 1 status: %x", status1);
> +
> +
> +		SAFE_WAITPID(child2, &status2, 0);
> +		tst_res(TINFO, "Child 2 status: %x", status2);
> +
> +		if (WIFSIGNALED(status1))
> +			tst_res(TFAIL, "Child 1 killed by signal %s",
> +			strsignal(WTERMSIG(status1)));
> +		if (WIFSIGNALED(status2))
> +			tst_res(TFAIL, "Child 2 killed by signal %s",
> +			strsignal(WTERMSIG(status2)));
> +	} else {
> +		struct racer_info ri1 = {
> +			.p = p,
> +			.cpu = online_cpus[0],
> +			.mytrigger = trigger1,
> +			.othertrigger = trigger2,
> +			.status = -1,
> +		};
> +		struct racer_info ri2 = {
> +			.p = p,
> +			.cpu = online_cpus[1],
> +			.mytrigger = trigger2,
> +			.othertrigger = trigger1,
> +			.status = -1,
> +		};
> +		SAFE_PTHREAD_CREATE(&thread1, NULL, thread_racer, &ri1);
> +		SAFE_PTHREAD_CREATE(&thread2, NULL, thread_racer, &ri2);
> +		SAFE_PTHREAD_JOIN(thread1, &tret1);
> +		if (tret1 != &ri1) {
> +			test_flag = -1;
> +			tst_res(TFAIL, "Thread 1 returned %p not %p, killed?\n",
> +			     tret1, &ri1);
> +		}
> +		SAFE_PTHREAD_JOIN(thread2, &tret2);
> +
> +		if (tret2 != &ri2) {
> +			test_flag = -1;
> +			tst_res(TFAIL, "Thread 2 returned %p not %p, killed?\n",
> +			     tret2, &ri2);
> +		}
> +		status1 = ri1.status;
> +		status2 = ri2.status;
> +	}
> +
> +	if (status1 != 0) {
> +		test_flag = -1;
> +		tst_res(TFAIL, "Racer 1 terminated with code %d", status1);
> +	}
> +
> +	if (status2 != 0) {
> +		test_flag = -1;
> +		tst_res(TFAIL, "Racer 2 terminated with code %d", status2);
> +	}
> +	if (test_flag != -1)
> +		test_flag = 0;
> +
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
> +
> +	if (p != MAP_FAILED)
> +		SAFE_MUNMAP(p, hpage_size);
> +
> +	if (q_sync != MAP_FAILED) {
> +		SAFE_MUNMAP(q_sync, getpagesize());
> +		q_sync = NULL;
> +	}
> +}
> +
> +static void run_test(void)
> +{
> +	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	hpage_size = tst_get_hugepage_size();
> +
> +	/* Allocate all save one of the pages up front */
> +	tst_res(TINFO, "instantiating.. ");
> +
> +	fd_sync = tst_creat_unlinked(MNTPOINT, 0, 0600);
> +	/* Get a shared normal page for synchronization */
> +	q_sync = SAFE_MMAP(NULL, getpagesize(), PROT_READ|PROT_WRITE,
> +			MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> +	tst_res(TINFO, "Mapping %ld/%ld pages.. ", totpages-1, totpages);
> +	p_sync = SAFE_MMAP(NULL, (totpages-1)*hpage_size, PROT_READ|PROT_WRITE,
> +			MAP_SHARED, fd_sync, 0);
> +
> +	run_race(q_sync, race_type);

This q_sync is passed around in the wrong way. Please take a look at its
usage because q_sync is used in run_race() but initialized in run_test().
If run_test() fails before run_race(), q_sync could be uninitialized.


Kind regards,

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
