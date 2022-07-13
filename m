Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E96C433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 05:43:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0B8E3C9886
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 07:43:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C11A83C0780
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 07:43:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2EA14600709
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 07:43:17 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 766A61FAE6
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 05:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657690997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HXsUKcG79bZoJN+gE/reSikHr519Fbci7us4LrG8fuQ=;
 b=CCSQDy6KGHDa25tO5kGa4SaZZymAYET0Pk560PMVT/BvKi/9JZ/o9B+owyc3w6ywkb3Awp
 +cPZ5+mSinDUrVJyHMh9geZy7leL/zeQpfcR5pK4U+ZZ/vig3uMRVOAOeU/0MEwzHWPOkX
 NqINxK7Gfu3NKetImy8cipTTOybSkug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657690997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HXsUKcG79bZoJN+gE/reSikHr519Fbci7us4LrG8fuQ=;
 b=8hWudjaOdVUz5nCDnlDPG9G8w287bgvCzVtuv6YFU7D9zjqESuVz699I8cjlJesdFXArz5
 SzXk524CIXm50bAQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2A30A2C141;
 Wed, 13 Jul 2022 05:43:17 +0000 (UTC)
References: <20220712153417.14551-1-akumar@suse.de>
 <20220712153417.14551-7-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Wed, 13 Jul 2022 06:43:13 +0100
In-reply-to: <20220712153417.14551-7-akumar@suse.de>
Message-ID: <87cze9mutn.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 6/9] Rewrite rename06.c using new LTP API
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


Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Avinesh Kumar <akumar@suse.de> writes:

> Rewrite using new LTP API and enable all filesystems
>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/rename/rename06.c | 187 +++-----------------
>  1 file changed, 28 insertions(+), 159 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/rename/rename06.c b/testcases/kernel/syscalls/rename/rename06.c
> index e415b4158..82665d1c2 100644
> --- a/testcases/kernel/syscalls/rename/rename06.c
> +++ b/testcases/kernel/syscalls/rename/rename06.c
> @@ -1,173 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
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
> + * Copyright (c) International Business Machines  Corp., 2001
> + *  07/2001 Ported by Wayne Boyer
> + * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
>  
> -/*
> - * NAME
> - *	rename06
> - *
> - * DESCRIPTION
> - *	This test will verify that rename(2) failed in EINVAL
> - *
> - * ALGORITHM
> - *	Setup:
> - *		Setup signal handling.
> - *		Create temporary directory.
> - *		Pause for SIGUSR1 if option specified.
> - *              create the "old" directory
> - *              create the "new" directory under the "old" directory
> - *
> - *	Test:
> - *		Loop if the proper options are given.
> - *                  rename the "old" to the "new" directory
> - *                  verify rename() failed and returned EINVAL
> - *
> - *	Cleanup:
> - *		Print errno log and/or timing stats if options given
> - *		Delete the temporary directory created.
> - *
> - * USAGE
> - *	rename06 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *	where,  -c n : Run n copies concurrently.
> - *		-e   : Turn on errno logging.
> - *		-i n : Execute test n times.
> - *		-I x : Execute test for x seconds.
> - *		-P x : Pause for x seconds between iterations.
> - *		-t   : Turn on syscall timing.
> +/*\
> + * [Description]
>   *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	None.
> + * Verify that rename(2) fails with EINVAL when
> + * an attempt is made to make a directory a subdirectory of itself.
>   */
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> -#include <errno.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -void setup();
> -void cleanup();
>  
> -char *TCID = "rename06";
> -int TST_TOTAL = 1;
> +#include <stdio.h>
> +#include "tst_test.h"
>  
> -int fd;
> -char fdir[255], mdir[255];
> -struct stat buf1, buf2;
> -dev_t olddev, olddev1;
> -ino_t oldino, oldino1;
> +#define MNT_POINT "mntpoint"
> +#define DIR1 "dir1"
> +#define DIR2 DIR1"/dir2"
>  
> -int main(int ac, char **av)
> +static void setup(void)
>  {
> -	int lc;
> -
> -	/*
> -	 * parse standard options
> -	 */
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	/*
> -	 * perform global setup for test
> -	 */
> -	setup();
> -
> -	/*
> -	 * check looping state if -i option given
> -	 */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/* rename a directory to a subdirectory of itself */
> -		/* Call rename(2) */
> -		TEST(rename(fdir, mdir));
> -
> -		if (TEST_RETURN != -1) {
> -			tst_resm(TFAIL, "rename(%s, %s) succeed unexpected",
> -				 fdir, mdir);
> -			continue;
> -		}
> -
> -		if (errno != EINVAL) {
> -			tst_resm(TFAIL, "Expected EINVAL got %d", TEST_ERRNO);
> -		} else {
> -			tst_resm(TPASS, "rename() returned EINVAL");
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -
> +	SAFE_CHDIR(MNT_POINT);
> +	SAFE_MKDIR(DIR1, 00770);
> +	SAFE_MKDIR(DIR2, 00770);
>  }
>  
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void run(void)
>  {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/* Create a temporary directory and make it current. */
> -	tst_tmpdir();
> -
> -	sprintf(fdir, "./tdir_%d", getpid());
> -	sprintf(mdir, "%s/rndir_%d", fdir, getpid());
> -
> -	/* create "old" directory */
> -	if (stat(fdir, &buf1) != -1) {
> -		tst_brkm(TBROK, cleanup, "tmp directory %s found!", fdir);
> -	}
> -	SAFE_MKDIR(cleanup, fdir, 00770);
> -	SAFE_STAT(cleanup, fdir, &buf1);
> -	/* save "old"'s dev and ino */
> -	olddev = buf1.st_dev;
> -	oldino = buf1.st_ino;
> -
> -	/* create another directory */
> -	if (stat(mdir, &buf2) != -1) {
> -		tst_brkm(TBROK, cleanup, "tmp directory %s found!", mdir);
> -	}
> -	SAFE_MKDIR(cleanup, mdir, 00770);
> -
> -	SAFE_STAT(cleanup, mdir, &buf2);
> -
> -	/* save "new"'s dev and ino */
> -	olddev1 = buf2.st_dev;
> -	oldino1 = buf2.st_ino;
> +	TST_EXP_FAIL(rename(DIR1, DIR2),
> +				EINVAL);
>  }
>  
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -
> -	/*
> -	 * Remove the temporary directory.
> -	 */
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNT_POINT,
> +	.all_filesystems = 1
> +};
> -- 
> 2.36.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
