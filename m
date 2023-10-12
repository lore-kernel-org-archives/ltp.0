Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6CECDB46E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 09:55:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 336263CD420
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 11:55:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D6EF3C88AA
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:55:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 54382600657
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:55:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C300E1F74B;
 Thu, 12 Oct 2023 09:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697104516;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4vTLZf4r7ub4BbRjYyAGFllAoKJXVhKUa2ABakarpz0=;
 b=i/8dRFPb87YYGHIs/LFbkmXcPFxIC3FP9hBQzbJKmnHcEaR/mSiaCaVjBM9vNNGoF9YgK+
 XJt8Qckd/JRn+usmujvIowUX5Cp01gZi/3aXiikWI/c+bxtWOHsciixggOfQiOpIDjbJLi
 kCw0CW+y2lLLzfidQhCkuybQGxxlSro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697104516;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4vTLZf4r7ub4BbRjYyAGFllAoKJXVhKUa2ABakarpz0=;
 b=83i00C0G44Jgys/H3g1Eew70ImeRwjws5M3za0ikyi6a+cfT0twqJvbT6PFwxW5f9TC2Yc
 zkGX650+rxLyxRBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B487139ED;
 Thu, 12 Oct 2023 09:55:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +HO5JITCJ2VvfQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 Oct 2023 09:55:16 +0000
Date: Thu, 12 Oct 2023 11:55:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231012095515.GA618148@pevik>
References: <1697021709-22916-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1697021709-22916-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] link03: Convert docs to docparse
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

first, so far we did these changes during rewrite to the new C API.
Do we really put docparse on these old tests? I would postpone it.

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/link/link03.c | 41 +++++--------------------
>  1 file changed, 7 insertions(+), 34 deletions(-)

> diff --git a/testcases/kernel/syscalls/link/link03.c b/testcases/kernel/syscalls/link/link03.c
> index 1f45240ae..27f8a4efe 100644
> --- a/testcases/kernel/syscalls/link/link03.c
> +++ b/testcases/kernel/syscalls/link/link03.c
> @@ -1,42 +1,15 @@
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - *  AUTHOR		: Richard Logan
> - *  CO-PILOT		: William Roske
> + * AUTHOR		: Richard Logan
> + * CO-PILOT		: William Roske
Although we probably should keep these names, we're not forced to have it in
original ugly form. How about put it as:
* Authors: Richard Logan, William Roske


>   * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
I would also put here:
* Copyright (c) Linux Test Project, 2001-2023

> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - * http://www.sgi.com
> - *
> - * For further information regarding this notice, see:
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - *
>   */

You removed GPL, but haven't added SPDX on a first line:
// SPDX-License-Identifier: GPL-2.0-only

> - /*
> -  * Tests that link(2) succeds with creating n links.
> -  */
> +/*\
> + * [Description]
> + *
> + * Tests that link(2) succeds with creating n links.
s/succeds/succeeds/g
> + */

Kind regards,
Petr

>  #include <sys/types.h>
>  #include <fcntl.h>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
