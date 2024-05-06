Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108B0C25B4F
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 19:18:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48A033CD970
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 21:18:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B2C03CBB7E
 for <ltp@lists.linux.it>; Mon,  6 May 2024 21:17:44 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1CF6D1400F8F
 for <ltp@lists.linux.it>; Mon,  6 May 2024 21:17:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 615E9225C3;
 Mon,  6 May 2024 19:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715023061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7S6rk1wmSfjGH3w4O6ba2All7wxvcnT2dRwnVhtFZg=;
 b=cYxxvhvFE0H4yy9HIgtTaDBUu6mVDpWgxzogYBxB4ADC2LmHd1FT2+jLQNrNjTb+uZcMYC
 I5laHasiPsLjLyqOyzf3RaupoRPfTvITaq3+DHmtfNrsBdNQwsKqG9H9GkCTUlJjZ17/VA
 mA23Q1tDvgDOCaTTCXvqSTY3PvAJfyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715023061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7S6rk1wmSfjGH3w4O6ba2All7wxvcnT2dRwnVhtFZg=;
 b=Q/axu60pU09hHY2M+Uu3868xFMcjQb0kdM4ufpmh3iBgWqsR3RBlPUMX8/uR/f9Q6Z52/a
 YtMJhuKl94W+OYBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715023061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7S6rk1wmSfjGH3w4O6ba2All7wxvcnT2dRwnVhtFZg=;
 b=cYxxvhvFE0H4yy9HIgtTaDBUu6mVDpWgxzogYBxB4ADC2LmHd1FT2+jLQNrNjTb+uZcMYC
 I5laHasiPsLjLyqOyzf3RaupoRPfTvITaq3+DHmtfNrsBdNQwsKqG9H9GkCTUlJjZ17/VA
 mA23Q1tDvgDOCaTTCXvqSTY3PvAJfyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715023061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7S6rk1wmSfjGH3w4O6ba2All7wxvcnT2dRwnVhtFZg=;
 b=Q/axu60pU09hHY2M+Uu3868xFMcjQb0kdM4ufpmh3iBgWqsR3RBlPUMX8/uR/f9Q6Z52/a
 YtMJhuKl94W+OYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1025B13A25;
 Mon,  6 May 2024 19:17:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e+GQO9QsOWaTTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 May 2024 19:17:40 +0000
Date: Mon, 6 May 2024 21:17:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240506191739.GA36275@pevik>
References: <20220421123351.17645-1-mdoucha@suse.cz>
 <20220421123351.17645-3-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220421123351.17645-3-mdoucha@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add test for CVE 2021-38198
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

Hi Martin, Cyril,

> --- /dev/null
> +++ b/testcases/kernel/kvm/kvm_pagefault01.c
...
> +static void setup(void)
> +{
> +	disable_tdp();
> +	tst_kvm_setup();
> +}
> +
> +static struct tst_test test = {
> +	.test_all = tst_kvm_run,
> +	.setup = setup,
> +	.cleanup = tst_kvm_cleanup,
> +	.needs_root = 1,

This test was merged some time ago.

FYI this .needs_root generates -Wsingle-bit-bitfield-constant-conversion error.
Nothing important, maybe you see an easy way to fix it.

kvm_pagefault01.c:218:16: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
        .needs_root = 1,
                      ^
1 warning generated.

Kind regards,
Petr

> +	.save_restore = (const struct tst_path_val[]) {
> +		{"?/sys/module/kvm/parameters/tdp_mmu", "0"},
> +		{}
> +	},
> +	.supported_archs = (const char *const []) {
> +		"x86_64",
> +		NULL
> +	},
> +	.tags = (struct tst_tag[]){
> +		{"linux-git", "b1bd5cba3306"},
> +		{"CVE", "2021-38198"},
> +		{}
> +	}
> +};
> +
> +#endif /* COMPILE_PAYLOAD */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
