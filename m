Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FC3C54E58
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 09:29:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA39D3CFBBF
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 10:29:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CFF83CE639
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 10:29:29 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0AF1910167F4
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 10:29:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3706353C9;
 Thu, 21 Mar 2024 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711013368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tY4mGODYPMtLPPUsCusCLd3kE9lgSipuaIKWzjI/Etw=;
 b=NayvFa0M8YSjo/wYD0hYbfylouWIidTrs66TyFLxkm8x3G0JY1ci3tuNlwv93xDp2295T0
 PGNoB3a7YiquhZJNkQHqzlkI4NOTvTuS2j6DwMYs9uC+CtsNRNAdCBYa2vcwcREGLGRZ9v
 Znip4kuNdp+Q11wMYvHG+br+srdgD7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711013368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tY4mGODYPMtLPPUsCusCLd3kE9lgSipuaIKWzjI/Etw=;
 b=JivwyDhTqu0myLpdSDeA8LDZ/brT5dQTzpZbGj2Y/MXnPYFJ2lDZJ+2+hS1yj6KlxXSB1M
 81kDE1vSE/esTXAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711013367;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tY4mGODYPMtLPPUsCusCLd3kE9lgSipuaIKWzjI/Etw=;
 b=Bj+YIIjlcCzAd3zaXrrXWg/PdwrtSasxH+8whQR50tNmjbZ3VthsnK05HUkqFH6w9XJsQ2
 Zvqr4JrVnv1bzw6HBtpgRSz9FGSa2HAC7AMxYwH+wG5uiLCwZ/o2s8I+030mT9TbLoiSKU
 0vEgrS2UevbDMvwHjq2+i1zHGONVKPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711013367;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tY4mGODYPMtLPPUsCusCLd3kE9lgSipuaIKWzjI/Etw=;
 b=ykzBTcDntIS1f0+S3UAz57Wy7TzxkQMtBpM/6mjflTilYlM0IIZbbZWKAvUv3hUksA0kuC
 gP2q4ho021/YyMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0F7B13976;
 Thu, 21 Mar 2024 09:29:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2gYTMvf9+2XKCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 21 Mar 2024 09:29:27 +0000
Date: Thu, 21 Mar 2024 10:29:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240321092922.GA548078@pevik>
References: <20240320095927.19973-1-chrubis@suse.cz>
 <20240320095927.19973-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240320095927.19973-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-0.56 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.06)[61.74%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls: Add test for splicing from
 /dev/zero and /dev/full
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

Hi Cyril,

> +static void test_splice(unsigned int bytes, int dev_fd)
> +{
> +	int pipefd[2];
> +	char buf[bytes];
> +	size_t i;
> +	int fail = 0;
> +
> +	memset(buf, 0xff, sizeof(buf));
> +
> +	SAFE_PIPE(pipefd);
> +
> +	TST_EXP_POSITIVE(splice(dev_fd, NULL, pipefd[1], NULL, sizeof(buf), 0));
> +
> +	if (!TST_PASS)
> +		goto ret;
> +
> +	SAFE_READ(1, pipefd[0], buf, sizeof(buf));
> +
> +	for (i = 0; i < sizeof(buf); i++) {
> +		if (buf[i])
> +			fail++;
> +	}
> +
> +	if (fail)
> +		tst_res(TFAIL, "Non-zero bytes spliced from /dev/zero");
Maybe write how many fail we have?

I also agree with Jan's comment about missing TST_RET, which is in splice09.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +	else
> +		tst_res(TPASS, "All bytes spliced from /dev/zero are zeroed");
> +
> +ret:
> +	SAFE_CLOSE(pipefd[0]);
> +	SAFE_CLOSE(pipefd[1]);
> +}
> +
> +static void verify_splice(unsigned int n)
> +{
> +	unsigned int bytes = 1009 * n;

Out of curiosity, why 1009 and not 1000?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
