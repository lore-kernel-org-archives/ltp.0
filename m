Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D00C48BC3
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 22:11:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9DB23D140E
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 23:11:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 241BD3D1380
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 23:10:52 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4A708100053D
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 23:10:50 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 77B4421DBE;
 Mon, 19 Feb 2024 22:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708380649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o1T9Zm6Z7jsWRRfqpzvL8tOfl8wf9FnLokhssjZRurg=;
 b=ASVU888hjxgn/zk8JMrcFpGaCofmPFtOftbuAuWvABTDJFCjh7/84pJ58U6CXD0hP4yH52
 T1hmmU7MePZ0ADUgxepwyGjN3yYyhQGQOK6raF/VTfXSBTOTgbp58JKHdDgRSdZfr0Bu89
 mdeI4+Z8Xi+LB5iv0Fd3k5Dp7IKOuUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708380649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o1T9Zm6Z7jsWRRfqpzvL8tOfl8wf9FnLokhssjZRurg=;
 b=qLdAFH39L2FfBtSYzY+thCaMZaKmwCgd72KbM1eJP4nCsvT0V7+3VWfN3YvZ4j4BcEsfVB
 213odGtu5TJPZ3AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708380649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o1T9Zm6Z7jsWRRfqpzvL8tOfl8wf9FnLokhssjZRurg=;
 b=ASVU888hjxgn/zk8JMrcFpGaCofmPFtOftbuAuWvABTDJFCjh7/84pJ58U6CXD0hP4yH52
 T1hmmU7MePZ0ADUgxepwyGjN3yYyhQGQOK6raF/VTfXSBTOTgbp58JKHdDgRSdZfr0Bu89
 mdeI4+Z8Xi+LB5iv0Fd3k5Dp7IKOuUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708380649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o1T9Zm6Z7jsWRRfqpzvL8tOfl8wf9FnLokhssjZRurg=;
 b=qLdAFH39L2FfBtSYzY+thCaMZaKmwCgd72KbM1eJP4nCsvT0V7+3VWfN3YvZ4j4BcEsfVB
 213odGtu5TJPZ3AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 561FA13585;
 Mon, 19 Feb 2024 22:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 2sepEunR02UhbwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 19 Feb 2024 22:10:49 +0000
