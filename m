Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E41C5DF85
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:15:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EE1C3CD73F
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:15:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 931313C1D3E
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:14:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4243120092C
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:14:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5174584C04
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ch4FoN0VwP7OfuvbSYMG6SOOH1rJC78G2W7L4efl5nE=;
 b=ix9hVI8X+qsVnG6FGmfMGHuA/KXBUF+Uc7+QcXIuHkv962AotvhXFrVKECGNnlahoC9pu4
 SRYK707/opsriTA5MePCalMF6+Eb0KLV5BRw8DHVkJ6pR/lGxU290kzPLM/lbW1xOI/34f
 g8zsVkc8NTeQrxZgB8gGEvxWG4DiJT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ch4FoN0VwP7OfuvbSYMG6SOOH1rJC78G2W7L4efl5nE=;
 b=DBddHNySqUDuEyy7cBBEfB191UkcsiJh+qMypu3vrIrINIz5mmiCMjMDraQEAUTVmi315Z
 ZunTroFnTVuyIdBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ch4FoN0VwP7OfuvbSYMG6SOOH1rJC78G2W7L4efl5nE=;
 b=k4NX663Jff5yDG7EJUF33cmd49ZxkjHyiViejpxIZyqNnGIhQ3DTzFv5TaQncu5Jwa9jMl
 xDNB12s0qBURIH1y+MBmEEBHshh0j7Em+TbjE+8lQEQ5D+mislRcDyIpmkDXB3YeMj5TJk
 ufkS1i4ZsSrXNgGvivxPpcRDZN8EthA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ch4FoN0VwP7OfuvbSYMG6SOOH1rJC78G2W7L4efl5nE=;
 b=fr+C3USgiucyHLOxRbef/eFopwBdrYVViZT8VQwq8H5pf2FKN4INVsYwQIc/VW+Iih5nHm
 oVGJhY59xLEb5YCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 428DA2F81
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R8BgD2/WhWqecAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:14:39 +0000
Date: Wed, 19 Aug 2026 18:14:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <aoXWbzGpcVF3nf1Y@yuki.lan>
References: <20260818141311.1265557-1-chrubis@suse.cz>
 <20260818141311.1265557-31-chrubis@suse.cz>
 <aoUFrxZAKAGWMq7i@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aoUFrxZAKAGWMq7i@linux.dev>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 30/31] testcases: sysfs: Add sys_swap01
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > @@ -25,3 +25,4 @@ sys_block_size01 sys_block_size01
> >  sys_hugepages01 sys_hugepages01
> >  sys_hugepages02 sys_hugepages02
> >  sys_ksm01 sys_ksm01
> > +sys_swap01 sys_swap01
> 
> This should be sys_mm_swap01; otherwise, the runtest file cannot
> find the correct test to execute.

Fixed.

> > --- /dev/null
> > +++ b/testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c
> > @@ -0,0 +1,32 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
> > + */
> > +
> > +/*\
> > + * Sanity check for /sys/kernel/mm/swap/vma_ra_enabled.
> > + *
> > + * Unlike most other boolean sysfs tunables which use 0/1, this one is
> > + * formatted as the strings "true" or "false", so it needs its own check
> > + * rather than TST_SYSFS_ASSERT_BOOL().
> > + *
> > + * The test skips with TCONF when the attribute is not present.
> > + */
> > +
> > +#include "tst_test.h"
> > +#include "tst_sysfs_assert.h"
> > +
> > +#define VMA_RA "/sys/kernel/mm/swap/vma_ra_enabled"
> 
> I suggest adding all of those path definitions to tst_path_defs.h
> and unifying the common macro names.

I didn't fix that one yet, since I wanted to send v2 today. If we agree
that we want that I will fix this in subsequent versions or before
applying.

> Also, we need to add the sysfs/ directory to testcases/kernel/Makefile
> so they can build successfully by default.
> 
> --- a/testcases/kernel/Makefile
> +++ b/testcases/kernel/Makefile
> @@ -36,6 +36,7 @@ SUBDIRS                       += connectors \
>                            sched \
>                            security \
>                            sound \
> +                          sysfs \
>                            thermal \
>                            tracing \
>                            uevents \
> 

Fixed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
