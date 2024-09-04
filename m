Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EC4CD37B4
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 12:33:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C49E3C1DFA
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 14:33:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3D803C050E
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 14:32:53 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F194E600217
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 14:32:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4BDFE219D2;
 Wed,  4 Sep 2024 12:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725453171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KhKHFQM+2CXCVP0BqNSNWT4DoaOfBmWDgUmDZ3t4SLA=;
 b=ZJY/R+n1hYuK8m54+78VmQ1vnLqXQlSGa//9YvjFM5OCWAX7iy1KUhNeIv1njjUG/nRIUW
 lT++QG+GYg8dESYnrIp6FyPCMjk/MYj1bxsCPU3WtwknhpM9EgaBvXNRYYQpE25yGZiNZW
 PAhlX+LIp9ivJX+v5o3ay6BKG1TFIbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725453171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KhKHFQM+2CXCVP0BqNSNWT4DoaOfBmWDgUmDZ3t4SLA=;
 b=YGtQu0k75Ad7MAzDLfRB5cSzYw+Pc+E/0f2x591qJtuKap+wDroU/HsV9sMOZC+tqLny1g
 U9cLmsrwsO/yMaDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ZJY/R+n1";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YGtQu0k7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725453171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KhKHFQM+2CXCVP0BqNSNWT4DoaOfBmWDgUmDZ3t4SLA=;
 b=ZJY/R+n1hYuK8m54+78VmQ1vnLqXQlSGa//9YvjFM5OCWAX7iy1KUhNeIv1njjUG/nRIUW
 lT++QG+GYg8dESYnrIp6FyPCMjk/MYj1bxsCPU3WtwknhpM9EgaBvXNRYYQpE25yGZiNZW
 PAhlX+LIp9ivJX+v5o3ay6BKG1TFIbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725453171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KhKHFQM+2CXCVP0BqNSNWT4DoaOfBmWDgUmDZ3t4SLA=;
 b=YGtQu0k75Ad7MAzDLfRB5cSzYw+Pc+E/0f2x591qJtuKap+wDroU/HsV9sMOZC+tqLny1g
 U9cLmsrwsO/yMaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AFF6139D2;
 Wed,  4 Sep 2024 12:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KnGFDXNT2GZ3UQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Sep 2024 12:32:51 +0000
Date: Wed, 4 Sep 2024 14:31:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin P Bappalige <sachinpb@linux.ibm.com>
Message-ID: <ZthTJhjcF8lmjP5z@yuki.lan>
References: <20240515092456.3180-1-sachinpb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240515092456.3180-1-sachinpb@linux.ibm.com>
X-Rspamd-Queue-Id: 4BDFE219D2
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Migrating the
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
> Test Description: This testcase creates shared memory segments
> backed by hugepages, writes specific patterns to each segment,
> verifies pattern and detaches a shared memory segments in a loop.
> 
> This looping test was added to verify the functionality of
> large page backed shared memory segments. A segment is created,
> written, verified, and detached for specified number of times.
> 
> -Updated 'kernel/mem/.gitignore'
> -Updated 'runtest/hugetlb' for number of iterations with -i 10
> 
> Signed-off-by: Sachin P Bappalige <sachinpb@linux.ibm.com>
> ---
>  runtest/hugetlb                               |  1 +
>  testcases/kernel/mem/.gitignore               |  1 +
>  .../mem/hugetlb/hugeshmget/hugeshmget06.c     | 78 +++++++++++++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..f294e9aaa 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -55,3 +55,4 @@ hugeshmget01 hugeshmget01 -i 10
>  hugeshmget02 hugeshmget02 -i 10
>  hugeshmget03 hugeshmget03 -i 10
>  hugeshmget05 hugeshmget05 -i 10
> +hugeshmget06 hugeshmget06 -i 10
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index c96fe8bfc..d88484fa1 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -47,6 +47,7 @@
>  /hugetlb/hugeshmget/hugeshmget02
>  /hugetlb/hugeshmget/hugeshmget03
>  /hugetlb/hugeshmget/hugeshmget05
> +/hugetlb/hugeshmget/hugeshmget06
>  /ksm/ksm01
>  /ksm/ksm02
>  /ksm/ksm03
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
> new file mode 100644
> index 000000000..85a731113
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
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
> +static void run_test(void)
> +{
> +	size_t i, j;
> +	char pattern;
> +	char *shmaddr;
> +
> +	shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
> +	tst_res(TINFO, "shmaddr: %p", shmaddr);
> +
> +	for (i = 0; i < NR_HUGEPAGES; i++) {
> +		pattern = 65 + (i % 26);
> +		tst_res(TINFO, "Touching %p with %c",
> +		shmaddr + (i * hpage_size), pattern);
> +		memset(shmaddr + (i * hpage_size), pattern, hpage_size);
> +	}
> +
> +	for (i = 0; i < NR_HUGEPAGES; i++) {
> +		pattern = 65 + (i % 26);
> +		tst_res(TINFO, "Verifying %p", (shmaddr + (i * hpage_size)));
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
> +static void setup(void)
> +{
> +	hpage_size = tst_get_hugepage_size();
> +	tst_res(TINFO, "hugepage size is %ld", hpage_size);
> +	shmid = SAFE_SHMGET(key, NR_HUGEPAGES * hpage_size, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W);

This uses hardcoded key (-1). Why can't we use IPC_PRIVATE here instead?

> +	tst_res(TINFO, "shmid: 0x%x", shmid);
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
> +	.needs_hugetlbfs = 0,

If you do not need it, just do not list it here. Uninitialized variables
are set to zero automatically.

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
