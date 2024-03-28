Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3F3C54E64
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 12:11:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A6363C20B9
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 13:11:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9488E3C1CEC
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 13:11:12 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 920862001DB
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 13:11:10 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 23F7933E4E;
 Thu, 28 Mar 2024 12:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711627868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ozo9Pv+/iW8OPlIo9P84yhcz8T45hhhw6Z6l3rYuzZM=;
 b=WqTB9/oRtOH9OvIxScC46+RUT8fnFJbthm2AexL50ynWr9Aev1OxN0+i9AC/hVpYIGMd0s
 F4fx0X1drwXz5oaLgr/d/L2i5UFXsQ48TazEv8GiqNkbJiGrloTAAWlnurgweHH+bamscy
 C6zTrqk8zdU63lefey+JfgrerbDyE0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711627868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ozo9Pv+/iW8OPlIo9P84yhcz8T45hhhw6Z6l3rYuzZM=;
 b=uRCaSkthuFzZKs+ofdAxTtG4St2XHrKfaNUt26yX69+P8g6KQmgRC+J0/s7s6ZuToSFw8d
 ObYR3FplSH/40zBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711627866;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ozo9Pv+/iW8OPlIo9P84yhcz8T45hhhw6Z6l3rYuzZM=;
 b=CTfVZS0UFhVxWlFYOiwoCRWmL8o20PgG5Hakc2jQhvb8hzlFolXlHjAOWaZilAnZFFF8+T
 ezh2PdFQA7YIwlztAh5x3Oua0IfOxBoC5fJ4jVX3xJ5WuZ75jaXq6JGqMqSo7ChWIoX7Jd
 BY+gLwF+6XkuutUqlHrUQCrW9jqOyt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711627866;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ozo9Pv+/iW8OPlIo9P84yhcz8T45hhhw6Z6l3rYuzZM=;
 b=RQI3AJ1MrI8dHiFKVfD1cVtBRyzgm2HFIIll9Qvc9Nkdq/dNnKbU6+iAdVSn7o3rL+wqAW
 Tca1JuZRHqY6ntAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 09ECA13AF7;
 Thu, 28 Mar 2024 12:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id LxA6AVpeBWaJJQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 28 Mar 2024 12:11:06 +0000
Date: Thu, 28 Mar 2024 13:11:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240328121104.GE51940@pevik>
References: <20240208013224.859-1-wegao@suse.com>
 <20240327034923.30987-1-wegao@suse.com>
 <20240327034923.30987-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240327034923.30987-2-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.05 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.55)[92.11%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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

...
>  #define TST_EXP_FAIL_ARR_(SCALL, SSCALL, EXP_ERRS, EXP_ERRS_CNT, ...)          \
>  	do {                                                                   \
>  		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, SSCALL,              \
> @@ -258,6 +293,32 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>  		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
>  		                  ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);

> +#define TST_EXP_FAIL_PTR_NULL(SCALL, EXP_ERR, ...)                             \
> +	do {                                                                   \
> +		int tst_exp_err__ = EXP_ERR;                                   \
> +		TST_EXP_FAIL_PTR_(SCALL, #SCALL, NULL,                         \
> +			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
> +	} while (0)
> +
> +#define TST_EXP_FAIL_PTR_ARR_NULL(SCALL, EXP_ERRS, ...)                        \
> +	do {                                                                   \
> +		TST_EXP_FAIL_PTR_(SCALL, #SCALL, NULL,                         \
> +			EXP_ERRS, ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);        \

FYI I send a patch [1] (Cyril's suggestion) replacing ARRAY_SIZE() with just
size parameter. I.e. moving ARRAY_SIZE() to the caller. This allows to use array
of expected errnos more flexibly, e.g. fanotify14 [2].

Could you please send another version, which will be based on my v3 patchset or
just wait before it's merged and rebase?

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20240326144145.747735-3-pvorel@suse.cz/
[2] https://lore.kernel.org/ltp/20240326144145.747735-4-pvorel@suse.cz/
[3] https://patchwork.ozlabs.org/project/ltp/list/?series=400495

> +	} while (0)
> +
> +#define TST_EXP_FAIL_PTR_VOID(SCALL, EXP_ERR, ...)                             \
> +	do {                                                                   \
> +		int tst_exp_err__ = EXP_ERR;                                   \
> +		TST_EXP_FAIL_PTR_(SCALL, #SCALL, (void *)-1,                   \
> +			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
> +	} while (0)
> +
> +#define TST_EXP_FAIL_PTR_ARR_VOID(SCALL, EXP_ERRS, ...)                        \
> +	do {                                                                   \
> +		TST_EXP_FAIL_PTR_(SCALL, #SCALL, (void *)-1,                   \
> +			EXP_ERRS, ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);        \
> +	} while (0)
> +

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
