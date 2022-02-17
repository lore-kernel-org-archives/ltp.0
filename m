Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5920DC433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 18:53:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 676E83C964D
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 19:53:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A0B23C56F5
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 19:52:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DFC3C1A01975
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 19:52:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D85C8219A0;
 Thu, 17 Feb 2022 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645123973;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cAEQ2XUMP1SRmhEpFP1Yc3yuuyBS2YHZ8Bljq+fDr8I=;
 b=WGrTlVE6LFguhDsowmn34kwEmkAWon0rVV2dbc0KquRo5BGGoZN5xeyklA0bTDLd2FGalm
 4PIFhTxjQ2NmfLRAQiJ3riuGJLjnKK01Sca7vyIiZ099+3rl4lnaDSGMvexZwfoNtBeYc3
 VrTYOxbdFPr/rpuLuAgQEBIPUhClkz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645123973;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cAEQ2XUMP1SRmhEpFP1Yc3yuuyBS2YHZ8Bljq+fDr8I=;
 b=6EneRuZ4CRyXjVyQpXQkH2uUiuHslJf/xZ2bfOK3BGrVeMw++2NBTRHsyTyy7ADJh0hsIK
 QdhgeiHIFeveWxAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9378513C2E;
 Thu, 17 Feb 2022 18:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4WG/H4WZDmI3PwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Feb 2022 18:52:53 +0000
Date: Thu, 17 Feb 2022 19:52:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Yg6ZgyD3R2PgL+HN@pevik>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1645005868-2373-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] lapi/kcmp.h: Replace GPL with
 SPDX-License-Identifier
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

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  include/lapi/kcmp.h | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

> diff --git a/include/lapi/kcmp.h b/include/lapi/kcmp.h
> index 59371fc07..77086191f 100644
> --- a/include/lapi/kcmp.h
> +++ b/include/lapi/kcmp.h
> @@ -1,29 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software Foundation,
> - * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   */

> -#ifndef KCMP_H
> -#define KCMP_H
> +#ifndef LAPI_KCMP_H__
> +#define LAPI_KCMP_H__

>  #include <sys/types.h>
>  #include "config.h"
>  #include "lapi/syscalls.h"

> -#if !defined(HAVE_ENUM_KCMP_TYPE)
> +#ifndef HAVE_ENUM_KCMP_TYPE

>  enum kcmp_type {
>  	KCMP_FILE,
> @@ -42,7 +29,7 @@ enum kcmp_type {

>  #endif

> -#if !defined(HAVE_KCMP)
> +#ifndef HAVE_KCMP

>  int kcmp(int pid1, int pid2, int type, int fd1, int fd2)
$ make check-pidfd_getfd01
../../../../include/lapi/kcmp.h:34:5: warning: Symbol 'kcmp' has no prototype or library ('tst_') prefix. Should it be static?

Could you please mark this as static inline?

Not sure if this should be with the same commit as SPDX.
When doing cleanup it'd be worth to fix it.

Kind regards,
Petr

>  {
> @@ -51,4 +38,4 @@ int kcmp(int pid1, int pid2, int type, int fd1, int fd2)

>  #endif

> -#endif /* KCMP_H */
> +#endif /* LAPI_KCMP_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
