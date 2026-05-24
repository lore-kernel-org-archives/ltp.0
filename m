Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEF1CD5BAB
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 19:22:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDC663C7297
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 21:22:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 341353C7297
 for <ltp@lists.linux.it>; Sun, 24 May 2026 21:22:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B8716600170
 for <ltp@lists.linux.it>; Sun, 24 May 2026 21:22:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E5D95682C6;
 Sun, 24 May 2026 19:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779650548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YILLm6NjnmYTZZ/+t4NU8qnBieAlWWbBgiHbgwAsgFA=;
 b=jvGk+xVSxM1XEbqd6Ql9c4B0XTMRS01TmuQc5TqJvVDFoGR53NZfs47Q7Ek6vi5iC6hpSX
 CekDi9864rWikN2sXVrXhHlfDev9KbyHfu130iiNUo7xX52K9x+jR1k++HGLnFj9PCdtml
 8DygqE0DEQSCDnPZhu+AiQXDezlkOuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779650548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YILLm6NjnmYTZZ/+t4NU8qnBieAlWWbBgiHbgwAsgFA=;
 b=p4lKpx7pDaMr6W3X2knwjBpZFP0WmV/YYM+vJU6P3IRefL1px7zXZGfSXfORPKHsrICU3D
 HlvVQdd6C10iRjBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779650547;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YILLm6NjnmYTZZ/+t4NU8qnBieAlWWbBgiHbgwAsgFA=;
 b=2r/EgRSMYarA7rJuvlKmfZ+tfMXxgGcF6g+CRuDEgwD6YNC8SPjlSczCFmU5qHMpJTfxEi
 xsRZNHs3nhs8jfmqHj7CEuhDaOEn1exUFcthu5IUKiSvH8tjcRcNJ3J2O3dncdmdvqZi+M
 4ccK6k2DmyauFC+gaAZOzUxqcLmHRY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779650547;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YILLm6NjnmYTZZ/+t4NU8qnBieAlWWbBgiHbgwAsgFA=;
 b=N81JVkT9TyykVW9NWpjpRNrPZv+FOAEN/r2dTZM0ErvosUap8A9Ubo29AqBg6C1CndfOBe
 3NXpFkee3JJ2VeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 254575983F;
 Sun, 24 May 2026 19:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dzpuAfNPE2oMcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 24 May 2026 19:22:27 +0000
Date: Sun, 24 May 2026 21:22:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260524192220.GA36011@pevik>
References: <20260515133613.31249-1-pvorel@suse.cz> <ahBmB7fs2dJJtIZ9@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahBmB7fs2dJJtIZ9@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 internal_greylist_whitelist(0.00)[10.150.64.97];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_net.sh: tst_rhost_run(): Go to LTP
 temporary directory first
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

> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> Have you tested this change? If it does not cause any regression it
> should be applied before the release.

Yes, I run most of the networking tests. It should be safe so I merged now, in
case of a potential regression is spot early next week.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
