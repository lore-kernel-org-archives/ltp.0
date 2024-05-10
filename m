Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6747C25B10
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 10:45:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 209043CE3A0
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 12:45:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 731C53CE2FB
 for <ltp@lists.linux.it>; Fri, 10 May 2024 12:45:06 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AB02E1009BCC
 for <ltp@lists.linux.it>; Fri, 10 May 2024 12:45:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E9B736137F;
 Fri, 10 May 2024 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715337904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMWBr8SIAROuNzS0Yipg9pieufNc+1fOqTx3z93YQ18=;
 b=KMn5Hk7y0DTmxgcWkT9BIOlbnfOV3AsFE3zeDwTi55pBzsKvi6sOBl+ZTFbzT4nM90pFPc
 fF06EhylmhTlgWVmDB2oSZPQs3MExAJlfHwT/OhxrMUV4APHTmTonqVxzA+g8O42DMYiKs
 BQCOnwkktOuzewaPJmD9Jx90EGCG6Zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715337904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMWBr8SIAROuNzS0Yipg9pieufNc+1fOqTx3z93YQ18=;
 b=ub3aTdzyaIRutG2ex6ENW/11aBOmAOdIITyFIx8BT3WsD3wKZi7YDymZ8DZxKoID8Dzf4I
 3lxZnP4+MvvIMACA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ObS7TmEN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9rnar5k+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715337902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMWBr8SIAROuNzS0Yipg9pieufNc+1fOqTx3z93YQ18=;
 b=ObS7TmENcRF+IgJK008WfPLR8D3HdNgj6fwdtIoypKPxTjoapD1sB6dEV5OxmysQnEXjdi
 QNctqICfEOy/SlkK7hJuky3wAK2URVTLg4w4GI5Hg+HbDk0jpwewx9J0Y/UF092wiMqCCL
 70t9l483zoGEYUmwdPsM286wWmHlvIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715337902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMWBr8SIAROuNzS0Yipg9pieufNc+1fOqTx3z93YQ18=;
 b=9rnar5k+D4JaieLA40cwC8tND+nk2X7ibdT99PFe62gyZwpyLqdCHQYqEeNubJhyGR9Uzz
 NL8Q3ssyhC6pRACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DACDD1386E;
 Fri, 10 May 2024 10:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vZZrNK76PWaeTgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 May 2024 10:45:02 +0000
Date: Fri, 10 May 2024 12:44:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Message-ID: <Zj36gf1qMvdZfFcm@yuki>
References: <20240307084513.109829-1-sachinpb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240307084513.109829-1-sachinpb@linux.vnet.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E9B736137F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Migrating the
 libhugetlbfs/testcases/shm-gettest.c test
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
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * DESCRIPTION

This should be [Description]

> + *	hugeshmget06 -

This shouldn't be there.

> + * This testcase creates shared memory segments backed by hugepages,
> + * writes specific patterns to each segment, verifies pattern,
> + * and detaches a shared memory segments in a loop.
> + * It ensures that the hugepage backed shared memory functionalities
> + * works correctly by validating the data written to segment.
> + */
> +
> +#include "hugetlb.h"
> +#include "tst_safe_sysv_ipc.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +#define NR_HUGEPAGES 4
> +
> +static long hpage_size;
> +static int shmid = -1, key = -1;
> +
> +static void do_shmtest(void)
> +{
> +	size_t i, j;
> +	char pattern;
> +	char *shmaddr;
> +
> +	shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
> +	tst_res(TINFO, "shmaddr: %p\n", shmaddr);
> +
> +	for (i = 0; i < NR_HUGEPAGES; i++) {
> +		pattern = 65 + (i % 26);
> +		tst_res(TINFO, "Touching %p with %c\n",
> +		shmaddr + (i * hpage_size), pattern);

Please do not add newlines in the tst_res() format strings. Also this

> +		memset(shmaddr + (i * hpage_size), pattern, hpage_size);
> +	}
> +
> +	for (i = 0; i < NR_HUGEPAGES; i++) {
> +		pattern = 65 + (i % 26);
> +		tst_res(TINFO, "Verifying %p\n", (shmaddr + (i * hpage_size)));

Here as well.

> +		for (j = 0; j < (size_t)hpage_size; j++)
> +			if (*(shmaddr + (i * hpage_size) + j) != pattern) {
> +				tst_res(TFAIL, "Got wrong byte 0x%02x expected 0x%02x",
> +						*(shmaddr + (i * hpage_size) + j),
> +						pattern);
> +				return;
> +			}
> +	}
> +	SAFE_SHMDT((const void *)shmaddr);
> +	tst_res(TPASS, "shm hugepages works correctly");
> +}
> +
> +static void run_test(void)
> +{
> +	do_shmtest();

What is the point of this indirection?

Just put the test code in the do_test() function instead.

> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = tst_get_hugepage_size();
> +	tst_res(TINFO, "hugepage size is  %ld", hpage_size);
                                        ^
					Just one space here.

> +	shmid = SAFE_SHMGET(key, NR_HUGEPAGES * hpage_size, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W);
> +	tst_res(TINFO, "shmid: 0x%x\n", shmid);
                                    ^
Here as well, no newlines.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (shmid >= 0)
> +		SAFE_SHMCTL(shmid, IPC_RMID, NULL);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,

The test does not use the hugetlbfs, no need to mount it at all.

> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {NR_HUGEPAGES, TST_NEEDS},
> +};
> -- 
> 2.43.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
