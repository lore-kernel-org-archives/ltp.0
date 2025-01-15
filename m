Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6142FC02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:45:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B79193C7B67
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 13:45:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 052783C2C32
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:45:16 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EF399225B7B
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:45:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6EA081F7CC;
 Wed, 15 Jan 2025 12:45:15 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B58413A6F;
 Wed, 15 Jan 2025 12:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i9rGENuth2fUUgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 Jan 2025 12:45:15 +0000
Date: Wed, 15 Jan 2025 13:45:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Ricardo B. Marliere" <rbm@suse.com>
Message-ID: <20250115124513.GC648257@pevik>
References: <20250115103813.3584089-1-ruansy.fnst@fujitsu.com>
 <2i72vxn22otybddbjyhmsqyxyw2a7jgsswjpbkjccv75ei3n3j@robwkpf3zef6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2i72vxn22otybddbjyhmsqyxyw2a7jgsswjpbkjccv75ei3n3j@robwkpf3zef6>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 6EA081F7CC
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] posix_fadvise: Convert docs to docparse
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

Hi Ricardo, Shiyang Ruan,

> On Wed, Jan 15, 2025 at 06:38:13PM +0800, Shiyang Ruan via ltp wrote:
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > ---
> >  .../kernel/syscalls/fadvise/posix_fadvise01.c  | 17 +++--------------
> >  .../kernel/syscalls/fadvise/posix_fadvise02.c  | 17 +++--------------
> >  .../kernel/syscalls/fadvise/posix_fadvise03.c  | 18 ++++--------------
> >  .../kernel/syscalls/fadvise/posix_fadvise04.c  | 17 +++--------------
> >  4 files changed, 13 insertions(+), 56 deletions(-)

> > diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > index 71e6454d8..650459455 100644
> > --- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > @@ -3,21 +3,10 @@
> >   * Copyright (c) Red Hat Inc., 2007
> >   */

> > -/*
> > - * NAME
> > - *	posix_fadvise01.c
> > - *
> > - * DESCRIPTION
> > - *	Check the value that posix_fadvise returns for wrong ADVISE value.
> > - *
> > - * USAGE
> > - *	posix_fadvise01
> > - *
> > - * HISTORY
> > - *	11/2007 Initial version by Masatake YAMATO <yamato@redhat.com>

> IMHO, you could keep these 'HISTORY' lines below the copyright.

IMHO we should keep names or whatever info is there. But don't have to keep
messy formatting or original comments. I would personally keep here only:

 * Author: Masatake YAMATO <yamato@redhat.com>
(it's obvious it was initial version and Red Hat copyright 2007)

or more conservative:
 * Initial version by Masatake YAMATO <yamato@redhat.com>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
