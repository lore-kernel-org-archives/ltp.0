Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422BFC4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 08:55:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A2FE3CB043
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 10:55:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2D5D3C93EF
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:55:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1169D1400BDF
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:55:17 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 74B5033E89;
 Tue, 18 Oct 2022 08:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666083317;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMB/t3MFVJIf3CAzB3yyDox+AKzgwPoQcndWQjiepAg=;
 b=JEMSLkaIjeAoTRsOZzzAu2qW0XJ3Z4LmNrBptaxqzBZZfNQRIuDI3302KWIhyM32Xwc1O1
 dZTN9VgQPMd1oSAZNALhLuFXFp7TbY+eFBRitIxn3abob6M7uQlWn/k3jtUSnvmLaq7TkB
 /5J5lcKlhafSaFJqlfTxGrAcqjyMvfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666083317;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMB/t3MFVJIf3CAzB3yyDox+AKzgwPoQcndWQjiepAg=;
 b=LklXwJTFA4Ddk7DIjyGgQ4OXpXk/ueqqXnIH931mkAFFJmbfKioSHrr37pf5t0reMT1kTb
 bl2/nOeSVTiZjkBQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0449B2C141;
 Tue, 18 Oct 2022 08:55:16 +0000 (UTC)
References: <20221018032203.3429895-1-liwang@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 18 Oct 2022 09:48:06 +0100
In-reply-to: <20221018032203.3429895-1-liwang@redhat.com>
Message-ID: <87bkq9mryj.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pthread_barrier_init: remove the restrict limit
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

Li Wang <liwang@redhat.com> writes:

> The restrict keyword tells the compiler that a given pointer
> does not alias any other pointer in the same context. But this
> is only supported by C99.
>
> To make older platforms compilinng LTP successful, we have to cancel
> that limitation in function definition.
>
> Fix error: https://github.com/linux-test-project/ltp/actions/runs/3263823142/jobs/5363481739
>
> Signed-off-by: Li Wang <liwang@redhat.com>

Sure, we don't care about this optimization. If it were a safety feature
I would suggest adding macros with an empty fallback.

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>
> Notes:
>       I also considering adding "-std=gun99" for compiling the whole library,
>       but not sure if this could bring a bigger potential impact on
> LTP.

It would be nice to at least use C99, but I guess we can wait a bit
longer until centos7 is EOL.

>
>  include/tst_safe_pthread.h | 4 ++--
>  lib/safe_pthread.c         | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/tst_safe_pthread.h b/include/tst_safe_pthread.h
> index cc6da2de8..8fb553929 100644
> --- a/include/tst_safe_pthread.h
> +++ b/include/tst_safe_pthread.h
> @@ -41,8 +41,8 @@ int safe_pthread_barrier_destroy(const char *file, const int lineno,
>  	safe_pthread_barrier_destroy(__FILE__, __LINE__, barrier);
>  
>  int safe_pthread_barrier_init(const char *file, const int lineno,
> -			      pthread_barrier_t *restrict barrier,
> -			      const pthread_barrierattr_t *restrict attr,
> +			      pthread_barrier_t *barrier,
> +			      const pthread_barrierattr_t *attr,
>  			      unsigned count);
>  #define SAFE_PTHREAD_BARRIER_INIT(barrier, attr, count) \
>  	safe_pthread_barrier_init(__FILE__, __LINE__, barrier, attr, count);
> diff --git a/lib/safe_pthread.c b/lib/safe_pthread.c
> index d7bfee4cc..d70bb8707 100644
> --- a/lib/safe_pthread.c
> +++ b/lib/safe_pthread.c
> @@ -90,8 +90,8 @@ int safe_pthread_cancel(const char *file, const int lineno,
>  }
>  
>  int safe_pthread_barrier_init(const char *file, const int lineno,
> -			      pthread_barrier_t *restrict barrier,
> -			      const pthread_barrierattr_t *restrict attr,
> +			      pthread_barrier_t *barrier,
> +			      const pthread_barrierattr_t *attr,
>  			      unsigned count)
>  {
>  	int rval;


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
