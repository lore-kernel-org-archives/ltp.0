Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A998C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 14:17:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 590263CBE58
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:17:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EAB53CBE07
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:17:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CCA2A1400141
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:17:01 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D805E1FE91;
 Mon, 12 Dec 2022 14:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670854620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlJs4D3GmcN4HAfU8sFAT09ki8G0t0lu9FrPBx2Q/aA=;
 b=wIrXXD3qhfCdb8Hc1WxmSRmeRKGOIAiX9CQPmtEE3+YwSqGoyXkAXDD96zuYrVHIH/dq3v
 iVZSPEFHI47fDvcpyrQZg2Esc0GOBl765b6h/5NRVac93TH7QU5YNuLKfBG8V0M6Hw23W+
 +ANEtDbafRHYzc1owRymJBnZsO9HcqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670854620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlJs4D3GmcN4HAfU8sFAT09ki8G0t0lu9FrPBx2Q/aA=;
 b=hJgXosGiIWq9IGie+aZXnTdtdXTRPoGJ7qMfeYwWAh9u9OlJrcGdt6oBYcx6zA/AJvlGbf
 i1LIMmc59eqqHiBg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 836432C141;
 Mon, 12 Dec 2022 14:17:00 +0000 (UTC)
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-5-tsahu@linux.ibm.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Mon, 12 Dec 2022 14:08:37 +0000
Organization: Linux Private Site
In-reply-to: <20221201122844.142062-5-tsahu@linux.ibm.com>
Message-ID: <878rjcvh9f.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/8] Hugetlb: Migrating libhugetlbfs icache-hygiene
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

> Migrating the libhugetlbfs/testcases/icache-hygiene.c test
>
> Test Description: Older ppc64 kernels don't properly flush dcache to
> icache before giving a cleared page to userspace.  With some exceedingly
> hairy code, this attempts to test for this bug.
>
> This test will never trigger (obviously) on machines with coherent
> icache and dcache (including x86 and POWER5).  On any given run,
> even on a buggy kernel there's a chance the bug won't trigger -
> either because we don't get the same physical page back when we
> remap, or because the icache happens to get flushed in the interim.

Compiling with Clang 15.0.5 on x86_64 and upstream kernel 6.0.9 in a KVM
VM the test fails:

sh-5.2# ./hugemmap15
[13712.044617] hugemmap15 (2118): drop_caches: 3
tst_hugepage.c:83: TINFO: 3 hugepage(s) reserved
tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
hugemmap15.c:191: TFAIL: icache unclean

> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {3, TST_NEEDS},
> +};
> -- 
> 2.31.1

Again, it would be nice to have the git tag(s) of the fix commit(s) if
possible.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
