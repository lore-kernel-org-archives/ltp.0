Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CA9EB64D9
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 11:47:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CE5E3C99E3
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 13:47:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 043E43C997D
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 13:47:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D66E81400965
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 13:47:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16BE22280D;
 Tue,  4 Jul 2023 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688471220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVxBVEIgU+G7JIe31gxxdtmV4bSL4zTOnehZYC6d5u8=;
 b=dOWoKoEClzqluVJFP87OSiI8wWDkhnQWj9DtVLqI4v5IRFlKnZtyTzhTCo5Uu82xPw7PzM
 UU5+VznaFBb5kZTBMKkBCh1KqBssHciPkg8Hlm2iepCbL0DevNFA0pu3kiRtxi0dnVyYVK
 16KdXZKDAlCW06LA/Z/suexjBKCYdGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688471220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVxBVEIgU+G7JIe31gxxdtmV4bSL4zTOnehZYC6d5u8=;
 b=J1Ytao7PWchDMUm3LWKqDJWE+djbDeafqWIYsKaK71j3UoaYJaZjt+D+JyNHI/XCX0GyDD
 42GpO0+Ylcql7fDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4DF2133F7;
 Tue,  4 Jul 2023 11:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id n10AN7MGpGRtHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jul 2023 11:46:59 +0000
Date: Tue, 4 Jul 2023 13:46:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230704114658.GC507064@pevik>
References: <20230703194904.445661-1-pvorel@suse.cz>
 <ZKPbSn2qQzxJGxR3@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZKPbSn2qQzxJGxR3@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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
 Vlastimil Babka <vbabka@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > +#define PAGE_SIZE 4096

> This wouldn't work on 64k page size.

> > +#define MMAP_SIZE ((ARRAY_SIZE(tcases)+1)*PAGE_SIZE)
> > +#define MREMAP_SIZE (ARRAY_SIZE(tcases)*PAGE_SIZE)

> These have to be variables initialized on the fly with getpagesize()
> instead of PAGE_SIZE.

Yep, I thought about getpagesize().

...
> > +static int check_pages(void)
> > +{
> > +	int fail = 0, i;
> > +	char val;
> > +
> > +	for (i = 0; i < (int)ARRAY_SIZE(tcases); i++) {
> > +		val = buf[i * PAGE_SIZE];
> > +		if (val != 0x30 + i) {
> > +			tst_res(TFAIL, "page %d wrong value %d (0x%x)", i, val - 0x30, val);

> Woudn't this generate too many FAILURE messages? Maybe we should just
> break the for cycle here.

It could be. I wasn't sure if it's important to know which pages were wrong.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
