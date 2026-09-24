Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088DAC98317
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 11:27:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8829F3E64FA
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 13:27:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5D163CD88C
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:26:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2CB881400071
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:26:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE92C21F18;
 Thu, 24 Sep 2026 11:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790249199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NCN5QdzcgYgYK4UEz5Cehnoqr+gHXqoBNTj4CzSQi5M=;
 b=kxdtFLz6q2ZB4LdN36eCPNtmRz0PJkV7o+NmqfycTikwPwTe6fyx5sNC3MjtTk9qMlD/r+
 XnoHiFtTB1NN3Cb5ie22ZmIYvNazzHt+jXxAO4DAu8r8iNI1wix8+LnkRV5NVy8W1aowjs
 E9XacLYJ2Xn6UBoXl6ib7eQ6XLTh0Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790249199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NCN5QdzcgYgYK4UEz5Cehnoqr+gHXqoBNTj4CzSQi5M=;
 b=ISUl5n/4vHt7fF8Epe0lvSo9Glm48OkdXtVvzi22l7aD2pjtcwRhjG9iPzYgrBx5NCaoYu
 4UT1bsXMo7q90jCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a00Pi5dZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f4XY7R7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790249195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NCN5QdzcgYgYK4UEz5Cehnoqr+gHXqoBNTj4CzSQi5M=;
 b=a00Pi5dZkLnVDUjN2dOhkiVu+4vx9crGLZGYnrc3oCHFS/rLQ809IoMKnx8qmrN6ggQkWe
 HlgtTbUcMERshmxLultvF5ElWwla+Vy9IsbxHEF8o2RLxXJpD/fzCWhwzYttLGwVjCBOxr
 aun/TT7lV5IlNcoMAIhzDHQOupqfMyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790249195;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NCN5QdzcgYgYK4UEz5Cehnoqr+gHXqoBNTj4CzSQi5M=;
 b=f4XY7R7DEN4KiSIJKOv1cAHWFih3t51cflv/jRBkbspxSxJ1CDP+pF7ru0HIUzAakgu1KO
 9zmDHiObFJDvq3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C50813668;
 Thu, 24 Sep 2026 11:26:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oCzbFesItWorIgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 24 Sep 2026 11:26:35 +0000
Date: Thu, 24 Sep 2026 13:26:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Nirmoy Das <nirmoyd@nvidia.com>
Message-ID: <arUI-D85OmQAiZBT@yuki.lan>
References: <apgVur5s_potD6ND@yuki.lan>
 <20260902160113.1207205-1-nirmoyd@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260902160113.1207205-1-nirmoyd@nvidia.com>
X-Rspamd-Queue-Id: AE92C21F18
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

We do have tst_ncpus() in the test library, please use that instead.

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

I like the funciton from Jan that pins the test to the current CPU
slightly better.

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
