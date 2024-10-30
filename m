Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37E0D5CC9F
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 12:07:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE28D3CAE09
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 13:07:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D20F3CA873
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 13:07:04 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 047A3142E64D
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 13:07:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E78121E50;
 Wed, 30 Oct 2024 12:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730290023;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTCE3uGiXSjnuIhflTxxQ2/FO9uxSJ7BRYRyEXER2bI=;
 b=mpA88qVdvj/3Ox61V2PzD6veO/ZBTLDtPgs+MpbfwrgOqvJ0h/EB5DR4DMDrJ/mizEioSf
 gVaKw9cE/ynPowW+BjX1L4f+MYHcO0boAqW2sE5T+MVHll6xtbetCqolyCoNahn6P+biPp
 fqOpvz1Keb7IEy6SMexLXKJKcWLF/ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730290023;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTCE3uGiXSjnuIhflTxxQ2/FO9uxSJ7BRYRyEXER2bI=;
 b=rtypmWUXX8QkN358gwYKuWFHZWTBoL5LMefZDrLoIb5r7Ym/Z/3nH/PPKiAlt/WyCe/Tt7
 GM7JJj8pcwuGTTAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730290023;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTCE3uGiXSjnuIhflTxxQ2/FO9uxSJ7BRYRyEXER2bI=;
 b=mpA88qVdvj/3Ox61V2PzD6veO/ZBTLDtPgs+MpbfwrgOqvJ0h/EB5DR4DMDrJ/mizEioSf
 gVaKw9cE/ynPowW+BjX1L4f+MYHcO0boAqW2sE5T+MVHll6xtbetCqolyCoNahn6P+biPp
 fqOpvz1Keb7IEy6SMexLXKJKcWLF/ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730290023;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTCE3uGiXSjnuIhflTxxQ2/FO9uxSJ7BRYRyEXER2bI=;
 b=rtypmWUXX8QkN358gwYKuWFHZWTBoL5LMefZDrLoIb5r7Ym/Z/3nH/PPKiAlt/WyCe/Tt7
 GM7JJj8pcwuGTTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE04513AD9;
 Wed, 30 Oct 2024 12:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I4jjM2YhImdLVgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Oct 2024 12:07:02 +0000
Date: Wed, 30 Oct 2024 13:06:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241030120645.GA888753@pevik>
References: <20241030084558.195297-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241030084558.195297-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Print failure hints only once to reduce log
 duplication
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

Hi all,

> The LTP test currently prints failure hints multiple times if a test
> encounters several TFAIL or TBROK results. This leads to unnecessarily
> verbose and duplicated logs.

> This patch modifies the `print_failure_hints()` function to ensure that
> failure hints are printed only once per test run. By setting `show_failure_hints`
> to 0 after the first print, subsequent calls to `print_failure_hints()`
> will not produce redundant output.

> Fixes: 701212f08 ("Disable failure hints before we actually run the test")
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Cyril Hrubis <chrubis@suse.cz>
...

> +++ b/lib/tst_test.c
> @@ -911,6 +911,8 @@ static void print_failure_hints(void)
>  	print_failure_hint("musl-git", "missing musl fixes", MUSL_GIT_URL);
>  	print_failure_hint("CVE", "vulnerable to CVE(s)", CVE_DB_URL);
>  	print_failure_hint("known-fail", "hit by known kernel failures", NULL);
> +
> +	show_failure_hints = 0;

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
