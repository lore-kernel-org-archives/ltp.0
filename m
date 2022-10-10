Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8444DC433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 11:57:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 054AB3CAE70
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 13:57:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F6823C1841
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 13:57:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C55C4600242
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 13:57:32 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4C7341F8E8
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 11:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665403051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5ec5EsDBU7fItGHUgJHYSiCVNbmw1a4hlp2GUs+Ty4k=;
 b=bUsGeqo2Pi6sd+uzf7gljdAkNN9+9g19TBJWWMW5hsrbggKIUP1+Zv5ZNOEaTV5K+EidgG
 0yoX8XAA5Nig9/Ztw5wlI5vhXOsNcvB/kQSy24Sb59uAhwQQIIy4qdq7RuiTk/8kdqKRap
 3n94kKmCo5CQv8em/ESRjUsQMVg6MZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665403051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5ec5EsDBU7fItGHUgJHYSiCVNbmw1a4hlp2GUs+Ty4k=;
 b=GUeQwiDsfNFnw92XN1Og5llnSVW0SZK1YSkJuikBWcYd9erpKIl6hHHC8j6Zk3JlcImZ9V
 jQSHDzNF+USZAYBw==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B03962C141;
 Mon, 10 Oct 2022 11:57:30 +0000 (UTC)
References: <20220704114523.10409-1-mdoucha@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 10 Oct 2022 12:57:03 +0100
In-reply-to: <20220704114523.10409-1-mdoucha@suse.cz>
Message-ID: <87edvfao2e.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] msgget03: Set custom queue limit
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

Merged!

Martin Doucha <mdoucha@suse.cz> writes:

> The runtime limit patchset has reduced default test timeout to 30 seconds
> which is not enough for msgget03 on some archs. Set custom queue count
> limit to make the test faster.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/syscalls/ipc/msgget/msgget03.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> index 711886e17..2257ae0f9 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> @@ -41,7 +41,8 @@ static void setup(void)
>  	tst_res(TINFO, "Current environment %d message queues are already in use",
>  		used_cnt);
>  
> -	SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", "%i", &maxmsgs);
> +	maxmsgs = used_cnt + 32;
> +	SAFE_FILE_PRINTF("/proc/sys/kernel/msgmni", "%i", maxmsgs);
>  
>  	queues = SAFE_MALLOC((maxmsgs - used_cnt) * sizeof(int));
>  
> @@ -73,5 +74,9 @@ static struct tst_test test = {
>  	.needs_tmpdir = 1,
>  	.setup = setup,
>  	.cleanup = cleanup,
> -	.test_all = verify_msgget
> +	.test_all = verify_msgget,
> +	.save_restore = (const struct tst_path_val[]){
> +		{"/proc/sys/kernel/msgmni", NULL},
> +		{}
> +	}
>  };
> -- 
> 2.36.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
