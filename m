Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26EEC369D1
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 07:44:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92FFD3CB4E6
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 09:44:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9EFA3C0626
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 09:44:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9FE32600846
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 09:44:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75FC4210F9;
 Fri, 25 Apr 2025 07:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745567078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jbK+KdkB5qRxf08R9bXog6nJjgHwj6FOVKQedjNqtPo=;
 b=WrILOzDQopQpD+H5QknR6eRspCl3WeHRwXd3rtH0T9l4zzO8hfMregva7zeannomvHU3Tv
 /lKBkAM0tdWZV8/+5ldvmXwn6N4fQQV+H6Y3O8pmh6Grd2o4WTIlwW8ony2um/jxKx97Jh
 YSm9nz9UcPoTrV9L+WdOE914XHfFiCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745567078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jbK+KdkB5qRxf08R9bXog6nJjgHwj6FOVKQedjNqtPo=;
 b=bAYcS7JuW4is7YPMsEZ8rJQN1OhCs34jMiTSJWxYdJR9dyW+msUKs4o5leVALjlTA3zcdN
 Hb1/tFN3x1XvhLAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745567077;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jbK+KdkB5qRxf08R9bXog6nJjgHwj6FOVKQedjNqtPo=;
 b=ToEkJ031j293fYkQfDKwt/nReAX/PNLqY0jgw5w3dx3YWi7szYRh1rmqII2uW87TUv07mQ
 OkymN5/2iGqGnbjY/LpFehfHqW/8eezQjZN8jnfbxl6QHvpOnDIhnssVxktTYAQCjirepQ
 5Bxt37aQWst/6HlbidhYDWy6mFbu5Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745567077;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jbK+KdkB5qRxf08R9bXog6nJjgHwj6FOVKQedjNqtPo=;
 b=uFs2BQWRvhOx8W7/xaIoyXSc+kBUuOkyBQpqxDAoUWM8U7DONXIbXllJkXLTPqbRaGkl5z
 vIc8Ds9lHJkX9kAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A88113A80;
 Fri, 25 Apr 2025 07:44:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tl1IFWU9C2jOcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Apr 2025 07:44:37 +0000
Date: Fri, 25 Apr 2025 09:44:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250425074435.GA18650@pevik>
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
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
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
Cc: Lu Fei <lufei@uniontech.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh, all,

merged, thank you!

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

>  	SAFE_DUP2(2, nr_open + 1);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