Date: Mon, 19 Feb 2024 23:10:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Shirisha G <shirisha@linux.ibm.com>
Message-ID: <20240219221047.GB1067220@pevik>
References: <20231213084753.61762-1-shirisha@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213084753.61762-1-shirisha@linux.ibm.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ASVU888h;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qLdAFH39
X-Spamd-Result: default: False [-2.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 77B4421DBE
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add hugemmap41(Migrating the
 libhugetlbfs/testcases/slbpacaflush.c test)
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

Hi Shirisha,

> We are verifying ppc64 kernels prior to 2.6.15-rc5 exhibit a bug in the
Test is from 2005, for 2.6.15-rc5. Is it really relevant now?

> hugepage SLB flushing path. When opening new hugetlb areas, updating masks
> in the thread_struct and copying to the PACA only occurs on the CPU where
> segments are opened, leading to potential stale copies in other CPUs.
> This bug can be triggered by multiple threads sharing the mm or a single thread
> migrating between CPUs, particularly evident in a close-to-idle system,
> as other processes may flush the SLB and prevent the bug from manifesting.

Please run  make check-hugemmap41 in the test directory and fix formatting.

> Original test originates from https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/slbpacaflush.c

> Signed-off-by: Shirisha G <shirisha@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 144 ++++++++++++++++++
>  3 files changed, 146 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c

> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..d956866ac 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>  hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
> +hugemmap41 hugemmap41
nit: Any reason why not add it as hugemmap33? You don't want to clash with other
sent test, right?

>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index c96fe8bfc..b7e108956 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -34,6 +34,7 @@
>  /hugetlb/hugemmap/hugemmap30
>  /hugetlb/hugemmap/hugemmap31
>  /hugetlb/hugemmap/hugemmap32
> +/hugetlb/hugemmap/hugemmap41
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
> new file mode 100644
> index 000000000..3b3388c68
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +/*\
> + * [Description]
> + *
> + * ppc64 kernels (prior to 2.6.15-rc5) have a bug in the hugepage SLB
> + * flushing path.  After opening new hugetlb areas, we update the
> + * masks in the thread_struct, copy to the PACA, then do slbies on
> + * each CPU.  The trouble is we only copy to the PACA on the CPU where
> + * we're opening the segments, which can leave a stale copy in the
> + * PACAs on other CPUs.
> + *
> + * This can be triggered either with multiple threads sharing the mm,
> + * or with a single thread which is migrated from one CPU, to another
> + * (where the mapping occurs), then back again (where we touch the
> + * stale SLB).  We use the second method in this test, since it's
> + * easier to force (using sched_setaffinity).  However it relies on a
> + * close-to-idle system, if any process other than a kernel thread
> + * runs on the first CPU between runs of the test process, the SLB
> + * will be flushed and we won't trigger the bug, hence the
> + * PASS_INCONCLUSIVE().  Obviously, this test won't work on a 1-cpu
> + * system (should get CONFIG() on the sched_setaffinity)
> + *
> + */
> +#define _GNU_SOURCE
> +#include "hugetlb.h"
> +#define SYSFS_CPU_ONLINE_FMT	"/sys/devices/system/cpu/cpu%d/online"
> +#define MNTPOINT "hugetlbfs/"
Could you please have these 2 #define above _GNU_SOURCE? (readablility)
> +
> +
> +#include <stdio.h>
> +#include <sched.h>
> +
> +
> +long hpage_size;
> +int fd;
> +void *p;
> +volatile unsigned long *q;
> +int online_cpus[2], err;
> +cpu_set_t cpu0, cpu1;
> +
> +
> +
Please remove these blank lines above.

> +void check_online_cpus(int online_cpus[], int nr_cpus_needed)
> +{
> +	char cpu_state, path_buf[64];
> +	int total_cpus, cpu_idx, fd, ret, i;
> +
> +	total_cpus = get_nprocs_conf();
> +	cpu_idx = 0;
> +
> +	if (get_nprocs() < nr_cpus_needed)
> +		tst_res(TFAIL, "Atleast online %d cpus are required", nr_cpus_needed);
> +
> +	for (i = 0; i < total_cpus && cpu_idx < nr_cpus_needed; i++) {
nit: Maybe just use get_nprocs_conf() directly?

> +		errno = 0;
Is it errno reset really needed?

> +		sprintf(path_buf, SYSFS_CPU_ONLINE_FMT, i);
> +		fd = open(path_buf, O_RDONLY);
> +		if (fd < 0) {
> +			/* If 'online' is absent, the cpu cannot be offlined */
> +			if (errno == ENOENT) {
> +				online_cpus[cpu_idx] = i;
> +				cpu_idx++;
> +				continue;
> +			} else {
> +				tst_res(TFAIL, "Unable to open %s: %s", path_buf,
> +				     strerror(errno));
We have TERRNO:
				tst_res(TFAIL | TERRNO, "Unable to open %s: %s", path_buf);
> +			}
> +		}
> +
> +		ret = read(fd, &cpu_state, 1);
> +		if (ret < 1)
> +			tst_res(TFAIL, "Unable to read %s: %s", path_buf,
> +			     strerror(errno));
Maybe use SAFE_READ() ?
> +
> +		if (cpu_state == '1') {
> +			online_cpus[cpu_idx] = i;
> +			cpu_idx++;
> +		}
> +
> +		if (fd >= 0)
> +			SAFE_CLOSE(fd);
> +	}
> +
> +	if (cpu_idx < nr_cpus_needed)
> +		tst_res(TFAIL, "Atleast %d online cpus were not found", nr_cpus_needed);
> +}
> +
> +
> +static void run_test(void)
> +{
> +	check_online_cpus(online_cpus, 2);
> +	CPU_ZERO(&cpu0);
> +	CPU_SET(online_cpus[0], &cpu0);
> +	CPU_ZERO(&cpu1);
> +	CPU_SET(online_cpus[1], &cpu1);
> +
> +	err = sched_setaffinity(getpid(), CPU_SETSIZE/8, &cpu0);
> +	if (err != 0)
> +		tst_res(TFAIL, "sched_setaffinity(cpu%d): %s", online_cpus[0],
> +				strerror(errno));
Again, please use TTERRNO.
> +
> +	err = sched_setaffinity(getpid(), CPU_SETSIZE/8, &cpu1);
Maybe define CPU_SETSIZE/8 at the top?
> +
> +	if (err != 0)
> +		tst_res(TFAIL, "sched_setaffinity(cpu%d): %s", online_cpus[1],
> +				strerror(errno));
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +	err = sched_setaffinity(getpid(), CPU_SETSIZE/8, &cpu0);
> +	if (err != 0)
> +		tst_res(TFAIL, "sched_setaffinity(cpu%d): %s", online_cpus[0],
> +				strerror(errno));
> +	q = (volatile unsigned long *)(p + getpagesize());
> +	*q = 0xdeadbeef;
Why to set the address before end of testing? (yes, the original does it, but
why?). Wouldn't be better to use guarded buffers instead?

https://github.com/linux-test-project/ltp/wiki/C-Test-API#131-guarded-buffers

Kind regards,
Petr

> +
> +	tst_res(TPASS, "Test Passed inconclusive");
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = tst_get_hugepage_size();
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
> +}
> +
> +void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {1, TST_NEEDS},
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
