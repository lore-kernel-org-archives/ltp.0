Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F04C5AD7B
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 05:42:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 293DE3CC018
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 07:42:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9935F3CB2DE
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 07:41:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 014891A002E2
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 07:41:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 41A113E02;
 Tue, 11 Aug 2026 05:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786426913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GioA2dxnQkkqMhn6T1StkeM7L3l+yFlGH6041ZUUa7w=;
 b=vmO8ich6ZyQuzkLmVhfol4TW0KPyMrdy+5NOnEWg404bA4GKhL0nSRGroA7pXe7Fmj7EDs
 9Nyu0rqAMjGAyyFCK4FANKG0d6BWZGKlmwRH8xJSfkepQpUUrG3M3yr4rX9sJDawJGdc3g
 JbULmCyS2ovpOfCbmLpBU57D1udGrwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786426913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GioA2dxnQkkqMhn6T1StkeM7L3l+yFlGH6041ZUUa7w=;
 b=Wz0NpQZUpIzIKfvxUznrAlOaa4DjurVUuQRx9hd/swGWUYk+VZ558ew90x7SgyJXDRw7Go
 64hGCp8R1St2I+BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FqE5NWNZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8PJR0FCy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786426909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GioA2dxnQkkqMhn6T1StkeM7L3l+yFlGH6041ZUUa7w=;
 b=FqE5NWNZ+KYa4V25uTe60S/BPilSgA+wBz0N0AVj5OIg/X1nDGH7c9SEs0NSx0iADXOH8o
 XCvg9Sw95JzqMX/OEih/IWLwaf3Yzua5qwFgOcxtfwigxc431X69myksRkwLe1niYA54cj
 hYhZfHFCh41I4yUFmyTMWA9bouCQSWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786426909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GioA2dxnQkkqMhn6T1StkeM7L3l+yFlGH6041ZUUa7w=;
 b=8PJR0FCy+RIofjnRHxsVDong0CWoWPT6aJqcHNcGxwO5em5SmtRvWx/wtJQy51u5bkwOOw
 gwuhtzfafnNnu3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 279B4779B2;
 Tue, 11 Aug 2026 05:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g+NsCB22emq4IQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Aug 2026 05:41:49 +0000
Date: Tue, 11 Aug 2026 07:41:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260811054139.GB1613289@pevik>
References: <20260810111521.GB918586@pevik>
 <6a79b501.18b7d65e.302874.4926@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a79b501.18b7d65e.302874.4926@mx.google.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 41A113E02
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] cve: reproducer for cve-2026-64600
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

> Hi Petr,

> > > > > +			.min_kver = "4.16",
> > > > It got introduced in 4.11. Is there a reason for testing from 4.16?
> > > > Or is it just the copy paste error?

> > > 1e369b0e199bb ("xfs: remove experimental tag for reflinks") was merged
> > > in 4.16

> > Well, 1e369b0e199bb just remove warning from dmesg that reflinks are
> > experimental. Why to hide from users that kernels from 4.11 to 4.15 are
> > vulnerable? Also, Darrick marked his fix as vulnerable from 4.11 (Commit has
> > "Cc: stable@vger.kernel.org # v4.11" [1]), blog publish 4.11 [2], but LTP test
> > says "Test requires 4.16" => potential user of 4.11 will think "ok I'm safe".
> > IMHO perfect example of hiding kernel bug, specially due the fact that oldest
> > fixed kernel is v5.15.212, which backported upstream fix 2f4acd0fcd86 as
> > dc11be133efc, it was not backported to still supported LTS 5.10.x (EOL 31 Dec
> > 2026) because it has conflicts.

> We can use 4.11 then

Thank you!

> > [5] https://lore.kernel.org/ltp/20260401094946.GA126168@pevik/

> you will have hard time updating all tests then :) from what i see, we have
> just a bunch of tests using the short SHA. Anyway, I had more than a few
> reviews in the past asking to keep it short, so if we want to use the long one
> in order to avoid hash collisions, we also need to officially ask for it.

I'll just after some time rerun the script to update them in a single batch
(script is part of the commit message, anybody can run it).

I also updated the examples in the docs. I wonder if it should be more
documented.

> I will update thepatch and merge, thanks 

Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
