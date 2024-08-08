Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DBAC3DA4A
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 09:58:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A72A03D204A
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 11:58:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B9E23D1EB2
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 11:58:27 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4C418600F3B
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 11:58:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9BD3C21AFD;
 Thu,  8 Aug 2024 09:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723111105;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmXrvYzPZND725QiQYDiOwgS4/05buZ65qoBwqI4gFs=;
 b=iyMnauUKjOuTDCcPchd94PepbYVJT9gjQHqLr8ucD9iXG1sDfqsfBgXAzb3CBFHenxoK+W
 5Vezvl8bcLPwxMvivXeNlK5Nf6+cHm+twOvfEshs+Xta2wuc2t7AJuh5x9ECEgvgbadZyG
 vWcJLgrKse34NyyWG2mS+bYmdoDdzHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723111105;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmXrvYzPZND725QiQYDiOwgS4/05buZ65qoBwqI4gFs=;
 b=kYtHsXRRsnBRseLz/Q5tKeLh0atwn/agrFx4AOa5msLSujlr3/SV46TPxJ3wfWTzpCZB+L
 az6XlrL7VpdT7bDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723111105;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmXrvYzPZND725QiQYDiOwgS4/05buZ65qoBwqI4gFs=;
 b=iyMnauUKjOuTDCcPchd94PepbYVJT9gjQHqLr8ucD9iXG1sDfqsfBgXAzb3CBFHenxoK+W
 5Vezvl8bcLPwxMvivXeNlK5Nf6+cHm+twOvfEshs+Xta2wuc2t7AJuh5x9ECEgvgbadZyG
 vWcJLgrKse34NyyWG2mS+bYmdoDdzHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723111105;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmXrvYzPZND725QiQYDiOwgS4/05buZ65qoBwqI4gFs=;
 b=kYtHsXRRsnBRseLz/Q5tKeLh0atwn/agrFx4AOa5msLSujlr3/SV46TPxJ3wfWTzpCZB+L
 az6XlrL7VpdT7bDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77AC313876;
 Thu,  8 Aug 2024 09:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nhmzG8GWtGYNLgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Aug 2024 09:58:25 +0000
Date: Thu, 8 Aug 2024 11:58:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240808095824.GC327665@pevik>
References: <20240801-landlock-v5-0-663d7383b335@suse.com>
 <20240801-landlock-v5-3-663d7383b335@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240801-landlock-v5-3-663d7383b335@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/6] Disable kernel version check in landlock
 tests
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
Cc: =?iso-8859-2?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 =?iso-8859-2?Q?G=FCnther?= Noack <gnoack@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> The reason why we remove kernel version check is that we use
> verify_landlock_is_enabled() function in order to check if landlock is
> present in the system. This is really helpful when landlock support has
> been backported into old kernels.

Great, I'm glad you removed it from all landlock tests. It really did not make
sense to guard correct version with 3 guards (kernel version, kernel config and
ABI). Could you please remove also CONFIG_SECURITY_LANDLOCK=y, because you
check EOPNOTSUPP in verify_landlock_is_enabled().

Anyway, feel free to merge these first 3 patches (ideally remove also
CONFIG_SECURITY_LANDLOCK=y before merge).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
