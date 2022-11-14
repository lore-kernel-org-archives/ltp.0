Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B594C433FE
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 10:52:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 508E93CD24E
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 11:52:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB06C3C0796
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 11:52:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EEBA71A00701
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 11:52:19 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 54C4F1FE73
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 10:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668423139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsbXhOh8i0nuyeh2iD4TZc+xvQzuZ5R/GE1uRdo/MFs=;
 b=qsx2yyPDtemF+M/Ck+sjSB7VcJ1JAjYTIsTogM8Fh1n0udwdXrpnV/SQLs+Cn6MsDFB+r5
 BsC1ouo1ZzfsBChfuyuukqQa54ZaDs2smKevDKpp+/OV8V1odrPjH1HnfOr4Tb16w/1Ly9
 5+vyxItWqUE7j+OuDJIRbUMMLF54gnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668423139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsbXhOh8i0nuyeh2iD4TZc+xvQzuZ5R/GE1uRdo/MFs=;
 b=tleR1fKPWw8HVXUVuOVQRsM5yPax95gswdm1bqtcSAyN/HnbDfx9dFPGAfejNtVq6JntR2
 dkMeC6KPqlYqXYCA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2B3F32C141;
 Mon, 14 Nov 2022 10:52:19 +0000 (UTC)
References: <20221103062811.9636-1-akumar@suse.de>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 14 Nov 2022 10:52:08 +0000
Organization: Linux Private Site
In-reply-to: <20221103062811.9636-1-akumar@suse.de>
Message-ID: <87k03xu7tp.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] setfsuid03: Convert to new LTP API
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

> - rewrite using new API
> - using caller's real user ID as fsuid when calling
> setfsuid(fsuid) by non-root user
> - verifying that fsuid is updated correctly, by calling
> setfsuid(-1)
>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>

Merged, thanks!

> ---
>  .../kernel/syscalls/setfsuid/setfsuid03.c     | 111 ++++--------------
>  1 file changed, 26 insertions(+), 85 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid03.c b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
> index 0e5f860c8..02698f7cf 100644
> --- a/testcases/kernel/syscalls/setfsuid/setfsuid03.c
> +++ b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
> @@ -2,105 +2,46 @@
>   * Copyright (C) International Business Machines  Corp., 2001
>   * Ported by Wayne Boyer
>   * Adapted by Dustin Kirkland (k1rkland@us.ibm.com)
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
> - * Testcase to test the basic functionality of the setfsuid(2) system
> - * call when called by a user other than root.
> +/*\
> + * [Description]
> + *
> + * Verify that setfsuid() correctly updates the filesystem uid
> + * when caller is a non-root user and provided fsuid matches
> + * caller's real user ID.
>   */
>  
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <sys/types.h>
> -#include <errno.h>
>  #include <pwd.h>
>  
> -#include "test.h"
> -#include "compat_16.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> +#include "tst_test.h"
> +#include "compat_tst_16.h"
>  
> -TCID_DEFINE(setfsuid03);
> -int TST_TOTAL = 1;
> +static uid_t nobody_uid;
>  
> -static char nobody_uid[] = "nobody";
> -static struct passwd *ltpuser;
> -
> -int main(int ac, char **av)
> +static void setup(void)
>  {
> -	int lc;
> -
> -	uid_t uid;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	uid = 1;
> -	while (!getpwuid(uid))
> -		uid++;
> +	struct passwd *nobody;
>  
> -	UID16_CHECK(uid, setfsuid, cleanup);
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
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
> -		if (TEST_RETURN == uid) {
> -			tst_resm(TFAIL,
> -				 "setfsuid() returned %ld, expected anything but %d",
> -				 TEST_RETURN, uid);
> -		} else {
> -			tst_resm(TPASS, "setfsuid() returned expected value : "
> -				 "%ld", TEST_RETURN);
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	nobody = SAFE_GETPWNAM("nobody");
> +	nobody_uid = nobody->pw_uid;
>  }
>  
> -static void setup(void)
> +static void run(void)
>  {
> -	tst_require_root();
> -
> -	ltpuser = getpwnam(nobody_uid);
> -	if (ltpuser == NULL)
> -		tst_brkm(TBROK, cleanup, "getpwnam failed for user id %s",
> -			nobody_uid);
> -
> -	if (setuid(ltpuser->pw_uid) == -1)
> -		tst_resm(TINFO | TERRNO, "setuid failed to "
> -			 "to set the effective uid to %d", ltpuser->pw_uid);
> +	uid_t ruid, euid, suid;
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	SAFE_GETRESUID(&ruid, &euid, &suid);
> +	SAFE_SETEUID(nobody_uid);
> +	UID16_CHECK(ruid, setfsuid);
>  
> -	TEST_PAUSE;
> +	TST_EXP_VAL_SILENT(setfsuid(ruid), nobody_uid);
> +	TST_EXP_VAL(setfsuid(-1), ruid, "setfsuid(fsuid) by non-root user:");
>  }
>  
> -static void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.setup = setup,
> +	.test_all = run
> +};
> -- 
> 2.38.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
