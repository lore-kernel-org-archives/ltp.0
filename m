Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C0FCAC592
	for <ltp@archiver.kernel.org>; Fri, 19 Sep 2025 16:05:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A1903CDD3D
	for <ltp@archiver.kernel.org>; Fri, 19 Sep 2025 18:05:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9C7B3CA299
 for <ltp@lists.linux.it>; Fri, 19 Sep 2025 18:04:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1F33860049E
 for <ltp@lists.linux.it>; Fri, 19 Sep 2025 18:04:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DE4722909;
 Fri, 19 Sep 2025 16:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758297886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnFqeCo79IiFjupO8dGgcPXAhGLX6biONxCOi7MDZkQ=;
 b=cmqRDC0wohuqfVJZFB3YcoeJwLbfqRCUIyKQZNvVqv0UcsTNhXsf2jsRBQZ5+GdAVYx/9T
 hRhwTt0Z9tpvqEzuX5x4ri7Bs0YMxZzEJfghehFWAVKGPIzrxtRbXMftC7JQPfgO2qHnjz
 c42W0Sm2cqEdMRp7uIsDAFE79QQ249g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758297886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnFqeCo79IiFjupO8dGgcPXAhGLX6biONxCOi7MDZkQ=;
 b=cc1teTFDayuEf0NrRB17agSkcpL6+l1HqEM2MpZmY7MaMXahrl5Hl4HlcaM0nLasiBIzNw
 1cifA8PPDIgIJsAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cmqRDC0w;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cc1teTFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758297886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnFqeCo79IiFjupO8dGgcPXAhGLX6biONxCOi7MDZkQ=;
 b=cmqRDC0wohuqfVJZFB3YcoeJwLbfqRCUIyKQZNvVqv0UcsTNhXsf2jsRBQZ5+GdAVYx/9T
 hRhwTt0Z9tpvqEzuX5x4ri7Bs0YMxZzEJfghehFWAVKGPIzrxtRbXMftC7JQPfgO2qHnjz
 c42W0Sm2cqEdMRp7uIsDAFE79QQ249g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758297886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnFqeCo79IiFjupO8dGgcPXAhGLX6biONxCOi7MDZkQ=;
 b=cc1teTFDayuEf0NrRB17agSkcpL6+l1HqEM2MpZmY7MaMXahrl5Hl4HlcaM0nLasiBIzNw
 1cifA8PPDIgIJsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79C4513A39;
 Fri, 19 Sep 2025 16:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ga5jHB5/zWi+SgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Sep 2025 16:04:46 +0000
Date: Fri, 19 Sep 2025 18:05:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: jiaying.song.cn@windriver.com
Message-ID: <aM1_RTDldCgMmajC@yuki.lan>
References: <20250519064955.2061913-1-jiaying.song.cn@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250519064955.2061913-1-jiaying.song.cn@windriver.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 8DE4722909
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/time01:Avoid using TST_RET in time()
 test to support Y2038-safe time_t
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
Sorry for the late reply.

> +        time_t ret_time = time(tloc);        
> +        
> +        ret_time = time(tloc);
>  
> -	TEST(time(tloc));
> -
> -	if (TST_RET == -1) {
> +	if (ret_time == -1) {
>  		tst_res(TFAIL | TTERRNO, "time()");
>  		return;
>  	}
>  
>  	if (!tloc)
> -		tst_res(TPASS, "time() returned value %ld", TST_RET);
> -	else if (*tloc == TST_RET)
> +		tst_res(TPASS, "time() returned value %lld", ret_time);
> +	else if (*tloc == ret_time)
>  		tst_res(TPASS,
> -			"time() returned value %ld, stored value %jd are same",
> -			TST_RET, (intmax_t) *tloc);
> +			"time() returned value %lld, stored value %jd are same",
> +			ret_time, (intmax_t) *tloc);

The ret_time needs a cast, since it's not always long long. Or we can
just use the %jd and cast to (intmax_t) as we do for the tloc argument.

>  	else
>  		tst_res(TFAIL,
> -			"time() returned value %ld, stored value %jd are different",
> -			TST_RET, (intmax_t) *tloc);
> +			"time() returned value %lld, stored value %jd are different",
> +			ret_time, (intmax_t) *tloc);
>  }

Here as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
