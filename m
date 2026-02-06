Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF69EE2086
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 10:31:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62C043CC67A
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 11:31:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 869F13C1CC0
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 11:31:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DA2AA6001F5
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 11:31:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 353AC3E6D5;
 Fri,  6 Feb 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10DC53EA63;
 Fri,  6 Feb 2026 10:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JPLiAvvChWmLFQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Feb 2026 10:31:23 +0000
Date: Fri, 6 Feb 2026 11:31:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260206103121.GA381209@pevik>
References: <20260205135724.23772-1-chrubis@suse.cz>
 <20260205174756.GA338897@pevik> <aYWfNaJeXqut0Isb@redhat.com>
 <aYWnRzaz7Luhm26x@yuki.lan> <20260206093715.GB374678@pevik>
 <aYW4KB4oKXurWohy@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aYW4KB4oKXurWohy@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 353AC3E6D5
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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
> > > > > utsname01.c:39: TDEBUG: mmap((nil), 64, PROT_READ | PROT_WRITE(3), 33, -1, 0)
> > > > > utsname01.c:40: TDEBUG: mmap((nil), 64, PROT_READ | PROT_WRITE(3), 33, -1, 0)

> > > Maybe we need TTRACE that would print syscall tracing like that and
> > > TDEBUG for the rest of the messages.

> > I suppose TTRACE would be printed only for test process and not for the library,
> > right?

> Yes.

> > And it'd be enabled only for debugging (existing -D or
> > LTP_ENABLE_DEBUG=1):

> > if (ttype == TTRACE && context->lib_pid == getpid())
> > 	return;

> > Other would we need a new switch and variable? (e.g. -T and
> > LTP_ENABLE_TRACING_DEBUG=1)

> I would go for LTP_ENABLE_TRACING=1.
OK.
+ some switch I guess (I suggest -T).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
