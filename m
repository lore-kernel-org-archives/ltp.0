Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3995AC369AB
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 11:05:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A29383CB315
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 13:05:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CF4F3CB2EC
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 13:05:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 794C220038B
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 13:05:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7EAC91F44E;
 Thu, 24 Apr 2025 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745492702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WxDOmrXcYPpHqPBsi5cJIzNnSHfyuSVhuBJSZ8XkcTY=;
 b=ybBYTzv6XOb5pS1L6hMohcGO3FJrsIWut+s6bS5cv4qywumbdqa69inQYeYEyA4GO+maT9
 YMWm3tibJxmx6jG8Hx9/thQt1qdqG2VMqj+9qPuTSg7drqCWhy0qvOhEIw6lqfDyQLKoYe
 rONtZYKhL7JYmwhmdUBO5XMAQ1X9Xt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745492702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WxDOmrXcYPpHqPBsi5cJIzNnSHfyuSVhuBJSZ8XkcTY=;
 b=OBu7oFHlWm1DnL86Sqsuh/2brEgO5J3Tuymi69H4kAzg+urhV/LE2i7tiHajh7gt19WpGd
 WR3B2EvVzgAtEeBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745492702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WxDOmrXcYPpHqPBsi5cJIzNnSHfyuSVhuBJSZ8XkcTY=;
 b=ybBYTzv6XOb5pS1L6hMohcGO3FJrsIWut+s6bS5cv4qywumbdqa69inQYeYEyA4GO+maT9
 YMWm3tibJxmx6jG8Hx9/thQt1qdqG2VMqj+9qPuTSg7drqCWhy0qvOhEIw6lqfDyQLKoYe
 rONtZYKhL7JYmwhmdUBO5XMAQ1X9Xt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745492702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WxDOmrXcYPpHqPBsi5cJIzNnSHfyuSVhuBJSZ8XkcTY=;
 b=OBu7oFHlWm1DnL86Sqsuh/2brEgO5J3Tuymi69H4kAzg+urhV/LE2i7tiHajh7gt19WpGd
 WR3B2EvVzgAtEeBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56CC7139D0;
 Thu, 24 Apr 2025 11:05:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f2uEEN4aCmi9NQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 24 Apr 2025 11:05:02 +0000
Date: Thu, 24 Apr 2025 13:04:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250424110456.GA1078321@pevik>
References: <20250424105536.21645-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250424105536.21645-1-akumar@suse.de>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.de:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unshare03: use sizeof(long long) to fix for 32bit
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

Hi Avinesh,

> when executing on 32bit compat layer
> "nr_open = sizeof(long) * 8" does not evaluate to a large enough value
> for /proc/sys/fs/nr_open.
> unshare03.c:38: TBROK: Failed to close FILE '/proc/sys/fs/nr_open': EINVAL (22)
> Use (long long) instead.

> Fixes: fc8be6ed4 ("unshare03: Simplify EMFILE test by using fixed fd limit (sizeof(long) * 8)")
> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/unshare/unshare03.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
> index c3b98930d..7128b3b97 100644
> --- a/testcases/kernel/syscalls/unshare/unshare03.c
> +++ b/testcases/kernel/syscalls/unshare/unshare03.c
> @@ -27,7 +27,7 @@ static void run(void)
>  		.exit_signal = SIGCHLD,
>  	};

> -	int nr_open = sizeof(long) * 8;
> +	int nr_open = sizeof(long long) * 8;

Thank you!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
