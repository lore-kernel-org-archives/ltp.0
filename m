Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F35BC4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 08:08:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 607D73CAFDC
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 10:07:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF4AC3CAD6A
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 10:07:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CFE2A200907
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 10:07:46 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 44BFB20243
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 08:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665994065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ZcEzaSzmFBfKCRx8fY5N7DcwTCpkITy8dpE4g5Ub3E=;
 b=Jw01VFKeu+yF4E5B07cV1svW6wigJLXKN0IpcjzIpA3IkJnjqt5EhavoH9A5Z8ZZAQhpRj
 vmP+b7v6HPi5zk/IzMGVY5vjPvz4yRZENfxb2Ga7k7bBcBkTdwyLDbpxtNaIFceYzMqvmd
 tf8OcMmuKYeXsov6pINuvSt+XOMNIt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665994065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ZcEzaSzmFBfKCRx8fY5N7DcwTCpkITy8dpE4g5Ub3E=;
 b=g5/VUi8dz7aYgaylbTxy7zEAt+JiutBNkzM7/g2N9Csu8CjNHzd2ShQw+E4r5HIKuePVw/
 /DaO5dYzgvQyDnCA==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B06AC2C141;
 Mon, 17 Oct 2022 08:07:44 +0000 (UTC)
References: <20220823145213.24375-1-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 17 Oct 2022 09:07:33 +0100
In-reply-to: <20220823145213.24375-1-akumar@suse.de>
Message-ID: <87edv6q3e8.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid01.c: Rewrite using new LTP API
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

Merged! Thanks

Avinesh Kumar <akumar@suse.de> writes:

> Rewrite with new API and add test to verify that filesystem user ID was
> correctly updated by calling setfsuid(-1) which will always fail but
> will return the previous filesystem user ID.
>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  .../kernel/syscalls/setfsuid/setfsuid01.c     | 96 ++++++-------------
>  1 file changed, 27 insertions(+), 69 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid01.c b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
> index 63f9f5dd8..0cbf101ee 100644
> --- a/testcases/kernel/syscalls/setfsuid/setfsuid01.c
> +++ b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
> @@ -1,87 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2001
>   * Ported by Wayne Boyer
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
> + * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
>  
> -/*
> - * Testcase to test the basic functionality of the setfsuid(2) system call.
> +/*\
> + * [Description]
> + *
> + * Verify that setfsuid() correctly updates the filesystem user ID
> + * to the value given in fsuid argument.
>   */
>  
> -#include <sys/types.h>
> -#include <sys/fsuid.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <errno.h>
> +#include <pwd.h>
> +#include "tst_test.h"
> +#include "compat_tst_16.h"
>  
> -#include "test.h"
> -#include "compat_16.h"
> +static uid_t nobody_uid;
>  
> -static void setup(void);
> -static void cleanup(void);
> +static void setup(void)
> +{
> +	struct passwd *nobody;
>  
> -TCID_DEFINE(setfsuid01);
> -int TST_TOTAL = 1;
> +	nobody = SAFE_GETPWNAM("nobody");
> +	nobody_uid = nobody->pw_uid;
> +}
>  
> -int main(int ac, char **av)
> +static void run(void)
>  {
> -	int lc;
> -
>  	uid_t uid;
>  
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
>  	uid = geteuid();
> -	UID16_CHECK(uid, setfsuid, cleanup);
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +	UID16_CHECK(uid, setfsuid);
>  
> -		tst_count = 0;
> -
> -		TEST(SETFSUID(cleanup, uid));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO,
> -				"setfsuid() failed unexpectedly");
> -			continue;
> -		}
> -
> -		if (TEST_RETURN != uid) {
> -			tst_resm(TFAIL, "setfsuid() returned %ld, expected %d",
> -				 TEST_RETURN, uid);
> -		} else {
> -			tst_resm(TPASS,
> -				"setfsuid() returned expected value : %ld",
> -				TEST_RETURN);
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	SAFE_SETEUID(0);
> +	TST_EXP_VAL(setfsuid(nobody_uid), uid, "setfsuid(%d)", nobody_uid);
> +	TST_EXP_VAL(setfsuid(-1), nobody_uid);
>  }
>  
> -static void setup(void)
> -{
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -}
> -
> -static void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1
> +};
> -- 
> 2.37.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
