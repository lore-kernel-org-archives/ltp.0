Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D023C4332F
	for <ltp@archiver.kernel.org>; Wed,  8 Nov 2023 05:31:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 697AB3CE7E6
	for <ltp@archiver.kernel.org>; Wed,  8 Nov 2023 06:31:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D36E13CC598
 for <ltp@lists.linux.it>; Wed,  8 Nov 2023 06:31:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0D7551A00A31
 for <ltp@lists.linux.it>; Wed,  8 Nov 2023 06:31:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EFB3F1F45A;
 Wed,  8 Nov 2023 05:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699421484;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yY+3CHWy++Bh2sBD4mPREYQvIOiPZ1YyKVuixzofhVo=;
 b=qafGL9VAqVrblHISb1vi8wgRJy+SDmIGY8QAQWxXSPDqlXlqTGTuG1BQzpIvHSfkbLjZXg
 WRnziKiMt8mVsCBBzE30uZHD0ABU/7m87JRhVxEjmpUWGnSrr2EyGnxYRHZOwF/8uFgsh/
 5G0YkGRtj/kI+6t7tpe5muSIelDDJxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699421484;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yY+3CHWy++Bh2sBD4mPREYQvIOiPZ1YyKVuixzofhVo=;
 b=nXEwPjefwiRVpdmpyig4IyEnz20MDY6qHNDu+RvZz5x32r6YLDKJ9kAM3HJ85QK/h5LK3H
 bfCyT0LESeJDWnDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8C3E1390F;
 Wed,  8 Nov 2023 05:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lpt3LywdS2UsawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Nov 2023 05:31:24 +0000
Date: Wed, 8 Nov 2023 06:31:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231108053122.GA1383908@pevik>
References: <20231107105836.68108-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231107105836.68108-1-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] link05: Convert docs to docparse
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

> The description of link05's test has no relevance to the test code,
> I've changed the description.

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/link/link05.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
> index 95787ec24..f255bc13b 100644
> --- a/testcases/kernel/syscalls/link/link05.c
> +++ b/testcases/kernel/syscalls/link/link05.c
> @@ -1,13 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - *  AUTHOR		: Richard Logan
> - *  CO-PILOT		: William Roske
> + * Authors: Richard Logan, William Roske
>   * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (c) Linux Test Project, 2001-2023
>   */
+1

> -/*
> - * Test if link(2) fails with EMLINK.
> +/*\
> + * [Description]
> + *
> + * Tests that link(2) succeeds with creating n links.
+1. I'd just instead of "n links" mention either "1000 links" or "high number of
links" (to be more obvious).

Kind regards,
Petr

>   */


>  #include <stdio.h>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
