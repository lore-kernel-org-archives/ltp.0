Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA33BCCFA1E
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 19:00:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3505D3CF7B4
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 20:00:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6B3D3CF701
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 20:00:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E18F1000A50
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 20:00:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B90D1219E1;
 Wed, 12 Nov 2025 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762974005;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWX2BJyTldJ6v4jTRO9J+hv9qmaEntZ9BOMd9Wnq0aA=;
 b=LZ48p2BvJ2mwFBb6LZGMmPNpNXxBetpU3eHcAnq0a+kO1oyEgekEyDzS59AnEKXc14oMf8
 +6AxrDWTepqAQJueZHr2xCLX4ez9vwAo0DN85oIlR7Hh5y0+NBWgkBuDPCNo8tqCoUe0IY
 dDXqh1XZISbawgAGFSgfJW/AD1ClnMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762974005;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWX2BJyTldJ6v4jTRO9J+hv9qmaEntZ9BOMd9Wnq0aA=;
 b=QNCeRb8kqJaeQbrWa8crn8Qgv79VLRhPHIlHdHjBqaXdqT0PnFdDr8noa7lwjeNAH18jGA
 7bdc4/05xLFC5yCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762974005;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWX2BJyTldJ6v4jTRO9J+hv9qmaEntZ9BOMd9Wnq0aA=;
 b=LZ48p2BvJ2mwFBb6LZGMmPNpNXxBetpU3eHcAnq0a+kO1oyEgekEyDzS59AnEKXc14oMf8
 +6AxrDWTepqAQJueZHr2xCLX4ez9vwAo0DN85oIlR7Hh5y0+NBWgkBuDPCNo8tqCoUe0IY
 dDXqh1XZISbawgAGFSgfJW/AD1ClnMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762974005;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWX2BJyTldJ6v4jTRO9J+hv9qmaEntZ9BOMd9Wnq0aA=;
 b=QNCeRb8kqJaeQbrWa8crn8Qgv79VLRhPHIlHdHjBqaXdqT0PnFdDr8noa7lwjeNAH18jGA
 7bdc4/05xLFC5yCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98D513EA61;
 Wed, 12 Nov 2025 19:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wgNMJDXZFGk0QAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Nov 2025 19:00:05 +0000
Date: Wed, 12 Nov 2025 20:00:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251112190004.GB144447@pevik>
References: <20251110102407.15308-1-chrubis@suse.cz>
 <20251112140608.GA141617@pevik> <aRSlUmoktYACJRV6@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRSlUmoktYACJRV6@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,sphinx-doc.org:url,email.com:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

> > > +Shell API overview
> > > +------------------
> > > +
> > > +First lines of the shell test should be a shebang, a license, and copyrights.
> > > +
> > > +.. code-block:: shell
> > > +
> > > +   #!/bin/sh
> > > +   # SPDX-License-Identifier: GPL-2.0-or-later
> > > +   # Copyright 2099 Foo Bar <foo.bar@email.com>
> > > +
> > > +A documentation comment block formatted in ReStructuredText should follow right
> > > +after these lines. This comment is parsed and exported into the LTP
> > > +documentation at https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html

> > +1. Great, I did not realize it's ok to use at least #doc part for normal shell
> > tests (i.e. these without shell loader).

> That should indeed work fine. You can have a doc block in old shell test
> and it would be picked up by the metadata parser.

Yeah, it works (I tested it). I looked into metadata/parse.sh and it's due it
searches for both *.c and *.sh without checking what library they use. Which is
good (no side effects so far and we can include docs). I'll probably convert
some of network tests docs into docparse to update the test catalog.

> > > +
> > > +.. code-block:: shell
> > > +
> > > +   # ---
> > > +   # doc
> > > +   # Test for a foo bar.
> > > +   #
> > > +   # This test is testing foo by checking that bar is doing xyz.
> > > +   # ---
> > > +

> > I would frankly link the old API doc (and link :master:`testcases/lib/tst_test.sh`)...
> > https://github.com/linux-test-project/ltp/blob/master/doc/old/Shell-Test-API.asciidoc

> > > +The shell loader test library uses the C test library internally by parsing a

Could we instead "the C test library" just use link:
:doc:`../developers/api_c_tests`

NOTE: I would avoid it, but you can set a custom text via <>
https://www.sphinx-doc.org/en/master/usage/referencing.html


> > > +special JSON formatted comment and initializing it accordingly. The JSON format
> > > +is nearly 1:1 serialization of the C tst_test structure into a JSON. The

And "C tst_test structure" as:
:ref:`struct tst_test`

The shell loader test library uses the :doc:`../developers/api_c_tests`
internally by parsing a special JSON formatted comment and initializing it
accordingly.  The JSON format is nearly 1:1 serialization of the :ref:`struct
tst_test` into a JSON. The environment must be always preset even when it's
empty.

> > > +environment must be always preset even when it's empty.

> > And here would have subtitle "shell loader test library".  Why? It'd be good to
> > admit we have plain shell (which uses tst_test.sh) and shell loader. Of course,
> > shell loader could be a mentioned first, then old API:

> Generally I would like to avoid mixing documentation for different APIs.
> I'm afraid that would make things unnecessarily confusing.

OK, no problem (I did not get you want to document only Shell Loader). But
hiding the fact that vast majority of the shell tests use tst_test.h is not
optimal (it might be confusing for new users).

Also, Shell Loader does not have useful functions from tst_test.h, e.g.
ROD(), EXPECT_PASS(). But ok, nobody needs them so far (although ROD() could be
useful) and I would also ask people to use C API if possible.

Could we decide that tst_test.sh becomes "legacy/old" shell API which could be
on a separate page doc/developers/legacy_api_shell_tests.rst which would just
mention it's deprecated and linked:
https://github.com/linux-test-project/ltp/blob/master/doc/old/Shell-Test-API.asciidoc
(AI would convert it quickly to RST, but I'd be ok to keep just a link.)

And test.h becomes undocumented "legacy legacy" shell API (test.h is still used
by few tests).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
