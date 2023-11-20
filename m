Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEA1C54E76
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 11:03:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F7023CE1B0
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 12:03:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 918473CC1F1
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 12:02:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4759D1400FB6
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 12:02:53 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4E0481F890;
 Mon, 20 Nov 2023 11:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700478173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9RcjBm82fLIlotOP8iCnJWUefEpagXve7TWsA0YD3Es=;
 b=D0tgaPXCxcTtP3VdCCw8pzDEn9UKfZ9gqVescalQ1nFPJtZBCvsDOLE+9imrRadN+YwE7W
 NHoCLcvx5fSGLxBzWO9v8B7Xb3Rxa+8XRjwTu02LMNWW/wI/O59mlij8Tnc4rt5HMv80Mo
 mfzWkhK7au56+NhNZ9xROOUITiqYqGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700478173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9RcjBm82fLIlotOP8iCnJWUefEpagXve7TWsA0YD3Es=;
 b=B0bxl7QgpQq5c2u6KgQzgzSmDgKsxQ2IvMVaH9KxuWr1VUYMwo1rWkKG9iqANBzO1fgqeu
 UvCOSEJb3sxentAw==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D11762C227;
 Mon, 20 Nov 2023 11:02:52 +0000 (UTC)
References: <20230919072022.93034-1-samir@linux.vnet.ibm.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Samir Mulani <samir@linux.vnet.ibm.com>
Date: Mon, 20 Nov 2023 10:34:48 +0000
Organization: Linux Private Site
In-reply-to: <20230919072022.93034-1-samir@linux.vnet.ibm.com>
Message-ID: <87a5r8adr8.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [14.29 / 50.00];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 HAS_ORG_HEADER(0.00)[];
 R_RATELIMIT(0.00)[rip(RLa6h5sh378tcam5q78u)]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_DKIM_NA(2.20)[]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(3.00)[1.000];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.de];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 VIOLATED_DIRECT_SPF(3.50)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Queue-Id: 4E0481F890
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Migrating the
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Samir Mulani <samir@linux.vnet.ibm.com> writes:

> In this test case, we are verifying the bug fix commit that is attached as
> a part of the test case structure,
>
> Some kernel have a bug in the positioning of the test against
> i_size.  This bug means that attempting to instantiate a page
> beyond the end of a hugepage file can result in an OOM and SIGKILL
> instead of the correct SIGBUS.
>
> Signed-off-by: Samir Mulani <samir@linux.vnet.ibm.com>
> ---
> v2:
>  -Corrected typo.
>  -Fixed the make check warnings.
> ---
>  runtest/hugetlb                               |  1 +
>  testcases/kernel/mem/.gitignore               |  1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 88 +++++++++++++++++++
>  3 files changed, 90 insertions(+)
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
> index 7258489ed..7b923c8fd 100644
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
> index 000000000..66990db25
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test Name: Truncate_sigbus_versus_oom
> + *
> + * Some kernel have a bug in the positioning of the test against
> + * i_size.  This bug means that attempting to instantiate a page
> + * beyond the end of a hugepage file can result in an OOM and SIGKILL
> + * instead of the correct SIGBUS.
> + */
> +
> +#include "hugetlb.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +#define PTS_PASS 0
> +static int  fd = -1, fdx = -1;
> +
> +static unsigned long long hpage_size;
> +static unsigned long totpages;
> +struct sigaction sa;
> +
> +static void sigbus_handler(int signum)
> +{
> +	if (signum == SIGBUS) {
> +		tst_res(TPASS, "Test PASSED\n");
> +		_exit(PTS_PASS);

In LTP we try to do as little as possible in signal handlers. In rare
cases some library functions don't work as expected.

Here we should just set a volatile variable with the signal number that
was caught. Then inspect it later.

> +	}
> +}
> +
> +static void run_test(void)
> +{
> +	void *p, *q;
> +	unsigned long i;
> +
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +	SAFE_FTRUNCATE(fd, 0);
> +
> +	fdx = tst_creat_unlinked(MNTPOINT, 0);
> +	q = SAFE_MMAP(NULL, totpages * hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fdx, 0);
> +	/* Touch the pages to ensure they're removed from the pool */
> +	for (i = 0; i < totpages; i++) {
> +		volatile char *x = (volatile char *)q + i*hpage_size;
> +		*x = 0;
> +	}
> +	/* SIGBUS is what *should* happen */
> +	SAFE_FTRUNCATE(fdx, 0);
> +	*((volatile unsigned int *)p);
> +	tst_res(TFAIL, "Didn't SIGBUS or OOM");

Here we could check a variable we set in the signal handler.

There is nothing here to free the mapped pages or close the files. So
most likely SAFE_MMAP will fail on the second iteration (i.e. with -i 2)
and eventually we would run out of file descriptors.

> +}
> +
> +void setup(void)
> +{
> +	sa.sa_flags = SA_SIGINFO;
> +	sa.sa_handler = sigbus_handler;
> +	SAFE_SIGACTION(SIGBUS, &sa, NULL);
> +	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);

There is a possible TOCTOU problem here. I don't think it can be avoided
completely, but perhaps we should read the number of free pages just
before calling the second mmap?

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
> +		{"linux-git", "0d59a01bc461"},

I think this is the wrong commit. It prevents the stack from growing
into a huge page region.

> +		{}
> +	},
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {2, TST_NEEDS},
> +};
> -- 
> 2.39.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
