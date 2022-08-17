Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D857EC25B08
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 14:12:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BD903C9F03
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 16:12:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B54A3C88EB
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 16:12:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 66AA56009E1
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 16:12:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B72DB37DCC;
 Wed, 17 Aug 2022 14:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660745522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udInvNKLtt+RLHlNBzrwd+oIylTOfw8wLdVoAU5VYSE=;
 b=Yh0dOwzIVUneZUglGf0CV18u5JlU0PcPUqaXd5PBCCcUjjmv+mWZx0977k1diz3lVRLoj9
 tA3glJ2XW0KKuhUC627YJ59Mw/nvlEpNFnz0Fzm4DClYNb6ATiazUvVpOfVVsuWvEtnnic
 5HqbbADltjlt2iXpYe4G0nK3qczUrIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660745522;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udInvNKLtt+RLHlNBzrwd+oIylTOfw8wLdVoAU5VYSE=;
 b=TReTWlnYoCgPyISnjNdLuCYj2Sdp712B5YFgLSTQVA6hNTcxvP1zO3tVMu2tGb3uPwMETt
 UGg0C4+SfDGIgEBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2C8213A8E;
 Wed, 17 Aug 2022 14:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iCb4JjL3/GLNbQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 17 Aug 2022 14:12:02 +0000
Date: Wed, 17 Aug 2022 16:13:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>
Message-ID: <Yvz3p3AD1YHDKdPh@yuki>
References: <20220817133946.234985-1-tudor.cretu@arm.com>
 <20220817133946.234985-2-tudor.cretu@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220817133946.234985-2-tudor.cretu@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] lib: Fix initialization of recursive mutex
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
> ---
>  lib/tst_res.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index 8d86b48a4..2f66ec40c 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -82,17 +82,27 @@ void *TST_RET_PTR;
>  	assert(strlen(buf) > 0);		\
>  } while (0)
>  
> -#ifndef PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
> -# ifdef __ANDROID__
> -#  define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP \
> -	PTHREAD_RECURSIVE_MUTEX_INITIALIZER
> -# else
> -/* MUSL: http://www.openwall.com/lists/musl/2017/02/20/5 */
> -#  define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP  { {PTHREAD_MUTEX_RECURSIVE} }
> -# endif
> +#if !defined(PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP) && defined(__ANDROID__)
> +#define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP PTHREAD_RECURSIVE_MUTEX_INITIALIZER
>  #endif
>  
> +#ifdef PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
>  static pthread_mutex_t tmutex = PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
> +#else
> +/* MUSL: http://www.openwall.com/lists/musl/2017/02/20/5 */

I would have put this URL to the commit message instead, otherwise the
change looks good.

> +static pthread_mutex_t tmutex;
> +
> +__attribute__((constructor))
> +static void init_tmutex(void)
> +{
> +	pthread_mutexattr_t mutattr = {0};
> +
> +	pthread_mutexattr_init(&mutattr);
> +	pthread_mutexattr_settype(&mutattr, PTHREAD_MUTEX_RECURSIVE);
> +	pthread_mutex_init(&tmutex, &mutattr);
> +	pthread_mutexattr_destroy(&mutattr);
> +}
> +#endif
>  
>  static void check_env(void);
>  static void tst_condense(int tnum, int ttype, const char *tmesg);
> -- 
> 2.25.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
