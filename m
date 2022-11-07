Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D971C433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 12:05:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D3283CDA01
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 13:05:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCEB13C8C79
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 13:04:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 32C3B200330
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 13:04:56 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 319CA225C1
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 12:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667822696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yLcik5WXzM6hi+EyGh7a170OmA5P8dU147CK9D8LxAc=;
 b=iBY98Gxf27pLxt2/0wL/Mp6LkPd/b122kNSQZ4OfNGPezV8p3LM5deCUXD+cHOyMNIZtfg
 zqDJ+aAnduIAWnK/NPopBLCb7tWx/O5Adox+TwjzbjemNkDfzoCQxSZ7WeOsg2BWSyI9ph
 kTX8ZhT4ru0MMKKbcPz3U7sEs/9hhEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667822696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yLcik5WXzM6hi+EyGh7a170OmA5P8dU147CK9D8LxAc=;
 b=8ZxOWexWBdW/rbC0E026atJU9LtNG0SLu5GfJDBuqmER+XihbuN51dNSX/8stqXZm4Z3Kt
 sNT7Zicb3KTD+pBQ==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DA87D2C141;
 Mon,  7 Nov 2022 12:04:55 +0000 (UTC)
References: <20221021115333.13725-1-pvorel@suse.cz>
 <20221021115333.13725-3-pvorel@suse.cz>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 07 Nov 2022 12:03:38 +0000
Organization: Linux Private Site
In-reply-to: <20221021115333.13725-3-pvorel@suse.cz>
Message-ID: <87v8nrvul4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] Makefile: Update copyright, use SPDX
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  Makefile | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index ea11ac7f3..1ccb301a0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,25 +1,7 @@
> -#
> -#    Top-level Makefile for LTP. See INSTALL for more info.
> -#
> -#    Copyright (c) Linux Test Project, 2009-2020
> -#    Copyright (c) Cisco Systems Inc., 2009-2010
> -#
> -#    This program is free software; you can redistribute it and/or modify
> -#    it under the terms of the GNU General Public License as published by
> -#    the Free Software Foundation; either version 2 of the License, or
> -#    (at your option) any later version.
> -#
> -#    This program is distributed in the hope that it will be useful,
> -#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#    GNU General Public License for more details.
> -#
> -#    You should have received a copy of the GNU General Public License along
> -#    with this program; if not, write to the Free Software Foundation, Inc.,
> -#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) Linux Test Project, 2009-2022
> +# Copyright (c) Cisco Systems Inc., 2009-2010
>  # Ngie Cooper, July 2009
> -#

I would just merge, but it won't apply

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

>  
>  # Avoid funny character set dependencies
>  export LANG=C
> -- 
> 2.38.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
