Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49AFC4167B
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 19:07:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24FFD3CD8F8
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 20:07:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16C3C3CB2AC
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 20:07:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3BBEA208D3F
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 20:07:29 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F40BF1F848;
 Fri, 15 Dec 2023 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702667249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tp9LedwvAiPwjSDfGOPKcYkCS5/jnkaRriIR5Gzyxs=;
 b=Hamc2BrP57wepmJ9i5irPfi0LE7lpgkJjg0ZOrOKb/Y8OUH2h20ylrf8LT/lmksNzQxN5M
 R7/Tbjdjq9mlvqhzz4XA5px17IRrqTptgSORJlLHhvHVLRsJEZO0PxnzYoYhamweJuuWKe
 +lzK2Q+vUPRXeWp4TIvILdacNvlHW20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702667249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tp9LedwvAiPwjSDfGOPKcYkCS5/jnkaRriIR5Gzyxs=;
 b=67xhgV7nc/hBqTwkYukI5mKSGrt+7e5OGAPsTRNYtJeM4absSaLe/fXpz0ka9B/SynOylI
 uAJ61+bVmf9hqXCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702667247;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tp9LedwvAiPwjSDfGOPKcYkCS5/jnkaRriIR5Gzyxs=;
 b=phNzZprlMBTO+iVdZjrJN3thZ5jnn22V1rg13cDwXFIBfBbV+GzmULv406tc51GR7TV46P
 +9jXd68U/rSylUcD72LxbzXA5/L6/MOUCRWQU2cqqllN+w7w0UG7Q1EwJwRXgzdjdApSXT
 UyDzRy7gcHO3xonc9la/bD/LSDB6Pjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702667247;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tp9LedwvAiPwjSDfGOPKcYkCS5/jnkaRriIR5Gzyxs=;
 b=GDZ9piGklCqxm+Cp1qVrO7nQmp/hyGkGSP2Q91sHOZh/IbHJoamGzn+9/ux0GW4oTaXL3D
 SMtGjVvQ/cNPSbDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C951C13912;
 Fri, 15 Dec 2023 19:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id mPI7L+6jfGWdNwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 15 Dec 2023 19:07:26 +0000
Date: Fri, 15 Dec 2023 20:07:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231215190725.GA67360@pevik>
References: <20231031132756.12799-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231031132756.12799-1-chrubis@suse.cz>
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[wipro.com:email,suse.cz:email,nokia.com:email]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[14.37%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/sched_rr_get_interval: Convert to
 docparse
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

Hi Cyril,


> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  .../sched_rr_get_interval01.c                 | 19 +++++++++++++++---
>  .../sched_rr_get_interval02.c                 |  3 +++
>  .../sched_rr_get_interval03.c                 | 20 ++++++++++++-------
>  3 files changed, 32 insertions(+), 10 deletions(-)

> diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> index 597de4665..520f44fe0 100644
> --- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> +++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> @@ -2,13 +2,26 @@
>  /*
>   * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
>   *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
> + */
> +/*\
> + * [Description]
>   *
>   * Gets round-robin time quantum by calling sched_rr_get_interval() and
>   * checks that the value is sane.
>   *
> - * It is also a regression test for kernel
> - * commit 975e155ed873 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR
> - * timeslice tuning knob in milliseconds").
> + * It is also a regression test for:
> + *
> + *  commit 975e155ed8732cb81f55c021c441ae662dd040b5
> + *  Author: Shile Zhang <shile.zhang@nokia.com>
> + *  Date:   Sat Jan 28 22:00:49 2017 +0800
> + *
> + *    sched/rt: Show the 'sched_rr_timeslice' SCHED_RR timeslice tuning knob in milliseconds
> + *
> + *  commit c7fcb99877f9f542c918509b2801065adcaf46fa
> + *  Author: Cyril Hrubis <chrubis@suse.cz>
> + *  Date:   Wed Aug 2 17:19:05 2023 +0200
> + *
> + *    sched/rt: Fix sysctl_sched_rr_timeslice intial value

I was going to merge, but this is really ugly formatting in html.

If the dates and authors are important, could this comment be inside normal
comments (e.g. info is in the sources, but not in docparse doc)? Because we have
that info in docs as linux-git tags.

Or, if this is not important, could we use just:

/*\
 * [Description]
....
 * It is also a regression test for:
 * * 975e155ed8732 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR timeslice tuning knob in milliseconds")
 * * c7fcb99877f9f ("sched/rt: Fix sysctl_sched_rr_timeslice intial value")
 */

Also, for me would be instead of year enough just to add also kernel release to the hash.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
