Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2467AC433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 20:44:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E8C13C8191
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 21:44:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CA783C7ACE
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 21:44:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C3C7600084
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 21:44:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AADAC210FE;
 Thu,  9 Dec 2021 20:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639082646;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=39z6H5KpUrhnsrcINTg+tbIEiHz8sdVPZcDJpdlc260=;
 b=Vod+qlJ9qLGvDzP/cYkCkn9985bH5PaN5Jj4xNOmCUG673/1/U4paHNc4c1aotGT57/qRa
 fvlLRTwZr7OReSrjFDxeu1tzZHLr64H4GvjcknS6FLol67tZJ29BX+tMgEf40kYBsgCBTY
 LEFG5nu/IGAG/RmYXGnhZXWcGK81Nfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639082646;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=39z6H5KpUrhnsrcINTg+tbIEiHz8sdVPZcDJpdlc260=;
 b=tjv1OX9DnuuCwJ5WejywEi8cHUzB/G6mylhbwqf+qGYRPUzDb1kLEfW02mu8B+MAtnTCZt
 mainZ/YbtrxDP1Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6989E13D8F;
 Thu,  9 Dec 2021 20:44:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YaWpF5ZqsmHyQwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Dec 2021 20:44:06 +0000
Date: Thu, 9 Dec 2021 21:44:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbJqlKzTZS99xk48@pevik>
References: <YbDl7YtVZvYXPxwp@pevik>
 <1639020068-2198-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639020068-2198-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] library: add cmd check handler in
 needs_cmds
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

Hi Xu,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Very nice code, nice tests, thanks!

> diff --git a/lib/newlib_tests/test_needs_cmds01.c b/lib/newlib_tests/test_needs_cmds01.c
> new file mode 100644
> index 000000000..92305ee97
> --- /dev/null
> +++ b/lib/newlib_tests/test_needs_cmds01.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +#include <stdio.h>
All <stdio.h> in the tests aren't needed, please remove it before merge.

nit: I'd also call tests tst_needs_cmds*.c (tst_ prefix instead of test_) as
most of the tests in the library takes this scheme, but that's very minor.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
