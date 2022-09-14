Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9615ECAAD8
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:34:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DBC83CAC0A
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 11:34:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1535E3C1C21
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:34:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 19F921000994
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:34:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F84322522;
 Wed, 14 Sep 2022 09:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663148072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ws52QpaZDM0mbwcQYNFoUSA8m2/wzaaF5FCQUeuEd+g=;
 b=oNnfF/Dc7ItmMR1Hr0Zc74TZVigiSpqhwTXoK9MLpxsoY1O6Umqzf8R3rSICfpAEmWYtxj
 maJBDP9aNZGlvNtfbFidSZj+UeDkxp+PcJ6cpQo9g1db3jMVXz+XHkDSY87QZ8blADUEFT
 RtWQxwrQS7BTATqbHaJRqaKnHFH4a2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663148072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ws52QpaZDM0mbwcQYNFoUSA8m2/wzaaF5FCQUeuEd+g=;
 b=LLogxLzF+jLiqNASB+e1wP0sO5DuG/7EUldBjMJ8YFHi1z/8/O4yyD7e4GVIvzz0t4LsDt
 lXn47e7ibGkI1iBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D2BE134B3;
 Wed, 14 Sep 2022 09:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ayp6GSigIWNmLQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 14 Sep 2022 09:34:32 +0000
Date: Wed, 14 Sep 2022 11:36:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyGgnY1e+CD2p9ws@yuki>
References: <20220913151907.26763-1-mdoucha@suse.cz>
 <20220913151907.26763-3-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220913151907.26763-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] Make io_read() runtime-aware
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
> diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> index 88aec7952..595c76226 100644
> --- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> +++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> @@ -188,7 +188,6 @@ static void cleanup(void)
>  static void run(void)
>  {
>  	char *filename = "file.bin";
> -	int status;
>  	int i, pid;
>  
>  	*run_child = 1;
> @@ -222,12 +221,10 @@ static void run(void)
>  		}
>  	}
>  
> -	if (SAFE_WAITPID(-1, &status, WNOHANG))
> -		tst_res(TFAIL, "Non zero bytes read");
> -	else
> -		tst_res(TPASS, "All bytes read were zeroed");
> -
>  	*run_child = 0;
> +
> +	if (!tst_validate_children(numchildren))
> +		tst_res(TPASS, "All bytes read were zeroed");

This actually breaks the test, have a look at the io_read() in common.h.
The code is written so that the child exits with zero if we find
non-zero bytes so the only way how to actually report a failure is to
check if any of the children did exit before we set the run_child to
zero.

Looking at the code closer the break actually breaks only the inner
for () loop, so it looks like the code was broken and is stil broken. I
guess that we should do return instead of break as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
