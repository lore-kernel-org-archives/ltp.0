Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE62D462BF
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 15:17:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A38873D67C1
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 16:17:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4793F3D679E
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 16:17:05 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 99259602AD1
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 16:17:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E617C1F37C;
 Wed, 13 Nov 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BDE013301;
 Wed, 13 Nov 2024 15:17:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hJKVJO7CNGflDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 13 Nov 2024 15:17:02 +0000
Date: Wed, 13 Nov 2024 16:17:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241113151701.GD162955@pevik>
References: <20241113105925.295697-1-pvorel@suse.cz>
 <ZzSr-X47F4MfM831@yuki.lan> <20241113140712.GA162955@pevik>
 <ZzS1xaQp1xKcHagu@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZzS1xaQp1xKcHagu@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: E617C1F37C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Dominique Leuenberger <dleuenberger@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > I think that the main mistake here is that I kept the code in
> > > tst_vbrk_() that exits the test with a return value in the case of a
> > > child processes.

> > I suppose you talk about in tst_vbrk_ (lib/tst_test.c):

> > 	if (getpid() == lib_pid)
> > 		do_exit(TTYPE_RESULT(ttype));

> That one should stay, that is the overall exit value from the test.

> There is one below that that should be replaced with exit(0).

> > > So ideal fix would be to change the test library not to
> > > do that,

> > So would you just do_exit(0) or even just exit(0)?
> > Or exit 0 for TPASS or TCONF and 1 otherwise (TBROK, TFAIL, TWARN)? Or what
> > exactly did you meant?

> Anything but the main library process would do exit(0).

Ah, thx for info. Makes sense to me.

> > Other option could be to keep library as is and have a custm functions which
> > "translate" LTP exit codes. I was thinking something like this:

> > bool tst_exit_status(int status)
> > {
> > 	if (!WEXITSTATUS(status))
> > 		return false;

> > 	if (WEXITSTATUS(status) == TPASS || WEXITSTATUS(status) == TCONF)
> > 		return true;

> > 	return false;
> > }

> > But we actually have check_child_status(pid_t pid, int status) for this:

> > static void check_child_status(pid_t pid, int status)
> > {
> > 	int ret;

> > 	if (WIFSIGNALED(status)) {
> > 		tst_brk(TBROK, "Child (%i) killed by signal %s", pid,
> > 			tst_strsig(WTERMSIG(status)));
> > 	}

> > 	if (!(WIFEXITED(status)))
> > 		tst_brk(TBROK, "Child (%i) exited abnormally", pid);

> > 	ret = WEXITSTATUS(status);
> > 	switch (ret) {
> > 	case TPASS:
> > 	case TBROK:
> > 	case TCONF:
> > 	break;
> > 	default:
> > 		tst_brk(TBROK, "Invalid child (%i) exit value %i", pid, ret);
> > 	}
> > }

> > BTW I'm surprised that there is TBROK whitelisted.

> That just checks for valid exit status.

OK. Shouldn't be here TFAIL as well (or even TWARN)?

> > > but that would require a bit more work, especially we would
> > > have to look at all WAITPID() usages in newlib tests and make sure that
> > > there are not tests that depends on such behavior. If there are none it
> > > would stil require a few changes in the test library.

> > Well, what I fear more is to broke even more tests :). But if you consider is
> > useful enough I can do the cleanup.

> The change would allow us to implement things like tst_brk(TFAIL, ...)
> and tst_brk(TPASS, ...) correctly. The problem is that the result from
> children after tst_brk() is propagated as a return value. What we need
> instead is to add an abort flag to the results structure.

Ah, now I see why you want to do it properly. Makes sense.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
