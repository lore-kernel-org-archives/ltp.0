Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDCFECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 14:49:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AC603CA946
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 16:49:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67CFE3CA914
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 16:49:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 475332000FE
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 16:49:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FEDF1F9ED;
 Mon,  5 Sep 2022 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662389369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U3pUCxOZztclRORv5aVEgdu5BAexmpZu4m8r8b7TMD0=;
 b=aHVUxwrRtiQGQSHN4Ex8y3/ktYj/moJ2lVXc09t129PP7n7H4iOM7pqir+poYRaIzjfLfp
 I/JewgHfuOgl+6U7AuFuHskCR6Eaa3N9Fd3uZNrDp0WrDDxkkOIEkoyOpRhYXBMQx4Z5cP
 Ce+u1ehl4rnozJw22omkz3XM/Jfy2wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662389369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U3pUCxOZztclRORv5aVEgdu5BAexmpZu4m8r8b7TMD0=;
 b=QxLcXBJGQdANU8rROduOerw8PeIIT/bfNf5eoGx4aoSYgTUaCoso3IXEHaHt7Vf+SB6uzX
 WKmksFQB+jw4JVCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EACC13A66;
 Mon,  5 Sep 2022 14:49:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pPHVBXkMFmOCRwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 05 Sep 2022 14:49:29 +0000
Date: Mon, 5 Sep 2022 16:49:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YxYMdvjkSowhJgl1@pevik>
References: <20220902062355.19954-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220902062355.19954-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] unlink07: use TST_EXP_FAIL(), docparse format,
 copyright update  and remove redundant headers
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

Hi Avinesh,

I merged with following diff:

* kept relevant headers (It might be a good practise to keep *relevant headers -
library can be rewritten and headers removed, the build would fail).
* fixed docparse formatting (blank line before list is needed

Thanks!

...
> +++ b/testcases/kernel/syscalls/unlink/unlink07.c
> @@ -1,23 +1,22 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + * Copyright (c) Linux Test Project, 2002-2022
>   */

> -/*
> - * Description:
> - * The testcase checks the various errnos of the unlink(2).
> - * 1) unlink() returns ENOENT if file doesn't exist.
> - * 2) unlink() returns ENOENT if path is empty.
> - * 3) unlink() returns ENOENT if path contains a non-existent file.
> - * 4) unlink() returns EFAULT if address is invalid.
> - * 5) unlink() returns ENOTDIR if path contains a regular file.
> - * 6) unlink() returns ENAMETOOLONG if path contains a regular file.
> +/*\
> + * [Description]
> + *
> + * Verify that unlink() fails with
blank line is needed here.
> + * - ENOENT when file does not exist
> + * - ENOENT when pathname is empty
> + * - ENOENT when a component in pathname does not exist
> + * - EFAULT when pathname points outside the accessible address space
> + * - ENOTDIR when a component used as a directory in pathname is not,
> + * in fact, a directory
> + * - ENAMETOOLONG when pathname is too long
>   */

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
