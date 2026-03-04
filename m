Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9B4EB7EBA
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 10:27:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E4E63DAE58
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 11:27:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C6C73D0722
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 11:27:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 85219200097
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 11:27:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E65415BDA8;
 Wed,  4 Mar 2026 10:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772620053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Whq+9Ie5dDkOtGSp4MOHYxjzOwHRZoDVLZKx3JkFIE=;
 b=A8rJKgH8fD4PMXBRodsw2dHvZxJgQMxcPWQvSjUmA8LPLh+IRIskG5WrFlnYrlXhfjlg49
 Wv4/EWNhkeMXFQkiuj9DJk18nNlbKLitZ8iT8gQPAbR4E/jodozy5/xfb1zc/FNq6hUCvK
 LSX4c6qeCaG6xGt7FTg7wALZ6js/3Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772620053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Whq+9Ie5dDkOtGSp4MOHYxjzOwHRZoDVLZKx3JkFIE=;
 b=ENaJAGcaYKRozqVmFZfJuI6cFeGmNXLBhz9BOGAlwpGffKoywXNoogArY1bIlfGX/4e4so
 HC1f5P8nqIkqJqCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qJoi+HuX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8vTB6YpA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772620050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Whq+9Ie5dDkOtGSp4MOHYxjzOwHRZoDVLZKx3JkFIE=;
 b=qJoi+HuXpoHEJ5QhdhAQX82ul1c+EF0nrUwawTfqpUngkaUMKFo9XP+mFBkC83dcF3yfzL
 gUy05L+pe0xzO+47ni8/urtbW3ElJp3YU/du9FgLfyPyor3ETY6cCxAuEPlaiXaChcmEHe
 fTxzL33w5HjTk7lOkrrMdp8a9izQiw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772620050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Whq+9Ie5dDkOtGSp4MOHYxjzOwHRZoDVLZKx3JkFIE=;
 b=8vTB6YpAAZ+lle9vLXqpelDbWtjwEha90PXjSOqvbEloBse5mQGY4U/+ItqhT4+jPiteQ1
 8TeX1wE84HtZhXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6E7B3EA69;
 Wed,  4 Mar 2026 10:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hJKfMxIJqGmWCwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Mar 2026 10:27:30 +0000
Date: Wed, 4 Mar 2026 11:27:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Shirisha G <shirisha@linux.ibm.com>
Message-ID: <aagJHAlunapFWY0h@yuki.lan>
References: <20250822055311.1807891-1-shirisha@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250822055311.1807891-1-shirisha@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, yuki.lan:mid, suse.cz:dkim, suse.cz:email,
 linux.it:url]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E65415BDA8
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Migrating the
 libhugetlbfs/testcases/slbpacaflush.c test
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
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..d956866ac 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>  hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
> +hugemmap41 hugemmap41
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
> index 000000000..4657fd99d
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
> @@ -0,0 +1,124 @@
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
> +
> +#include "hugetlb.h"
> +
> +#include <stdio.h>
> +#include <sched.h>
> +#include <unistd.h>
> +
> +#define MNTPOINT "hugetlbfs/"
> +
> +static long hpage_size;
> +static int fd;
> +static void *p;
> +static volatile unsigned long *q;
> +static int online_cpus[2];
> +static int err;
> +static cpu_set_t cpu0, cpu1;
> +
> +/*
> + * Helper to get online CPUs (based on thread affinity)
> + * Returns number of CPUs found, fills in `online_cpus[]`.
> + */
> +static unsigned int tst_get_online_cpus(int online_cpus[], unsigned int online_cpus_cnt)
> +{
> +	cpu_set_t mask;
> +	unsigned int count = 0;
> +
> +	if (sched_getaffinity(0, sizeof(mask), &mask) < 0)
> +		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
> +
> +	for (int i = 0; i < CPU_SETSIZE && count < online_cpus_cnt; i++) {
> +		if (CPU_ISSET(i, &mask))
> +			online_cpus[count++] = i;
> +	}
> +
> +	return count;
> +}
> +
> +static void run_test(void)
> +{
> +	if (tst_get_online_cpus(online_cpus, 2) != 2)
> +		tst_brk(TCONF, "Require at least 2 online CPUs.");
> +
> +	CPU_ZERO(&cpu0);
> +	CPU_SET(online_cpus[0], &cpu0);
> +
> +	CPU_ZERO(&cpu1);
> +	CPU_SET(online_cpus[1], &cpu1);
> +
> +	err = sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpu0);
> +	if (err != 0)
> +		tst_res(TFAIL | TERRNO, "sched_setaffinity(cpu%d)", online_cpus[0]);
> +
> +	err = sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpu1);
> +	if (err != 0)
> +		tst_res(TFAIL | TERRNO, "sched_setaffinity(cpu%d)", online_cpus[1]);
> +
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

I wonder if it wouldn't be easier to pass MAP_HUGETLB instead of
creating a file on a hugetlb. Or is there something that prevents us
doing that?

> +	err = sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpu0);
> +	if (err != 0)
> +	tst_res(TFAIL, "sched_setaffinity(cpu%d)", online_cpus[0]);

Missing tab before tst_res()

Also given the amount of setaffinity calls here it may make sense to add
SAFE_SCHED_SETAFFINITY() to the library.


> +	q = (volatile unsigned long *)(p + getpagesize());
> +	*q = 0xdeadbeef;
> +
> +	tst_res(TPASS, "Nothing bad happened, probably.");
> +
> +	SAFE_MUNMAP(p, hpage_size);
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = tst_get_hugepage_size();
> +
> +	/* Fix: pass 3 arguments */

No comments like this please.

> +	fd = tst_creat_unlinked(MNTPOINT, O_RDWR | O_CREAT, 0644);
> +	if (fd < 0)
> +		tst_brk(TBROK | TERRNO, "tst_creat_unlinked() failed");

tst_creat_unlinked() cannot fail.

> +}
> +
> +static void cleanup(void)
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
> -- 
> 2.43.5
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
