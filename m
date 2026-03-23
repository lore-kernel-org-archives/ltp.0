Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02319F46101
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 13:30:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 854163E3040
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 14:30:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C0263E1459
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 14:29:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CE2A4600736
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 14:29:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FB1D4D332;
 Mon, 23 Mar 2026 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774272585;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ny9xcZ2VOlh4UXZqQNZ3XovTa9J9qscAHLJHv3pdnEU=;
 b=IXBmlco8NDwZT/pWGMB8+vKZGt4D8Cp0TI2rbtpnfZOjt4i7Sj/yJABieOCmrXqm8w2k2a
 NKNcGMZCW8HSo6PZ6EJU09dvIjO6w0piq5LQReqgmK4WGvpnPSONun34I/xohDtj9Q1spJ
 5ch5yBcfiPteoccH+lFMMT80wJrehmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774272585;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ny9xcZ2VOlh4UXZqQNZ3XovTa9J9qscAHLJHv3pdnEU=;
 b=qwq/HmhBmXTllA7ZKn5RhncGt/+2P4iyyG/iY8R/iBaIetdw/OsscSYjwV8xF7VaRqy9yd
 t6kZPQGK4WplLXCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IXBmlco8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="qwq/HmhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774272585;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ny9xcZ2VOlh4UXZqQNZ3XovTa9J9qscAHLJHv3pdnEU=;
 b=IXBmlco8NDwZT/pWGMB8+vKZGt4D8Cp0TI2rbtpnfZOjt4i7Sj/yJABieOCmrXqm8w2k2a
 NKNcGMZCW8HSo6PZ6EJU09dvIjO6w0piq5LQReqgmK4WGvpnPSONun34I/xohDtj9Q1spJ
 5ch5yBcfiPteoccH+lFMMT80wJrehmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774272585;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ny9xcZ2VOlh4UXZqQNZ3XovTa9J9qscAHLJHv3pdnEU=;
 b=qwq/HmhBmXTllA7ZKn5RhncGt/+2P4iyyG/iY8R/iBaIetdw/OsscSYjwV8xF7VaRqy9yd
 t6kZPQGK4WplLXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4670B438CE;
 Mon, 23 Mar 2026 13:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bWItD0lAwWk/XwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 23 Mar 2026 13:29:45 +0000
Date: Mon, 23 Mar 2026 14:29:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260323132935.GB323525@pevik>
References: <20260318144113.30981-1-pvorel@suse.cz>
 <69bd15a1.050a0220.27cce5.4d03@mx.google.com>
 <20260320113040.GB140154@pevik> <ab01vxdLgFfeFSg2@yuki.lan>
 <ab02mGftGg-a4krj@yuki.lan> <20260320141859.GA158409@pevik>
 <ab1bveCpTrEk5jEB@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab1bveCpTrEk5jEB@yuki.lan>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,tst_run.sh:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5FB1D4D332
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print tcnt in tst_{brk,res}()
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
> > > > This looks good to me. Maybe we can also color the setup/lib/test
> > > > differently if the output goes into the terminal.


> > > And in order to make it work in the shell as well we would need a
> > > function tst_set_context() that would set the current context so that we
> > > can call it from shell. I suppose that this needs to be designed
> > > carefuly in order to make ti work properly with threads/forked
> > > processes.

> > How about having enum with few states (lib, setup, test, cleanup), which would
> > be switched when context switches (and test_get_state() would just print the
> > string). And test would get the number (idea from this patch).

> > I'm still missing how to call C API code from shell test, because C API code
> > forks child and execute the script, how it could "talk back"?

> Same as the test results the enum would have to be stored in shared
> memory and updated with atomic operations.

Thanks for a hint, I should have figure this myself.

Anyway shell loader uses C API helper tst_res_.c anyway, shared memory is
directly available. But for the iterations (recently discussed) tst_run.sh will
need to have a simple C API helper to get required info.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
