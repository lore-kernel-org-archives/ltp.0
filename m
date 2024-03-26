Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B266C6FD1F
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 10:55:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 060A23CE526
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 11:55:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 634B83CB931
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 11:55:33 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9ACE31002043
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 11:55:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E82253718F;
 Tue, 26 Mar 2024 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711450530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7yP5Q2upXXTvpOkyquH3T6G38S3ALwqYSFx3UpVucw=;
 b=fFbNbkC+jDXTnuPcUrKxyIapChNbwLs/KPsTBgfBUTmsc2Wf+Oitxnv/WcZv+4WwULIfTn
 m7x42uYGQqWJuOKdlug/kRI1oipduQHmbnHhh8WPR+aLiX1N00G2gKVgGSM2cvEIK3mpLM
 1M4aYN1zUYiehwcyr8ZI8SQYSy2sE/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711450530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7yP5Q2upXXTvpOkyquH3T6G38S3ALwqYSFx3UpVucw=;
 b=SQKcb45cHesBhS/izsdQuTO960U0kFEhigQE8rE0N8qnTu9QNJpaIW3xPDXbvq06n9zWuu
 wqZkjTLIt6liYTBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711450529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7yP5Q2upXXTvpOkyquH3T6G38S3ALwqYSFx3UpVucw=;
 b=hwFKLPa2Y/WOmeWx7cie1nnCjHOFUET+CsWSntCPBNH3MfPjo6B5f3qBGhmNN8z0jtW186
 RJg61Iap/EjILtvAq1NaKPmtGQ/hsfEUEXFK8QHT752jWuPg0ROIjtQ8inE9FTWHUiRfN3
 O6cDZQJiOt0DdcSqySFZ6V2tF8/sQ1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711450529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7yP5Q2upXXTvpOkyquH3T6G38S3ALwqYSFx3UpVucw=;
 b=IXO/1zzVETo2Dk5PiSGN9OFsKqef0oJ7RX1BAELukykLBgnlBLoz3t11S0rDcIE8zRuxv+
 25mzFFXmgNWm1OAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0BEE13306;
 Tue, 26 Mar 2024 10:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7qEBMaGpAmaJCAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 26 Mar 2024 10:55:29 +0000
Date: Tue, 26 Mar 2024 11:54:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZgKpbr1tZwhMvZNF@yuki>
References: <20240117125227.24700-1-wegao@suse.com>
 <20240208013224.859-1-wegao@suse.com>
 <20240208013224.859-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240208013224.859-2-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.86 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.06)[61.75%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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
> +#define TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, FAIL_PTR_VAL,                  \
> +	ERRNOS, ERRNOS_CNT, ...)                                               \
> +	do {                                                                   \
> +		TESTPTR(SCALL);                                                \
> +		                                                               \
> +		TST_PASS = 0;                                                  \
> +		                                                               \
> +		if (TST_RET_PTR != FAIL_PTR_VAL) {                             \
> +			TST_MSG_(TFAIL, " succeeded", SSCALL, ##__VA_ARGS__);  \
> +		        break;                                                 \
> +		}                                                              \
> +		                                                               \
> +		if (!tst_errno_in_set(TST_ERR, ERRNOS, ERRNOS_CNT)) {          \
> +			char tst_str_buf__[ERRNOS_CNT * 20];                   \
> +			TST_MSGP_(TFAIL | TTERRNO, " expected %s",             \
> +				  tst_errno_names(tst_str_buf__,               \
> +						  ERRNOS, ERRNOS_CNT),         \
> +				  SSCALL, ##__VA_ARGS__);                      \
> +			break;                                                 \
> +		}                                                              \
> +                                                                               \
> +		TST_PASS = 1;                                                  \
> +                                                                               \
> +	} while (0)
> +
>  #define TST_EXP_FAIL_ARR_(SCALL, SSCALL, EXP_ERRS, EXP_ERRS_CNT, ...)          \
>  	do {                                                                   \
>  		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, SSCALL,              \
> @@ -258,6 +283,40 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>  		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
>  		                  ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);
>  
> +#define TST_EXP_FAIL_PTR_NULL(SCALL, EXP_ERR, ...)                             \
> +	do {                                                                   \
> +		int tst_exp_err__ = EXP_ERR;                                   \
> +		TST_EXP_FAIL_SILENT_PTR_(SCALL, #SCALL, NULL,                  \
> +			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
> +		if (TST_PASS)                                                  \
> +			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
> +	} while (0)

Given that the if (TST_PASS) message is same in all the cases we could
as well add TST_EX_FAIL_PTR_() and simplify all the
TST_EXP_FAIL_PTR_{NULL,ARR_NULL,VOID,ARR_VOID} to be build on the top of
that.

Other than that it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
