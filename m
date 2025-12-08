Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D741DD3B7F3
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 15:15:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B73023CF55A
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 16:15:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7188B3CF32A
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 16:15:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 631DA600649
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 16:15:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04C925BCC9;
 Mon,  8 Dec 2025 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765206930;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/q/95H93dz756pHrJDTcuqUt1KoChqN2QTtAF/FE46Q=;
 b=zwhWted8Q9uqPT56AyiiX2q+ER4ZtEFO8X5m4EKtFGo4+Fjpy2FsF14ZwpyKFLd2yecIfD
 jP//i+/sl8kBUTrTADGBho/H1Y5AW+0CC2zHaOOA//zpoW/yXbIebyBab4EJ49igEJoli+
 gbQQY3FnjVcnledzfExN/cG/xY7PyH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765206930;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/q/95H93dz756pHrJDTcuqUt1KoChqN2QTtAF/FE46Q=;
 b=/MvwlxjixyyyAdKoJyxYfPU47qTFNaukV0vcFDQ+JLzPtiPpVQiH487Pa+XtCrWPhNdi+Q
 YXnFUPYIJS+QwpAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765206929;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/q/95H93dz756pHrJDTcuqUt1KoChqN2QTtAF/FE46Q=;
 b=p10RL+TqF+NiVQo2o/Yc7R5OAwrfRTVhvAhuVrmuB6K0ti8+4N/UxwagEoNZTrKXM7C4mu
 cV/9ahGhJRm/1GCz8/AJPKfs02yzXYFZGIyolR8pmNLnOCherJT9vhy0wP6AsfFUFANqZn
 Knhjp/5NQc4LAu12bQm9gneru9ntcQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765206929;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/q/95H93dz756pHrJDTcuqUt1KoChqN2QTtAF/FE46Q=;
 b=H22Fvrhls0CVolC00h8jFVz+NCb3sb3971CArcIxPNeVK1WqgUvwjeAAgF/KIiNblK/2zN
 R/HbeIUBf71thOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C89F63EA63;
 Mon,  8 Dec 2025 15:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E0NLL5DrNmmCYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Dec 2025 15:15:28 +0000
Date: Mon, 8 Dec 2025 16:15:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: simplemessager@163.com
Message-ID: <20251208151527.GA704055@pevik>
References: <20251205031719.53914-1-simplemessager@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251205031719.53914-1-simplemessager@163.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[163.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[163.com]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,chinatelecom.cn:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,ozlabs.org:url];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Skip wqueue testcases when KEY_NOTIFICATIONS
 not enabled.
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
Cc: Meng Yang <yangm50@chinatelecom.cn>, ltp@lists.linux.it,
 Mingyu Li <limy83@chinatelecom.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mingyu, Meng,

I sent an alternative approach for this. Could you please retest it.

https://lore.kernel.org/ltp/20251208150542.704006-1-pvorel@suse.cz/T/#t
https://patchwork.ozlabs.org/project/ltp/list/?series=484779&state=*

> From: Mingyu Li <limy83@chinatelecom.cn>

> Skip wqueue testcases when KEY_NOTIFICATIONS not enabled.

> wqueue testcases relys on both CONFIG_WATCH_QUEUE
> and CONFIG_KEY_NOTIFICATIONS. keyctl will return EOPNOTSUPP
> when CONFIG_KEY_NOTIFICATIONS is not enabled and the wqueue
> testcases will failed when timeout. So we should skip
> testcases when we got EOPNOTSUPP from keyctl.

> Reported-by: Meng Yang <yangm50@chinatelecom.cn>
> Signed-off-by: Mingyu Li <limy83@chinatelecom.cn>
> ---
>  testcases/kernel/watchqueue/common.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/watchqueue/common.h b/testcases/kernel/watchqueue/common.h
> index 92e8f079c..e9100ab52 100644
> --- a/testcases/kernel/watchqueue/common.h
> +++ b/testcases/kernel/watchqueue/common.h
> @@ -85,8 +85,26 @@ static inline key_serial_t wqueue_add_key(int fd)
>  	if (key == -1)
>  		tst_brk(TBROK, "add_key error: %s", tst_strerrno(errno));

> -	keyctl(KEYCTL_WATCH_KEY, key, fd, 0x01);
> -	keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02);
> +	TEST(keyctl(KEYCTL_WATCH_KEY, key, fd, 0x01));
> +	if (TST_RET) {
> +		switch (TST_ERR) {
> +		case EOPNOTSUPP:
> +			tst_brk(TCONF | TTERRNO, "CONFIG_KEY_NOTIFICATION is not set!");
nit: "| TTERRNO" is not needed, because we know the content of errno:
EOPNOTSUPP.

> +			break;
> +		default:
> +			tst_res(TINFO, "CONFIG_KEY_NOTIFICATION is set.");
> +		}

If your approach is taken, I would simplify it (we don't need TINFO)

	if (keyctl(KEYCTL_WATCH_KEY, key, fd, 0x01) && errno == EOPNOTSUPP)
			tst_brk(TCONF, "CONFIG_KEY_NOTIFICATION is not set!");

	if (keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02) && errno == EOPNOTSUPP)
			tst_brk(TCONF, "CONFIG_KEY_NOTIFICATION is not set!");

Kind regards,
Petr

> +	}
> +	TEST(keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02));
> +	if (TST_RET) {
> +		switch (TST_ERR) {
> +		case EOPNOTSUPP:
> +			tst_brk(TCONF | TTERRNO, "CONFIG_KEY_NOTIFICATION is not set!");
> +			break;
> +		default:
> +			tst_res(TINFO, "CONFIG_KEY_NOTIFICATION is set.");
> +		}
> +	}

>  	return key;
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
