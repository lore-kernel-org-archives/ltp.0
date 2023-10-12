Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFFFCDB484
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 09:58:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 889293CD401
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 11:58:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA69A3C888B
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:58:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6488E600770
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:58:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BEF51F74C;
 Thu, 12 Oct 2023 09:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697104704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BND5zeG32am+ynETGQTKzwINNGzabQ158jKrDsqG6P4=;
 b=CPRIipo3X2SGUqSX3jgcFmf2U8V49T4m5SW69KDouO8bek5wqENSiYhBn0bcTJ7MoMbV+o
 qX05GKuZR02Qz9AfQEtuWPYg85Hv51FW//QAQTavnlFzRMWuar34luoaXPem1wFPQiYVoK
 Hlq2oV88TOPovrBaN1fY7jcLtenVhhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697104704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BND5zeG32am+ynETGQTKzwINNGzabQ158jKrDsqG6P4=;
 b=ml1GNH3ngiWOm/f8ZGpJvvsy32rIe/ohbiSNFURHEXq5nk8zALlcVPZdIpw98noKVKRPIS
 eXDcIPglnmJ7ETAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70F6A139ED;
 Thu, 12 Oct 2023 09:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S5fhGUDDJ2UMfwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 Oct 2023 09:58:24 +0000
Date: Thu, 12 Oct 2023 11:58:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231012095823.GB618148@pevik>
References: <1697021709-22916-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697021709-22916-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1697021709-22916-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] link08: Convert docs to docparse
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

...
> +++ b/testcases/kernel/syscalls/link/link08.c
> @@ -3,21 +3,23 @@
>   * Copyright (c) 2014 Fujitsu Ltd.
While you're in it, maybe update the copyright?

* Copyright (c) Linux Test Project, 2014-2022

>   * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
>   */
> -/*
> - * Test Description:
> - *  Verify that,
> - *   1. link() fails with -1 return value and sets errno to EPERM
> - *      if oldpath is a directory.
> - *   2. link() fails with -1 return value and sets errno to EXDEV
> - *      if oldpath and newpath are not on the same mounted file system( Linux
> - *      permits a file system to be mounted at multiple points, but link()
> - *      does not work across different mount points, even if the same
> - *      file system is mounted on both. ).
> - *   3. link() fails with -1 return value and sets errno to EROFS
> - *      if the file is on a read-only file system.
> - *   4. link() fails with -1 return value and sets errno to ELOOP
> - *      if too many symbolic links were encountered in resolving path.
> +
> +/*\
> + * [Description]
I would keep the sentence:
"Verify that"" or "Test that:"

Beware, there must be a blank line before the list, otherwise list will not be
formatted as list, but inline.

With this change:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> + *
> + * - link() fails with -1 return value and sets errno to EPERM
> + *   if oldpath is a directory.
> + * - link() fails with -1 return value and sets errno to EXDEV
> + *   if oldpath and newpath are not on the same mounted file system( Linux
> + *   permits a file system to be mounted at multiple points, but link()
> + *   does not work across different mount points, even if the same
> + *   file system is mounted on both. ).
> + * - link() fails with -1 return value and sets errno to EROFS
> + *   if the file is on a read-only file system.
> + * - link() fails with -1 return value and sets errno to ELOOP
> + *   if too many symbolic links were encountered in resolving path.
>   */
> +

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
