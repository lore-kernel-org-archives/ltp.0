Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2AE10D14B4
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 13:33:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 249FD3E54ED
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 15:33:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 268AE3CC619
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 15:33:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 94D8C60070C
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 15:33:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D639F4D22D;
 Mon, 30 Mar 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774877592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qZL6UG7pC58oWtz2y9KunnLVYXwr6hjUB9btOEne0M=;
 b=R2g4rEhAnVCzVEW0LAGjkpLuDEfJIWoz8bv4oXAowBxChLVpVmF2t8WNLSh5nCRRjhSmkX
 eTeFRssMdMrApgzRN2KXrQM23I2Dc32/oJ49ZFgB3n2TCVEp0FgpUfdSRHdAaU5UF53gaS
 21hGICckFqfJ3ksuXWKMtxLhFGtOGes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774877592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qZL6UG7pC58oWtz2y9KunnLVYXwr6hjUB9btOEne0M=;
 b=CifrAQri0R2UBfxbV0folhRIAne8ayaY+6JfTpCLMO1cjRU4NIxZzqQbMZPVYMXpX0RVuF
 YW+UDdGT5IHCg1Aw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="haj/pZ5L";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="fyN/gXXl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774877591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qZL6UG7pC58oWtz2y9KunnLVYXwr6hjUB9btOEne0M=;
 b=haj/pZ5LB1/St/w2fKk5UoQ+eGe5jBYzRSvgyhhRvUkqLPyJ7MapJ5CoV8xKZGuchXKc8c
 8WmNhwDMcQg/vJ8BS4wuecQcTBV9/3i+yv3prAqQDP5RE9vsbVvdMI+GDPffGlVziBNX30
 +EtqZNfWeSYxKg1ZrGkb7KUzGXF7pZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774877591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qZL6UG7pC58oWtz2y9KunnLVYXwr6hjUB9btOEne0M=;
 b=fyN/gXXlhE7iTwoLlnAV30ivAkNGLPUVJ1YHNCxRAOpQnRmLgFRKSvV59rgELRbTq7ecpV
 OHY/tCMMCAttMMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FEEF4A0A2;
 Mon, 30 Mar 2026 13:33:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gVfcGZd7ymkHIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 30 Mar 2026 13:33:11 +0000
Date: Mon, 30 Mar 2026 15:33:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Message-ID: <20260330133304.GA93779@pevik>
References: <20260330100750.858390-1-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260330100750.858390-1-vasileios.almpanis@virtuozzo.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: D639F4D22D
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pidns32: fix PID namespace nesting depth
 off-by-one
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

Hi Vasileios,

> The 2023 refactor used tst_atomic_inc() before clone with a zero-initial
> counter, which only performed 31 CLONE_NEWPID nests while still expecting
> MAXNEST (32). Compare the level to MAXNEST first, then increment and clone,
> so the shared counter runs 0..32 and the chain reaches 32 nested namespaces
> again.

Indeed, good catch.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Fixes: 647cfd468c3b ("Refactor pidns32 test using new LTP API")
> Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
> ---
>  testcases/kernel/containers/pidns/pidns32.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
> index fc9bf0aaa..3a272f569 100644
> --- a/testcases/kernel/containers/pidns/pidns32.c
> +++ b/testcases/kernel/containers/pidns/pidns32.c
> @@ -27,9 +27,11 @@ static pid_t child_func(void)
>  {
>  	pid_t cpid = 0;

> -	if (tst_atomic_inc(level) == MAXNEST)
> +	if (tst_atomic_load(level) == MAXNEST)
>  		return cpid;

> +	tst_atomic_inc(level);
> +
>  	cpid = SAFE_CLONE(&args);
>  	if (!cpid) {
>  		child_func();

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
