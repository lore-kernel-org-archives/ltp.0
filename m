Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BBDCD1284
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 13:42:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 786383CE3CB
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 15:42:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F099D3C13E8
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 15:42:29 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 764B0600C4A
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 15:42:29 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF66337C1C;
 Thu,  4 Apr 2024 13:42:28 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 928A3139E8;
 Thu,  4 Apr 2024 13:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id oQjZHkSuDmaCeAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 04 Apr 2024 13:42:28 +0000
Date: Thu, 4 Apr 2024 15:42:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240404134223.GA526878@pevik>
References: <20240403082618.5829-1-chrubis@suse.cz>
 <20240403082618.5829-3-chrubis@suse.cz>
 <20240404125124.GC503552@pevik> <Zg6jOZjxGGHKkS-0@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zg6jOZjxGGHKkS-0@yuki>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: BF66337C1C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] include: doc: Convert comments into
 linuxdoc
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
> > Very nit: I would prefer if the formatting would not force the indent, e.g.:

> >  * @tcnt: A number of tests. If set the test() callback is called tcnt times
> >  * and each time passed an increasing counter value.

> > Because variables with long name will require more lines, but feel free to
> > ignore it.

> I do not have a strong opinion here, but I guess that we should add at
> least a single space before the subsequent lines so that it's clear that
> it's a continuation.

That's IMHO better, but feel free to ignore (it's not important).

> Does anyone else have an opinion on this?

> > > + * @options: An NULL optstr terminated array of struct tst_option.
> > > + *
> > > + * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
> > > + *
> > > + * @supported_archs: A NULL terminated array of architectures the test runs on
> > > + *                   e.g. {"x86_64, "x86", NULL}. Calls tst_is_on_arch() to
> > > + *                   check if current CPU architecture is supported and exits
> > > + *                   the test with TCONF if it's not.
> > > + *

> > ...
> > >  	void (*setup)(void);
> > >  	void (*cleanup)(void);
> > > -
> > >  	void (*test)(unsigned int test_nr);
> > >  	void (*test_all)(void);

> > > -	/* Syscall name used by the timer measurement library */
> > We decided to drop this comment. Isn't it useful?
> > >  	const char *scall;
> > > -
> > > -	/* Sampling function for timer measurement testcases */
> > >  	int (*sample)(int clk_id, long long usec);
> > And this one as well.

> The sampling is a kind of hack, I would like to rethink it a bit if it
> can't be done in a cleaner way before documenting it.

Sure, ack.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
