Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2E8C19F2D
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 06:14:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B37123C948F
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 08:14:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C88523C1BEA
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 08:13:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4C484140099D
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 08:13:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B62A234752
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 06:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1660198431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJIwP4zFnfZnfvwmBy7iH1Jpyo0wcg58r4ALPFchu1Q=;
 b=rRCGqhj9sm947OWFO5ogj9k74AF6WjeWTSEz6Z/+PlwA/sgt0HWUhqF6Xfjoahf4cm6BWX
 nLenEFkHC7pb4gxElVxeHzEzmRXkoPjKajKoZClbMLbYScyRFT4cUOzI5F39KoFBp3oZEG
 NbJXeBhSOuJJCxr/zrxi3YX8oZg9wgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1660198431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJIwP4zFnfZnfvwmBy7iH1Jpyo0wcg58r4ALPFchu1Q=;
 b=PmQxelDnFtDkEAuzhVo6wsxg3ZcqZ4DTpHvvsAZ6gnDfcrRzErMnDFVXXHb+XtNXTqo9y/
 5ejDDI3n7F16K0DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2537D13A9B
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 06:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ScFnNR6e9GKaGQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 06:13:50 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 11 Aug 2022 11:43:48 +0530
Message-ID: <4786479.31r3eYUQgx@localhost>
Organization: SUSE
In-Reply-To: <20220727165542.2861-1-akumar@suse.de>
References: <20220727165542.2861-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setuid03.c: using TST_EXP_FAIL() and
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Sent a v2 for this with correct docparse format and updated copyright.

On Wednesday, July 27, 2022 10:25:42 PM IST Avinesh Kumar wrote:
> use TST_EXP_FAIL() with expected errno code, use SAFE_SETUID() in setup
> and turn comment into docparse
> 
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/setuid/setuid03.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setuid/setuid03.c b/testcases/kernel/syscalls/setuid/setuid03.c
> index f2e007f8d..61529b1ff 100644
> --- a/testcases/kernel/syscalls/setuid/setuid03.c
> +++ b/testcases/kernel/syscalls/setuid/setuid03.c
> @@ -3,7 +3,9 @@
>   * Copyright (c) International Business Machines Corp., 2001
>   */
>  
> -/* DESCRIPTION
> +/*
> + * [Description]
> + *
>   * This test will switch to nobody user for correct error code collection.
>   * Verify setuid returns errno EPERM when it switches to root_user.
>   */
> @@ -19,16 +21,7 @@
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
> @@ -39,10 +32,7 @@ static void setup(void)
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
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
