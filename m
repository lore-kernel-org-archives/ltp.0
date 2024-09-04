Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58964CD3431
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 08:53:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B727C3C1C89
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 10:53:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20EC03C0596
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 10:53:27 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 09E7E14098DC
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 10:53:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B1E01F7A7;
 Wed,  4 Sep 2024 08:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725440004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPDWdkHj02f4krcbpGwRKMjXNtF+XUjmgV1Llq2eJ7w=;
 b=MrWed2XLzVrJy/X0kxhFgeTF+VbsDRVFd2q6qPuyjBAptR8jy+pJLC93nkGxjpDy7YFJBc
 SvriVjsmljemuI8kTdxL2wGY7K401TPL0kYNLZZOpVctA9ojYSayjf3DXQSx5Vbds9+Tw8
 MsxmsjGBqqHHRGMj+mKQV1mZdoX2s6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725440004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPDWdkHj02f4krcbpGwRKMjXNtF+XUjmgV1Llq2eJ7w=;
 b=4lS5/r3wq07QawOUGVyHSKmuDJdevjL4GBs+phwMXM025p7FFAi6lE/jKh73AXdkV64ZLD
 Oya3uEQme2hhxwDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725440004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPDWdkHj02f4krcbpGwRKMjXNtF+XUjmgV1Llq2eJ7w=;
 b=MrWed2XLzVrJy/X0kxhFgeTF+VbsDRVFd2q6qPuyjBAptR8jy+pJLC93nkGxjpDy7YFJBc
 SvriVjsmljemuI8kTdxL2wGY7K401TPL0kYNLZZOpVctA9ojYSayjf3DXQSx5Vbds9+Tw8
 MsxmsjGBqqHHRGMj+mKQV1mZdoX2s6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725440004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPDWdkHj02f4krcbpGwRKMjXNtF+XUjmgV1Llq2eJ7w=;
 b=4lS5/r3wq07QawOUGVyHSKmuDJdevjL4GBs+phwMXM025p7FFAi6lE/jKh73AXdkV64ZLD
 Oya3uEQme2hhxwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A04D139E2;
 Wed,  4 Sep 2024 08:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nAwPFQQg2GZ6CgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Sep 2024 08:53:24 +0000
Date: Wed, 4 Sep 2024 10:52:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Ztgfu4bTVyw7hvdP@yuki.lan>
References: <20240903140326.773060-1-pvorel@suse.cz>
 <ZtcoDmsWrMu8Qaze@yuki.lan> <20240904053157.GA836933@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240904053157.GA836933@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] swapoff01: Define max_runtime 45s
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
> > So yes it looks like the actual test needs some runtime defined,
> > although I'm not sure how long it should be. We probably need a
> > reference machine to callibrate this on. I would avoid any emulated CPU
> > and choose a real hardware. I guess one of the RPis e.g. Pi Zero would
> > be a good choice since they are widely available and slow by any modern
> > standards.
> 
> This makes sense.

So I dusted off my Pi Zero and indeed the test timeouts there as well.
The ntfs filesystem takes 78s, ext2 29s, exfat 20s. So I would say that
max_runtime should be at least a minute. I guess I will try to run the
whole run there before the release and check for timeouts so that we are
sure that the runtime is set reasonably even for very slow hardware.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
