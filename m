Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E493C46467
	for <ltp@archiver.kernel.org>; Mon,  2 Jan 2023 12:01:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 510FF3CCEDD
	for <ltp@archiver.kernel.org>; Mon,  2 Jan 2023 13:01:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC7543C2AF4
 for <ltp@lists.linux.it>; Mon,  2 Jan 2023 13:01:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 08D541A0043C
 for <ltp@lists.linux.it>; Mon,  2 Jan 2023 13:01:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 088E2340B2;
 Mon,  2 Jan 2023 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672660894;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c9hRtoaf38FQqRo60mgvRhnz1lO1lqvR5CBWgo77G+8=;
 b=xEGCWxd68yyGn8b0AH08CLJDWC28P+Jgi5FiVaKchxxCGzQ3++JTd3yKsTsOJ9CVlyYqP2
 PKDFgnF+uewlO/eCSZAMwO5xFjahW7+Kr4HYIXhfTEs+Vje3qpBkpJBF/Gw2ywelNeucFy
 EDxKCtbbiGYPa6UdT8Z4Uux/YDA4cnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672660894;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c9hRtoaf38FQqRo60mgvRhnz1lO1lqvR5CBWgo77G+8=;
 b=8HEX7MoKBGRcToEIl0bNFv+B+UdAtW/9b1YXfhD7XZU37GJuSLWX5XQ6UNcShYs1M1w7LS
 fsD4bMdw109AY3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD54F139C8;
 Mon,  2 Jan 2023 12:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QhhwNJ3HsmNLAwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 02 Jan 2023 12:01:33 +0000
Date: Mon, 2 Jan 2023 13:01:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Y7LHnOTNQ4IBikVP@pevik>
References: <1672132813-26636-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1672132813-26636-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1672132813-26636-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] Remove old kernel version check when using
 tst_kvercmp under 3.10
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> We have raised the minimal kernel version from 3.0 to 3.10,
> so remove these useless check.
s/check/checks/

...
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
> index 0014241da..ff372a9bf 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate04.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
> @@ -121,13 +121,8 @@ static void test02(void)
>  			tst_brk(TFAIL | TERRNO,
>  				 "fallocate() or lseek() failed");
>  		}
> -		if (tst_kvercmp(3, 1, 0) < 0) {
> -			tst_res(TINFO, "lseek() doesn't support SEEK_HOLE, "
> -				 "this is expected for < 3.1 kernels");
> -		} else {
> -			tst_brk(TBROK | TERRNO,
> -				 "lseek() doesn't support SEEK_HOLE");
> -		}
> +		tst_brk(TBROK | TERRNO,
> +			"lseek() doesn't support SEEK_HOLE");
This can be on single line.

...
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> index f4bca5ec8..d2d1a882a 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> @@ -247,8 +247,7 @@ static void setup(void)
>  {
>  	msgkey = GETIPCKEY();

> -	if (tst_kvercmp(3, 8, 0) >= 0)
> -		msg_copy_sup = 1;
> +	msg_copy_sup = 1;
msg_copy_sup = 1 should be moved out of setup:

-static int queue_id = -1, msg_copy_sup;
+static int queue_id = -1, msg_copy_sup = 1;

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
