Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AB5C433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 11:03:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BAE13CAB08
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 13:03:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F00BD3CAA69
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:03:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ADFD11A001D6
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:03:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0081221BDB;
 Fri, 20 May 2022 11:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653044594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U6PjxQupgDwI9FQRJt1oD4VWMD55TVS5T8P5amfZh9k=;
 b=O0CITfzu3lWbro64FbOnSPil6JxtbNG507ZwBLWiY1IUvbK/K6j8qSwbo217q38LjHwQOT
 OYyEM7ZgFcKVqmwE4EvjxdUrvKL8/3b/R7buOgrsdR0TBYFON9F2i9l/L4JQfgmdGRLtxP
 w0rCcSpMOY2WcIKCbTv2id1pM6K5pJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653044594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U6PjxQupgDwI9FQRJt1oD4VWMD55TVS5T8P5amfZh9k=;
 b=xKj6jXaxsOK0oBqLLppb/v8wnibBzxfAkKl16DIjIosmr7K4O6+6ZfjF8k2L4wubwlz/+x
 rmqPe1z4/dp2P+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E074113A5F;
 Fri, 20 May 2022 11:03:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a+l4NXF1h2JLHgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 20 May 2022 11:03:13 +0000
Date: Fri, 20 May 2022 13:05:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yod19WafdD4AIdrg@yuki>
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220520083627.2499121-1-liwang@redhat.com>
 <20220520083627.2499121-3-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220520083627.2499121-3-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mmap3: reset runtime to 10s
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
> As we have removed the "-x" support from this test, there is no way to
> reduce running time by multiply small float number.

Actually the -x has been replaced by -I so we may as well change the
runtest file to pass -I instead.

On the other hand I guess that the original runtime was way too long for
a default value.

> Let's set 10 seconds for the max_runtime (approximately equal to -x 0.002).

If we are touching the code we may as well pick slightly longer
interval, what about a minute so that we have chance to do some testing
even on slower targets?

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  runtest/mm                           | 2 +-
>  testcases/kernel/mem/mtest06/mmap3.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/runtest/mm b/runtest/mm
> index 6537666a9..4ecb61f24 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -16,7 +16,7 @@ mtest01w mtest01 -p80 -w
>  mtest05   mmstress
>  mtest06   mmap1
>  mtest06_2 mmap2 -x 0.002 -a -p
> -mtest06_3 mmap3 -x 0.002 -p
> +mtest06_3 mmap3 -p
>  # Remains diabled till the infinite loop problem is solved
>  #mtest-6_4 shmat1 -x 0.00005
>  
> diff --git a/testcases/kernel/mem/mtest06/mmap3.c b/testcases/kernel/mem/mtest06/mmap3.c
> index 6d47b01e7..3064f5cf7 100644
> --- a/testcases/kernel/mem/mtest06/mmap3.c
> +++ b/testcases/kernel/mem/mtest06/mmap3.c
> @@ -182,5 +182,5 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.test_all = test_mmap,
> -	.max_runtime = 86400,
> +	.max_runtime = 10,
>  };
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
