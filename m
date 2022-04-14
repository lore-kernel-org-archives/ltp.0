Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8C0C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 10:16:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A56C83CA5C0
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 12:16:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 222E03C5785
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 12:16:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2FDDC1A0064B
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 12:16:31 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 354161F746;
 Thu, 14 Apr 2022 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649931391;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=thSLgGAQQJUvo5vPTxS/x6lF7WmSgHwpyY/GHnuo0Bw=;
 b=FvlWz+4FFGgKuObuBedP4CL4MYFjQVGvR2XEbzNIYnbmd1a6uNpZArmZD2iyMN2YlbEWkZ
 LLrrjmxYCou/QKzh8/ZeXDVWgO/Mhp/5aZsUPdGQmuBudKnUJCuWKQgq14mWiG+Ekgfchq
 oHxl1XJEIVebltR6OakDF6andAESBjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649931391;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=thSLgGAQQJUvo5vPTxS/x6lF7WmSgHwpyY/GHnuo0Bw=;
 b=Vh7qdzid2AIaYmZphiGC9bMAZy9NoKXsosJ6/mX8kfHpx3ph2JPlKyMbQ9BVjGZp/R2sCw
 zHjunri10QA9v5AQ==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F3FC8A3B95;
 Thu, 14 Apr 2022 10:16:30 +0000 (UTC)
References: <20220216145458.18505-1-andrea.cervesato@suse.de>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 14 Apr 2022 10:55:36 +0100
In-reply-to: <20220216145458.18505-1-andrea.cervesato@suse.de>
Message-ID: <87r160x94x.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite sighold02.c using new LTP API
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

Andrea Cervesato <andrea.cervesato@suse.de> writes:

> Removed TST_CHECKPOINT_INIT and replaced it with the .needs_checkpoints
> LTP test feature. Simplified source code.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> ---
>  testcases/kernel/syscalls/sighold/sighold02.c | 180 +++++-------------
>  1 file changed, 48 insertions(+), 132 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
> index b763142df..212e6e78c 100644
> --- a/testcases/kernel/syscalls/sighold/sighold02.c
> +++ b/testcases/kernel/syscalls/sighold/sighold02.c
> @@ -1,74 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>   *  AUTHOR          : Bob Clark
>   *  CO-PILOT        : Barrie Kletscher
>   *  DATE STARTED    : 9/26/86
>   * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
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
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
                    ^2022
>   */
> -/*
> - * TEST ITEMS
> - *	1. sighold action to turn off the receipt of all signals was done
> - *	   without error.
> +
> +/*\
> + * [Description]
> + *
> + * This test checks following conditions:
> + *	1. sighold action to turn off the receipt of all signals was done without error.
>   *	2. After signals were held, and sent, no signals were trapped.
>   */
> -#define _XOPEN_SOURCE 500
> -#include <errno.h>
> +
> +#define _XOPEN_SOURCE 600
>  #include <signal.h>
> -#include <string.h>
> -#include <fcntl.h>
> -#include <stdlib.h>
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/signal.h"
> +#include "tst_test.h"
>  
>  /* _XOPEN_SOURCE disables NSIG */
>  #ifndef NSIG
> -# define NSIG _NSIG
> +#	define NSIG _NSIG
>  #endif
>  
>  /* ensure NUMSIGS is defined */

Comments like this can be removed

With those fixed:

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
