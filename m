Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0201DC4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 11:40:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC8A93CFE72
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 13:40:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 137353CC614
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 13:40:17 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 70F841A00FA8
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 13:40:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F20F20A39;
 Thu, 25 Apr 2024 11:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714045216;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ODM9o7a3yLBBJSEr/1ha67UCaROdeiMB4rsZnKdl+rw=;
 b=plI3qFj9b1dJVAC7lHMCb8ydPocJeJFSnaR0sQFKQqt/BuGKCtKwTIipyelBaFKtm8IAX4
 89VYOWwcLFPG+saA1oiRjyXkvIjOGsRsALD/LT96TlWyCygZW4KMOuzaR9golh1sTAiNVZ
 O9ENkGP9kqBx9McqSrLpR9VcJvVCcAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714045216;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ODM9o7a3yLBBJSEr/1ha67UCaROdeiMB4rsZnKdl+rw=;
 b=K2vaYVtyP2KgrFxD+tbzuXB2kHhWo1868BsavEDi2tbUDbkkDDMsn05uKEAGKaCRjswGyy
 mAe/ns7zpGQm8aCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714045215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ODM9o7a3yLBBJSEr/1ha67UCaROdeiMB4rsZnKdl+rw=;
 b=0W9zJvqTUsZTKYSu38Mej8MRV/xUZkq6LmqNgCUHLFbZnruzxH+KzvPedlR0T7gr5S0yli
 vAoLaMAYExr7STgnDUmkh5rJhseSgUj/yTIgYkAAr3tamnjDVyNBiirB2dwLodlX35/tVP
 migsCdx64ehgxT6Q/bBV+GIMqzgSNis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714045215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ODM9o7a3yLBBJSEr/1ha67UCaROdeiMB4rsZnKdl+rw=;
 b=L7ErU+hpEDoFZv8AOA0j3yqrOm+cSb9gTC7n17QKx4rPNL2eBTJS5bnrsDsFgRFlmPeUmF
 FM2euU/FTVwwBHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D2E51393C;
 Thu, 25 Apr 2024 11:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2MU1Bh9BKmbgUgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Apr 2024 11:40:15 +0000
Date: Thu, 25 Apr 2024 13:40:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240425114013.GA284406@pevik>
References: <20240415025100.2103-1-wegao@suse.com>
 <20240425020308.25367-1-wegao@suse.com>
 <20240425020308.25367-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240425020308.25367-2-wegao@suse.com>
X-Spamd-Result: default: False [-3.49 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: Add TST_EXP_PASS_PTR_{NULL,
 VOID} macros
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/tst_test_macros.h | 45 +++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)

> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 22b39fb14..1fb133dd3 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -178,6 +178,28 @@ extern void *TST_RET_PTR;
>                                                                                 \
>  	} while (0)

> +#define TST_EXP_PASS_SILENT_PTR_(SCALL, SSCALL, FAIL_PTR_VAL, ...)             \
> +	do {                                                                   \
> +		TESTPTR(SCALL);                                                \
> +		                                                               \
> +		TST_PASS = 0;                                                  \
> +		                                                               \
> +		if (TST_RET_PTR == FAIL_PTR_VAL) {                             \
> +			TST_MSG_(TFAIL | TTERRNO, " failed",                   \
> +			         SSCALL, ##__VA_ARGS__);                       \
> +		        break;                                                 \
> +		}                                                              \
> +		                                                               \
> +		if (TST_RET != 0) {                                            \
> +			TST_MSGP_(TFAIL | TTERRNO, " invalid retval %ld",      \
> +			          TST_RET, SSCALL, ##__VA_ARGS__);             \
> +			break;                                                 \
> +		}                                                              \
> +                                                                               \
> +		TST_PASS = 1;                                                  \
> +                                                                               \
> +	} while (0)
> +
>  #define TST_EXP_PASS_SILENT(SCALL, ...) TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__)

>  #define TST_EXP_PASS(SCALL, ...)                                               \
> @@ -188,6 +210,21 @@ extern void *TST_RET_PTR;
>  			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
>  	} while (0)                                                            \

> +#define TST_EXP_PASS_PTR_(SCALL, SSCALL, FAIL_PTR_VAL, ...)                    \
> +	do {                                                                   \
> +		TST_EXP_PASS_SILENT_PTR_(SCALL, SSCALL,                        \
> +					FAIL_PTR_VAL, ##__VA_ARGS__);          \
> +		                                                               \
> +		if (TST_PASS)                                                  \
> +			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
> +	} while (0)
> +
> +#define TST_EXP_PASS_PTR_NULL(SCALL, ...)                                      \
> +               TST_EXP_PASS_PTR_(SCALL, #SCALL, NULL, ##__VA_ARGS__);

I'm still not sure whether add TST_EXP_PASS_PTR_NULL, which is not used.
I wonder what others think (it can be removed before merge).

> +
> +#define TST_EXP_PASS_PTR_VOID(SCALL, ...)                                      \
> +               TST_EXP_PASS_PTR_(SCALL, #SCALL, (void *)-1, ##__VA_ARGS__);
> +
>  /*
>   * Returns true if err is in the exp_err array.
>   */
> @@ -301,10 +338,8 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>  	} while (0)

>  #define TST_EXP_FAIL_PTR_NULL_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)      \
> -	do {                                                                   \
>  		TST_EXP_FAIL_PTR_(SCALL, #SCALL, NULL,                         \
> -			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);        \
> -	} while (0)
> +			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);
+1

>  #define TST_EXP_FAIL_PTR_VOID(SCALL, EXP_ERR, ...)                         \
>  	do {                                                                   \
> @@ -314,10 +349,8 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>  	} while (0)

>  #define TST_EXP_FAIL_PTR_VOID_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)      \
> -	do {                                                                   \
>  		TST_EXP_FAIL_PTR_(SCALL, #SCALL, (void *)-1,                   \
> -			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);        \
> -	} while (0)
> +			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);
+1

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
>  	do {                                                                   \

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
