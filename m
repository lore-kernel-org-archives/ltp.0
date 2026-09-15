Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532CAC88E75
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 15:29:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A86673E8CDB
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 17:29:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 025C53E8CC1
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 17:29:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4B0531A009B2
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 17:29:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 70E6221D59;
 Tue, 15 Sep 2026 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789486141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kbw9ctjJEgbs/GuoKsYJPtjjF8L3y+s2WU3SdjVMPig=;
 b=dMYvhLIS+IhZkMmi1DfCMn+4M8plr6yFPPDt7fCf9cGOYPTjpbKgbNu2jvo1J7iPzrXp5R
 2wMIpQ1EiYYLWrmeBPy+sObvDd25Th5pMXTAWbOcG10ZNW3ZImN1riRp7hqdyRcxQ2MVRJ
 mfLXzt8CO5tHPYYa9n9QSimsIgwEbqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789486141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kbw9ctjJEgbs/GuoKsYJPtjjF8L3y+s2WU3SdjVMPig=;
 b=ldfIt4VxgZ2I+RwLf1gaxwXqGdBc/Dg/EjZW+S27wNpPhpGldPzFwFpo6f/qCu1kA3jXwI
 B5RiwNZk8c7u0JAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789486137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kbw9ctjJEgbs/GuoKsYJPtjjF8L3y+s2WU3SdjVMPig=;
 b=UcZWy/cMnqGph+Bkm0vcXgXD6VRAIZvXYgaU/V1DtnO1nm0udK/vClRCuBXc3cGJgS/bYI
 NWRmDnrKhr9z7Vzh9LXBVBK+X8dSUwUl328xmsUKLTp/XKuzhNL54mdv+75qvcrwXTnWMb
 JYNitYrztvjOxF3j4SpF8jrjFp5CE1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789486137;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kbw9ctjJEgbs/GuoKsYJPtjjF8L3y+s2WU3SdjVMPig=;
 b=J+8glG/9+hXd0jDIVst5vCZnKIW6xU2+8sqvdnOynYmJGojW7T7GtK/ciy3fT3dqIbfhGi
 DhcFd2yUx6QaLOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EBB8136A5;
 Tue, 15 Sep 2026 15:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 51J9BzlkqWrQdwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Sep 2026 15:28:57 +0000
Date: Tue, 15 Sep 2026 17:29:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Nirmoy Das <nirmoyd@nvidia.com>
Message-ID: <aqlkQAUnD06oQ5KR@yuki.lan>
References: <apgVur5s_potD6ND@yuki.lan>
 <20260902160113.1207205-1-nirmoyd@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260902160113.1207205-1-nirmoyd@nvidia.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,yuki.lan:mid]; 
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getrusage03: account for percpu RSS counter
 batching
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
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
> index a2cdd6158..38a100576 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage03.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
> @@ -13,9 +13,13 @@
>   * this program.
>   */
>  
> +#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <stdio.h>
>  
> +#include "lapi/cpuset.h"
> +#include "tst_safe_stdio.h"
> +#include "tst_cpu.h"
>  #include "tst_test.h"
>  #include "getrusage03.h"
>  
> @@ -23,12 +27,99 @@
>  
>  static struct rusage ru;
>  static long maxrss_init;
> +static long lower_allowance;
>  
>  static const char *const resource[] = {
>  	TESTBIN,
>  	NULL,
>  };
>  
> +static long count_online_cpus(void)
> +{
> +	FILE *fp = SAFE_FOPEN("/proc/stat", "r");
> +	char line[BUFSIZ];
> +	long count = 0;
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (line[0] == 'c' && line[1] == 'p' && line[2] == 'u' &&
> +		    line[3] >= '0' && line[3] <= '9')
> +			count++;
> +	}
> +
> +	if (ferror(fp))
> +		tst_brk(TBROK | TERRNO, "fgets(/proc/stat)");
> +
> +	SAFE_FCLOSE(fp);
> +
> +	if (!count)
> +		tst_brk(TBROK, "No online CPUs found in /proc/stat");
> +
> +	return count;
> +}
> +
> +static void pin_to_cpu(void)
> +{
> +	long ncpus = tst_ncpus_max();
> +	size_t size = CPU_ALLOC_SIZE(ncpus);
> +	cpu_set_t *mask = CPU_ALLOC(ncpus);
> +	int cpu = -1;
> +
> +	if (!mask)
> +		tst_brk(TBROK | TERRNO, "CPU_ALLOC()");
> +
> +	CPU_ZERO_S(size, mask);
> +	if (sched_getaffinity(0, size, mask) < 0) {
> +		CPU_FREE(mask);
> +		tst_brk(TBROK | TERRNO, "sched_getaffinity()");
> +	}
> +
> +	for (long i = 0; i < ncpus; i++) {
> +		if (CPU_ISSET_S((int)i, size, mask)) {
> +			cpu = (int)i;
> +			break;
> +		}
> +	}
> +
> +	if (cpu < 0) {
> +		CPU_FREE(mask);
> +		tst_brk(TBROK, "sched_getaffinity() returned an empty CPU mask");
> +	}
> +
> +	CPU_ZERO_S(size, mask);
> +	CPU_SET_S(cpu, size, mask);
> +	if (sched_setaffinity(0, size, mask) < 0) {
> +		CPU_FREE(mask);
> +		tst_brk(TBROK | TERRNO, "sched_setaffinity()");
> +	}
> +
> +	CPU_FREE(mask);
> +}
> +
> +static void setup(void)
> +{
> +	long online_cpus = count_online_cpus();
> +	long batch = MAX(32L, online_cpus * 2);
> +	long page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> +	long batch_kib = batch * page_size / 1024;
> +
> +	lower_allowance = MAX(20 * 1024L, batch_kib);
> +	if (lower_allowance >= 102400L)
> +		tst_brk(TCONF, "Per-CPU RSS allowance is too large: %li KiB",
> +			lower_allowance);

As long as we pin to a single CPU the whole batch accounting shouldn't
be needed.

FYI Jan send a similar patch that just pins the process to a single CPU:

https://patchwork.kernel.org/project/ltp/patch/a308e12198ce96305761a009858fa4a80c91f932.1788518850.git.jstancek@redhat.com/

As far as I can tell that should be enough to fix the test.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
