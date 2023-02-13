Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49153C636CC
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 11:37:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5279B3CBF9A
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 12:37:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E8F13CB077
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 12:37:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E6ECA20092F
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 12:37:08 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0375E211AE;
 Mon, 13 Feb 2023 11:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676288228;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3niUHcSovbldrVEfK3ZMXDG3fSQuxM9mWlm5z6I3UKM=;
 b=gVCpzr6VbL77KQRiIrX1MT4Cg8R1hL17HiM8G0hR5n7RA9S36urWuRMn8x+Vkb5UKz9TkL
 RVarf1DmRkkG4Ha3RkNEGi3It6qeMcZQYHylpYLxBCUmYn/v8J1jMFpSO5ANhpJNfHYt8X
 +6zyOQQMyiCEZ2Y0HkRfm2RVJR26zmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676288228;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3niUHcSovbldrVEfK3ZMXDG3fSQuxM9mWlm5z6I3UKM=;
 b=ll/0ZtJ1Xi+RqgVk8ofbS1PRZoCOIkk7sHJXV7CCy2g7TBGNGD01J3BS0cbomGb5uIqdpD
 hqy9OS+cHVn3bWCQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5B5682C141;
 Mon, 13 Feb 2023 11:37:07 +0000 (UTC)
References: <20230207082041.1021333-1-minachou@andestech.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Hui Min Mina Chou <minachou@andestech.com>
Date: Mon, 13 Feb 2023 11:34:05 +0000
Organization: Linux Private Site
In-reply-to: <20230207082041.1021333-1-minachou@andestech.com>
Message-ID: <878rh1pzj1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/getrusage04:Fix tst_resm() format string
 for 64bit offset
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
Cc: tim609@andestech.com, ltp@lists.linux.it, az70021@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Hui Min Mina Chou <minachou@andestech.com> writes:

> This patch fixes the incorrect output on 32bit platform.
> The correct way to print tv_usec is cast it to (long long) type and
> change the format string to %lld.

Merged, thanks!

>
> Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
> ---
>  testcases/kernel/syscalls/getrusage/getrusage04.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
> index 06b576d79..b03bc549b 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage04.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
> @@ -104,8 +104,9 @@ int main(int argc, char *argv[])
>  		tst_count = 0;
>  		i = 0;
>  		SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
> -		tst_resm(TINFO, "utime:%12luus; stime:%12luus",
> -			 usage.ru_utime.tv_usec, usage.ru_stime.tv_usec);
> +		tst_resm(TINFO, "utime:%12lldus; stime:%12lldus",
> +			 (long long)usage.ru_utime.tv_usec,
> +			 (long long)usage.ru_stime.tv_usec);
>  		ulast = usage.ru_utime.tv_usec;
>  		slast = usage.ru_stime.tv_usec;
>  
> @@ -115,9 +116,9 @@ int main(int argc, char *argv[])
>  			sdelta = usage.ru_stime.tv_usec - slast;
>  			if (udelta > 0 || sdelta > 0) {
>  				i++;
> -				tst_resm(TINFO, "utime:%12luus; stime:%12luus",
> -					 usage.ru_utime.tv_usec,
> -					 usage.ru_stime.tv_usec);
> +				tst_resm(TINFO, "utime:%12lldus; stime:%12lldus",
> +					 (long long)usage.ru_utime.tv_usec,
> +					 (long long)usage.ru_stime.tv_usec);
>  				if ((long)udelta > 1000 + (BIAS_MAX * factor_nr)) {
>  					sprintf(msg_string,
>  						"utime increased > %ldus:",
> -- 
> 2.34.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
