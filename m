Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC4EC43334
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 15:41:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 940F93CA775
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 17:41:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB8143CA240
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:41:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CDEF6600566
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:41:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D02F23370F;
 Tue, 12 Jul 2022 15:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657640479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7BDZdU0d63rFWe5QNurCTdblChvV3TvirgDxdmjDbiE=;
 b=H5YxEPiesKzQJt8YpWvuJoDJIjp8FecPApli9yBCa2FoWps5agtWa6ehahN7J8xY2YP2Fb
 NJ/0xczch3zblh9CjiOk1S8C+59N1uRuy7EoLV76CX21cPvyIsGKcJCePiJ2TVbP/walyv
 q5LzOlD03c3zjMyoNtGGe0Om/z7k3f0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657640479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7BDZdU0d63rFWe5QNurCTdblChvV3TvirgDxdmjDbiE=;
 b=Vkim+ybpyMP3aBv8K3ivr+NcZYvJ46XQLQVhnk93VAp9BczVVrKQ5F6lvUcuvJDJH/hwrF
 6MDKxsuZfovpJcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C589D13A94;
 Tue, 12 Jul 2022 15:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +bQCIR6WzWLyfgAAMHmgww
 (envelope-from <akumar@suse.de>); Tue, 12 Jul 2022 15:41:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Jul 2022 21:11:16 +0530
Message-ID: <4740847.qShWNTrPRO@localhost>
Organization: SUSE
In-Reply-To: <87edysp4o7.fsf@suse.de>
References: <20220707110319.24665-1-akumar@suse.de>
 <20220707110319.24665-2-akumar@suse.de> <87edysp4o7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/9] Rewrite rename01.c using new LTP API
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

On Monday, July 11, 2022 11:00:20 AM IST Richard Palethorpe wrote:
> Hello,
> 
> Avinesh Kumar <akumar@suse.de> writes:
> 
> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > ---
> >  testcases/kernel/syscalls/rename/rename01.c | 259 +++++---------------
> >  1 file changed, 58 insertions(+), 201 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/rename/rename01.c b/testcases/kernel/syscalls/rename/rename01.c
> > index e7de18ff4..695d85c57 100644
> > --- a/testcases/kernel/syscalls/rename/rename01.c
> > +++ b/testcases/kernel/syscalls/rename/rename01.c
> > @@ -1,218 +1,75 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> > - *
> > - *   Copyright (c) International Business Machines  Corp., 2001
> > - *
> > - *   This program is free software;  you can redistribute it and/or modify
> > - *   it under the terms of the GNU General Public License as published by
> > - *   the Free Software Foundation; either version 2 of the License, or
> > - *   (at your option) any later version.
> > - *
> > - *   This program is distributed in the hope that it will be useful,
> > - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> > - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > - *   the GNU General Public License for more details.
> > - *
> > - *   You should have received a copy of the GNU General Public License
> > - *   along with this program;  if not, write to the Free Software
> > - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> > + * Copyright (c) International Business Machines  Corp., 2001
> > + *  07/2001 Ported by Wayne Boyer
> > + * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
> >   */
> >  
> > -/*
> > - * NAME
> > - *	rename01
> > - *
> > - * DESCRIPTION
> > - *	This test will verify the rename(2) syscall basic functionality.
> > - *	Verify rename() works when the "new" file or directory does not exist.
> > +/*\
> > + * [Description]
> >   *
> > - * ALGORITHM
> > - *	Setup:
> > - *		Setup signal handling.
> > - *		Create temporary directory.
> > - *		Pause for SIGUSR1 if option specified.
> > - *
> > - *	Test:
> > - *		Loop if the proper options are given.
> > - *              1.  "old" is plain file, new does not exists
> > - *                  create the "old" file, make sure the "new" file
> > - *                  dose not exist
> > - *                  rename the "old" to the "new" file
> > - *                  verify the "new" file points to the "old" file
> > - *                  verify the "old" file does not exist
> > - *
> > - *              2.  "old" is a directory,"new" does not exists
> > - *                  create the "old" directory, make sure "new"
> > - *                  dose not exist
> > - *                  rename the "old" to the "new"
> > - *                  verify the "new" points to the "old"
> > - *                  verify the "old" does not exist
> > - *	Cleanup:
> > - *		Print errno log and/or timing stats if options given
> > - *		Delete the temporary directory created.
> > - *
> > - * USAGE
> > - *	rename01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> > - *	where,  -c n : Run n copies concurrently.
> > - *		-f   : Turn off functionality Testing.
> > - *		-i n : Execute test n times.
> > - *		-I x : Execute test for x seconds.
> > - *		-P x : Pause for x seconds between iterations.
> > - *		-t   : Turn on syscall timing.
> > - *
> > - * HISTORY
> > - *	07/2001 Ported by Wayne Boyer
> > - *
> > - * RESTRICTIONS
> > - *	None.
> > + * Verify rename() when the newpath file or directory does not exist.
> >   */
> > -#include <sys/types.h>
> > -#include <fcntl.h>
> > -#include <sys/stat.h>
> > -#include <unistd.h>
> > -#include <errno.h>
> >  
> > -#include "test.h"
> > -#include "safe_macros.h"
> > -
> > -void setup();
> > -void cleanup();
> > +#include <sys/stat.h>
> > +#include <stdio.h>
> > +#include "tst_test.h"
> >  
> > -char *TCID = "rename01";
> > -int TST_TOTAL = 2;
> > +#define SWAP(a, b) do { \
> > +		const char *tmp__ = a; \
> > +		a = b; \
> > +		b = tmp__; \
> > +} while (0)
> 
> This doesn't need to be a macro (which don't have type or name collision
> checking and confuse some tooling etc.). It's actually the same number of
> lines to write it inline as well, i.e.
> 
> char *tmp;
> 
> tmp = a;
> a = b;
> b = tmp;
> 
> tmp = c;
> c = d;
> d = tmp;
> 
> However if you don't want to write it inline I'd prefer a function which
> takes const *const *char.
> 

Thanks Richie! I have changed it to inline in updated patch.

> Otherwise looks good.
> 
> 

--
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
