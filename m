Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C9BC4332F
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 11:11:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B6FA3CE9C8
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 12:11:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73CB33CC8E7
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 12:11:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0394F2009DB
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 12:11:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 42E761F74D;
 Wed,  1 Nov 2023 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698837065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7bE6wtuMWFkspIfr9/m4CcGMCAEv6gSkJ+OZMrZICw=;
 b=23qpBhunZ5TIOlugYZT03Htrmr/OdqKO/B0PCYMyYZnuSDHtTtNpHH2GcAdgrsD41pZMDD
 lCAjNl4ob/PgvtMfS/NJ5SfofmexB78gOdu/JwxQA4i7qzAHeTCXsAA41ymLp7gALyA97z
 hCwKk+zLy0jS6iaio4KkPDrgrwBOQuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698837065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7bE6wtuMWFkspIfr9/m4CcGMCAEv6gSkJ+OZMrZICw=;
 b=ga9xGZxeFemGPe9oaU23HXFWLdL98JNwYyUqvzAfgTxVcAq1eVLtxYxTNpvFbLx0emr4dO
 layx9vdGk4zTN7BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16C0213460;
 Wed,  1 Nov 2023 11:11:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OqvlAkkyQmXGMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 01 Nov 2023 11:11:05 +0000
Date: Wed, 1 Nov 2023 12:11:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231101111103.GA896131@pevik>
References: <20231030110107.4528-1-andrea.cervesato@suse.de>
 <20231030110107.4528-2-andrea.cervesato@suse.de>
 <20231101103420.GC884786@pevik> <ZUIuNMoMbu2gGApM@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZUIuNMoMbu2gGApM@yuki>
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

> Hi!
> > > +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> > > @@ -1,1353 +1,392 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > >  /*
> > >   * Copyright (C) 1991, NeXT Computer, Inc.  All Rights Reserverd.
> > > - * Copyright (c) 1998-2001 Apple Computer, Inc. All rights reserved.
> > > - *
> > > - * @APPLE_LICENSE_HEADER_START@
> > > - *
> > > - * The contents of this file constitute Original Code as defined in and
> > > - * are subject to the Apple Public Source License Version 1.1 (the
> > > - * "License").  You may not use this file except in compliance with the
> > > - * License.  Please obtain a copy of the License at
> > > - * http://www.apple.com/publicsource and read it before using this file.

> > I wonder if we can switch from APSL-1.1 to GPL-2.0-or-later
> > https://spdx.org/licenses/APSL-1.1.html

> > "This is a complete rewrite of the old test." may justify that.

> The test was written from scratch based loosely on what the original
> stress test did, so I would say that the new license is okay.

> But I suggested adding "Based on fxs.c test by Next Computer, Inc."
> instead of the copyright lines, since I suppose that once we add these
> copyrights we have to keep the original license.

Sounds good, thanks!
Not yet marking as changes requested (the real review should be done).

> > > - * This Original Code and all software distributed under the License are
> > > - * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
> > > - * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
> > > - * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
> > > - * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
> > > - * License for the specific language governing rights and limitations
> > > - * under the License.
> > > - *
> > > - * @APPLE_LICENSE_HEADER_END@
> > ...

> > > -#include <sys/types.h>
> > > -#include <sys/stat.h>
> > > -#if defined(_UWIN) || defined(__linux__)

> > I would also consider moving (and rename) the file to testcases/kernel/fs/fsx/fsx.c.
> > We don't care about _UWIN any more.

> I would keep the linux in the name, at least is clear that we do not
> intend to be portable to BSDs etc. like the orignal code was.

OK.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
