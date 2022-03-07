Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42001C433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 13:03:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0C3F3C1BB5
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 14:03:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1B4E3C1A87
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 14:03:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D18810009E0
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 14:03:03 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 885B9210F0
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 13:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646658182;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lkB6MiXHsx7oR6P4Oc/rZxHOsC3gDRsiYUBeAB5jGN4=;
 b=gFOaBeDF+oCWrIhsVggeqSHCCiHz8kCxEYu6hUe63IBzM3u/w3p7nK1631uG/yTyv9a05c
 DpAiDftpDGjzve9aNnCqbNP2w6I2aY5taBVib/XnqdhWM58j0m8EObxLtn34HQhVrYmupM
 6Qy9a5UKo8hSEeRGAGJTrxFCdY4j6f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646658182;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lkB6MiXHsx7oR6P4Oc/rZxHOsC3gDRsiYUBeAB5jGN4=;
 b=5vU6iSzg/uWUbQOiPFtfTiEyYegx0r17kCrl5BmUq3Bz/QuDbV1rc+4VCbCfE+hVJ6Qnmi
 rH1kTVETfLn2y9Ag==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5A9DBA3B8C;
 Mon,  7 Mar 2022 13:03:02 +0000 (UTC)
References: <20220303145032.21493-1-chrubis@suse.cz>
 <20220303145032.21493-2-chrubis@suse.cz>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 07 Mar 2022 13:02:22 +0000
In-reply-to: <20220303145032.21493-2-chrubis@suse.cz>
Message-ID: <87ee3dnce3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/7] ksm06: Move option parsing into the setup()
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

Hi,

Cyril Hrubis <chrubis@suse.cz> writes:

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  testcases/kernel/mem/ksm/ksm06.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
> index c5f219c37..379236f1f 100644
> --- a/testcases/kernel/mem/ksm/ksm06.c
> +++ b/testcases/kernel/mem/ksm/ksm06.c
> @@ -42,17 +42,12 @@
>  static int run = -1;
>  static int sleep_millisecs = -1;
>  static int merge_across_nodes = -1;
> -static unsigned long nr_pages;
> +static unsigned long nr_pages = 100;
>  
>  static char *n_opt;
>  
>  static void test_ksm(void)
>  {
> -	if (n_opt)
> -		nr_pages = SAFE_STRTOUL(n_opt, 0, ULONG_MAX);
> -	else
> -		nr_pages = 100;
> -
>  	test_ksm_merge_across_nodes(nr_pages);
>  }
>  
> @@ -64,6 +59,9 @@ static void setup(void)
>  	if (!is_numa(NULL, NH_MEMS, 2))
>  		tst_brk(TCONF, "The case needs a NUMA system.");
>  
> +	if (n_opt)
> +		nr_pages = SAFE_STRTOUL(n_opt, 0, ULONG_MAX);
> +
>  	/* save the current value */
>  	SAFE_FILE_SCANF(PATH_KSM "run", "%d", &run);
>  	SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
> -- 
> 2.34.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
