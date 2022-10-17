Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6186C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 13:02:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 176CA3CAFC7
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 15:02:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0A153CAFC7
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 15:02:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F1FC310007EF
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 15:02:20 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1EEBF33B5B;
 Mon, 17 Oct 2022 13:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666011740;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XiN01EJh77ecwOsD9H886s0SOKvCF/0v3bd1xzlB6Bc=;
 b=XIyMR1582LAIrfiAw0r4SYf8+gBXVddm7le0ccEUM+Nq+sAoLRGaR09DM0dxMjDXU6eG7S
 ok4RCpPJOsFv5VtYCo/erX+44P3dRLvd1FRAvLTzbu3VNBZDwA/yjhroZQ91MpEhjEkLPC
 xzUR41iEo5FwqBThWLuP0o7LxzDYyKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666011740;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XiN01EJh77ecwOsD9H886s0SOKvCF/0v3bd1xzlB6Bc=;
 b=73FnR9LQxuQj0u4DgpHQM2xKOU79kDgMhTaqEb8CI1wIR2y5HBuefZ/oeAY7Ff7Y9cF+ye
 jNINbjLgk5iT8jBg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 491A72C141;
 Mon, 17 Oct 2022 13:02:19 +0000 (UTC)
References: <1663208146-5239-1-git-send-email-liaohj.jy@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Liao Huangjie <liaohj.jy@fujitsu.com>
Date: Mon, 17 Oct 2022 13:54:05 +0100
In-reply-to: <1663208146-5239-1-git-send-email-liaohj.jy@fujitsu.com>
Message-ID: <87czaqob6v.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fork02: Remove it
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

Liao Huangjie <liaohj.jy@fujitsu.com> writes:

> From: Huangjie Liao <liaohj.jy@fujitsu.com>
>
> This test case has been covered in fork01,so remove it

Not exactly because of wait. However I'll accept this on the basis that
the original test doesn't ensure the child actually ran. Anything it
does test will be covered by a lot of other stuff.

>
> Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/fork/fork02.c | 99 -------------------------
>  1 file changed, 99 deletions(-)
>  delete mode 100644 testcases/kernel/syscalls/fork/fork02.c
>
> diff --git a/testcases/kernel/syscalls/fork/fork02.c b/testcases/kernel/syscalls/fork/fork02.c
> deleted file mode 100644
> index 6fe66f823..000000000
> --- a/testcases/kernel/syscalls/fork/fork02.c
> +++ /dev/null
> @@ -1,99 +0,0 @@
> -/*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
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
> - */
> -
> -/*
> - * NAME
> - *	fork02.c
> - *
> - * DESCRIPTION
> - *	Test correct operation of fork:
> - *		pid == 0 in child;
> - *		pid > 0 in parent from wait;
> - *
> - * ALGORITHM
> - *	Fork one process, check for pid == 0 in child.
> - *	Check for pid > 0 in parent after wait.
> - *
> - * USAGE
> - *	fork02
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	None
> - */
> -
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include "test.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -char *TCID = "fork02";
> -int TST_TOTAL = 1;
> -
> -int main(int ac, char **av)
> -{
> -	int pid1, pid2, status;
> -
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		pid1 = fork();
> -		if (pid1 == -1)
> -			tst_brkm(TBROK, cleanup, "fork() failed");
> -
> -		if (pid1 == 0) {
> -			tst_resm(TINFO, "Inside child");
> -			_exit(0);
> -		} else {
> -			tst_resm(TINFO, "Inside parent");
> -			pid2 = wait(&status);
> -			tst_resm(TINFO, "exit status of wait %d", status);
> -
> -			if (pid1 == pid2)
> -				tst_resm(TPASS, "test 1 PASSED");
> -			else
> -				tst_resm(TFAIL, "test 1 FAILED");
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> -}
> -
> -static void cleanup(void)
> -{
> -}
> -- 
> 2.27.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
