Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BDDC35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 12:45:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 696503CBA2A
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 13:45:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BEFA3C81B1
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 13:45:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E7988100047A
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 13:45:47 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 94394222DD;
 Mon, 18 Dec 2023 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702903546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=46Q7KWoYy686twfou+DLELG+jdU3NNgrxMPrU8SF3BM=;
 b=pr5ubp7JtQh1ENj2sPuLN+0Z+MMjw00K/Dya0tpPMXy/DDpFzz9lyum2P5eq7UcamDYA2j
 DQyAmtTfIHKK5lNyQH8pjUxWyp95vT3GFYwc1tIi/dxhhGNrlYpLoNMeeaf2JgqCSsjPV4
 CHciy3A8k4B+lkx4UaZjRaX6WgBnWqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702903546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=46Q7KWoYy686twfou+DLELG+jdU3NNgrxMPrU8SF3BM=;
 b=qT8xqJp6uhBeTypa54bT/ZEfL/qJSeHygaPAKiayTPA2Zcoivch7AapitVXHjCKpk+e4K+
 HcxGPVO37NnrmBBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702903546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=46Q7KWoYy686twfou+DLELG+jdU3NNgrxMPrU8SF3BM=;
 b=pr5ubp7JtQh1ENj2sPuLN+0Z+MMjw00K/Dya0tpPMXy/DDpFzz9lyum2P5eq7UcamDYA2j
 DQyAmtTfIHKK5lNyQH8pjUxWyp95vT3GFYwc1tIi/dxhhGNrlYpLoNMeeaf2JgqCSsjPV4
 CHciy3A8k4B+lkx4UaZjRaX6WgBnWqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702903546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=46Q7KWoYy686twfou+DLELG+jdU3NNgrxMPrU8SF3BM=;
 b=qT8xqJp6uhBeTypa54bT/ZEfL/qJSeHygaPAKiayTPA2Zcoivch7AapitVXHjCKpk+e4K+
 HcxGPVO37NnrmBBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 619A513927;
 Mon, 18 Dec 2023 12:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id zsiVFfo+gGUdTwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 18 Dec 2023 12:45:46 +0000
Date: Mon, 18 Dec 2023 13:45:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231218124540.GA197798@pevik>
References: <20231218062129.130236-1-xuyang2018.jy@fujitsu.com>
 <20231218062129.130236-2-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231218062129.130236-2-xuyang2018.jy@fujitsu.com>
X-Spamd-Result: default: False [0.70 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[36.82%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] gettimeofday02: Convert docs to docparse
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

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/gettimeofday/gettimeofday02.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

> diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
> index 7c462cc29..fcd027df5 100644
> --- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
> +++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
> @@ -4,13 +4,12 @@
>   * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>
>   */

> -/*
> +/*\
>   * DESCRIPTION
FYI this needs to be [Description] to have unified formatting in generated docs
(bold). I fixed it together with gettimeofday01.c.

Kind regards,
Petr

> - *	Check if gettimeofday is monotonous
> + * Check if gettimeofday is monotonous during 10s
>   *
> - * ALGORITHM
> - *	Call gettimeofday() to get a t1 (fist value)
> - *	call it again to get t2, see if t2 < t1, set t2 = t1, repeat for 10 sec
> + * - Call gettimeofday() to get a t1 (fist value)
> + * - Call it again to get t2, see if t2 < t1, set t2 = t1, repeat for 10 sec
>   */

>  #include <stdint.h>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
