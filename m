Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9756EC5CFEB
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 10:50:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D9013E6CB0
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 12:50:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E6AE3E2551
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 12:50:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98E3360065E
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 12:50:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF5BC3E51;
 Wed, 12 Aug 2026 10:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786531812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mrf7Cw2zIrF9qxP1ztJW2BLUtxjil4W454j1XNPsIiA=;
 b=2efE4J9c9m0sawi94oImbatyxjs54sFE+rQwIkzyCUa9FgPbWseMbgdrK+flrRpMu3vmBC
 9HskCEXUi+GXZq80tWRQ2oQCOD3kkiRd39YaxOLplBX1tb4cSQ1c/Ev2AG25V6+G4Y56GF
 DvWY6Hm+6d6MGgtTSGNsYjP8qADBwWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786531812;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mrf7Cw2zIrF9qxP1ztJW2BLUtxjil4W454j1XNPsIiA=;
 b=An6u3a2/vy7u5KxhjfFOzGo2EV4YrcAB6AAg6M0YVsng2k91oZCl1rM8Pn9QYAmRWO2y9N
 ubrpbZ6+4CqpccBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786531807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mrf7Cw2zIrF9qxP1ztJW2BLUtxjil4W454j1XNPsIiA=;
 b=HSnI56a9bRYtrl8GAZcrfwid/8Wd3rvHblaF9rqtObVhC/nFOBA7mvggQtgbhi7ClgNX8d
 664oUxA3s8x/c+SXxkSHZGXm2cgaOWAi5QvYqfc5k202GWWu7x51pGsjvtT7cDPF1YDqeS
 xJWgw0ov/8DoUbAJtjf7FCvYF6dPiFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786531807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mrf7Cw2zIrF9qxP1ztJW2BLUtxjil4W454j1XNPsIiA=;
 b=kwZt4cJ6LKCHKRuNKdE3FXjpiVPCQ5pWwT3FRPSYxYHE0g1Q6nVTOUObzeKiuqxG+1Nhu2
 VcmGoT2D+iY4fPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1F4A779B1;
 Wed, 12 Aug 2026 10:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Eed5Lt9PfGrbSQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Aug 2026 10:50:07 +0000
Date: Wed, 12 Aug 2026 12:50:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <anxP4sEfKLBtnDH3@yuki.lan>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810160048.1040517-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.986]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/7] tst_kvercmp: Factor out error handling
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
> -int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
> +static int tst_parse_kver_(const char *str_kver, int *v1, int *v2, int *v3)
>  {
>  	const char *str = str_kver;
>  
> @@ -81,17 +81,28 @@ int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
>  	return 0;
>  }

As I said this is changed into static function hence the tst_ prefix
should be dropped.

> -int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3)
> +int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
>  {
> -	int a1, a2, a3;
> -	int testver, currver;
> +	int rc;
> +
> +	rc = tst_parse_kver_(str_kver, v1, v2, v3);
>  
> -	if (tst_parse_kver(cur_kver, &a1, &a2, &a3)) {
> +	if (rc) {
>  		tst_resm(TWARN,
>  			 "Invalid kernel version %s, expected %%d.%%d.%%d",
> -		         cur_kver);
> +		         str_kver);
>  	}
>  
> +	return rc;
> +}
> +
> +int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3)
> +{
> +	int a1, a2, a3;
> +	int testver, currver;
> +
> +	tst_parse_kver(cur_kver, &a1, &a2, &a3);
> +
>  	testver = (r1 << 20) + (r2 << 10) + r3;
>  	currver = (a1 << 20) + (a2 << 10) + a3;
>  
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 9c5f2617fe..a147521e9d 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1067,11 +1067,7 @@ static bool check_kver(const char *min_kver, const int brk_nosupp)
>  	char *msg;
>  	int v1, v2, v3;
>  
> -	if (tst_parse_kver(min_kver, &v1, &v2, &v3)) {
> -		tst_res(TWARN,
> -			"Invalid kernel version %s, expected %%d.%%d.%%d",
> -			min_kver);
> -	}
> +	tst_parse_kver(min_kver, &v1, &v2, &v3);
>  
>  	if (tst_kvercmp(v1, v2, v3) < 0) {
>  		msg = "The test requires kernel %s or newer";
> -- 
> 2.55.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
