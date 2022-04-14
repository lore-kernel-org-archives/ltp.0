Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43708C433F5
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 07:57:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 904F33CA5C1
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 09:57:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF3BB3CA2C5
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 09:57:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EC6B8600A02
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 09:57:38 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id EBE8E21616;
 Thu, 14 Apr 2022 07:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649923057;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zqiyevPGHC+qGo+JdanO99On1zaFO+Hgv0Z1uDNSwyk=;
 b=dE31nxNkx/NBJORHI5Pr2Ii4R/g/JImywyG6Pjz/mxmmVREBtHGxpH3KLBGU/oroa0LZzm
 otJatJ8zvl2TbznX5qD3q8eIKG21nJw6TD1582GHl29y0a50oLQ4n4g42r0X+v1Aq4z4kU
 6bfkAcngkRmCwwRLimbQnjgdWg7Wq0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649923057;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zqiyevPGHC+qGo+JdanO99On1zaFO+Hgv0Z1uDNSwyk=;
 b=Gp8AvV0f2WhPWpwi6LG67XFfblTmjYtCG7bdL48kXa7ImqVSgWJIp/uc+6U3OH6VxrmM++
 EmwM8knJsVTKHmCQ==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 825B3A3B83;
 Thu, 14 Apr 2022 07:57:37 +0000 (UTC)
References: <20220216063430.31447-1-tangmeng@uniontech.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: tangmeng <tangmeng@uniontech.com>
Date: Thu, 14 Apr 2022 08:54:56 +0100
In-reply-to: <20220216063430.31447-1-tangmeng@uniontech.com>
Message-ID: <87czhkyu4v.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/fchmodat_01: Convert to new API
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

tangmeng <tangmeng@uniontech.com> writes:

> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> ---
>  .../kernel/syscalls/fchmodat/fchmodat01.c     | 166 +++++++-----------
>  1 file changed, 60 insertions(+), 106 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
> index 9676ae0fd..70e35b363 100644
> --- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
> +++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
> @@ -1,116 +1,65 @@
> -/******************************************************************************
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines  Corp., 2006
>   *
> - *   Copyright (c) International Business Machines  Corp., 2006
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - *
> - * NAME
> - *      fchmodat01.c
> - *
> - * DESCRIPTION
> - *	This test case will verify basic function of fchmodat
> - *	added by kernel 2.6.16 or up.
> - *
> - * Author
> - *	Yi Yang <yyangcdl@cn.ibm.com>
> - *
> - * History
> - *      08/28/2006      Created first by Yi Yang <yyangcdl@cn.ibm.com>
> + * 08/28/2006 AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
> + */
> +
> +/*\
> + * [Description]
>   *
> - *****************************************************************************/
> + * This test case will verify basic function of fchmodat.
> + */
>  
>  #define _GNU_SOURCE
>  
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
>  #include <unistd.h>
> -#include <stdlib.h>
> -#include <errno.h>
>  #include <string.h>
> -#include <signal.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include "tst_test.h"
>  #include "lapi/syscalls.h"
>  
> -#define TEST_CASES 6
>  #ifndef AT_FDCWD
>  #define AT_FDCWD -100
>  #endif
> -void setup();
> -void cleanup();
> -
> -char *TCID = "fchmodat01";
> -int TST_TOTAL = TEST_CASES;
> -char pathname[256];
> -char testfile[256];
> -char testfile2[256];
> -char testfile3[256];
> -int fds[TEST_CASES];
> -char *filenames[TEST_CASES];
> -int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
> -
> -int myfchmodat(int dirfd, const char *filename, mode_t mode)
> -{
> -	return tst_syscall(__NR_fchmodat, dirfd, filename, mode);
> -}
>  
> -int main(int ac, char **av)
> +static char pathname[256];
> +static char testfile[256];
> +static char testfile2[256];
> +static char testfile3[256];
> +
> +static struct tcase {
> +	int exp_errno;          /* Expected error no            */
> +	char *exp_errval;       /* Expected error value string  */

With these comments removed (I can remove them before merge, no need for
another patch)

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

The style guide says to avoid comments.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
