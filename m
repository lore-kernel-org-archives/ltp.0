Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB36C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 10:24:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BBC43CD246
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 11:24:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8511F3C25A5
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 11:24:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D71C3200913
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 11:24:44 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 26C1B1FE22;
 Mon, 14 Nov 2022 10:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668421484;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2MbopUaZc/vhZt2IB6EsQE6bkvFZbzK/9H8P2MaP5w8=;
 b=z6ZhyzWfDBXil8FfYXecaVgnY2ACHXppR8uy8RsWm/z06abdrep2eJ+o6Bca2BqK4+RSi9
 yqEDuNsIDbvPoITi6RLGM45O6pm2S/U4PjzOKDY4VZE/SF3KREvinqvUjn7vIyP4BAgZ5j
 SdDIgLAb5brVOviWR7UmkKYuyogUN/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668421484;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2MbopUaZc/vhZt2IB6EsQE6bkvFZbzK/9H8P2MaP5w8=;
 b=1gEiJMq3Xu3m8eKuiWlv0HxKQufQmQQRmsRs5nX1FaJO3q1DBezBPJRVabpo8GxjIpcZ9Y
 EhP9C4MSULdJCUCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D87F42C14B;
 Mon, 14 Nov 2022 10:24:43 +0000 (UTC)
References: <20221110175236.32094-1-pvorel@suse.cz>
 <20221110175236.32094-2-pvorel@suse.cz>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Nov 2022 10:23:41 +0000
Organization: Linux Private Site
In-reply-to: <20221110175236.32094-2-pvorel@suse.cz>
Message-ID: <87wn7xu93o.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib/tst_device: Remove unused
 count_match_len()
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
Reply-To: rpalethorpe@suse.de
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
 Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Fixes: e1b1ae66b ("tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Yup, my mistake.

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>


> ---
> Hi,
>
> obviously correct, but not merging it without ack there are changes and
> function is actually needed.
>
> Kind regards,
> Petr
>
>  lib/tst_device.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index db5c2ab8f..48d7e3ab6 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -510,16 +510,6 @@ unsigned long tst_dev_bytes_written(const char *dev)
>  	return dev_bytes_written;
>  }
>  
> -static int count_match_len(const char *first, const char *second)
> -{
> -	int len = 0;
> -
> -	while (*first && *first++ == *second++)
> -		len++;
> -
> -	return len;
> -}
> -
>  __attribute__((nonnull))
>  void tst_find_backing_dev(const char *path, char *dev)
>  {


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
