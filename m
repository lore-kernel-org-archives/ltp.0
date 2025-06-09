Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ABAC61DB2
	for <ltp@archiver.kernel.org>; Mon,  9 Jun 2025 06:32:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8420C3CAC6A
	for <ltp@archiver.kernel.org>; Mon,  9 Jun 2025 08:32:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54C0F3C1BC2
 for <ltp@lists.linux.it>; Mon,  9 Jun 2025 08:32:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 661EF20091A
 for <ltp@lists.linux.it>; Mon,  9 Jun 2025 08:32:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4286621191;
 Mon,  9 Jun 2025 06:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749450722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T14JqY/mvXtoKt1KElwH3tXFrZH0w2xIn5vvsXpNBzU=;
 b=gTvjtw5YnrqjtI1pXCILh4tZtek9y3k95/hH/4lNZyVkcq7Tnj4lRyURqMr9xXKfqjmWNu
 hBAA+bYWczZD96gneBUALrQqs7i6O8Es9aQdJeZjr9nm13GPzN/6ybFTMbZ4lORAYQupAP
 TvF6kHzHwknFdlCBMEs8NS96t4r8wcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749450722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T14JqY/mvXtoKt1KElwH3tXFrZH0w2xIn5vvsXpNBzU=;
 b=/jGR1bqSuQSih41YYOkqdUfiYK9ONihI2vPKh/MPhe3WVeI1NOwwbTEKc6xVpGQrTc3kSJ
 pKX9QbLWNmSaTaDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gTvjtw5Y;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/jGR1bqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749450722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T14JqY/mvXtoKt1KElwH3tXFrZH0w2xIn5vvsXpNBzU=;
 b=gTvjtw5YnrqjtI1pXCILh4tZtek9y3k95/hH/4lNZyVkcq7Tnj4lRyURqMr9xXKfqjmWNu
 hBAA+bYWczZD96gneBUALrQqs7i6O8Es9aQdJeZjr9nm13GPzN/6ybFTMbZ4lORAYQupAP
 TvF6kHzHwknFdlCBMEs8NS96t4r8wcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749450722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T14JqY/mvXtoKt1KElwH3tXFrZH0w2xIn5vvsXpNBzU=;
 b=/jGR1bqSuQSih41YYOkqdUfiYK9ONihI2vPKh/MPhe3WVeI1NOwwbTEKc6xVpGQrTc3kSJ
 pKX9QbLWNmSaTaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19D8B137FE;
 Mon,  9 Jun 2025 06:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eQHnBOJ/RmhJaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Jun 2025 06:32:02 +0000
Date: Mon, 9 Jun 2025 08:32:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250609063200.GA1402165@pevik>
References: <20250606132100.20145-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250606132100.20145-1-chrubis@suse.cz>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4286621191
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [RFC] doc: Add testers guide
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

very nice reading, thank you!

I found one more typo to these which Ricardo and Alok Tiwari found:

+and skill one cay say as much as is needed write the kernel code.
cay -> can

With these typo fixed:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +It's a good idea to start small with an evironment that models your production.
> +Once that works well you can try different configurations. Select a few
> +interesting ones and run them for some time in order to get an idea of their
> +usefulness. If you are feeling adventurous you may try to measure and compare
> +actual test coverage with one of the tools such as lcov. If you do so do not

People can use search engines, but maybe having lcov, pareto principle and kirk as links?

`lcov <https://github.com/linux-test-project/lcov>`_.

Maybe point out in "Debugging test failures" section about `-iN` or `-IN`
possibility and that how single core vs. more cores can influence the result?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
