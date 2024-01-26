Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC800C47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 14:13:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91CB03D0612
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 15:13:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28BFA3D060A
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:13:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9B8B860128A
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:13:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CCBA021E89;
 Fri, 26 Jan 2024 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706278407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KgFnWLDIfkhFcgqnOWljklVl41i/wjMygFmvYhvgfSI=;
 b=L30ayN39R32wWlweqmcW/75eT1RzHIj8MpI7fY1QAhQFHbWBMwD/5PirUjusEwQIMzmimW
 GUnp8esfeH5QYBrPxqbLG1NDMy6Rlll0HgGhWjlugucA4gVdnYS17uEDTKVCpEp6sCp9fT
 L4jp+1T6wO6aq3kvggEQ7BdK88iUh70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706278407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KgFnWLDIfkhFcgqnOWljklVl41i/wjMygFmvYhvgfSI=;
 b=MGlL2DLr64AlgWXia/5JR4Lnj2doajPQmiPUkYQisaOFdQUkbFrmsJo6PjbrXBIGdvhN8w
 LngXkYlt+TIvEzDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706278406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KgFnWLDIfkhFcgqnOWljklVl41i/wjMygFmvYhvgfSI=;
 b=jW8h5dWRgF5axKcEfSxAi/uoJh2zJ4DXF3jVSka4dDQ1GEvp7grPNNoQGF4dlb5mWWjyzq
 EhnvUTiHMM1s3YQKoSnjNUHfNBPmqqpj4MpHbSgWXuigr43VmiNQ6zt8Pq6uL+hMRPrnsC
 pMWGEU0cacKxYOOQfezq02Esj1LCTyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706278406;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KgFnWLDIfkhFcgqnOWljklVl41i/wjMygFmvYhvgfSI=;
 b=yMXTovjFhW3Foj2YjIOgjVhxX5n8Kydp+96WS+mCviLb7244AJtvHJ1AT/hOHvbxK/aVPP
 RmHBnEwB7vh10oCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADE6B13A22;
 Fri, 26 Jan 2024 14:13:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6fViKga+s2UmbAAAD6G6ig
 (envelope-from <jack@suse.cz>); Fri, 26 Jan 2024 14:13:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 88487A0805; Fri, 26 Jan 2024 15:13:25 +0100 (CET)
Date: Fri, 26 Jan 2024 15:13:25 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240126141325.zmusgsdxbchlgond@quack3>
References: <20240126121603.500470-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240126121603.500470-1-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.67 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.07)[62.88%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] splice07: Whitelist /dev/zero on pipe write
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri 26-01-24 13:16:03, Petr Vorel wrote:
> /dev/zero on pipe write started to succeeded on kernel 6.7.
> 
> This is due commit 1b057bd800c3 ("drivers/char/mem: implement splice()
> for /dev/zero, /dev/full") from kernel 6.7.
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Yeah, makes sense to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes v1->v2:
> * Skip only for kernel >= 6.7
> 
>  testcases/kernel/syscalls/splice/splice07.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
> index 135c42e47..c7b1c9ee5 100644
> --- a/testcases/kernel/syscalls/splice/splice07.c
> +++ b/testcases/kernel/syscalls/splice/splice07.c
> @@ -44,6 +44,10 @@ static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
>  		/* And this complains about socket not being connected */
>  		case TST_FD_INET_SOCK:
>  			return;
> +		/* 1b057bd800c3 implemented splice() for /dev/zero, /dev/full */
> +		case TST_FD_DEV_ZERO:
> +			if (tst_kvercmp(6, 7, 0) >= 0)
> +				return;
>  		default:
>  		break;
>  		}
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
