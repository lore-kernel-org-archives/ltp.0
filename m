Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD3CD7877D
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 14:04:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5EAB3D0536
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 15:04:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC4563C5624
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:03:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BB56B1A000A4
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:03:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C68B05BD33;
 Fri, 19 Dec 2025 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766153030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EM/TvU5XK0VFJTLhC24RaKOIlQ8o/zEaCz0BPo54OxM=;
 b=FDZc1CyA79Mrm8NpHRjOblkWI+crFL2ubcNehYOMR6STZRcQrPLnP/uWAEi1GUKP0DFufd
 KDQTb8hiGFBY7wmGJ6u6QQbhE7pjc9XNBknPxX/zriEkXlX/CDTGV1piP5rur3lQTrr7Tf
 W6Nyoa/EJ+kOl/jwjN8/hpQGw76f4q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766153030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EM/TvU5XK0VFJTLhC24RaKOIlQ8o/zEaCz0BPo54OxM=;
 b=L4p2NqXAMhp+q9B7MI78wGtQLym5dzEV8vCiPtRyV+IhLa27IC6t9c3aBL+MUTA2rqvT/g
 zAJoQ3uAjW5+3dCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766153028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EM/TvU5XK0VFJTLhC24RaKOIlQ8o/zEaCz0BPo54OxM=;
 b=F6u6Rhyz8hK/NLXZLkdbtsLteMCjf97JmxRSRwjWj8372ovWHhTTHtVyxmX7bwcwY8lN7T
 J8b7/Nv378zkC9xU37ELpKlvwyX5CBexSw+9XcAV+bEtW7OAILrpr3UrEcqCSJbFuYW60q
 pqa3L+oVrMR4oCP+v1m7ExIYInxz844=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766153028;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EM/TvU5XK0VFJTLhC24RaKOIlQ8o/zEaCz0BPo54OxM=;
 b=3RTZWWUw9h4yl7sF+LLR1QeAxlHYh7uNMaT5fhlEELWzC/iTNKR2/rTsrv147y7gkntd4M
 qaBo/sBx3EqJzxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B443F3EA63;
 Fri, 19 Dec 2025 14:03:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Bi3GKkRbRWmeNQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Dec 2025 14:03:48 +0000
Date: Fri, 19 Dec 2025 15:04:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aUVbhBY-SorareOp@yuki.lan>
References: <20251219094219.151887-1-pvorel@suse.cz>
 <aUUteQjVmMx1R_X9@yuki.lan>
 <CAEemH2dwp0KUHpo+gVzBUNdDPJMo2xiZ59apHBWx=M_mmC7Y6g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dwp0KUHpo+gVzBUNdDPJMo2xiZ59apHBWx=M_mmC7Y6g@mail.gmail.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files
 until it fails
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
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > >       tst_res(TINFO, "Successfully created %d swap files", swapfiles);
> > > -     MAKE_SMALL_SWAPFILE(TEST_FILE);
> >
> > This should stay here, right? I suppose that the test works even when we
> > pass non-existing file in the verify_swapon() but we shouldn't bet on
> > that.
> >
> 
> Not exactly,  I guess here deleted it because is_swap_supported(TEST_FILE)
> had already created the file but didn't clean it up in setup, so it still
> exists.
> 
> Or, we need to do is improve is_swap_supported(), remove the any test file,
> and then add it back separately.

Ah, now I remmeber, I proposed not to create the swapfile in the
is_swap_supported() and instead a pass a path to a swapfile to the
function last time I got confused by the code.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
