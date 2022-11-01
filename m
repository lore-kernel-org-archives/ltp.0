Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7792FA373D
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 11:37:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4AAD3CAD50
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 12:37:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75FA83CAC40
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 12:37:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B2AD460029D
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 12:37:10 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9B0061F8D5;
 Tue,  1 Nov 2022 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667302629;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=On3ByJWk/Kum+0w3vFzUbOFzItkf4D3Ekq+AjxxgHgI=;
 b=UOHDkTUiNJAi8kZC1ox9XPm7fRpLrN4Md2dwJkxbJ/e86Z6PTTendutRK66q4Wzszux2Rb
 9NyORIOxnu4WREMmVGQfEm6x8gR7F4LhsEt8gt7grbf8kzakywXUyM7wJxRsfbyw6cEl3g
 8BPIwlkN3UERnJ1Sm7MWmoRTuOdmmNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667302629;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=On3ByJWk/Kum+0w3vFzUbOFzItkf4D3Ekq+AjxxgHgI=;
 b=f8jIhGDWUK+ffDHKBFzqlbKoBTfQMKdwegiIW/280zKRjpMYziNYMefbMHiIC4qAOoSdYx
 sncNLAtbh4x3xDDg==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 497852C141;
 Tue,  1 Nov 2022 11:37:09 +0000 (UTC)
References: <20220722120501.28670-1-andrea.cervesato@suse.com>
 <20220722120501.28670-2-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 01 Nov 2022 11:36:58 +0000
Organization: Linux Private Site
In-reply-to: <20220722120501.28670-2-andrea.cervesato@suse.com>
Message-ID: <87zgda9a8r.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/7] Add more safe macros for mqueue API
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

Merged, thanks!

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Added SAFE_MQ_UNLINK and SAFE_MQ_CLOSE in tst_safe_posix_ipc.h
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/tst_safe_posix_ipc.h | 45 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/include/tst_safe_posix_ipc.h b/include/tst_safe_posix_ipc.h
> index b60c12c9e..5bfef03a9 100644
> --- a/include/tst_safe_posix_ipc.h
> +++ b/include/tst_safe_posix_ipc.h
> @@ -12,6 +12,12 @@
>  #define SAFE_MQ_OPEN(pathname, oflags, ...) \
>  	safe_mq_open(__FILE__, __LINE__, (pathname), (oflags), ##__VA_ARGS__)
>  
> +#define SAFE_MQ_CLOSE(__mqdes) \
> +	safe_mq_close(__FILE__, __LINE__, (__mqdes))
> +
> +#define SAFE_MQ_UNLINK(name) \
> +	safe_mq_unlink(__FILE__, __LINE__, (name))
> +
>  static inline int safe_mq_open(const char *file, const int lineno,
>  			       const char *pathname, int oflags, ...)
>  {
> @@ -41,6 +47,45 @@ static inline int safe_mq_open(const char *file, const int lineno,
>  		tst_brk_(file, lineno, TBROK | TERRNO,
>  			"mq_open(%s,%d,%04o,%p) failed", pathname, oflags,
>  			mode, attr);
> +	} else if (rval < 0) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid mq_open(%s) return value %d", pathname, rval);
> +	}
> +
> +	return rval;
> +}
> +
> +static inline int safe_mq_close(const char *file, const int lineno,
> +				mqd_t __mqdes)
> +{
> +	int rval;
> +
> +	rval = mq_close(__mqdes);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"mq_close(%d) failed", __mqdes);
> +	} else if (rval < 0) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid mq_close(%d) return value %d", __mqdes, rval);
> +	}
> +
> +	return rval;
> +}
> +
> +static inline int safe_mq_unlink(const char *file, const int lineno,
> +				const char* name)
> +{
> +	int rval;
> +
> +	rval = mq_unlink(name);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"mq_unlink(%s) failed", name);
> +	} else if (rval < 0) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid mq_unlink(%s) return value %d", name, rval);
>  	}
>  
>  	return rval;
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
