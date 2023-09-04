Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0D6C83F2C
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 09:32:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 973633CB88D
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 11:32:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4ECF3CB6F8
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 11:32:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B2BD60096A
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 11:32:11 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0836A1F38C
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 09:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693819931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VtugF8WjWltEauB4LstiLmQnf4dMKIiEGEsVob5Eutc=;
 b=1ap3XufMMFVhWwgRVlQHcKOZaonLKwtXhJjdzN683yxlrWct77Nhzq74PwkFjupa/4Oji7
 f9TIpEPZhEIYQYaH89S7wUl2v8dTlEfEfvjLS81Q6njS35+lAfpSm4nt/6cbww18fvEUvR
 tiOyG0M+NlwXCmgjZMWDjrwW0qkWHt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693819931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VtugF8WjWltEauB4LstiLmQnf4dMKIiEGEsVob5Eutc=;
 b=0++QTp3l2dBZiSeQYnEciVytn1F8rQBj7+rfZQXmt9X8eYR4cmrOJh0BYZaMVS2MAzitVx
 s7A+o/xeqzF8fDBw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5ABD42C142;
 Mon,  4 Sep 2023 09:32:10 +0000 (UTC)
References: <20230825063932.30875-1-akumar@suse.de>
 <20230825063932.30875-5-akumar@suse.de>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 04 Sep 2023 10:23:49 +0100
Organization: Linux Private Site
In-reply-to: <20230825063932.30875-5-akumar@suse.de>
Message-ID: <87pm2yffmx.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] syscalls/mmap15: Rewrite test using new LTP
 API
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

Avinesh Kumar <akumar@suse.de> writes:

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/mmap/mmap15.c | 117 +++++++-----------------
>  1 file changed, 35 insertions(+), 82 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/mmap/mmap15.c b/testcases/kernel/syscalls/mmap/mmap15.c
> index 443a37eb8..643ed3a8b 100644
> --- a/testcases/kernel/syscalls/mmap/mmap15.c
> +++ b/testcases/kernel/syscalls/mmap/mmap15.c
> @@ -1,113 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2004
>   *  Written by Robbie Williamson
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
>  
> -/*
> - * Test Description: Test that a normal page cannot be mapped into a high
> - * memory region.
> +/*\
> + * [Description]
> + *
> + * Verify that, a normal page cannot be mapped into a high memory region,
> + * and mmap() call fails with either ENOMEM or EINVAL errno.
>   */
>  
> -#include <sys/types.h>
> -#include <sys/mman.h>
> -#include <sys/mount.h>
> -#include <sys/stat.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <signal.h>
> -#include <stdint.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/abisize.h"
> -
> -char *TCID = "mmap15";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
>  
>  #ifdef __ia64__
> -# define HIGH_ADDR (void *)(0xa000000000000000UL)
> +# define HIGH_ADDR ((void *)(0xa000000000000000UL))
>  #else
> -# define HIGH_ADDR (void *)(-page_size)
> +# define HIGH_ADDR ((void *)(-page_size))
>  #endif
>  
> +#define TEMPFILE "mmapfile"
>  static long page_size;
> +static int fd;
>  
> -static void setup(void);
> -static void cleanup(void);
> -
> -int main(int ac, char **av)
> +static void run(void)
>  {
> -	int lc, fd;
> -	void *addr;
> -
>  #ifdef TST_ABI32
> -	tst_brkm(TCONF, NULL, "This test is only for 64bit");
> +	tst_brkm(TCONF, NULL, "Test is not applicable for 32-bit
> systems.");

This is still the old API. I suggest compiling with -m32 set to check
TCONF works as expected.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
