Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7754FEB64DC
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 04:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 489873CB9C5
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 06:31:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 224123C9946
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 06:31:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 53DFE600637
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 06:31:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 455481F383;
 Mon,  3 Jul 2023 04:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688358676;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSYsvyy9sSUCjt5QAzXwYixB70NgR1hs3W+pEf6d8/Y=;
 b=B54SpJ0TTCq+Aogi501q/AkwtecaeLafUTyr0IItv4Z4EcHrrygNalfXPlAytljNuYnDRG
 V/r5TZ1YYrGxPhJgW68FcPKT0yyLWBjIRorLVtmYKdCVvzMg46Z1xdGjHNyWTN+RZCYSTT
 LOMuaDUqrLdwnfAsFINoQaRJTkMy84E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688358676;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSYsvyy9sSUCjt5QAzXwYixB70NgR1hs3W+pEf6d8/Y=;
 b=Bp1dF2D84j8PAaWBxU7rLmuYRjPgbZ9VmYSYRA65iG6j5m9EIswl2SvSszKrBM4MuveU1p
 msiy2X0iYane6GAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22B4613276;
 Mon,  3 Jul 2023 04:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a2cbBxRPomS5CgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jul 2023 04:31:16 +0000
Date: Mon, 3 Jul 2023 06:31:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230703043114.GA363557@pevik>
References: <1688352041-4945-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1688352041-4945-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/geteuid01: Convert into new api
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

Hi Xu,

make check-geteuid01 reports a lot of errors.
Some of them are to compat_tst_16.h (missing static would be easy to add),
others are related to this file.

>  testcases/kernel/syscalls/geteuid/geteuid01.c | 88 ++++-----------------------
> +//SPDX-License-Identifier: GPL-2.0-only
geteuid01.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
Maybe adding your or LTP license?

...
> + *    AUTHOR            : William Roske
> + *    CO-PILOT          : Dave Fenner
Maybe just:
 * Author: William Roske, Dave Fenner

>   */

>  /*
This must be /*\, otherwise it will to be taken by our parser.

> + * [Description]
> + *
> + * Check the basic functionality of the geteuid() system call.
>   */

...
> +	TST_EXP_POSITIVE(GETEUID(),"geteuid");
geteuid01.c:20: ERROR: space required after that ',' (ctx:VxV)
TST_EXP_POSITIVE(GETEUID(), "geteuid");

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
