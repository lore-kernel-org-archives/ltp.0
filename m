Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F46CCF9E3
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 15:18:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 027E03CF796
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 16:18:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E951D3CF6FB
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 16:17:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 07C21600735
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 16:17:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5FA5A1F84B;
 Wed, 12 Nov 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FD973EA61;
 Wed, 12 Nov 2025 15:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f8dyESGlFGk9YwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Nov 2025 15:17:53 +0000
Date: Wed, 12 Nov 2025 16:18:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aRSlUmoktYACJRV6@yuki.lan>
References: <20251110102407.15308-1-chrubis@suse.cz>
 <20251112140608.GA141617@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251112140608.GA141617@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5FA5A1F84B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > +Shell API overview
> > +------------------
> > +
> > +First lines of the shell test should be a shebang, a license, and copyrights.
> > +
> > +.. code-block:: shell
> > +
> > +   #!/bin/sh
> > +   # SPDX-License-Identifier: GPL-2.0-or-later
> > +   # Copyright 2099 Foo Bar <foo.bar@email.com>
> > +
> > +A documentation comment block formatted in ReStructuredText should follow right
> > +after these lines. This comment is parsed and exported into the LTP
> > +documentation at https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html
> 
> +1. Great, I did not realize it's ok to use at least #doc part for normal shell
> tests (i.e. these without shell loader).

That should indeed work fine. You can have a doc block in old shell test
and it would be picked up by the metadata parser.

> > +
> > +.. code-block:: shell
> > +
> > +   # ---
> > +   # doc
> > +   # Test for a foo bar.
> > +   #
> > +   # This test is testing foo by checking that bar is doing xyz.
> > +   # ---
> > +
> 
> I would frankly link the old API doc (and link :master:`testcases/lib/tst_test.sh`)...
> https://github.com/linux-test-project/ltp/blob/master/doc/old/Shell-Test-API.asciidoc
> 
> > +The shell loader test library uses the C test library internally by parsing a
> > +special JSON formatted comment and initializing it accordingly. The JSON format
> > +is nearly 1:1 serialization of the C tst_test structure into a JSON. The
> > +environment must be always preset even when it's empty.
> 
> And here would have subtitle "shell loader test library".  Why? It'd be good to
> admit we have plain shell (which uses tst_test.sh) and shell loader. Of course,
> shell loader could be a mentioned first, then old API:

Generally I would like to avoid mixing documentation for different APIs.
I'm afraid that would make things unnecessarily confusing.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
