Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1ADC61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 10:11:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB75B3CC0AB
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 11:11:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EBCA3C632B
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 11:11:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD1B560035A
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 11:11:09 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D4B46352CF;
 Thu,  9 Feb 2023 10:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1675937468;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2omLlFaUq91DJwT710UTV4fidwUJFK6SyzW7glIuiAs=;
 b=p3a8sn6eUHkKOsN5VQCAa9AcMylgS80XTL94CIZBrc8vt766lrYK3RlvDd35wJygEnR3Fc
 nIQY9Wn95z6M5mKSwdo3iWzY2V3c+atIE98N/4h4a/Rx1SMZv1cUVKrIgWVe8B4qQUADcN
 Jm3FGcBC8hviWMM5TSy/Il08euYrc8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1675937468;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2omLlFaUq91DJwT710UTV4fidwUJFK6SyzW7glIuiAs=;
 b=/SqRE6wKE1HtinOviafS6/4ZpCW33/ttzjoeSvo0bpesrIwho4275seqVhJTRL9tQim5AW
 zq3FIgYtTJwGQ7CA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 961302C141;
 Thu,  9 Feb 2023 10:11:08 +0000 (UTC)
References: <20230125100043.32349-1-andrea.cervesato@suse.com>
 <20230125100043.32349-2-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Thu, 09 Feb 2023 10:10:21 +0000
Organization: Linux Private Site
In-reply-to: <20230125100043.32349-2-andrea.cervesato@suse.com>
Message-ID: <877cwrrvwk.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] Add SAFE_SETHOSTNAME macro
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

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/safe_net_fn.h  |  3 +++
>  include/tst_safe_net.h |  3 +++
>  lib/safe_net.c         | 17 +++++++++++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
> index ff81b1337..6c63cb2cf 100644
> --- a/include/safe_net_fn.h
> +++ b/include/safe_net_fn.h
> @@ -73,6 +73,9 @@ int safe_getsockname(const char *file, const int lineno,
>  int safe_gethostname(const char *file, const int lineno,
>  		     char *name, size_t size);
>  
> +int safe_sethostname(const char *file, const int lineno,
> +		     const char *name, size_t size);
> +
>  int tst_getsockport(const char *file, const int lineno, int sockfd);
>  
>  unsigned short tst_get_unused_port(const char *file, const int lineno,
> diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
> index e85b79a3e..98f0256fd 100644
> --- a/include/tst_safe_net.h
> +++ b/include/tst_safe_net.h
> @@ -68,6 +68,9 @@
>  #define SAFE_GETHOSTNAME(name, size) \
>  	safe_gethostname(__FILE__, __LINE__, name, size)
>  
> +#define SAFE_SETHOSTNAME(name, size) \
> +	safe_sethostname(__FILE__, __LINE__, name, size)
> +
>  #define TST_GETSOCKPORT(sockfd) \
>  	tst_getsockport(__FILE__, __LINE__, sockfd)
>  
> diff --git a/lib/safe_net.c b/lib/safe_net.c
> index 1717f0745..5dec0de11 100644
> --- a/lib/safe_net.c
> +++ b/lib/safe_net.c
> @@ -469,6 +469,23 @@ int safe_gethostname(const char *file, const int lineno,
>  	return rval;
>  }
>  
> +int safe_sethostname(const char *file, const int lineno,
> +		     const char *name, size_t size)
> +{
> +	int rval = sethostname(name, size);
> +
> +	if (rval == -1) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
> +			"sethostname(%p, %zu) failed", name, size);
> +	} else if (rval) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
> +			"Invalid sethostname(%p, %zu) return value %d", name,
> +			size, rval);
> +	}
> +
> +	return rval;
> +}
> +
>  /*
>   * @return port in network byte order.
>   */
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
