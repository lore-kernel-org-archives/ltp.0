Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92D7C433EF
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 08:35:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7DBF3CA8C0
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 10:35:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FE0B3C9AC5
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:34:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9F722600915
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:34:55 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0E0AD1F45E;
 Thu,  5 May 2022 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651739695;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+p7JwQ3AbuXG2P5c0tGDu9fk5hJLdiOXwwW8EfeoSU8=;
 b=emorkP10VJBDYflwMQ26XzmEFJJIuRnfAbiIUDJZwBU5YOojhkScrXIWzyBhsqooGXx6au
 x4KdYweebuObMu7vjguWKCCKgSP/pJijP8XJ/3SRgTAPjb3DZkFa48UuEMHdSJc1n+1ubS
 ANQV38SSux+Oda0plQ9AJcTiiHfN09U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651739695;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+p7JwQ3AbuXG2P5c0tGDu9fk5hJLdiOXwwW8EfeoSU8=;
 b=ojPEPt+TWzTF5srT0I6vn85YH4rg0i7VQf2ECqvpNAEgYsHoRg/azZUJK4AjRhtiQ+edsJ
 N4zZLGOdWr74D9BA==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BEDD12C141;
 Thu,  5 May 2022 08:34:54 +0000 (UTC)
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-7-chrubis@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 05 May 2022 09:33:28 +0100
In-reply-to: <20220503174718.21205-7-chrubis@suse.cz>
Message-ID: <871qx8e5sh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 06/30] crypto/af_alg02:
 Convert to runtime.
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

"Cyril Hrubis" <chrubis@suse.cz> writes:

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/crypto/af_alg02.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
> index 9894ffacd..b96b8b341 100644
> --- a/testcases/kernel/crypto/af_alg02.c
> +++ b/testcases/kernel/crypto/af_alg02.c
> @@ -65,7 +65,7 @@ static void run(void)
>  	TST_CHECKPOINT_WAIT(0);
>  
>  	while (!completed) {
> -		if (tst_timeout_remaining() <= 10) {
> +		if (tst_remaining_runtime()) {
>  			pthread_cancel(thr);
>  			tst_brk(TBROK,
>  				"Timed out while reading from request socket.");
> @@ -77,7 +77,7 @@ static void run(void)
>  
>  static struct tst_test test = {
>  	.test_all = run,
> -	.timeout = 20,
> +	.runtime_per_iteration = 20,

Isn't this the argument name to a function to set the runtime not the
tst_test member?

Probably they should be given the same name.

>  	.needs_checkpoints = 1,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "ecaaab564978"},


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
