Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50050C88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 11:57:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C5E03E920B
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:57:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FCF13CD382
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 13:57:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A86111A002EF
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 13:57:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B233521D37;
 Fri, 11 Sep 2026 11:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789127818;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncqa02+i7Ed2GDi8ruKXLSGI2brx1Nr0dechlFn0ZFA=;
 b=C38WsCTfjzxNIRYDEG6XgNnbVvOTyRwzAZRN24DGJ1MP7wQO4ybauv075ehYKXYorijKzX
 XxgU04T/504w3+w+B/qGPGXqrxchP/WSW66MLfj65D2qCN4jFKUQ0Qm9WlOPYPmdPCuvd7
 5gG+VlGCI4qM7GMfgEmuMMmT/hT34Hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789127818;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncqa02+i7Ed2GDi8ruKXLSGI2brx1Nr0dechlFn0ZFA=;
 b=EW+pV2+C4semfc1uko5RFG5JSlSBskneHkg6bAozxMCnYqwy0sqcN5yYPCHfdjQpLApFs5
 u6OS4+HT0da+lqAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789127814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncqa02+i7Ed2GDi8ruKXLSGI2brx1Nr0dechlFn0ZFA=;
 b=nJTO4339DlcJIveSOM3hbhLlYedXXGgEM2FH/geZeu1wNTd2TcUHsCW7QfDMWzV7fLd2LG
 ObkOT4NVW4yLFBbWObPxLoI57skrlfpKIMH4AOMNkCQuuxchUFBtEdDC5JUKgVXbl/hAu3
 gyixz/vy+uVy3d2Zvu1wv01Fm7eH6lE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789127814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncqa02+i7Ed2GDi8ruKXLSGI2brx1Nr0dechlFn0ZFA=;
 b=N1qtfb2T88Z9oVtAUDNTQQXSIf/G42RlN5aioBwD/vFMAF5mDd6oPIfSqr23wVk/zAYczW
 mDanrHeJY/MUXFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70F20136ED;
 Fri, 11 Sep 2026 11:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5WlqGobso2oaXQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 11:56:54 +0000
Date: Fri, 11 Sep 2026 13:56:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260911115649.GE1454430@pevik>
References: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
 <20260911-fix_documentation-v2-8-716b2613c477@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260911-fix_documentation-v2-8-716b2613c477@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 8/9] doc: Document CPU and common test helpers
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

...
> +++ b/include/tst_common.h
>  /**
>   * TST_RETRY_FUNC() - Repeatedly retry a function with an increasing delay.
> - * @FUNC - The function which will be retried
> - * @ECHCK - Function/macro for validating @FUNC return value
>   *
> - * This macro will call @FUNC in a loop with a delay between retries.
> - * If ECHCK(ret) evaluates to non-zero, the loop ends. The delay between
> - * retries starts at one microsecond and is then doubled each iteration until
> - * it exceeds one second (the total time sleeping will be approximately one
> - * second as well). When the delay exceeds one second, the loop will end.
> - * The TST_RETRY_FUNC() macro returns the last value returned by @FUNC.
> + * @FUNC: The function which will be retried.
> + * @ECHCK: Function or macro for validating @FUNC return value.
> + *
> + * This macro will call @FUNC in a loop with an exponential delay between
Interesting @FUNC seems to do the same formatting as ``FUNC`` (@ is maybe less
obvious formatting, but shorter than ``...``).

> + * retries. If ECHCK(ret) evaluates to non-zero, the loop ends. The delay
But it works only on a first item, i.e ECHCK(ret) would have to be formatted
with the usual ``ECHCK(ret)`` (maybe worth to change before merge).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
