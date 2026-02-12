Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E0DEB48EB
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 09:33:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4357B3CF2A0
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 10:33:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C36413CF1A7
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 10:33:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 327D11400511
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 10:33:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4D563E6D5;
 Thu, 12 Feb 2026 09:33:03 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 450913EA62;
 Thu, 12 Feb 2026 09:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RfaPD0+ejWnKJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 12 Feb 2026 09:33:03 +0000
Date: Thu, 12 Feb 2026 10:32:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260212093257.GA8902@pevik>
References: <20260211-fix_doc_build-v1-1-42897785e0c7@suse.com>
 <aYyrcqnGWKhsIUej@yuki.lan> <20260212084804.GA5659@pevik>
 <DGCV06VWH5W4.2S96MUIO5X4ZL@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DGCV06VWH5W4.2S96MUIO5X4ZL@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C4D563E6D5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: fix documentation build with latest
 setuptools
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

> On Thu Feb 12, 2026 at 9:48 AM CET, Petr Vorel wrote:
> > Hi Andrea,

> > > Hi!
> > > > Force setuptools to version 81.0.0, which is the last one where linuxdoc
> > > > still can be installed. Also, from python 3.12 setuptools is not
> > > > available anymore when creating a new virtualenv, so we need to force
> > > > its installation to ensure that documentation will be built.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > +1, higher setuptools version is probably better as it's still working on the
> > oldest distros (than 68 version I added in my patchset). IMHO it'd be good to
> > add (before merge) a comment to requirements.txt that it's just a temporary
> > workaround (once linuxdoc is released I'd upgrade it and remove the dependency).

> > Kind regards,
> > Petr

> It's not a workaround, we need it because python 3.12 removed it from
> virtualenv. It explained in the git commit message in my patch.

It is a workaround in a sense because new linuxdoc master thanks to my fix [1]
will not need setuptools any more (which I explained in my patch). Normally we
would update, but upstream does not have time to release.

Also, new release will use hatch, we'll need to use pyproject.toml instead of
requirements.txt.

Kind regards,
Petr

[1] https://github.com/return42/linuxdoc/commit/19f5e5cbe8fec100d9135cfb7d3f183fa9dc0642
[2] https://hatch.pypa.io/latest/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
