Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11912C64ED6
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 15:31:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED1223CDDD6
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 16:31:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E7093C30A8
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 16:31:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9A943200908
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 16:31:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 82B171FDBE;
 Tue, 28 Feb 2023 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677598264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4M1gAGMKH1flD37HzzJuoj0+RVlO6OLbRsyaTLED500=;
 b=ggsy67TtSi6GsNDfp7sjlpY7TrnfnZ/8qa3gKL7kK3MlTb1n5allpMthHbpbUEBCQn/qOh
 8FewZl8eoS2PTKQtqztZjkBe6PDyqVjuKgBqW10i2Rn/TN8xFwaeNuUfob99TNDbHGJPso
 OawsbD+A1Ecug0AJnJQrMWaON2DFjVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677598264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4M1gAGMKH1flD37HzzJuoj0+RVlO6OLbRsyaTLED500=;
 b=YaktNZ/HhoMhB5tgeZhdTEUMN+kgwUFpfAqrhXFIg+kxcbeOtV1VLeLgrYXqZwVuDT/2U2
 jF2L2gJElRNa/HCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8B8C13440;
 Tue, 28 Feb 2023 15:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AT/PHjce/mMiegAAMHmgww
 (envelope-from <akumar@suse.de>); Tue, 28 Feb 2023 15:31:03 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2023 21:00:59 +0530
Message-ID: <3121397.4e4APuK8be@localhost>
Organization: SUSE
In-Reply-To: <Y/jRxug4oBqJeEmy@yuki>
References: <20230222034501.11800-1-akumar@suse.de> <Y/jRxug4oBqJeEmy@yuki>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mknod01: Rewrite the test using new LTP API
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

Hi Cyril,

On Friday, February 24, 2023 8:33:34 PM IST Cyril Hrubis wrote:
> Hi!
> > +	if (S_ISCHR(tcases[i]))
> > +		dev = makedev(1, 3);
> > +	else
> > +		dev = 0;
> 
> Reading 'man 2 mknod' I suppose that we should pass non-zero dev for
> block devices as well. Hoever the test seems to work fine with zero dev
> for both cases.
> 
> Btw makedev(1, 3) seems to be the /dev/null char device and it should
> work for block devices since block makedev(1, 3) would be /dev/ram3, so
> what about:
Thank you for the review and yes I overlooked block devices scenario, your suggested
patch looks good, should I send this as v2 or will you merge with these changes?

> 
> diff --git a/testcases/kernel/syscalls/mknod/mknod01.c b/testcases/kernel/syscalls/mknod/mknod01.c
> index d4b8c7bf8..7a4d5b43f 100644
> --- a/testcases/kernel/syscalls/mknod/mknod01.c
> +++ b/testcases/kernel/syscalls/mknod/mknod01.c
> @@ -31,12 +31,10 @@ static int tcases[] = {
> 
>  static void run(unsigned int i)
>  {
> -       dev_t dev;
> +       dev_t dev = 0;
> 
> -       if (S_ISCHR(tcases[i]))
> +       if (S_ISCHR(tcases[i]) || S_ISBLK(tcases[i]))
>                 dev = makedev(1, 3);
> -       else
> -               dev = 0;
> 
>         TST_EXP_PASS(mknod(PATH, tcases[i], dev),
>                                 "mknod(PATH, %o, %ld)",
> 
> 
> 

Regards,
Avinesh





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
