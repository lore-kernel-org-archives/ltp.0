Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F8AC83F26
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 14:27:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4621A3CB49F
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 16:27:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 249933C2593
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 16:27:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9605F1400554
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 16:27:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED52821A82;
 Wed, 30 Jul 2025 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753885658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJ5ot7UasHiZJOa6K58DyeHGHUKsBTUcCFrZodlRGTQ=;
 b=wgx6wpwLVFCARAHL05jjAGHRV+6CgEKSmZFI6A2tCCid6aduXW0Uh/ibaSsp903ghaQjJv
 MiCs8+oyuAVSxO/FyZFkJ4CnYvsMQ/zkrr2pfUYTu8Qpd89dweUn2Uk6E0rQnYhsszUSXu
 ly6lBws52FTllsamp9Vk8McrpEcGVd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753885658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJ5ot7UasHiZJOa6K58DyeHGHUKsBTUcCFrZodlRGTQ=;
 b=2LZz7A9nqVF7DS6b7OCnPp/uzK6RsAnURnb1iwimT6k4rEdCSRXFudY/FTBmcqn/byC/+a
 1XVJQjfWt22YEvCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753885657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJ5ot7UasHiZJOa6K58DyeHGHUKsBTUcCFrZodlRGTQ=;
 b=iO/sruDS7pTWmsbQJ9F6u0JsLZTtiEq3BV71NExaSq9MiEpZN6/OmZnaYMgyY+DcTIE/8M
 L2h6hyeRkVGnVSFvWwRYUxZ2hiYvbl+unG+88f75TonX6VoGrL7KWafPqAAO9r8elvUKme
 e67uDoUYXmLlq5Q8gBpyDOPddI1sLf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753885657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJ5ot7UasHiZJOa6K58DyeHGHUKsBTUcCFrZodlRGTQ=;
 b=7wTObsmBv29Vp2VY3nyqNsacPXPxXTrP4mqHsKwXX2St52y0iUoq9gsq26IIiI0WF1tDEm
 FqhVfG+aW2lKC5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D839D1388B;
 Wed, 30 Jul 2025 14:27:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UC2ENNkrimhKTgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 30 Jul 2025 14:27:37 +0000
Date: Wed, 30 Jul 2025 16:28:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aIosCOiW5uVo18Ko@yuki.lan>
References: <20250730-ioctl_pidfd_supported-v4-1-db7bd905a1d6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250730-ioctl_pidfd_supported-v4-1-db7bd905a1d6@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Correctly check if PIDFD_INFO_EXIT is available
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
> When systems are not having the PIDFD_INFO_EXIT implementation,
> ioctl_pidfd testing suite might fail with:
> 
> 	ioctl_pidfd.h:32: TBROK: ioctl(...) failed: ENOTTY (25)
> 
> Fix the ioctl_pidfd_info_exit_supported() behavior, considering ENOTTY,
> EINVAL and ESRCH errors like a sign for not having PIDFD_INFO_EXIT
> implemented in the system.


>  	if (tst_kvercmp(6, 15, 0) >= 0)
> @@ -29,13 +30,24 @@ static inline int ioctl_pidfd_info_exit_supported(void)
>  	pidfd = SAFE_PIDFD_OPEN(pid, 0);
>  	SAFE_WAITPID(pid, NULL, 0);
>  
> -	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, &info);
> -	SAFE_CLOSE(pidfd);
> +	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
> +	if (ret == -1) {
> +		/* - ENOTTY: old kernels not implementing fs/pidfs.c:pidfd_ioctl

Okay that's what we get if there is no ioctl() handler for the pidfs.

> +		 * - EINVAL: until v6.13 kernel

And this is supposedly before PIDFD_GET_INFO was added.

> +		 * - ESRCH: all kernels between v6.13 and v6.15

I suppose what happens between 6.13 and 6.15 is that PIDFD_GET_INFO is
acutally implemented but all the data about the process are gone once it
has been waited for. I was thinking that we could eliminate this branch
if we waited for the process after the ioctl() but we need the actual
process to exit since otherwise the PIFD_INFO_EXIT flag woudln't be set
in the result even if it's supported. Sigh.


So I guess that we cannot make this any simpler.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
