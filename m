Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD62CE7A9A
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 09:22:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4BB53CF82F
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 10:22:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1183B3CEE04
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 10:22:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A959E600D56
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 10:22:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16B7F21240;
 Fri, 14 Nov 2025 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763112145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DyBRwGW9DT+oruEbY5lU0F8LmeJRdPNZg6nVyFGq9qs=;
 b=vua/or8PzLlvenImj5tqZRdinp0PHDaP52VeXSdsg5d7ybHhNwsCIibfeDsVWXKFXErYV4
 njGdyBMcsyc55iIGBzFgOFODqK7uoM3OEhS4aRUXvCM5lM8tz/2PY0zSnbsNpUaa0vkIIz
 x5rBYY5KIfqh6CDxeUmmOPn9eDqs7is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763112145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DyBRwGW9DT+oruEbY5lU0F8LmeJRdPNZg6nVyFGq9qs=;
 b=hyrU5HeYsGVfQLCmD2UiuMXA5CwtCpoqozC9XPUb6Panp//KflFwNgRiamHfG6yGUXzyTD
 Urn7/oOZMLM3bDAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763112145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DyBRwGW9DT+oruEbY5lU0F8LmeJRdPNZg6nVyFGq9qs=;
 b=vua/or8PzLlvenImj5tqZRdinp0PHDaP52VeXSdsg5d7ybHhNwsCIibfeDsVWXKFXErYV4
 njGdyBMcsyc55iIGBzFgOFODqK7uoM3OEhS4aRUXvCM5lM8tz/2PY0zSnbsNpUaa0vkIIz
 x5rBYY5KIfqh6CDxeUmmOPn9eDqs7is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763112145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DyBRwGW9DT+oruEbY5lU0F8LmeJRdPNZg6nVyFGq9qs=;
 b=hyrU5HeYsGVfQLCmD2UiuMXA5CwtCpoqozC9XPUb6Panp//KflFwNgRiamHfG6yGUXzyTD
 Urn7/oOZMLM3bDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E81153EA61;
 Fri, 14 Nov 2025 09:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bXCqN9D0FmkvTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 14 Nov 2025 09:22:24 +0000
Date: Fri, 14 Nov 2025 10:22:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251114092223.GB43654@pevik>
References: <20251110102407.15308-1-chrubis@suse.cz>
 <20251112140608.GA141617@pevik> <aRSlUmoktYACJRV6@yuki.lan>
 <20251112190004.GB144447@pevik> <aRWxKiuDJ2msKAUg@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRWxKiuDJ2msKAUg@yuki.lan>
X-Spamd-Result: default: False [6.00 / 50.00]; MW_SURBL_MULTI(7.50)[test:url];
 PH_SURBL_MULTI(5.00)[test:url]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%];
 URI_HIDDEN_PATH(1.00)[http://test\.sh];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 ABUSE_SURBL(0.00)[test:url]; CRACKED_SURBL(0.00)[test:url];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 CT_SURBL(0.00)[test:url]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DM_SURBL(0.00)[test:url];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > And here would have subtitle "shell loader test library".  Why? It'd be good to
> > > > admit we have plain shell (which uses tst_test.sh) and shell loader. Of course,
> > > > shell loader could be a mentioned first, then old API:

> > > Generally I would like to avoid mixing documentation for different APIs.
> > > I'm afraid that would make things unnecessarily confusing.

> > OK, no problem (I did not get you want to document only Shell Loader). But
> > hiding the fact that vast majority of the shell tests use tst_test.h is not
> > optimal (it might be confusing for new users).

> I'm not trying to hide it. I'm trying to write at least some
> documentation for the shell loader, that is independed task from
> converting the documentation we have for the older shell library into
> rst and putting it in it's own menu item.

Go ahead and merge as is. Actually the only my objections were
that previously "Shell API" was tst_test.sh, now it's shell loader.
I wanted to have the same name "Shell Loader" we have used in git commit logs
to match the docs to not confuse users which API we mean (we now have 3 shell
APIs). But I'm ok with the current version.

> > Also, Shell Loader does not have useful functions from tst_test.h, e.g.
> > ROD(), EXPECT_PASS(). But ok, nobody needs them so far (although ROD() could be
> > useful) and I would also ask people to use C API if possible.

> Indeed the shell loader is currently under construction, but it allows
> us to write a simple tests already and should be good enough for simple
> enough tests.

Sure. I just realized that we might need slightly extend the API during rewrite,
but that's of course not a problem.

> > Could we decide that tst_test.sh becomes "legacy/old" shell API which could be
> > on a separate page doc/developers/legacy_api_shell_tests.rst which would just
> > mention it's deprecated and linked:
> > https://github.com/linux-test-project/ltp/blob/master/doc/old/Shell-Test-API.asciidoc
> > (AI would convert it quickly to RST, but I'd be ok to keep just a link.)

> Yes, that is what I think would be ideal solution, much better than
> mixing the two APIs in a single page.

OK, I'll try to convert it soon, under doc/developers/legacy_api_shell_tests.rst.
There will be a warning - use new "Shell API (which is Shell loader).

> > And test.h becomes undocumented "legacy legacy" shell API (test.h is still used
> > by few tests).

> You mean 'test.sh' I suppose, yes there are a few tests using it. We
> should clean that up eventually.

Yes, I'm sorry, I meant test.sh.

FYI we need to rewrite 52 tests:
$ git grep -l -e ' test\.sh' -e TST_USE_LEGACY_API=1 |wc -l
52

Some of them are very obsolete tests, e.g. power_management, smack, ftrace, ...
I guess that is what holds the rewrite.

9 of them are network tests (ftp/http should be rewritten:
https://github.com/linux-test-project/ltp/issues/1207),
the rest would be trivial to convert even to shell loader.

$ git grep -l TST_USE_LEGACY_API=1 
testcases/network/multicast/mc_cmds/mc_cmds.sh
testcases/network/multicast/mc_commo/mc_commo.sh
testcases/network/multicast/mc_member/mc_member.sh
testcases/network/multicast/mc_opts/mc_opts.sh
testcases/network/stress/dns/dns-stress.sh
testcases/network/stress/ftp/ftp-download-stress.sh
testcases/network/stress/ftp/ftp-upload-stress.sh
testcases/network/stress/http/http-stress.sh
testcases/network/tcp_cmds/tcpdump/tcpdump01.sh

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
