Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF01D462AA
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 14:21:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6535B3D673E
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 15:21:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7F6E3D673E
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 15:20:51 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 67504101B15D
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 15:20:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5694211A5;
 Wed, 13 Nov 2024 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731507649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3hG9wygSUcS3R8JFNib/mmvayIA9tCml7MS4986Car4=;
 b=w97X21WDXzha6VJkxZky8qEIwDkLZqLkoWXyolQs68RCJnFAwY9EZKixk8HUEhKdGTWQOz
 N8DhjvSUK1S2EmWe8nZDRz8qo9X7K7Eg7S6RPuOnPX8Y+/9wrHfpHWerjWz83BcxIl1oN/
 EfB9xWtm3hUFBTUXM8ZzrujqbUz971E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731507649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3hG9wygSUcS3R8JFNib/mmvayIA9tCml7MS4986Car4=;
 b=SavjxfojZ2IjIgn/i2WbbrywCU+P0OB5IGd6p3/Dr/76lzB0WxNhL86RK01rucEk1a7UDY
 IJV+h6VzIv/NzEBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w97X21WD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Savjxfoj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731507649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3hG9wygSUcS3R8JFNib/mmvayIA9tCml7MS4986Car4=;
 b=w97X21WDXzha6VJkxZky8qEIwDkLZqLkoWXyolQs68RCJnFAwY9EZKixk8HUEhKdGTWQOz
 N8DhjvSUK1S2EmWe8nZDRz8qo9X7K7Eg7S6RPuOnPX8Y+/9wrHfpHWerjWz83BcxIl1oN/
 EfB9xWtm3hUFBTUXM8ZzrujqbUz971E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731507649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3hG9wygSUcS3R8JFNib/mmvayIA9tCml7MS4986Car4=;
 b=SavjxfojZ2IjIgn/i2WbbrywCU+P0OB5IGd6p3/Dr/76lzB0WxNhL86RK01rucEk1a7UDY
 IJV+h6VzIv/NzEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8541F13A6E;
 Wed, 13 Nov 2024 14:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vTQcH8G1NGcAcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 Nov 2024 14:20:49 +0000
Date: Wed, 13 Nov 2024 15:20:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZzS1xaQp1xKcHagu@yuki.lan>
References: <20241113105925.295697-1-pvorel@suse.cz>
 <ZzSr-X47F4MfM831@yuki.lan> <20241113140712.GA162955@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241113140712.GA162955@pevik>
X-Rspamd-Queue-Id: D5694211A5
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] select03: Fix false positive on TCONF
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
Cc: Dominique Leuenberger <dleuenberger@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I think that the main mistake here is that I kept the code in
> > tst_vbrk_() that exits the test with a return value in the case of a
> > child processes.
> 
> I suppose you talk about in tst_vbrk_ (lib/tst_test.c):
> 
> 	if (getpid() == lib_pid)
> 		do_exit(TTYPE_RESULT(ttype));

That one should stay, that is the overall exit value from the test.

There is one below that that should be replaced with exit(0).

> > So ideal fix would be to change the test library not to
> > do that,
> 
> So would you just do_exit(0) or even just exit(0)?
> Or exit 0 for TPASS or TCONF and 1 otherwise (TBROK, TFAIL, TWARN)? Or what
> exactly did you meant?

Anything but the main library process would do exit(0).

> Other option could be to keep library as is and have a custm functions which
> "translate" LTP exit codes. I was thinking something like this:
> 
> bool tst_exit_status(int status)
> {
> 	if (!WEXITSTATUS(status))
> 		return false;
> 
> 	if (WEXITSTATUS(status) == TPASS || WEXITSTATUS(status) == TCONF)
> 		return true;
> 
> 	return false;
> }
> 
> But we actually have check_child_status(pid_t pid, int status) for this:
> 
> static void check_child_status(pid_t pid, int status)
> {
> 	int ret;
> 
> 	if (WIFSIGNALED(status)) {
> 		tst_brk(TBROK, "Child (%i) killed by signal %s", pid,
> 			tst_strsig(WTERMSIG(status)));
> 	}
> 
> 	if (!(WIFEXITED(status)))
> 		tst_brk(TBROK, "Child (%i) exited abnormally", pid);
> 
> 	ret = WEXITSTATUS(status);
> 	switch (ret) {
> 	case TPASS:
> 	case TBROK:
> 	case TCONF:
> 	break;
> 	default:
> 		tst_brk(TBROK, "Invalid child (%i) exit value %i", pid, ret);
> 	}
> }
> 
> BTW I'm surprised that there is TBROK whitelisted.

That just checks for valid exit status.

> > but that would require a bit more work, especially we would
> > have to look at all WAITPID() usages in newlib tests and make sure that
> > there are not tests that depends on such behavior. If there are none it
> > would stil require a few changes in the test library.
> 
> Well, what I fear more is to broke even more tests :). But if you consider is
> useful enough I can do the cleanup.

The change would allow us to implement things like tst_brk(TFAIL, ...)
and tst_brk(TPASS, ...) correctly. The problem is that the result from
children after tst_brk() is propagated as a return value. What we need
instead is to add an abort flag to the results structure.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
