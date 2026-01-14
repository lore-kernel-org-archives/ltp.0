Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CCBD31A26
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 08:51:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6A3F3C99C7
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 09:51:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C55AC3C4C92
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 09:51:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2140C100096E
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 09:51:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF33633868;
 Wed, 14 Jan 2026 08:51:18 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CEB83EA63;
 Wed, 14 Jan 2026 08:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vBvIFQZZZ2m+ZwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 14 Jan 2026 08:51:18 +0000
Date: Wed, 14 Jan 2026 09:51:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260114085116.GB334250@pevik>
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
 <20260113115148.GA314748@pevik>
 <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
 <DFNI6KO750G6.13XP4I5MYH1HQ@suse.com>
 <CAEemH2d6=vmEKKf65WuAGRhfU4FE8mBf-dAzNWLmgYtFO3WA6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d6=vmEKKf65WuAGRhfU4FE8mBf-dAzNWLmgYtFO3WA6Q@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: CF33633868
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > > I'd keep them separate from core library. For non-core libraries, I'd go
> > with
> > > something more distinct, like "ltp" prefix for file and function names.


> Thanks!

> > > When I look at "libnuma.h" I'd have to think for a bit if this is
> > > header from numa-devel
> > > or LTP. "ltpnuma.h" seems (to me) more clear that it's not LTP core
> > > nor numa-devel.


> Good point, but the ltp* prefix sounds too serious to me. Anything with
> the ltp* prefix inside an LTP makes me think it's critical information.

+1

> Perhaps we can use a lightweight name for the extra libs/:

> est_*: extra test library
> xst_*: extened test library
> lst_*: ltp test library

> I prefer to use lst_*, which is not only different from tst_*, but also
> implies
> this is ltp tst_ things.

> What do you think? or any better prefix?

Given that include "libfoo.h" should be local header and include <foo.h> should
be header from /usr/lib* I would be ok with either keep things as they are or
use the original Li's proposal.

For me personally is more useful to know whether header can be used in the old
API (i.e. "tst_" prefix means source is converted in the new C API) than whether
header is from extra library.

Kind regards,
Petr

> > > my 2 cents,
> > > Jan


> > That's exactly why I was suggesting to keep `tst_*`, which is more for
> > code-library. The `lib*` prefix is pretty generic and we need something
> > more specific for LTP.


> Indeed.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
