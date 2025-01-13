Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94169E7719E
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 11:50:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 809FB3C7848
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 12:50:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 477203C286F
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 12:49:55 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 563971400F47
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 12:49:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4CF761F37C;
 Mon, 13 Jan 2025 11:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736768993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ts0CL94fSXOhpQFYWn2HKDMn3BE8EZbIUJpg/HnbNc8=;
 b=OkxJ4ZTHj6rU0tCdPS3FzgoGRMEno/Iw6X8y/++vSyYZ0B73Z9561olP4CkYQZ2UVnLOQ6
 iKYY6ACor+sSFFQzPxleRfxxjZcB5cRrF/0sFxKRHcBGkU/m57/+0TxJa/JyQvVOzkMzeM
 yhV0AZEvxwgV6oIf3gF4cIiBGzplk5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736768993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ts0CL94fSXOhpQFYWn2HKDMn3BE8EZbIUJpg/HnbNc8=;
 b=esHtMtNQLBzmavf0XPOQ8BoXcZV2fxK0X9xyIUNNs24allL+ViEk95Q2ZV6oaJJKdLPT+3
 9Dhpak9rB3eCgjBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OkxJ4ZTH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=esHtMtNQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736768993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ts0CL94fSXOhpQFYWn2HKDMn3BE8EZbIUJpg/HnbNc8=;
 b=OkxJ4ZTHj6rU0tCdPS3FzgoGRMEno/Iw6X8y/++vSyYZ0B73Z9561olP4CkYQZ2UVnLOQ6
 iKYY6ACor+sSFFQzPxleRfxxjZcB5cRrF/0sFxKRHcBGkU/m57/+0TxJa/JyQvVOzkMzeM
 yhV0AZEvxwgV6oIf3gF4cIiBGzplk5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736768993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ts0CL94fSXOhpQFYWn2HKDMn3BE8EZbIUJpg/HnbNc8=;
 b=esHtMtNQLBzmavf0XPOQ8BoXcZV2fxK0X9xyIUNNs24allL+ViEk95Q2ZV6oaJJKdLPT+3
 9Dhpak9rB3eCgjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39E0E13310;
 Mon, 13 Jan 2025 11:49:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UF67DeH9hGdlBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 13 Jan 2025 11:49:53 +0000
Date: Mon, 13 Jan 2025 12:53:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z4T-0Xk9-sKfPfR-@rei>
References: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
 <20250109-fix_setsid_tests-v3-9-2ce60c904019@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250109-fix_setsid_tests-v3-9-2ce60c904019@suse.com>
X-Rspamd-Queue-Id: 4CF761F37C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/12] Add TST_EXP_EQ_STRN macro
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
> +#define TST_EXP_EQ_STRN(STR_A, STR_B, LEN) do {                                \
> +	TST_PASS = strncmp(STR_A, STR_B, LEN) == 0;                            \
> +                                                                               \
> +	if (TST_PASS) {                                                        \
> +		tst_res_(__FILE__, __LINE__, TPASS,                            \
> +			"%s == %s (%s)",                                       \
> +			#STR_A, #STR_B, STR_B);                                \
> +	} else {                                                               \
> +		tst_res_(__FILE__, __LINE__, TFAIL,                            \
> +			"%s (%s) != %s (%s)",                                  \
> +			#STR_A, STR_A, #STR_B, STR_B);                         \

Passing these strings to printf-like function is not safe at all, since
they are possibly not nul terminated. If we realy wanted to print them
we would have to copy them and nul terminated them.

e.g.

	char str_a_cpy[LEN+1], str_b_cpy[LEN+1];

	strncpy(str_a_cpy, STR_A, LEN);
	str_a_cpy[LEN] = 0;
	strncpy(str_b_cpy, STR_B, LEN);
	str_b_cpy[LEN] = 0;

	...

		tst_res_(...., str_b_cpy, ...);

> +	}                                                                      \
> +} while (0)
> +
>  #endif	/* TST_TEST_MACROS_H__ */
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
