Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4ACC47090
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 09:03:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 678E93CC18A
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 10:03:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 527773C32DD
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 10:03:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF12122CFF7
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 10:03:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id DAA8E21C0A;
 Tue,  6 Dec 2022 09:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670317399;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPxFp6yYL7utD8Qd3vOtxIYl1AI0sxc0bnh8upcuh1k=;
 b=ANGPbFKfSgfZfafwQsIkIhFue6U7zqu6CEKK2dzEocgvVmBvrUJzyq8YB2e0CNr/DobRx8
 OU1OAfWC0w414IdFm2Gv0fLrwhOOeBAB/Ym6bdnbp2n2qvIUcpGXSzy1RQnlhlG6kXmlNX
 UzIKw4Sw0gZFcL3v9S/N0lso3lABIzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670317399;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPxFp6yYL7utD8Qd3vOtxIYl1AI0sxc0bnh8upcuh1k=;
 b=G6u7zHhmhiIp0SMwEg1JH8BfW4gcMJf46NOJBlQoB/5WzT+rEgMhVBVHzyVO+7m/jF0hcV
 QH/G5bjG/T9ZwkDQ==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 818642C141;
 Tue,  6 Dec 2022 09:03:19 +0000 (UTC)
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-4-tsahu@linux.ibm.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Tue, 06 Dec 2022 08:57:24 +0000
Organization: Linux Private Site
In-reply-to: <20221201122844.142062-4-tsahu@linux.ibm.com>
Message-ID: <87ilioucob.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/8] Hugetlb: Migrating libhugetlbfs
 huge_below_4GB_normal_above
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
Cc: aneesh.kumar@linux.ibm.com, ltp@lists.linux.it, sbhat@linux.ibm.com,
 geetika@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Tarun Sahu <tsahu@linux.ibm.com> writes:

> Migrating the libhugetlbfs/testcases/huge_below_4GB_normal_above.c test
>
> Test Description: Designed to pick up a bug on ppc64 where
> touches_hugepage_low_range() could give false positives because of the
> peculiar (undefined) behaviour of << for large shifts
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  | 156 ++++++++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 2029ee4b3..796ebe7fa 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -15,6 +15,7 @@ hugemmap10 hugemmap10
>  hugemmap11 hugemmap11
>  hugemmap12 hugemmap12
>  hugemmap13 hugemmap13
> +hugemmap14 hugemmap14
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 5955ed613..3106579ce 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -14,6 +14,7 @@
>  /hugetlb/hugemmap/hugemmap11
>  /hugetlb/hugemmap/hugemmap12
>  /hugetlb/hugemmap/hugemmap13
> +/hugetlb/hugemmap/hugemmap14
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
> new file mode 100644
> index 000000000..8ccd141f8
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Designed to pick up a bug on ppc64 where touches_hugepage_low_range()
> + * could give false positives because of the peculiar (undefined)
> + * behaviour of << for large shifts
> + *
> + * WARNING: The offsets and addresses used within are specifically
> + * calculated to trigger the bug as it existed.  Don't mess with them
> + * unless you *really* know what you're doing.

I guess the test is good insofar that I can tell. As with hugemmap13 it
would be nice to have a reference to the bugfix though.

> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {2, TST_NEEDS},

If we can find the bugfix commit then it can be referenced in the tags
here.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
