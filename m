Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5019C4332F
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 11:24:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 910133CD165
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 12:24:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 996203CD12D
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 12:23:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1A4F41000772
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 12:23:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4FEA1F8B5;
 Tue, 15 Nov 2022 11:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668511436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJJWB5TfbaHr8O/DQtGmSCYC1bzO5zhGzZG3HIkTWGg=;
 b=QaBSPz9ErunFM9arYChioRUuBhh91BwOeP8ScFzYupz4o31JmNylhtoVKNsTl/cwVcKLuM
 +ChqpKtlZIJEte05RfZ/Dr4WgWHsmHlf58C349V2kdeTCLcimjlPOKVPenZL03VoysePIm
 pTFBFOR35PQfOUeI6xWbtzHOe5qLeCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668511436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJJWB5TfbaHr8O/DQtGmSCYC1bzO5zhGzZG3HIkTWGg=;
 b=PjrQ/WskB7h30UrqZY7ztOrtcP0aknnniTZruPKtfIFlBKOg/g+TleYydPOuOoqYyVDF5H
 DyeRV0b0TsHxhqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C297013A91;
 Tue, 15 Nov 2022 11:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Uqp0Lsx2c2NoHAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 15 Nov 2022 11:23:56 +0000
Date: Tue, 15 Nov 2022 12:25:20 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
Message-ID: <Y3N3ICYP+g2Tf6bd@yuki>
References: <20221114225616.54212-1-federico.bonfiglio@protonmail.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221114225616.54212-1-federico.bonfiglio@protonmail.ch>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched_setscheduler: test SCHED_RESET_ON_FORK
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
> +/*
> + * [Description]
> + *
> + * Testcases that test if sched_setscheduler with flag
> + * SCHED_RESET_ON_FORK restores children policy to
> + * SCHED_NORMAL.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sched.h>
> +#include <linux/sched.h>
> +
> +#include "tst_test.h"
> +#include "tst_sched.h"
> +
> +struct test_c
> ase_t {
 ^
 Looks like the patch was mangled by your email client.

> +	int policy;
> +	char *desc;
> +};
> +
> +static struct test_case_t cases[] = {
> +	{
> +		.policy = SCHED_FIFO,
> +		.desc = "SCHED_FIFO"
> +	},
> +	{
> +		.policy = SCHED_RR,
> +		.desc = "SCHED_RR"
> +	}
> +};
> +
> +static void test_reset_on_fork(unsigned int i)
> +{
> +	struct sched_variant *tv = &sched_variants[tst_variant];
> +	struct test_case_t *tc = &cases[i];
> +
> +	tst_res(TINFO, "Testing %s variant", tv->desc);
> +	tst_res(TINFO, "Testing %s policy", tc->desc);

Why two messages? Why not just:

tst_res(TINFO, "Testing %s variant %s policy", tv->desc, tc->desc);

> +	struct sched_param param = { .sched_priority = 1 };
> +
> +	tv->sched_setscheduler(getpid(), tc->policy | SCHED_RESET_ON_FORK, &param);
> +
> +	pid_t pid = SAFE_FORK();
> +
> +	if (!pid == 0) {
            ^
	    Uff, please don't.

That's just if (pid)


> +		if (sched_getscheduler(pid) == SCHED_NORMAL)
> +			tst_res(TPASS, "Policy reset to SCHED_NORMAL");
> +		else
> +			tst_res(TFAIL, "Policy NOT reset to SCHED_NORMAL");


We should check that the priority was reset to DEFAULT_PRIO as well.

> +	}
> +
> +	tst_reap_children();

There is no need to call this as long as the child exits normally the
test library will pick it up.

> +}
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.caps = (struct tst_cap[]) {
> +	    TST_CAP(TST_CAP_REQ, CAP_SYS_NICE)
> 
> +	},
> +	.test_variants = ARRAY_SIZE(sched_variants),
> +	.tcnt = ARRAY_SIZE(cases),
> +	.test = test_reset_on_fork
> +};
> +
> --
> 2.38.1
> 





> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
