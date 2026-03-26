Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E436710A1E60
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 10:43:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E8823C7A5F
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:43:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00C8D3C3212
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:43:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9097B60082C
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:43:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D45964D27F;
 Thu, 26 Mar 2026 10:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774521816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUn6L5+kCfKpvwkTi1+iK/2VPWoZkG8uvQ5tB+/ecCk=;
 b=zKcBmlCu3DjgDFUjOiqH6BwWFA/1ZpbqBNZEjUV9AtoF3mBnAgQmE7lVyaRKA2oMBwD980
 A2hZZBs6n8/wVi2XVQzXYQ1+8AjdvZhZmRituC3HUzAG0g+SQsbE0y1eHYcbvIIQ6nLLdl
 xhskXeThx2Fg3ikCbodZBwHAMqzUBc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774521816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUn6L5+kCfKpvwkTi1+iK/2VPWoZkG8uvQ5tB+/ecCk=;
 b=PGNtUdZByOupHEUIX1kW5RblCHqGm2+DwkszkksI+dTxMJbdetol/TC6D8i4ioTCT0Y6/W
 Bz03KMfXsp1d4cAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zKcBmlCu;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PGNtUdZB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774521816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUn6L5+kCfKpvwkTi1+iK/2VPWoZkG8uvQ5tB+/ecCk=;
 b=zKcBmlCu3DjgDFUjOiqH6BwWFA/1ZpbqBNZEjUV9AtoF3mBnAgQmE7lVyaRKA2oMBwD980
 A2hZZBs6n8/wVi2XVQzXYQ1+8AjdvZhZmRituC3HUzAG0g+SQsbE0y1eHYcbvIIQ6nLLdl
 xhskXeThx2Fg3ikCbodZBwHAMqzUBc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774521816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUn6L5+kCfKpvwkTi1+iK/2VPWoZkG8uvQ5tB+/ecCk=;
 b=PGNtUdZByOupHEUIX1kW5RblCHqGm2+DwkszkksI+dTxMJbdetol/TC6D8i4ioTCT0Y6/W
 Bz03KMfXsp1d4cAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BCA64A0A6;
 Thu, 26 Mar 2026 10:43:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wWTBC9gNxWm7OwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 26 Mar 2026 10:43:36 +0000
Date: Thu, 26 Mar 2026 11:43:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260326104326.GB144321@pevik>
References: <20260226022536.20175-1-wegao@suse.com>
 <20260323060846.4675-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260323060846.4675-1-wegao@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: D45964D27F
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mseal02: Handle multiple errnos for 32-bit
 compat mode
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

Hi all,

> +++ b/testcases/kernel/syscalls/mseal/mseal02.c
> @@ -29,20 +29,22 @@ static struct tcase {
>  	size_t *len;
>  	unsigned long flags;
>  	int exp_err;
> +	int compat_err;
>  } tcases[] = {
> -	{&start_addr, &page_size, ULONG_MAX, EINVAL},
> -	{&unaligned_start_addr, &page_size, 0, EINVAL},
> -	{&start_addr, &overflow_size, 0, EINVAL},
> -	{&unallocated_start_addr, &twopages_size, 0, ENOMEM},
> -	{&unallocated_end_addr, &twopages_size, 0, ENOMEM},
> -	{&start_addr, &fourpages_size, 0, ENOMEM},
> +	{.addr = &start_addr, .len = &page_size, .flags = ULONG_MAX, .exp_err = EINVAL},
> +	{.addr = &unaligned_start_addr, .len = &page_size, .flags = 0, .exp_err = EINVAL},
> +	{.addr = &start_addr, .len = &overflow_size, .flags = 0, .exp_err = EINVAL, .compat_err = ENOMEM},
> +	{.addr = &unallocated_start_addr, .len = &twopages_size, .flags = 0, .exp_err = ENOMEM},
> +	{.addr = &unallocated_end_addr, .len = &twopages_size, .flags = 0, .exp_err = ENOMEM},
> +	{.addr = &start_addr, .len = &fourpages_size, .flags = 0, .exp_err = ENOMEM},

FYI I remove useless .flags = 0, in following commit.
55e16df13a ("mseal02: Remove useless zero initialization")
(The default zero initialization can shorten code in some cases.)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
