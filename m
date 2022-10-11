Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C69FC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 11:26:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADF283CAE9C
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 13:26:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A57C3C7319
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 13:26:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D82E0600806
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 13:26:41 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 16E3322865
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665487601;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDrcyfMOZWPbF51/DYpz1sT59o7QGC1+I4ZwvItJD30=;
 b=hXYidWe31j/9GxKfEM5v/G9srvuNTSN6ZRvbM7DRrgCyQni7jyGQzlylhZTmpsGbTWdE5p
 STySM29ouOfFVmjAVr813oLAUGrigVMEICeMj8kee6BX0HqHBu0McTIEc3kibTEzhUD40q
 BQpz+nDFzl7BEZPT78aB8W53/8UZ2Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665487601;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDrcyfMOZWPbF51/DYpz1sT59o7QGC1+I4ZwvItJD30=;
 b=U5rDEQ2c9ht4MsFIedJQSefTEyJoh2HsQ0xrA/dt30xqz4IqenBZqmdg49H10cAb86YWV5
 SGtO0+PcvxiSctAg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B9B972C141;
 Tue, 11 Oct 2022 11:26:40 +0000 (UTC)
References: <20220811061107.30966-1-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Tue, 11 Oct 2022 12:26:26 +0100
In-reply-to: <20220811061107.30966-1-akumar@suse.de>
Message-ID: <87a6627g9c.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] setuid03.c: using TST_EXP_FAIL() and
 SAFE_SETUID() macros
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged! thanks

Avinesh Kumar <akumar@suse.de> writes:

> use TST_EXP_FAIL() with expected errno code, use SAFE_SETUID() in setup
> and turn comment into docparse
>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/setuid/setuid03.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setuid/setuid03.c b/testcases/kernel/syscalls/setuid/setuid03.c
> index f2e007f8d..06934f142 100644
> --- a/testcases/kernel/syscalls/setuid/setuid03.c
> +++ b/testcases/kernel/syscalls/setuid/setuid03.c
> @@ -1,9 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines Corp., 2001
> + * Copyright (c) Linux Test Project, 2009-2022
>   */
>  
> -/* DESCRIPTION
> +/*\
> + * [Description]
> + *
>   * This test will switch to nobody user for correct error code collection.
>   * Verify setuid returns errno EPERM when it switches to root_user.
>   */
> @@ -19,16 +22,7 @@
>  
>  static void verify_setuid(void)
>  {
> -	TEST(SETUID(ROOT_USER));
> -	if (TST_RET != -1) {
> -		tst_res(TFAIL | TTERRNO, "setuid() succeeded unexpectedly");
> -		return;
> -	}
> -
> -	if (TST_ERR == EPERM)
> -		tst_res(TPASS, "setuid() returned errno EPERM");
> -	else
> -		tst_res(TFAIL | TTERRNO, "setuid() returned unexpected errno");
> +	TST_EXP_FAIL(SETUID(ROOT_USER), EPERM);
>  }
>  
>  static void setup(void)
> @@ -39,10 +33,7 @@ static void setup(void)
>  	pw = SAFE_GETPWNAM("nobody");
>  	uid = pw->pw_uid;
>  
> -	if (SETUID(uid) == -1) {
> -		tst_brk(TBROK,
> -			"setuid() failed to set the effective uid to %d", uid);
> -	}
> +	SAFE_SETUID(uid);
>  
>  	umask(0);
>  }
> -- 
> 2.36.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
