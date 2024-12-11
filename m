Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D34E7717F
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 00:11:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D9603E947B
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 01:11:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF45C3E9465
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 01:11:10 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5386D24C4AF
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 01:11:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 99232210F7;
 Wed, 11 Dec 2024 00:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733875868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8OyKmFfxZHiQXyNUKRq4u87WOIQQWVO5FWAZbHGqGM=;
 b=aRAm/OORtlT7QwFtmXC7u6GeoAx2QggYbHGASZegzSP5r9G/peREzZujZtABuHiozpumOo
 6Rns8KkGyR8MdSK20UimOs3eFL9cV9sQd6Ej4RtjX+UobOmlj9fc+yPEsx6h+5/lAnUC1L
 R5okwNjavQvAWpqlIXFFdufBVvXheaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733875868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8OyKmFfxZHiQXyNUKRq4u87WOIQQWVO5FWAZbHGqGM=;
 b=5BQixa65vBs061W08yUDFbQEQlDVDe69mEyEh3Z+GoDYHUIF4+hHnlUHLYvUnh8jFAOLQF
 clmqlnBYBClMKRCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="aRAm/OOR";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5BQixa65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733875868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8OyKmFfxZHiQXyNUKRq4u87WOIQQWVO5FWAZbHGqGM=;
 b=aRAm/OORtlT7QwFtmXC7u6GeoAx2QggYbHGASZegzSP5r9G/peREzZujZtABuHiozpumOo
 6Rns8KkGyR8MdSK20UimOs3eFL9cV9sQd6Ej4RtjX+UobOmlj9fc+yPEsx6h+5/lAnUC1L
 R5okwNjavQvAWpqlIXFFdufBVvXheaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733875868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8OyKmFfxZHiQXyNUKRq4u87WOIQQWVO5FWAZbHGqGM=;
 b=5BQixa65vBs061W08yUDFbQEQlDVDe69mEyEh3Z+GoDYHUIF4+hHnlUHLYvUnh8jFAOLQF
 clmqlnBYBClMKRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B1931344A;
 Wed, 11 Dec 2024 00:11:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xIVSF5zYWGd2PAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Dec 2024 00:11:08 +0000
Date: Wed, 11 Dec 2024 01:11:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241211001106.GE386508@pevik>
References: <20241203151530.16882-1-chrubis@suse.cz>
 <20241203151530.16882-5-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241203151530.16882-5-chrubis@suse.cz>
X-Rspamd-Queue-Id: 99232210F7
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] lib/tst_res_.c: Add TBROK handler + more
 verbose errors
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

> We use the tst_res_ helper for tst_brk_ as well so we need to be able to
> handle TBROK type as well.

How can we call tst_brk_() via tst_res_() ?
	tst_res_(argv[1], atoi(argv[2]), type, "%s", msg);

Also we have TST_RES_SUPPORTS_TCONF_TDEBUG_TFAIL_TINFO_TPASS_TWARN check to not
add TBROK to tst_res_().

...
> -	else if (!strcmp(argv[3], "TINFO"))
> +	} else if (!strcmp(argv[3], "TINFO")) {
>  		type = TINFO;
> -	else if (!strcmp(argv[3], "TDEBUG"))
> +	} else if (!strcmp(argv[3], "TDEBUG")) {
>  		type = TDEBUG;
> -	else
> +	} else if (!strcmp(argv[3], "TBROK")) {
> +		type = TBROK;
> +	} else {
> +		printf("Wrong type '%s'\n", argv[3]);
>  		goto help;

Also tst_brk allows only TBROK and TCONF in C:

#define tst_brk(ttype, arg_fmt, ...)						\
	({									\
		TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(!((ttype) &			\
			(TBROK | TCONF | TFAIL)));				\
		tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
	})

... and shell:

	if [ "$res" != TBROK -a "$res" != TCONF ]; then
		tst_res TBROK "tst_brk can be called only with TBROK or TCONF ($res)"
	else
		tst_res "$res" "$@"
	fi

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
