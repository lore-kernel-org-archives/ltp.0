Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981A4C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 12:02:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AB943CD22C
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 13:02:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 674D33CD213
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 13:02:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 91050200934
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 13:02:26 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id E6A07225D2
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668427345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v7L0Bb2KSmkscQXDUoXNveduZJGdEsMN7IxMVBCtusM=;
 b=gXRlIlJqhsH1Ky26yN5wRbiwuBJb2kO3brWfKOBKGTXFByGiYXKAD1JZVh8xYKm75Wa6iZ
 DFkHONZ0DhA+1UbEttFXABEyNwY5bnmeXC59LmgvRAjwDygEzgKKI9e39Q5gAtXE5JxltG
 hD+qNAR1w+H814RwbKwT38xxrz6PsbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668427345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v7L0Bb2KSmkscQXDUoXNveduZJGdEsMN7IxMVBCtusM=;
 b=hZQ77KDKRL7RAl/ahdPZ66oFQP06rHi0MesTCwMHXwnH+LdJRDs4rY+RWopeRBFWzRZT+r
 Hj46a7HNFHmjOzBg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BBE6B2C141;
 Mon, 14 Nov 2022 12:02:25 +0000 (UTC)
References: <20221110135442.14501-1-mdoucha@suse.cz>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 14 Nov 2022 11:56:56 +0000
Organization: Linux Private Site
In-reply-to: <20221110135442.14501-1-mdoucha@suse.cz>
Message-ID: <877czxu4ku.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Allow graceful subtest cleanup in shell tests
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

Martin Doucha <mdoucha@suse.cz> writes:

> The new shell test timeout code sends SIGTERM to any subprocesses when
> the main script hits timeout. SIGTERM isn't handled by the LTP library
> which means that tools like netstress will be instantly killed without
> performing any cleanup. Handle SIGTERM like SIGINT in LTP library
> to allow graceful cleanup.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Merged with Petr's tag, thanks!

Possibly we should also print the signal that we received somehow.

> ---
>
> Note: The current lack of graceful cleanup causes random failures in shell
> tests which run the same tool many times (e.g. netstress). When the PID
> counter wraps around and the tool accidentally gets the same PID as another
> process that got killed by SIGTERM, the new test process will fail during IPC
> setup.
>
>  lib/tst_test.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b225ba082..1732fd058 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1568,6 +1568,7 @@ static int fork_testrun(void)
>  	int status;
>  
>  	SAFE_SIGNAL(SIGINT, sigint_handler);
> +	SAFE_SIGNAL(SIGTERM, sigint_handler);
>  
>  	alarm(results->timeout);
>  
> @@ -1579,6 +1580,7 @@ static int fork_testrun(void)
>  		tst_disable_oom_protection(0);
>  		SAFE_SIGNAL(SIGALRM, SIG_DFL);
>  		SAFE_SIGNAL(SIGUSR1, SIG_DFL);
> +		SAFE_SIGNAL(SIGTERM, SIG_DFL);
>  		SAFE_SIGNAL(SIGINT, SIG_DFL);
>  		SAFE_SETPGID(0, 0);
>  		testrun();
> @@ -1586,6 +1588,7 @@ static int fork_testrun(void)
>  
>  	SAFE_WAITPID(test_pid, &status, 0);
>  	alarm(0);
> +	SAFE_SIGNAL(SIGTERM, SIG_DFL);
>  	SAFE_SIGNAL(SIGINT, SIG_DFL);
>  
>  	if (tst_test->taint_check && tst_taint_check()) {
> -- 
> 2.37.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
