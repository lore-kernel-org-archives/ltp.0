Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1ABCA0ED3
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 10:16:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D7A33C1881
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 12:16:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AE493C0BA7
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 12:16:32 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EABBD1A0068B
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 12:16:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D07B41F7BC;
 Wed,  4 Sep 2024 10:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725444991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ZxNDPoqgLEs9pDfCIm7uJhMddtNNggiwdXggIJQZ80=;
 b=c5afJmicN30EBGp5T8MSXMpa31jnOHybo/Ney1+iOmschRMjumluaYr7HaoTZll6aHvtt1
 tH1XwlhfcrYO3MjMdGi2kwCt3sMxhMowSR1u4g6rsww4UCX9RtYsjE5pXsljcUQHfbYir3
 u2/siwYsQkILE9Trz9nOatYuy6JYBgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725444991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ZxNDPoqgLEs9pDfCIm7uJhMddtNNggiwdXggIJQZ80=;
 b=xFzJESAYIA19uQ8QpO9tmVUKTvj7DXuRPqm9y+13hnen1tn8Ydzg+34h2AMMsV4uZK7ybV
 rwDhgyHOMV9lUfCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D+aXAhw0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a3KPX+9+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725444990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ZxNDPoqgLEs9pDfCIm7uJhMddtNNggiwdXggIJQZ80=;
 b=D+aXAhw0SX8Hgcnuwcm+8NAD9X/vM/5kTkJEYUzC3KBWAPdQRR7PXvVbKprG/rmPMq8fZ1
 iFlmSxGzXxSzXIAGGwmXust9RZ1yPuaM+dQFDfArvTOFdCKe+jUp4da2hFTU+knO/JtNUd
 xZ/PNFS6uu7t04vLu7rZq78DuexJeL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725444990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ZxNDPoqgLEs9pDfCIm7uJhMddtNNggiwdXggIJQZ80=;
 b=a3KPX+9++XhoezNH42BaRlIqi7QFwKofPLnSLh3L+SKAFeMcHHzKgYueFGFHuUj3cBzhQF
 Fl+RGitY1pujCUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5366139D2;
 Wed,  4 Sep 2024 10:16:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z1w9K34z2GZ5JQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Sep 2024 10:16:30 +0000
Date: Wed, 4 Sep 2024 12:15:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Samir Mulani <samir@linux.vnet.ibm.com>
Message-ID: <ZtgzOT0gPiIyumky@yuki.lan>
References: <20240407095243.65152-1-samir@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240407095243.65152-1-samir@linux.vnet.ibm.com>
X-Rspamd-Queue-Id: D07B41F7BC
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Migrating the
 libhugetlbfs/testcases/truncate_sigbus_versus_oom.c test
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
Cc: rpalethorpe@suse.de, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Some kernel have a bug in the positioning of the test against
> i_size.  This bug means that attempting to instantiate a page
> beyond the end of a hugepage file can result in an OOM and SIGKILL
> instead of the correct SIGBUS.
> 
> Signed-off-by: Samir Mulani <samir@linux.vnet.ibm.com>
> ---
> v3:
> --Addressed the below requested changes
>   1. Added volatile variable in signal handler to varify the SIGBUS signal in runtest method.
>   2. Fixed run test more times (-iN)
>   3. Removed number of required hugepages.
>   4. Corrected commit numberin struct tst_test.
>   5. Ran make check and fixed the issues.
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 103 ++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..7b7c44b77 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>  hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
> +hugemmap37 hugemmap37
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index c96fe8bfc..a74260689 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -34,6 +34,7 @@
>  /hugetlb/hugemmap/hugemmap30
>  /hugetlb/hugemmap/hugemmap31
>  /hugetlb/hugemmap/hugemmap32
> +/hugetlb/hugemmap/hugemmap37
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
> new file mode 100644
> index 000000000..5c55afe54
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test Name: Truncate_sigbus_versus_oom

Please drop the test name here as well.

> + * Some kernel have a bug in the positioning of the test against
> + * i_size.  This bug means that attempting to instantiate a page
> + * beyond the end of a hugepage file can result in an OOM and SIGKILL
> + * instead of the correct SIGBUS.
> + */
> +
> +#include <setjmp.h>
> +#include <signal.h>
> +#include "hugetlb.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +#define PTS_PASS 0

This macro is unused now.

> +static int  fd = -1, fdx = -1;
> +
> +static unsigned long long hpage_size;
> +static unsigned long totpages;
> +struct sigaction sa;
> +static sigjmp_buf sig_escape;
> +static volatile int test_pass;
> +static int sigbus_count;
> +
> +static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
> +{
> +	test_pass = 1;
> +	siglongjmp(sig_escape, 17);
> +}
> +
> +static void run_test(void)
> +{
> +	void *p, *q;
> +	unsigned long i;
> +
> +	sigbus_count = 0;
> +	test_pass = 0;
> +
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +	SAFE_FTRUNCATE(fd, 0);
> +
> +	fdx = tst_creat_unlinked(MNTPOINT, 0);
> +	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	q = SAFE_MMAP(NULL, totpages * hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fdx, 0);
> +	/* Touch the pages to ensure they're removed from the pool */
> +	for (i = 0; i < totpages; i++) {
> +		volatile char *x = (volatile char *)q + i*hpage_size;
> +		*x = 0;
> +	}
> +	/* SIGBUS is what *should* happen */
> +	SAFE_FTRUNCATE(fdx, 0);
> +	if (sigsetjmp(sig_escape, 1) == 0)
> +		*((volatile unsigned int *)p);
> +	else
> +		sigbus_count++;

I still think that this is actually useless, we already set a flag in
the signal handler so we can drop the whole sigbus_count logic from the
test and it could be simplified as:

	if (segsetjmp(sig_escape, 1) == 0)
		*((voilatile unsigned int *)p);

	if (test_pass)
		tst_res(TPASS, ...);
	else
		tst_res(TFAIL, ...);

I mean we are not going to get to the else branch that increments the
sigbus_count from anywhere else than the signal handler which already
set the test_pass, so the values of test_pass and sigbus_count will be
always the same.

> +	if (sigbus_count != 1)
> +		tst_res(TFAIL, "Didn't SIGBUS");
> +
> +	if (test_pass == 1)
> +		tst_res(TPASS, "Expected SIGBUS triggered");
> +}
> +
> +void setup(void)
> +{
> +	sa.sa_flags = SA_SIGINFO;
> +	sa.sa_handler = sigbus_handler;
> +	SAFE_SIGACTION(SIGBUS, &sa, NULL);
> +	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	hpage_size = tst_get_hugepage_size();
> +}
> +
> +void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +	if (fdx > 0)
> +		SAFE_CLOSE(fdx);
> +}
> +
> +
> +static struct tst_test test = {
> +	.tags = (struct tst_tag[]) {
> +		{"linux-git", "ebed4bfc8da8"},
> +		{}
> +	},
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
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
