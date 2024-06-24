Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659DFC2BD05
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 11:57:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C41B53D0F97
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 13:57:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A4653D0DA4
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 13:57:25 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4BFD91A00099
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 13:57:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56F311F80A;
 Mon, 24 Jun 2024 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719230243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=exHNU43CzO9nWEFu/sQY06dR6lHGyFoWIlg6cAZwAqA=;
 b=vU/NU/OOf8wgdRrkg0kui6DqkWtxnNjohgzy6Zz50Cu07pJmMb40QLu7PapaFHPlu3Kj8n
 NMSvcG8In8gmcjTmb8wVvhFzQ6BxmJiR2yUJznCfR+JiXbRDnJIlc1TCYnab1xd9HIvvsg
 JmcMv0aPn2teAC/zvqsQfX6UK1OnN6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719230243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=exHNU43CzO9nWEFu/sQY06dR6lHGyFoWIlg6cAZwAqA=;
 b=AdNdt+XcZRu1S4WkT3a6b4pLvyLmoTy03VEp5uKu+CaEyR0Qnw+dcZsTi/yngAirA3/1OZ
 dDGMIS+BnsY6kMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719230243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=exHNU43CzO9nWEFu/sQY06dR6lHGyFoWIlg6cAZwAqA=;
 b=vU/NU/OOf8wgdRrkg0kui6DqkWtxnNjohgzy6Zz50Cu07pJmMb40QLu7PapaFHPlu3Kj8n
 NMSvcG8In8gmcjTmb8wVvhFzQ6BxmJiR2yUJznCfR+JiXbRDnJIlc1TCYnab1xd9HIvvsg
 JmcMv0aPn2teAC/zvqsQfX6UK1OnN6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719230243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=exHNU43CzO9nWEFu/sQY06dR6lHGyFoWIlg6cAZwAqA=;
 b=AdNdt+XcZRu1S4WkT3a6b4pLvyLmoTy03VEp5uKu+CaEyR0Qnw+dcZsTi/yngAirA3/1OZ
 dDGMIS+BnsY6kMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4423B1384C;
 Mon, 24 Jun 2024 11:57:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A1JZECNfeWZCVwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Jun 2024 11:57:23 +0000
Date: Mon, 24 Jun 2024 13:57:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Shirisha G <shirisha@linux.ibm.com>
Message-ID: <ZnlfGVAO9-53sQ8z@yuki>
References: <20240416091107.783352-1-shirisha@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240416091107.783352-1-shirisha@linux.ibm.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Migrating the
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
> +#define _GNU_SOURCE
> +#define SYSFS_CPU_ONLINE_FMT "/sys/devices/system/cpu/cpu%d/online"
> +#define MNTPOINT "hugetlbfs/"
> +#define SINGLE_CPU (CPU_SETSIZE/8)
> +#include "hugetlb.h"
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

All these should be static.

> +void check_online_cpus(int online_cpus[], int nr_cpus_needed)
> +{
> +	char cpu_state, path_buf[64];
> +	int cpu_idx, fd, ret, i;
> +
> +	cpu_idx = 0;
> +
> +	if (get_nprocs() < nr_cpus_needed)
> +		tst_brk(TCONF, "minimum  %d online cpus are required", nr_cpus_needed);
> +
> +	for (i = 0; i < get_nprocs_conf() && cpu_idx < nr_cpus_needed; i++) {
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
> +				tst_res(TFAIL | TERRNO, "Unable to open %s", path_buf);
> +			}
> +		}
> +
> +		ret = read(fd, &cpu_state, 1);
> +		if (ret < 1)
> +			tst_res(TFAIL | TERRNO, "Unable to read %s", path_buf);
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
> +		tst_brk(TCONF, "minimum %d online cpus were not found", nr_cpus_needed);
> +}

There seems to be an easier method, recently we needed to find online
CPU for the startvation tests and all you need to do is to get the
current thread affinity and then look for non-zero bits in that, see
commit:

commit 1800e635783b69cacdce9f654ecd730a8f30915b
Author: Edward Liaw via ltp <ltp@lists.linux.it>
Date:   Wed Jun 19 16:28:07 2024 +0000

And I suppose that it would make sense to put this function in the test
library so taht we do not have to repeat it over in tests, but we would
have to make it return the actual number of CPUs found and do the
tst_brk(TCONF, ...) in the tests instead, so we would add:

unsigned int tst_get_online_cpus(int online_cpus[], unsigned int online_cpus_cnt);

And the test would do:

	if (tst_get_online_cpus(online_cpus, 2) != 2)
		tst_brK(TCONF, "Require at least 2 online CPUs.");

> +static void run_test(void)
> +{
> +	check_online_cpus(online_cpus, 2);
> +	CPU_ZERO(&cpu0);
> +	CPU_SET(online_cpus[0], &cpu0);
> +	CPU_ZERO(&cpu1);
> +	CPU_SET(online_cpus[1], &cpu1);
> +
> +	err = sched_setaffinity(getpid(), SINGLE_CPU, &cpu0);
> +	if (err != 0)
> +		tst_res(TFAIL | TERRNO, "sched_setaffinity(cpu%d)", online_cpus[0]);
> +
> +	err = sched_setaffinity(getpid(), SINGLE_CPU, &cpu1);
> +
> +	if (err != 0)
> +		tst_res(TFAIL | TERRNO, "sched_setaffinity(cpu%d)", online_cpus[1]);
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +	err = sched_setaffinity(getpid(), SINGLE_CPU, &cpu0);
> +	if (err != 0)
> +		tst_res(TFAIL, "sched_setaffinity(cpu%d)", online_cpus[0]);
> +	q = (volatile unsigned long *)(p + getpagesize());
> +	*q = 0xdeadbeef;

I suppose that the test crashes here, when the entries are not
propagated, right?

> +	tst_res(TPASS, "Test Passed inconclusive");

We usually print something as tst_res(TPASS, "Nothing bad happend, probably");
in the case that we haven't managed to crash the system.

Also we have to unmap the p here so that the test works properly with -i
parameter.

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
