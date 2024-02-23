Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F719C48BC4
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 09:37:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9A2B3CCD58
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 10:37:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E2813CCD58
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 10:37:26 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A28C71400FA6
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 10:37:25 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A206A1F7CE;
 Fri, 23 Feb 2024 09:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708681044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qYlOpLdPIi7Qkr4V0NSYl9RkMqcT/IT5a7pzKmIdPBE=;
 b=vVpDzWfIN+xaaO+ede+Qrs9jsTujFhYVO4PAthxN9/ElU1Ravglu16gMM5eTmt+EmXGHvu
 xaDCmWjaG/dEvj8AmHfLvDUJKscd5pic09zKJiv6dV8JNWW3MvuT0w2dj9tMo3ISOmiUrx
 cjAsEU0oAm45AVzLVZ35z/B3ivQXifs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708681044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qYlOpLdPIi7Qkr4V0NSYl9RkMqcT/IT5a7pzKmIdPBE=;
 b=uHIjZdHq4fvj3/bPusBxqjjjKvP7tojdALAxyGhfLhIJDYrOUBNKBCbrfjFi2U9wRUsTeO
 GmGwPtlo//w738Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708681044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qYlOpLdPIi7Qkr4V0NSYl9RkMqcT/IT5a7pzKmIdPBE=;
 b=vVpDzWfIN+xaaO+ede+Qrs9jsTujFhYVO4PAthxN9/ElU1Ravglu16gMM5eTmt+EmXGHvu
 xaDCmWjaG/dEvj8AmHfLvDUJKscd5pic09zKJiv6dV8JNWW3MvuT0w2dj9tMo3ISOmiUrx
 cjAsEU0oAm45AVzLVZ35z/B3ivQXifs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708681044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qYlOpLdPIi7Qkr4V0NSYl9RkMqcT/IT5a7pzKmIdPBE=;
 b=uHIjZdHq4fvj3/bPusBxqjjjKvP7tojdALAxyGhfLhIJDYrOUBNKBCbrfjFi2U9wRUsTeO
 GmGwPtlo//w738Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F73813776;
 Fri, 23 Feb 2024 09:37:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id nCPYHVRn2GVyQgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 09:37:24 +0000
Date: Fri, 23 Feb 2024 10:37:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240223093718.GD1423688@pevik>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
 <20240220074218.13487-2-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220074218.13487-2-xuyang2018.jy@fujitsu.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vVpDzWfI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uHIjZdHq
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[12.83%]
X-Rspamd-Queue-Id: A206A1F7CE
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/7] libltpswap: alter tst_count_swaps api
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

Hi Yang Xu,

> Like we count the ipc resource total, we can also add a
nit: s/ipc/IPC/

> similar api for swapfiles, so we can use it for swapon03 case.
nit: s/api/API/

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +
> +/*
> + * Get the used swapfiles number
> + */
> +int tst_count_swaps(void)
> +{
> +	FILE *fp;
> +	int used = -1;
> +	char c;
> +
> +	fp = fopen("/proc/swaps", "r");
> +	if (fp == NULL) {
> +		return -1;
Shouldn't we tst_brk(TCONF, "missing /proc/swaps, no swap support?");
This can happen if CONFIG_SWAP is not configured. We have in swapon03.c:

	if (access("/proc/swaps", F_OK))
		tst_brk(TCONF, "swap not supported by kernel");

Once this patchset is solved, I'll add to this code to a function
is_swap_supported in libswap.c, which will be used in all swapo{n,ff}* tests.
(That will be better than require CONFIG_SWAP kconfig.)
Then we can use SAFE_FOPEN() here.

> +	}
> +
> +	while ((c = fgetc(fp)) != EOF) {
> +		if (c == '\n')
> +			used++;
So you read number of lines in /proc/swaps, -1 because file has header.
> +	}
> +
> +	fclose(fp);
Maybe SAFE_FCLOSE() ?

> +	if (used < 0) {
> +		tst_brk(TBROK, "can't read /proc/swaps to get used swapfiles resource total");
> +	}
nit: no need for { }

Kind regards,
Petr

> +
> +	return used;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
