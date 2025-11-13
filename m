Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98ABCD5BB9
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 10:21:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 354B33CF7F5
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 11:21:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F81F3CF7BE
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 11:20:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D0FC8200AEA
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 11:20:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE8B51F800;
 Thu, 13 Nov 2025 10:20:48 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF0993EA61;
 Thu, 13 Nov 2025 10:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LYKILQCxFWmfKAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 13 Nov 2025 10:20:48 +0000
Date: Thu, 13 Nov 2025 11:21:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aRWxKiuDJ2msKAUg@yuki.lan>
References: <20251110102407.15308-1-chrubis@suse.cz>
 <20251112140608.GA141617@pevik> <aRSlUmoktYACJRV6@yuki.lan>
 <20251112190004.GB144447@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251112190004.GB144447@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: CE8B51F800
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: Add basic shell test description
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
> > > And here would have subtitle "shell loader test library".  Why? It'd be good to
> > > admit we have plain shell (which uses tst_test.sh) and shell loader. Of course,
> > > shell loader could be a mentioned first, then old API:
> 
> > Generally I would like to avoid mixing documentation for different APIs.
> > I'm afraid that would make things unnecessarily confusing.
> 
> OK, no problem (I did not get you want to document only Shell Loader). But
> hiding the fact that vast majority of the shell tests use tst_test.h is not
> optimal (it might be confusing for new users).

I'm not trying to hide it. I'm trying to write at least some
documentation for the shell loader, that is independed task from
converting the documentation we have for the older shell library into
rst and putting it in it's own menu item.

> Also, Shell Loader does not have useful functions from tst_test.h, e.g.
> ROD(), EXPECT_PASS(). But ok, nobody needs them so far (although ROD() could be
> useful) and I would also ask people to use C API if possible.

Indeed the shell loader is currently under construction, but it allows
us to write a simple tests already and should be good enough for simple
enough tests.

> Could we decide that tst_test.sh becomes "legacy/old" shell API which could be
> on a separate page doc/developers/legacy_api_shell_tests.rst which would just
> mention it's deprecated and linked:
> https://github.com/linux-test-project/ltp/blob/master/doc/old/Shell-Test-API.asciidoc
> (AI would convert it quickly to RST, but I'd be ok to keep just a link.)

Yes, that is what I think would be ideal solution, much better than
mixing the two APIs in a single page.

> And test.h becomes undocumented "legacy legacy" shell API (test.h is still used
> by few tests).

You mean 'test.sh' I suppose, yes there are a few tests using it. We
should clean that up eventually.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
