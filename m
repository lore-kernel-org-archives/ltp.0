Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1291FC05027
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 05:31:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 172603CB177
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 06:31:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4BBC3CB170
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 06:31:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9EC3260069C
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 06:31:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1AC8B38B2E;
 Mon,  6 Feb 2023 05:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675661497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M/eonmfVsL2YvgxKqpRClz+pnsMyJ+PM7FQTfZ4vswA=;
 b=YwGDgyoqAmQquhAEVqQu9J5Bao4aKViQXsHYKPd7zenlZcs5C1vjjQ7fZSuGzXLDezBWTZ
 DoHjwp6DGpQuZ91XFJ6dzy+hMFNYkZYoICwPbUQN7iWsASIvOCHTfwr44AN+RvDBihMnio
 JkW38Uafxbqj2byXipTRFal8/T3eVIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675661497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M/eonmfVsL2YvgxKqpRClz+pnsMyJ+PM7FQTfZ4vswA=;
 b=TSmPXA0E4TMNDJjOjVo/tzrIP2PimQ8ThJPft34CGJ18co4MMxXaMzNJcz0nMc7xVJAif6
 nz5DH/qUyvnZ24DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE0A213A65;
 Mon,  6 Feb 2023 05:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aZPuOLiQ4GMKLQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Feb 2023 05:31:36 +0000
Date: Mon, 6 Feb 2023 06:31:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y+CQt2SpeMzibUDT@pevik>
References: <20230129183930.2045-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230129183930.2045-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ioctl01.c:Test also struct termios
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

Hi Wei,

> ATM we're testing just legacy struct termio in ioctl01.c,
> we also need test struct termios.

Good idea.

> @@ -64,7 +66,21 @@ static void verify_ioctl(unsigned int i)
>  	if (TST_ERR != tcases[i].error) {
>  		tst_res(TFAIL | TTERRNO,
>  			"failed unexpectedly; expected %s",
> -		        tst_strerrno(tcases[i].error));
> +			tst_strerrno(tcases[i].error));
> +		return;
> +	}
Could you please replace TEST(ioctl(...) with TST_EXP_FAIL(ioctl(...))?
That would save all error handling.

We try to use these helping macros in include/tst_test_macros.h.
Although they would deserve some docs as macros are a bit harder to read.

> +
> +	TEST(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tios));
> +
And obviously here should go TST_EXP_FAIL(ioctl(...)) as well.

Kind regards,
Petr
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "call succeeded unexpectedly");
> +		return;
> +	}
> +
> +	if (TST_ERR != tcases[i].error) {
> +		tst_res(TFAIL | TTERRNO,
> +			"failed unexpectedly; expected %s",
> +			tst_strerrno(tcases[i].error));
>  		return;
>  	}


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
