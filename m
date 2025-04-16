Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C26C369BD
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 12:49:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 462FE3CB96A
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 14:49:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1C063C0F8A
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 14:48:54 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CB5151400445
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 14:48:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B7E3211BF;
 Wed, 16 Apr 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D96713976;
 Wed, 16 Apr 2025 12:48:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RAoyETOn/2dPLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Apr 2025 12:48:51 +0000
Date: Wed, 16 Apr 2025 14:48:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Dennis Brendel <dbrendel@redhat.com>
Message-ID: <20250416124846.GA602689@pevik>
References: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
 <20250415-patchwork_ci-v7-2-bc0b9adca971@suse.com>
 <20250415173535.GA520691@pevik>
 <9af81e6d-e0b5-4488-a589-76061f2be18b@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9af81e6d-e0b5-4488-a589-76061f2be18b@redhat.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6B7E3211BF
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] ci: add patchwork communication script
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

Hi Dennis,

> On 4/15/25 7:35 PM, Petr Vorel wrote:
> > Hi Andrea,
> > You may have noticed in tst_test.sh, that local variable never uses $(...).
> > It assign single value, but never call $(...). This is for a reason.
> > [...]
> > What happen? $? is assigned from result of local keyword,
> > it overwrite previous result from $(...). Note even '#!/bin/sh -e'
> > would not cause it to fail early.

> Here is the corresponding documentation:
> https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#index-local

> > The return status is zero unless local is used outside a function, an
> invalid name is supplied, or name is a readonly variable

> So:
> If you are interested in return statuses then don't *mask them* with local.

> Use this pattern instead:

> local my_var
> my_var=$(my_expr)

Thanks for much better explanation than I provided + link to the doc. I'll Cc
you on my shell related patches :).

I remember this since 87a82a62ce ("lib/tst_test.sh: fix ROD_SILENT command
return status check") [1], another related is e267a022cd ("tst_test.sh: Fix $@
usage on older dash releases") [2].

Because shell has quirks (both POSIX portable syntax or bash or whatever shell
extension) we've had many fixes for shell code, e.g. 0c0076fbaf ("tst_test.sh:
Fix ROD_SILENT() quoting") [3], although some of them are non-bash specific,
e.g. 0bb01e67b3 ("shell: Fix handling default parameters in tst_mkfs()") [4]
(just to list very few).

The biggest problem is that some things aren't easily done with plain shell,
that's why we need to use C helpers in testcases/lib (some of them are just
reusing C API to avoid reimplementing code, but e.g.  testcases/lib/tst_timeout_kill.c
was really needed after few attempts to write code in bash). Also cgroup tests
aren't reliable when written in shell. Therefore we're trying to get rid of
shell API (rewritten tests into C, or make them to use testcases/lib/tst_run_shell.c,
which makes the layer really thin).

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/87a82a62ce3fcdaf174d6e4529e0324742e13684
[2] https://github.com/linux-test-project/ltp/commit/e267a022cd2deb0d5e7280570c711420927ad817
[3] https://github.com/linux-test-project/ltp/commit/0c0076fbaf6e0059b470fadff6240fc56952c218
[4] https://github.com/linux-test-project/ltp/commit/0bb01e67b3ba079f8f069a99422d783fe6da4287

> Kind regards,
> Dennis

> > (Deliberately test with bash to demonstrate local behaves oddly not even in dash
> > or 'busybox sh' but even with bash. And yes, given how many errors we caught
> > with this script and generate_arch.sh and generate_syscalls.sh due shell strange
> > syntax and behavior makes me wonder if we really want to use shell scripts for
> > anything longer than 5 lines.)

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
