Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2D4C6FA8F
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 11:51:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0417A3CE045
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 13:51:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 469F03C6D29
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 13:51:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 916371A010ED
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 13:51:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA09221852;
 Wed, 30 Aug 2023 11:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693396274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkY+67tpv/EouGa45nx1DMrNCfkHb2IWZvARpp3sz1k=;
 b=o/si3A3O7CoOq15n2gOgoj/zQNQrfvWOlGNSulvYeVO0V/3V1ido07bIJ8+OEE5UUNdfCA
 UD0snqJ8LdSVJNS6JoJNSf9G3SmVvkNtzUYi9gqTYpD8FjIy/NNDzZ0su0fBFMlsHwNQ8b
 MSfdlNhCSFzBwkrRQlS+vmV/tvWuQ/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693396274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkY+67tpv/EouGa45nx1DMrNCfkHb2IWZvARpp3sz1k=;
 b=WekXG1KHxVCoyeSXtuWUuDE+/pJY3Mghsng77Jx6LPcquX/MoIhlamm3f4POQk6jAjKXfC
 O8/EZD4hD3Om5aAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C9C81353E;
 Wed, 30 Aug 2023 11:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id n6t4ADIt72RGMgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 30 Aug 2023 11:51:14 +0000
Date: Wed, 30 Aug 2023 13:50:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZO8tHUJFMyBFNo_r@rei>
References: <20230824074406.1129-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230824074406.1129-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] syscalls/mmap05: Rewrite the test using new
 LTP API
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
Pushed with two minor changes, thanks.

> +static void sig_handler(int sig)
>  {
> +	if (sig == SIGSEGV) {
> +		sig_flag = 1;
> +		siglongjmp(env, 1);
> +	} else
> +		tst_brk(TBROK, "Received an unexpected signal: %d", sig);

I've removed this else branch since tst_brk() unlike tst_res() is not
async-signal-safe since tst_brk() calls exit.

>  }
>  
>  static void setup(void)
>  {
> -	char *tst_buff;
> -
> -	tst_sig(NOFORK, sig_handler, cleanup);
> +	char *buf;
>  
> -	TEST_PAUSE;
> +	SAFE_SIGNAL(SIGSEGV, sig_handler);
>  
>  	page_sz = getpagesize();
> +	buf = SAFE_CALLOC(page_sz, sizeof(char));

And changed this to SAFE_MALLOC(page_sz); since sizeof(char) == 1 by
definition.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
