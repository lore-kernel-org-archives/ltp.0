Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CB6C433EF
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 08:38:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA0133CA8B0
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 10:38:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C981D3CA820
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:38:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0931E10009F3
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:38:27 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 664352187E;
 Thu,  5 May 2022 08:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651739907;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dOoSmgYjZK8YzYph6iiwNcBozh0pe9KlluJm6wYpyyo=;
 b=fWmP+xy7sBsZ7pXHpXrqa5BB/UZ+LvOFSfURykHpnYtawXAWYmw7Ow3u4byig6Gd1is+FO
 onrQXlZAhnhyJJC6R7yM8n9F74F9pTFYglmwpLJ5vXkZyNQAawUv29UyfszMDxLoPpLols
 fLKKYVLBvFZ74GqT9WF4/y8f4l1npj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651739907;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dOoSmgYjZK8YzYph6iiwNcBozh0pe9KlluJm6wYpyyo=;
 b=rkc2ri6Am70EQqCJa7f28rfcaNQ0OwS5B2aIXO8f8xI0Yc4J4TrX2znHh+12Yf+yu4ilci
 6Cn2amr7CMg1pMAw==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 29E8C2C141;
 Thu,  5 May 2022 08:38:27 +0000 (UTC)
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-23-chrubis@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 05 May 2022 09:37:30 +0100
In-reply-to: <20220503174718.21205-23-chrubis@suse.cz>
Message-ID: <87wnf0cr25.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 22/30] crypto/af_alg02:
 Convert to runtime
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

"Cyril Hrubis" <chrubis@suse.cz> writes:

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/crypto/af_alg02.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
> index b96b8b341..9c2f488c4 100644
> --- a/testcases/kernel/crypto/af_alg02.c
> +++ b/testcases/kernel/crypto/af_alg02.c
> @@ -65,7 +65,7 @@ static void run(void)
>  	TST_CHECKPOINT_WAIT(0);
>  
>  	while (!completed) {
> -		if (tst_remaining_runtime()) {
> +		if (!tst_remaining_runtime()) {
>  			pthread_cancel(thr);
>  			tst_brk(TBROK,
>  				"Timed out while reading from request socket.");
> @@ -77,7 +77,7 @@ static void run(void)
>  
>  static struct tst_test test = {
>  	.test_all = run,
> -	.runtime_per_iteration = 20,
> +	.max_iteration_runtime = 20,

Ah, you probably want to ammend the previous commit.

>  	.needs_checkpoints = 1,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "ecaaab564978"},


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
