Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD20BC0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 22:47:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 161543CF915
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 00:47:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D71193CCB57
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 00:46:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 473B910011B3
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 00:46:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 455771F74C;
 Wed, 25 Oct 2023 22:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698274012;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rka3hOKvbykAHw/gbC8tYCTCTj6tgpU8etC+SG/jMnM=;
 b=Nr3PNvViXBJV1Yny2h9Zj8Us/oAlLurss9G5Ewut8EkTH5mtyegfd5MirgAw09hEJDirK2
 lbeorYI8KsQ+OdqbpOMZh4xf56oX7pynwyGJgz6cRe7+ZcN2KaVxiornFomUBoYXsntU4D
 8n9KUfwvXzP/EdYFsM2qvGj1g2M5rNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698274012;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rka3hOKvbykAHw/gbC8tYCTCTj6tgpU8etC+SG/jMnM=;
 b=UXWPQvT4SFl3D47SgObcDt7ZRJU+ewcobRaYG5xBVxdCCxfDY0UoVVbkRlKLdVzCyhBwZq
 +5Cws8r821zMynAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2803013524;
 Wed, 25 Oct 2023 22:46:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 58mhCNyaOWUZSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 22:46:52 +0000
Date: Thu, 26 Oct 2023 00:46:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231025224650.GA507231@pevik>
References: <1697794677-14892-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1697794677-14892-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/symlink02: Convert to new API
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

> The original test didn't produce any output results.
> Use tst_macro to enable test to produce output results.

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/symlink/symlink02.c | 218 ++----------------
>  1 file changed, 25 insertions(+), 193 deletions(-)

> diff --git a/testcases/kernel/syscalls/symlink/symlink02.c b/testcases/kernel/syscalls/symlink/symlink02.c
> index c18db2b37..c152bb2b7 100644
> --- a/testcases/kernel/syscalls/symlink/symlink02.c
> +++ b/testcases/kernel/syscalls/symlink/symlink02.c
> @@ -1,208 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.

Unfortunately this is GPL v2 only.

I fixed that and merged also with Li's RBT (he added it to v1 and pointed out
the useless fd).

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
