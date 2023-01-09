Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750E8C54EBD
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 15:05:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50C2B3CA166
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 16:05:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE2C23C899B
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 16:05:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A0BF71A000A4
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 16:05:11 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4CF023F161
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673276710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UCt21rMPX0aGjOkaL5RlcW8DgegMzkjeyyHOuAxeuEM=;
 b=ZLK2zpZq+M04X8ibcbrMcF/2twnxgBaDsYUf/OPTZkJfDxPHhziBQhnUnodLlOf8X5eDHb
 Zb465atbYz+/vu2sPpudks4JJmv6YUjhmRVmumopdZD3dgDRzhV96u0VciVvz0N/Lxo5y1
 yTKM7JLT0NpsDRJN1OEkMlDg5BPJhe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673276710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UCt21rMPX0aGjOkaL5RlcW8DgegMzkjeyyHOuAxeuEM=;
 b=Dqeb3/Z7cWWmeSdasgRuxoqRxz9DXy5+iBUnWMOyMO0IFRhntS+3XMr2/zpcNR+Spk2eEo
 elMKOOxX7EdlTpBA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 237FC2C19F;
 Mon,  9 Jan 2023 15:05:10 +0000 (UTC)
References: <20221221075220.14353-1-akumar@suse.de>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 09 Jan 2023 14:55:16 +0000
Organization: Linux Private Site
In-reply-to: <20221221075220.14353-1-akumar@suse.de>
Message-ID: <87pmbniw9o.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setreuid01.c: Rewrite using new LTP API and use
 TST_EXP* macros
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

> Hi,
> I changed this simple setreuid() test to new LTP API but I think
> this is a subset of setreuid03.c test and can be removed altogether.
> Please share your opinion. If this should be removed, I'll post new
> patch for that.
>
>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  .../kernel/syscalls/setreuid/setreuid01.c     | 188 +++---------------
>  1 file changed, 25 insertions(+), 163 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setreuid/setreuid01.c b/testcases/kernel/syscalls/setreuid/setreuid01.c
> index 54ba2d7a8..b0c1e0ab2 100644
> --- a/testcases/kernel/syscalls/setreuid/setreuid01.c
> +++ b/testcases/kernel/syscalls/setreuid/setreuid01.c
> @@ -1,176 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
> - * Author: William Roske
> - * Co-pilot: Dave Fenner
> + *	Author: William Roske
> + *	Co-pilot: Dave Fenner
> + * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
>  
> -/*
> - * Testcase to test the basic functionality of setreuid(2) system call.
> +/*\
> + * [Description]
> + *
> + * Verify the basic functionality of setreuid(2) system call when executed
> + * as non-root user.
>   */
>  
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include <sys/types.h>
> +#include "tst_test.h"
> +#include "compat_tst_16.h"
>  
> -#include "test.h"
> -#include "compat_16.h"
> +static uid_t ruid, euid;
>  
> -static void setup(void);
> -static void cleanup(void);
> -
> -TCID_DEFINE(setreuid01);
> -int TST_TOTAL = 5;
> -
> -static uid_t ruid, euid;	/* real and effective user ids */
> -
> -int main(int ac, char **av)
> +static void run(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/*
> -		 * TEST CASE:
> -		 *  Don't change either real or effective uid
> -		 */
> -		ruid = getuid();	/* get real uid */
> -		UID16_CHECK(ruid, setreuid, cleanup);
> -
> -		euid = geteuid();	/* get effective uid */
> -		UID16_CHECK(euid, setreuid, cleanup);
> -
> -		TEST(SETREUID(cleanup, -1, -1));
> +	ruid = getuid();
> +	UID16_CHECK(ruid, setreuid);
>  
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL,
> -				 "setreuid -  Don't change either real or effective uid failed, errno=%d : %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			tst_resm(TPASS,
> -				 "setreuid -  Don't change either real or effective uid returned %ld",
> -				 TEST_RETURN);
> -		}
> +	euid = geteuid();
> +	UID16_CHECK(euid, setreuid);
>  
> -		/*
> -		 * TEST CASE:
> -		 *  change effective to effective uid
> -		 */
> -
> -		TEST(SETREUID(cleanup, -1, euid));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL,
> -				 "setreuid -  change effective to effective uid failed, errno=%d : %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			tst_resm(TPASS,
> -				 "setreuid -  change effective to effective uid returned %ld",
> -				 TEST_RETURN);
> -		}
> -
> -		/*
> -		 * TEST CASE:
> -		 *  change real to real uid
> -		 */
> -
> -		TEST(SETREUID(cleanup, ruid, -1));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL,
> -				 "setreuid -  change real to real uid failed, errno=%d : %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			tst_resm(TPASS,
> -				 "setreuid -  change real to real uid returned %ld",
> -				 TEST_RETURN);
> -		}
> -
> -		/*
> -		 * TEST CASE:
> -		 *  change effective to real uid
> -		 */
> -
> -		TEST(SETREUID(cleanup, -1, ruid));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL,
> -				 "setreuid -  change effective to real uid failed, errno=%d : %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			tst_resm(TPASS,
> -				 "setreuid -  change effective to real uid returned %ld",
> -				 TEST_RETURN);
> -		}
> -
> -		/*
> -		 * TEST CASE:
> -		 *  try to change real to current real
> -		 */
> -
> -		TEST(SETREUID(cleanup, ruid, ruid));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL,
> -				 "setreuid -  try to change real to current real failed, errno=%d : %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			tst_resm(TPASS,
> -				 "setreuid -  try to change real to current real returned %ld",
> -				 TEST_RETURN);
> -		}
> -
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(void)
> -{
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> +	TST_EXP_PASS(setreuid(-1, -1));
> +	TST_EXP_PASS(setreuid(-1, euid));
> +	TST_EXP_PASS(setreuid(ruid, -1));
> +	TST_EXP_PASS(setreuid(-1, ruid));
> +	TST_EXP_PASS(setreuid(euid, -1));

This drops setreuid(ruid, ruid) from the end.

>  }
>  
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.test_all = run
> +};
> -- 
> 2.39.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
