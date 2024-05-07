Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA58C10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 12:51:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 318863CDCD5
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 14:51:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A8CE3CDB74
 for <ltp@lists.linux.it>; Tue,  7 May 2024 14:51:14 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0D972600069
 for <ltp@lists.linux.it>; Tue,  7 May 2024 14:51:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE0F9209FF;
 Tue,  7 May 2024 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715086272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=38Sps/8QdE/3k1QUSt0AoqAaStWtIQ9VOCOrWKZpEr8=;
 b=kkLb3jqNrFOYL3dHb4pTwVHbwodVtxYJYpnd5wVtWVtSh9zdDdOdSh/vsP10SqXtMK2eQj
 Qv1ujVg87aLxMmPW5y++tFL7CL+GLc38hqDR/e3uHhz80B4nHZsrE0Q/JOW4E9bUlIRYT4
 o7M+Uz+FY4KuYPIJngZowzT/XyQM4Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715086272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=38Sps/8QdE/3k1QUSt0AoqAaStWtIQ9VOCOrWKZpEr8=;
 b=gXMsKaK+qkTXUP2O3Ssa+QqwqTrLS7leAKD7fsxeBZeVGPPDnTjRIrlG5WAkObe7iGeuPU
 zU+WIc7M9ZPYPBAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715086272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=38Sps/8QdE/3k1QUSt0AoqAaStWtIQ9VOCOrWKZpEr8=;
 b=kkLb3jqNrFOYL3dHb4pTwVHbwodVtxYJYpnd5wVtWVtSh9zdDdOdSh/vsP10SqXtMK2eQj
 Qv1ujVg87aLxMmPW5y++tFL7CL+GLc38hqDR/e3uHhz80B4nHZsrE0Q/JOW4E9bUlIRYT4
 o7M+Uz+FY4KuYPIJngZowzT/XyQM4Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715086272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=38Sps/8QdE/3k1QUSt0AoqAaStWtIQ9VOCOrWKZpEr8=;
 b=gXMsKaK+qkTXUP2O3Ssa+QqwqTrLS7leAKD7fsxeBZeVGPPDnTjRIrlG5WAkObe7iGeuPU
 zU+WIc7M9ZPYPBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE1C2139CB;
 Tue,  7 May 2024 12:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QO1RLcAjOmZNGwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 May 2024 12:51:12 +0000
Date: Tue, 7 May 2024 14:50:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <ZjojkXpTTleALvrQ@yuki>
References: <20240506070336.2711930-2-lufei@uniontech.com>
 <20240507043235.1692-1-lufei@uniontech.com>
 <20240507043235.1692-2-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240507043235.1692-2-lufei@uniontech.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add case about arch_prctl syscall.
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
> +static void run(unsigned int index)
> +{
> +	struct tcase tc = tcases[index];
> +
> +	TEST(arch_prctl_set(ARCH_SET_CPUID, tc.input));
> +
> +	if (TST_RET == tc.set_exp)
> +		if (tc.set_exp == -1)
> +			tst_res((TST_ERR == tc.tst_errno ? TPASS : TFAIL),
> +				"set cpuid, expect: %s, get: %s",
> +				tst_strerrno(tc.tst_errno),
> +				tst_strerrno(TST_ERR));
> +		else
> +			tst_res(TPASS, "set cpuid succeed.");
> +	else
> +		tst_res(TFAIL, "set cpuid failed.");

This is kind of ugly, why can't we just do:

	if (tag)
		TST_EXP_PASS(arch_prctl_set(ARCH_SET_CPUID, index));
	else
		TST_EXP_FAIL(arch_prctl_set(ARCH_SET_CPUID, index), ENODEV);

> +	TEST(arch_prctl_get(ARCH_GET_CPUID));
> +
> +	if (TST_RET == tc.get_exp)
> +		tst_res(TPASS, "get cpuid succeed.");
> +	else
> +		tst_res(TFAIL, "get cpuid failed.");


We have to check the errno here as well, just branch on the tag as well:

	if (tag) {
		TEST(arch_prctl_get(ARCH_GET_CPUID));

		if (TST_RET == index)
			tst_res(TPASS, "...");
		else
			tst_res(FAIL, "...");
	} else {
		TST_EXP_FAIL(arch_prctl_get(ARCH_GET_CPUID), ENODEV);
	}

Generally the use of TST_EXP_FAIL() is prefered whenever possible.

> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.min_kver = "4.12",
> +	.supported_archs = (const char *const []){"x86_64", "x86", NULL}
> +};
> +
> +#else /* HAVE_ASM_PRCTL_H */
> +TST_TEST_TCONF("missing <asm/prctl.h>");
> +#endif
> -- 
> 2.39.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
