Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FD9C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 15:48:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 430123D3838
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:48:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DDB73CBB49
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 17:47:58 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 435E6601931
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 17:47:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 875E9219CD;
 Wed, 10 Jul 2024 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720626475;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kgINZDgL6B0NKEDX31hhE9rvlZK2bd2SvOs3XXde0H4=;
 b=zCEBCCMZjbuznYyVkZ3H3bmLeucdY2WoPZMFwNOlklWdkOJx0vsoxfeeC9QqByzGLF7jgj
 zAzuf935AkACR8ZawGs62AO0e4ySO/vBcQsvR9gmAwfM5za07zDIA7WJ+EwQFNiBD0K4qu
 40cd0SgzLeYtjpPfUOQCexCI55isNmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720626475;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kgINZDgL6B0NKEDX31hhE9rvlZK2bd2SvOs3XXde0H4=;
 b=IVD7rV7iyzur/YheBuHdW6D2qYQciAQyX6BUUDuNw91Q6Mwq2RYpqusNy80gevbr6dcXaz
 +nMgDDPaOqrM3gBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zCEBCCMZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IVD7rV7i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720626475;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kgINZDgL6B0NKEDX31hhE9rvlZK2bd2SvOs3XXde0H4=;
 b=zCEBCCMZjbuznYyVkZ3H3bmLeucdY2WoPZMFwNOlklWdkOJx0vsoxfeeC9QqByzGLF7jgj
 zAzuf935AkACR8ZawGs62AO0e4ySO/vBcQsvR9gmAwfM5za07zDIA7WJ+EwQFNiBD0K4qu
 40cd0SgzLeYtjpPfUOQCexCI55isNmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720626475;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kgINZDgL6B0NKEDX31hhE9rvlZK2bd2SvOs3XXde0H4=;
 b=IVD7rV7iyzur/YheBuHdW6D2qYQciAQyX6BUUDuNw91Q6Mwq2RYpqusNy80gevbr6dcXaz
 +nMgDDPaOqrM3gBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39403137D2;
 Wed, 10 Jul 2024 15:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s/fOCSutjmaXVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 10 Jul 2024 15:47:55 +0000
Date: Wed, 10 Jul 2024 17:47:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240710154753.GA300896@pevik>
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-4-58e9af649a72@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240701-landlock-v1-4-58e9af649a72@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 875E9219CD
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/10] Add SAFE_PRCTL macro
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

Hi Andrea, Li,

...
> +int safe_prctl(const char *file, const int lineno,
> +	int option, unsigned long arg2, unsigned long arg3,
> +	unsigned long arg4, unsigned long arg5)
> +{
> +	int rval;
> +
> +	rval = prctl(option, arg2, arg3, arg4, arg5);
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"prctl(%d, %lu, %lu, %lu, %lu)",
> +			option, arg2, arg3, arg4, arg5);
If I understand man prctl(2) correctly, valid values are >= 0, -1 is for error.
Shouldn't we check for invalid return value, e.g. else if (rval < 0) should
TBROK (see other uses safe_dup)? If yes, this applies to landlock SAFE_* macros
as well.

Also, some modes are for new kernels: PR_SET_IO_FLUSHER (since Linux 5.6), but I
would solve it once needed.

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +	}
> +
> +	return rval;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
