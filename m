Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6315CA0EE4
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 06:08:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F65F3CC65F
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 08:08:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E85473CA131
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 08:08:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF45310007C6
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 08:08:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F3C321261;
 Mon, 18 Aug 2025 06:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755497301;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tSJOfDL8wBpIBvsW82OVP8Mk6lRSqzW34m7PyaQ3Ok8=;
 b=MxoX1RXU9m+LAAOdh9+8RAhm97sLxwx/RNAMhG2P6r1dWfgQfRqBD8ODENOdpvttg7fv99
 GgRyNYjUy9q/2J7KhBZ7596p9p8CXHVTpFsSeknuwj/uBe6HDUW4Xp0WZOulaSNrfA+2yA
 dJ06boplURFytPtAPbz9kC9DFHeIiGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755497301;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tSJOfDL8wBpIBvsW82OVP8Mk6lRSqzW34m7PyaQ3Ok8=;
 b=uJvZdAMeIEs+sMZ6zqfoPaMb09B0cDEP01IDGFoM0XI1xy45gyAENuY8zPmaaVOff71556
 TD9JKVXXsisVPeAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755497301;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tSJOfDL8wBpIBvsW82OVP8Mk6lRSqzW34m7PyaQ3Ok8=;
 b=MxoX1RXU9m+LAAOdh9+8RAhm97sLxwx/RNAMhG2P6r1dWfgQfRqBD8ODENOdpvttg7fv99
 GgRyNYjUy9q/2J7KhBZ7596p9p8CXHVTpFsSeknuwj/uBe6HDUW4Xp0WZOulaSNrfA+2yA
 dJ06boplURFytPtAPbz9kC9DFHeIiGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755497301;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tSJOfDL8wBpIBvsW82OVP8Mk6lRSqzW34m7PyaQ3Ok8=;
 b=uJvZdAMeIEs+sMZ6zqfoPaMb09B0cDEP01IDGFoM0XI1xy45gyAENuY8zPmaaVOff71556
 TD9JKVXXsisVPeAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F31713686;
 Mon, 18 Aug 2025 06:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5rrLAlXDomjIeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 18 Aug 2025 06:08:21 +0000
Date: Mon, 18 Aug 2025 08:08:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250818060819.GA133791@pevik>
References: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
 <20250812101237.GA835467@pevik> <aJsg11G8hOAqoGkw@yuki.lan>
 <20250812114540.GC843668@pevik> <aJsu4qw72EZiKnSP@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aJsu4qw72EZiKnSP@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [doc,
 runtest] [was: Re:  [PATCH] cve: add CVE-2025-38236 test]
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

Hi Cyril, all,

> Hi!
> > This problem happen on all runtest files, fixing just one does not fix the
> > problem.

> Well we can do that for any runtest file that has clear definition of
> which tests belongs there. For CVE it's crystal clear, tests that have
> cve tag should be there. For the rest of the runtest files, it's not so
> much. Maybe for syscalls we may be able to do so.

> The main thing is that we have to start somewhere got eventually get
> there. I just quickly looked at the cve runtest file and figured out
> that we have to add tests variants somewhere into the metadata. I.e.
> quite a few of the CVE tests have command line options in the runtest
> file which has to be stored somewhere else.

Thanks for analysis. I put your investigation into an issue:

https://github.com/linux-test-project/ltp/issues/1253

> > Sure, it'd be possible to generate runtest/cve from metadata. Do we really want
> > to implement it? (I can create a ticket). I guess we would use C and ujson to
> > not require json-c or python3 for building LTP.

> Or we can hook it up directly into the metadata parser, instead of
> parsing the resulting JSON we can act on the data while they are in the
> memory. Matching some tags and writing a test name into a file could be
> easily done.

> > I would be more interested to have section "CVE reproducers" in Statistics page [1].
> > While the same tool could be used to do both goals, when only doc page
> > implemented, it could be easily done in python3 (doc/conf.py already parses
> > ltp.json).

> > When we are at Statistics page, also generating list of reproducers (based on
> > kernel fixes) would be also nice. Because this was implemented in the previous
> > asciidoctor implementation. How about having these lists Statistics, where are
> > other tables already (and linking each test to "Test Catalog")?

> > Also I find "Statistics" name confusing. It says nothing about the content. I
> > wonder if people curiously click on the page or just ignore the page (if they
> > don't like math :)). Maybe "Kernel coverage" or something like that would be
> > more informative.

> I would put the list of reproducers and list of CVE reproducers into a
> separate page that would be have "reproducers" in the name.

https://github.com/linux-test-project/ltp/issues/1254

> And statistics is probably okayish name, since coverage may mislead
> people even more. For example we have a lot of tests for a write()
> syscall yet coverage for all the possible write handlers in kernel is
> very poor and not likely to improve.

Fair enough.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
