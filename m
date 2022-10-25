Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C86C04A95
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 11:18:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98BB93CA461
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 13:17:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D9243C0367
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 13:17:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ECCE0680E54
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 13:17:48 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3D4DA22061;
 Tue, 25 Oct 2022 11:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666696668;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zixxmICs8duTYZMQGM8rxgzQIZQtngodaGkmTJjNsv0=;
 b=PKnL05ftUGJ7T2waAVnWd5eojgkpJyqKF4DDDYETjAtJ8gQKSP9jQHXtW8dG1vrWyKqpFF
 /au9wlRGaAVuYVKHiYYwsXRDdrx4G42nz9NyNw3AaUQHOySYGywAAojJDjadObH9SA45K7
 i0smLoecUpddA8CxjpjoKGLheOQwUmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666696668;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zixxmICs8duTYZMQGM8rxgzQIZQtngodaGkmTJjNsv0=;
 b=AgcgYQDqD5KBHSc0mjbcs7X8YWQ2pT+B0aaiJYpJE2PxdeWtLkHWaWSM68IwclDUkgX5z4
 gWRHTLdeQR7k/gDg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4CCF92C141;
 Tue, 25 Oct 2022 11:17:47 +0000 (UTC)
References: <20221019184846.89318-1-tsahu@linux.ibm.com>
 <20221019184846.89318-4-tsahu@linux.ibm.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Tue, 25 Oct 2022 12:04:27 +0100
In-reply-to: <20221019184846.89318-4-tsahu@linux.ibm.com>
Message-ID: <8735bcxicr.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Hugetlb: Migrating libhugetlbfs
 corrupt-by-cow-opt
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
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Tarun Sahu <tsahu@linux.ibm.com> writes:

> Migrating the libhugetlbfs/testcases/corrupt-by-cow-opt.c test
>
> Test Description: Test sanity of cow optimization on page cache. If a page
> in page cache has only 1 ref count, it is mapped for a private mapping
> directly and is overwritten freely, so next time we access the page, we
> can see corrupt data.

Seems like this and 2/3 follow the same pattern. The setups are
reasonably similar and could be encapsulated in tst_hugepage.

> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.options = (struct tst_option[]) {
> +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
> +		{"s:", &nr_opt, "Set the number of the been allocated
> hugepages"},

nr_opt also seems suspicious. The test only ever allocates one page at a
time regardless of what this is set to. Changing it will just change how
much free memory we check for unless I am mistaken.

> +		{}
> +	},
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {2, TST_NEEDS},
> +};
> -- 
> 2.31.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
