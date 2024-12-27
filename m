Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF4EE7718B
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 10:48:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 309F83EB97D
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 11:48:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97D443E6E82
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 11:48:12 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 85A7E66102F
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 11:48:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A01E62121A;
 Fri, 27 Dec 2024 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735296491;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/r2f89im5R/mbed3GiEYuheUffgKoBYeV0d9+QNsKc=;
 b=AuDSr+XiS9ZVcPcJOsvhW18xdWrnwJTot3NJ81o6xZBa7xYaLottWdFxN9kcMUR/8JkwnQ
 kUMlCkKafCKroT4t8gMi1bUmn2Ko1sFfRPEyKRphWCz5X+2wH9af9bONWy9/nUf8cZOt7G
 RwqUI9HdZ2gijgTbM/wLLUQeFsGwrt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735296491;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/r2f89im5R/mbed3GiEYuheUffgKoBYeV0d9+QNsKc=;
 b=Tcl7H2A59k2zkoF4D4tVLNeemVBs9enIicZnItlql1X5I/4JY5k3QaHTOIcVDOU0l2Gxqh
 pTJ4PmLdojL1AaDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735296491;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/r2f89im5R/mbed3GiEYuheUffgKoBYeV0d9+QNsKc=;
 b=AuDSr+XiS9ZVcPcJOsvhW18xdWrnwJTot3NJ81o6xZBa7xYaLottWdFxN9kcMUR/8JkwnQ
 kUMlCkKafCKroT4t8gMi1bUmn2Ko1sFfRPEyKRphWCz5X+2wH9af9bONWy9/nUf8cZOt7G
 RwqUI9HdZ2gijgTbM/wLLUQeFsGwrt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735296491;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/r2f89im5R/mbed3GiEYuheUffgKoBYeV0d9+QNsKc=;
 b=Tcl7H2A59k2zkoF4D4tVLNeemVBs9enIicZnItlql1X5I/4JY5k3QaHTOIcVDOU0l2Gxqh
 pTJ4PmLdojL1AaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 432C913A30;
 Fri, 27 Dec 2024 10:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tiDNCuuFbme0WQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Dec 2024 10:48:11 +0000
Date: Fri, 27 Dec 2024 11:48:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241227104805.GD317565@pevik>
References: <20241218184518.16190-1-chrubis@suse.cz>
 <20241218184518.16190-7-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241218184518.16190-7-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 06/13] testcases/kernel/mem: Move check_hugepage()
 + PATH_THP
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

> +#define PATH_THP "/sys/kernel/mm/transparent_hugepage/"
> +
> +static inline void check_hugepage(void)
> +{
> +        if (access(PATH_HUGEPAGES, F_OK))
> +                tst_brk(TCONF, "Huge page is not supported.");
> +}

I guess we don't want to move this into static inline function (used only in 2
tests.

	if (access(PATH_THP, F_OK) == -1)
		tst_brk(TCONF, "THP not enabled in kernel?");

I also wonder if we should add to the library struct tst_test test something
like .requires_proc_sys which would check for files in /sys or /proc. There
could be an optional parameter for TCONF message. Advantage would be to have
this in docparse docs (or isn't it useful to see this)?

We have .save_restore, but that's only for files and it reads the value.
But it could share the flags (TST_SR_TCONF, TST_SR_TBROK, TST_SR_SKIP, ...).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
