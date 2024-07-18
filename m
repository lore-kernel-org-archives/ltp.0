Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D01C3DA49
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 13:15:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8333E3D1B06
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 15:15:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B1123D1AD0
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 15:15:41 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 36B2F601710
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 15:15:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D6C0921A3D;
 Thu, 18 Jul 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9891A136F7;
 Thu, 18 Jul 2024 13:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UCxGInoVmWYiAgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Jul 2024 13:15:38 +0000
Date: Thu, 18 Jul 2024 15:15:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240718131536.GB739726@pevik>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
 <20240718125709.GB738326@pevik> <ZpkTmcvKtJeTsU_N@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZpkTmcvKtJeTsU_N@yuki>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D6C0921A3D
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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
> > > This is a proof of a concept of a seamless C and shell integration. The
> > > idea is that with this you can mix shell and C code as much as as you
> > > wish to get the best of the two worlds.

> > > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > > ---
> > >  include/tst_test.h                           | 38 +++++++++++++
> > >  lib/tst_test.c                               | 51 +++++++++++++++++
> > >  testcases/lib/.gitignore                     |  1 +
> > >  testcases/lib/Makefile                       |  4 +-
> > >  testcases/lib/run_tests.sh                   | 10 ++++
> > >  testcases/lib/tests/.gitignore               |  6 ++
> > >  testcases/lib/tests/Makefile                 | 11 ++++
> > >  testcases/lib/tests/shell_loader.sh          |  5 ++
> > >  testcases/lib/tests/shell_test01.c           | 17 ++++++
> > >  testcases/lib/tests/shell_test02.c           | 18 ++++++
> > >  testcases/lib/tests/shell_test03.c           | 25 +++++++++
> > >  testcases/lib/tests/shell_test04.c           | 18 ++++++
> > >  testcases/lib/tests/shell_test05.c           | 27 +++++++++
> > >  testcases/lib/tests/shell_test06.c           | 16 ++++++
> > FYI we have shell tests for new library in lib/newlib_tests (C tests) and
> > lib/newlib_tests/shell/ (shell tests), is it necessary to add new location? Or,
> > if you prefer this, we should move existing tests from lib/newlib_tests/shell/
> > to this new location.

> For a historical reasons the lib for shell is in testcases/lib/ and the
> tests use paths to binaries and scripts in there so I added the code
> there. We may as well move it to the top level lib/shell, or create top
> level slib (as for shell lib) or anywhere else as long as we agree on a
> better place to put the code.

Yeah, we could move everything to lib/shell. I'm also OK with different location
with the tests, i.e. we can keep things where they are.

My main concern is to run the tests in CI and in 'make test' target (also
specify new subtest e.g. test-c-shell: or add them to test-c).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
