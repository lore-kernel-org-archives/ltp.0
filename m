Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29365EB64D9
	for <ltp@archiver.kernel.org>; Mon, 10 Jul 2023 12:26:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AC083CB9EE
	for <ltp@archiver.kernel.org>; Mon, 10 Jul 2023 14:26:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1E593CA964
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 14:26:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CCCB51000451
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 14:26:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 136EA2203E;
 Mon, 10 Jul 2023 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688991978;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ysmfjv6mbc884EDPAUBhqygPy15ZILzd0doWhjfZK0=;
 b=jfuEsF4jrqmiGqaUAUb9mC8hOCN0/2593rg1DEAvMOgf1rwKXIDxixx89jqAoWbeDFQ+XG
 ACSbI52rnTJ3gesnMWYQTqthMVvZiegIV1lZHSxdsNoB0J+TsdKyOtqf08qpJfxE3wW8Nv
 D70liKVwrPQWO87jJ9UqfdkUi35Ti8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688991978;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ysmfjv6mbc884EDPAUBhqygPy15ZILzd0doWhjfZK0=;
 b=2ciplUagdOErHmhXjdr5xOXHs5UFgMt/z6iQDB8gJm8HqiVWVP1cS3+YugMInUdGRsR88C
 aWqwpomoIbqx8EDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B578E13A05;
 Mon, 10 Jul 2023 12:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ieGvKOn4q2Q+fwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 10 Jul 2023 12:26:17 +0000
Date: Mon, 10 Jul 2023 14:26:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <20230710122616.GA639201@pevik>
References: <20230703194904.445661-1-pvorel@suse.cz> <ZKPbSn2qQzxJGxR3@yuki>
 <20230704114658.GC507064@pevik>
 <b62ecf41-e35d-35f2-9b01-dca1fdf4d611@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b62ecf41-e35d-35f2-9b01-dca1fdf4d611@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] mremap06: Add mremap() reproducer for
 7e7757876f25
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Fabian Vogt <fvogt@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 7/4/23 13:46, Petr Vorel wrote:
> > Hi Cyril,

> >> > +#define PAGE_SIZE 4096

> >> This wouldn't work on 64k page size.

> >> > +#define MMAP_SIZE ((ARRAY_SIZE(tcases)+1)*PAGE_SIZE)
> >> > +#define MREMAP_SIZE (ARRAY_SIZE(tcases)*PAGE_SIZE)

> >> These have to be variables initialized on the fly with getpagesize()
> >> instead of PAGE_SIZE.

> > Yep, I thought about getpagesize().

> Agreed.

> Also IMHO it's awkward to have the number of pages and the iterations
> expressed using ARRAY_SIZE(tcases). I'd say it's just an accident that the
> number of pages involved in the merging and the number of testcases is both
> 3. I'd rather separate those.

Thanks for info. I'll define NUM_PAGES 3 then.

> > ...
> >> > +static int check_pages(void)
> >> > +{
> >> > +	int fail = 0, i;
> >> > +	char val;
> >> > +
> >> > +	for (i = 0; i < (int)ARRAY_SIZE(tcases); i++) {
> >> > +		val = buf[i * PAGE_SIZE];
> >> > +		if (val != 0x30 + i) {
> >> > +			tst_res(TFAIL, "page %d wrong value %d (0x%x)", i, val - 0x30, val);

> >> Woudn't this generate too many FAILURE messages? Maybe we should just
> >> break the for cycle here.

> > It could be. I wasn't sure if it's important to know which pages were wrong.

> There's just 3 pages to print so it won't be that many messages, I'd just
> print them all.

+1

Kind regards,
Petr

> > Kind regards,
> > Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
