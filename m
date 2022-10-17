Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F2BC433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 08:01:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C06B3CAFD4
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 10:01:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A9913CAD6A
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 10:01:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 805DE60075A
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 10:01:34 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7E25422D24
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665993694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fvaIRs/2/LEIuNHiB30j3C30WW4oLXXA6tIxwudG6VM=;
 b=prvDaDwQpvWL5xcJq68CCWF9VTai9joJpLTJHzJviJ6PY1Bfc9f0sKTKp7+zkDn0wZe1hr
 UqicPhiDG24pwmjSSoEAIXzmQMTLhlYeJzAdBNUQpfx1Gh3fy6gXnPLRKbMcWRDWT+VRE2
 Cd3udgrfpbbchOzCKWHHenHTLzgow1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665993694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fvaIRs/2/LEIuNHiB30j3C30WW4oLXXA6tIxwudG6VM=;
 b=9h0PstsmaU4jNIBhGuDmprUFUVaGAWC3RbxTg562EKCqqaiaaLgJtRd3GYoHOMEx2RMvUJ
 hB9YUm3uayPNQWDw==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 19F5F2C141;
 Mon, 17 Oct 2022 08:01:33 +0000 (UTC)
References: <20220823095116.369-1-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 17 Oct 2022 09:01:17 +0100
In-reply-to: <20220823095116.369-1-akumar@suse.de>
Message-ID: <87ilkiq3oj.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setegid02.c: Rewrite using new LTP API
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

Merged! Thanks

Avinesh Kumar <akumar@suse.de> writes:

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/setegid/setegid02.c | 90 +++++--------------
>  1 file changed, 21 insertions(+), 69 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setegid/setegid02.c b/testcases/kernel/syscalls/setegid/setegid02.c
> index 7c60a9cf5..66a8a07fb 100644
> --- a/testcases/kernel/syscalls/setegid/setegid02.c
> +++ b/testcases/kernel/syscalls/setegid/setegid02.c
> @@ -1,87 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2014 Fujitsu Ltd.
>   * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
> -/*
> - * DESCRIPTION
> - *	The calling process is not privileged and euid is not appropriate,
> - *	EPERM should return.
> +
> +/*\
> + * [Description]
> + *
> + * Verify that setegid() fails with EPERM when the calling process is not
> + * privileged and egid does not match the current real group ID,
> + * current effective group ID, or current saved set-group-ID.
>   */
>  
> -#include <errno.h>
>  #include <pwd.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "setegid02";
> -int TST_TOTAL = 1;
> -static void setup(void);
> -static void setegid_verify(void);
> -static void cleanup(void);
> +#include "tst_test.h"
>  
>  static struct passwd *ltpuser;
>  
> -int main(int argc, char *argv[])
> -{
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		setegid_verify();
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
>  static void setup(void)
>  {
> -	tst_require_root();
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
> -
> -	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
> +	ltpuser = SAFE_GETPWNAM("nobody");
> +	SAFE_SETEUID(ltpuser->pw_uid);
>  }
>  
>  static void setegid_verify(void)
>  {
> -	TEST(setegid(ltpuser->pw_gid));
> -
> -	if (TEST_RETURN != -1) {
> -		tst_resm(TFAIL, "setegid(%d) succeeded unexpectedly",
> -			 ltpuser->pw_gid);
> -		return;
> -	}
> -
> -	if (TEST_ERRNO == EPERM) {
> -		tst_resm(TPASS | TTERRNO, "setegid failed as expected");
> -	} else {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "setegid failed unexpectedly; expected: %d - %s",
> -			 EPERM, strerror(EPERM));
> -	}
> +	TST_EXP_FAIL(setegid(ltpuser->pw_gid),
> +				EPERM,
> +				"setegid(%d)",
> +				ltpuser->pw_gid);
>  }
>  
> -static void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = setegid_verify,
> +	.needs_root = 1
> +};
> -- 
> 2.37.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
