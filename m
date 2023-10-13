Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F34CDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 12:24:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D90C73CF035
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 14:24:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D52823CD3BE
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 14:24:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5E36B60042D
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 14:24:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A2C1219F3
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697199850;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBxqLDoTNxbFm+WF2EwmJqmqtkTdN1RVPX2PAWJNQ0Y=;
 b=NNBeLfdEyiEntXP3kimK17rbU95Y+S6pw2gA7AKLTx5/x8WX3KVRe/oIXp5ZE6CYtsEruc
 mgqJP99e5/QGi4VkD+gNcuwvFRobv8Kvf4BICOcn4ca9pA8ovDns8JqOF9Ieuh4HV/5EGL
 drRKUkaVY6k4cCwfRQCrvAxbW63WMTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697199850;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBxqLDoTNxbFm+WF2EwmJqmqtkTdN1RVPX2PAWJNQ0Y=;
 b=8GFnepYDu/c8rMxNPAN9SCyAxQH9dCGEKZdZ6rcOiLzhbxdzwXnE33eB2i/xg3Q6LikF6q
 3DobOEBRDgYVPZBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25A6E1358F
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 12:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C30zCOo2KWWkbwAAMHmgww
 (envelope-from <pvorel@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 12:24:10 +0000
Date: Fri, 13 Oct 2023 14:24:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20231013122408.GB733568@pevik>
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231013074748.702214-2-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] tst_kernel: Add safe_check_driver()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

...
>  int tst_check_driver(const char *driver);

> +/*
> + * Checks support for the kernel module (both built-in and loadable)
> + * and exit with TCONF if driver not available.
> + *
> + * @param driver The name of the driver.
> + * On Android it *always* passes (always expect the driver is available).
> + */
> +void safe_check_driver(const char *driver);

In the end, I haven't used this function in the second commit,
thus this function is useless (used only on single place).
I'll remove it in v2 (still waiting for more input if whole .modprobe option is
worth of merging).

Kind regards,
Petr

> +
>  #endif	/* TST_KERNEL_H__ */
> diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
> index 4b75ceadb..de4c28308 100644
> --- a/lib/tst_kernel.c
> +++ b/lib/tst_kernel.c
> @@ -198,3 +198,9 @@ int tst_check_driver(const char *driver)

>  	return -1;
>  }
> +
> +void safe_check_driver(const char *driver)
> +{
> +	if (tst_check_driver(driver))
> +		tst_brkm(TCONF, NULL, "%s driver not available", driver);
> +}
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index c2f8f503f..087c62a16 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1191,8 +1191,7 @@ static void do_setup(int argc, char *argv[])
>  		int i;

>  		for (i = 0; (name = tst_test->needs_drivers[i]); ++i)
> -			if (tst_check_driver(name))
> -				tst_brk(TCONF, "%s driver not available", name);
> +			safe_check_driver(name);
>  	}

>  	if (tst_test->mount_device)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
