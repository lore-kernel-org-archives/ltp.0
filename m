Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867CCC35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 13:34:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C7EE3CF32D
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 14:34:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2D213C8B9E
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 14:34:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A5A55204B49
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 14:34:07 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6536921114;
 Mon, 18 Dec 2023 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702906446;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNuMGvJLkbJGKtExFcLdiotszavBAwCRxEI14Y6xGwA=;
 b=kgcx7tigqgjgACYUVJ3MGgynq266dm7YP/S/xufnNHyL+9RwebchlVmNe8KtCMWrAPYxag
 zG8lzllZbd12znCvB7/4Rs/QMNrOqp1rUu76WMPB7V27N8brB11I58HGbMaWT5pNoNI1R+
 OwyTnXGX6ShkF9CgZAEv5CR0/RnlTDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702906446;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNuMGvJLkbJGKtExFcLdiotszavBAwCRxEI14Y6xGwA=;
 b=9QVGIDtxKP7mENL2IA2CbdbqvOZMBLhk1DN11IDsDlsuXzDOlHl+RMipY/Faa4qvzbI0q2
 O7PKTlem9Y6MV2DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702906446;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNuMGvJLkbJGKtExFcLdiotszavBAwCRxEI14Y6xGwA=;
 b=kgcx7tigqgjgACYUVJ3MGgynq266dm7YP/S/xufnNHyL+9RwebchlVmNe8KtCMWrAPYxag
 zG8lzllZbd12znCvB7/4Rs/QMNrOqp1rUu76WMPB7V27N8brB11I58HGbMaWT5pNoNI1R+
 OwyTnXGX6ShkF9CgZAEv5CR0/RnlTDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702906446;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNuMGvJLkbJGKtExFcLdiotszavBAwCRxEI14Y6xGwA=;
 b=9QVGIDtxKP7mENL2IA2CbdbqvOZMBLhk1DN11IDsDlsuXzDOlHl+RMipY/Faa4qvzbI0q2
 O7PKTlem9Y6MV2DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 496E113BC8;
 Mon, 18 Dec 2023 13:34:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 1+N5EE5KgGURXgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 18 Dec 2023 13:34:06 +0000
Date: Mon, 18 Dec 2023 14:34:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231218133404.GB199735@pevik>
References: <20231214071321.9863-1-wegao@suse.com>
 <20231218122236.24917-1-wegao@suse.com>
 <20231218122236.24917-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231218122236.24917-3-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kgcx7tig;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9QVGIDtx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.08 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.37)[90.64%]
X-Rspamd-Queue-Id: 6536921114
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] swapping01.c: Reporting /proc/meminfo
 during test
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

> Get clear overview memory status during test is good for debug, such as
> get report before the test and also at the moment of the failure.

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/mem/swapping/swapping01.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
> index fc225e4a6..025f44363 100644
> --- a/testcases/kernel/mem/swapping/swapping01.c
> +++ b/testcases/kernel/mem/swapping/swapping01.c
> @@ -83,7 +83,9 @@ static void test_swapping(void)

>  	switch (pid = SAFE_FORK()) {
>  	case 0:
> +		TST_PRINT_MEMINFO();
>  		do_alloc(0);
> +		TST_PRINT_MEMINFO();
Developer asked you to print /proc/meminfo "before the test starts and at the
moment of the failure" Wouldn't be just this second TST_PRINT_MEMINFO() enough?

Kind regards,
Petr

>  		do_alloc(1);
>  		exit(0);
>  	default:
> @@ -138,6 +140,7 @@ static void check_swapping(void)
>  		swap_free_now = SAFE_READ_MEMINFO("SwapFree:");
>  		sleep(1);
>  		long diff = labs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:"));
> +
>  		if (diff < 10)
>  			break;

> @@ -146,6 +149,7 @@ static void check_swapping(void)

>  	swapped = SAFE_READ_PROC_STATUS(pid, "VmSwap:");
>  	if (swapped > mem_over_max) {
> +		TST_PRINT_MEMINFO();
>  		kill(pid, SIGCONT);
>  		tst_brk(TFAIL, "heavy swapping detected: "
>  				"%ld MB swapped.", swapped / 1024);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
