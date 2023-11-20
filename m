Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE22AC2BB3F
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 16:51:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEE943CE1F2
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 17:51:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C549D3CC9D7
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 17:50:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4186201731
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 17:50:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10CB8218F8;
 Mon, 20 Nov 2023 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700499048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1itjl5bvBIaAUBr4p5s7wBZ1ziCGzKoffS7GGnmA34=;
 b=MUdfiSosgyIxTKvFwCZcueJeyV19qJ1ceS/xJj8bP8dgPyZUf2c8vRew24PqK1DwjB5vuB
 6BljClMDGgvfLWZToI8f/W3fXPD2oDl9mFI13chaaQCvY8WJN7NnoJUIG2wrWvYUv3j7Ok
 ESY4iLtAyJwJaL+3uhqGkF/m/NBMWJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700499048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1itjl5bvBIaAUBr4p5s7wBZ1ziCGzKoffS7GGnmA34=;
 b=LJ76asRJ4BLAz6aVrswwSBq6py9v68uW6rdOu9foHx1c/1XKQ+ZB40i9u6/MzuawW9ektt
 ctQwW1HkXXSP12Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A286A13499;
 Mon, 20 Nov 2023 16:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b+nsI2eOW2V/ewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Nov 2023 16:50:47 +0000
Date: Mon, 20 Nov 2023 17:50:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20231120165045.GA40415@pevik>
References: <20231030110107.4528-1-andrea.cervesato@suse.de>
 <20231030110107.4528-2-andrea.cervesato@suse.de>
 <20231101103420.GC884786@pevik> <ZUIuNMoMbu2gGApM@yuki>
 <a54b0968-fca8-49aa-91a2-4135e8bd231e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a54b0968-fca8-49aa-91a2-4135e8bd231e@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.86 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.960];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.37)[76.93%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Rewrite fsx-linux test
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

Hi Andrea,

> Hi!

> On 11/1/23 11:53, Cyril Hrubis wrote:
> > Hi!
> > > > +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> > > > @@ -1,1353 +1,392 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > >   /*
> > > >    * Copyright (C) 1991, NeXT Computer, Inc.  All Rights Reserverd.
> > > > - * Copyright (c) 1998-2001 Apple Computer, Inc. All rights reserved.
> > > > - *
> > > > - * @APPLE_LICENSE_HEADER_START@
> > > > - *
> > > > - * The contents of this file constitute Original Code as defined in and
> > > > - * are subject to the Apple Public Source License Version 1.1 (the
> > > > - * "License").  You may not use this file except in compliance with the
> > > > - * License.  Please obtain a copy of the License at
> > > > - * http://www.apple.com/publicsource and read it before using this file.
> > > I wonder if we can switch from APSL-1.1 to GPL-2.0-or-later
> > > https://spdx.org/licenses/APSL-1.1.html

> > > "This is a complete rewrite of the old test." may justify that.
> > The test was written from scratch based loosely on what the original
> > stress test did, so I would say that the new license is okay.

> > But I suggested adding "Based on fxs.c test by Next Computer, Inc."
> > instead of the copyright lines, since I suppose that once we add these
> > copyrights we have to keep the original license.
> This is explained in the description.

If you mean the commit message description, that's IMHO not enough.
Statements like this are added into the source code header so that people who
download tarballs see it as well.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
