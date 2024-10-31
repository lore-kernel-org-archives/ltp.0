Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738BEE68974
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 11:17:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F07543CBF09
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 12:17:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7851E3CBEEA
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 12:17:34 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 854A1200ADF
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 12:17:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BC1221D3E;
 Thu, 31 Oct 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6961136A5;
 Thu, 31 Oct 2024 11:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qSBUN0tnI2d0TQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 31 Oct 2024 11:17:31 +0000
Date: Thu, 31 Oct 2024 12:17:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241031111715.GA1002312@pevik>
References: <20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com>
 <20241031-generate_syscalls-v6-1-1ad86a33ce2d@suse.com>
 <20241031094927.GB995052@pevik> <ZyNbzFs39LOOLgV7@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZyNbzFs39LOOLgV7@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1BC1221D3E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] Refactor regen.sh script to generate
 syscalls
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
> > I was comparing the old include/lapi/syscalls.h (21579 lines) and the new one
> > (20054). Having new file shorter is a bit surprising to me. I haven't found what
> > is missing, probably I'm missing something myself :).

> That is strange, I got exactly same content minus some whitespaces and
> slightly different macros that check for arch support:

Hm, that must be on my side than. I was doing that on old version,
but even with update to the current master and deleting all:

rm -rf *; git reset --hard; make autotools && ./configure

I still get:

21579 for master (84e77afb3a)
20054 for v6.

Because diff is big, I posted: diff [1], old master [2], new v6 [3]

Now I see the reason - what I pushed as Anrea's v6 [4] is broken for many
distros [5].

Reason for the failure itself is quite obvious [6]:

414 ../include/lapi/syscalls.h:13:2: error: unterminated conditional directive
415 #ifndef LAPI_SYSCALLS_H__
416 ^
417 1 error generated.

Looking it's broken on Debian any version I suspect
include/lapi/syscalls/generate_syscalls.sh works differently on dash.
But it works on ash. Maybe it's not a shell syntax but some dependency.

I suppose include/lapi/syscalls/generate_syscalls.sh should use:
#!/bin/sh -eux
instead of plain #!/bin/sh, that will show the error immediately.
(set -eu is useful for shell scripts which should not fail).

Kind regards,
Petr

[1] https://github.com/pevik/ltp/wiki/diff-master-and-v6
[2] https://github.com/pevik/ltp/wiki/syscalls.h-old-master-(84e77afb3a)
[3] https://github.com/pevik/ltp/wiki/syscalls.h-v6-(new)
[4] https://github.com/pevik/ltp/tree/refs/heads/andrea/automatically-generate-syscalls.h.v6
[5] https://github.com/pevik/ltp/actions/runs/11609439723
[6] https://github.com/pevik/ltp/actions/runs/11609439723/job/32326686364

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
