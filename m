Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745B6C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 09:09:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 828193C9A4D
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 11:09:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0C163C05C3
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 11:09:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AE45D1A00705
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 11:09:25 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 05EDA375FA
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 09:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658826565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4kanUT3N+TjKduEEEi6VlMtf+LUJY5l1DitOpHjyKA=;
 b=QQ9FIPmFnfJuMfZ81GE+g6P+KHkEiyCi1JvBiZVD5x8eLIm6hsZDxu7rG8AOFtZyyqxyC7
 3uCGZegCbk1am3nFqYTH2rIX0rAyUCBOavtfWS9MZIRw4PfPW+32meW4gw+EptRIlNm0wr
 49Fa/bMeCYKvXJYneWJRv09i2CjYCj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658826565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4kanUT3N+TjKduEEEi6VlMtf+LUJY5l1DitOpHjyKA=;
 b=uPeTLwVDnSpquOqQv5bbFBaLFARBEwdnGy2Ni6F3FQVNYkQD7bzbrji2LtOLpeCpuAXIhp
 TjU8o0w5ec3UcCBw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id AC6B42C171;
 Tue, 26 Jul 2022 09:09:24 +0000 (UTC)
References: <20220725173819.9669-1-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Tue, 26 Jul 2022 10:09:03 +0100
In-reply-to: <20220725173819.9669-1-akumar@suse.de>
Message-ID: <87pmhs44vv.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rename13.c: Convert to new LTP API
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

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Avinesh Kumar <akumar@suse.de> writes:

> Rewrite test using new LTP API and enable on all supporting filesystems
>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/rename/rename13.c | 206 ++++----------------
>  1 file changed, 37 insertions(+), 169 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/rename/rename13.c b/testcases/kernel/syscalls/rename/rename13.c
> index 07a90c4d1..51490db75 100644
> --- a/testcases/kernel/syscalls/rename/rename13.c
> +++ b/testcases/kernel/syscalls/rename/rename13.c
> @@ -1,186 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *
>   *   Copyright (c) International Business Machines  Corp., 2001
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
> + *		07/2001 Ported by Wayne Boyer
> + *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
>  
> -/*
> - * NAME
> - *	rename13
> - *
> - * DESCRIPTION
> - *	Verify rename() return successfully and performs no other action
> - *      when "old" file and "new" file link to the same file.
> - *
> - * ALGORITHM
> - *	Setup:
> - *		Setup signal handling.
> - *		Create temporary directory.
> - *		Pause for SIGUSR1 if option specified.
> - *
> - *	Test:
> - *		Loop if the proper options are given.
> - *                  create the "old" file
> - *                  link the "new" file to the "old" file
> - *                  rename the "old" to the "new" file
> - *                  verify the "new" file points to the original file
> - *                  verify the "old" file exists and points to
> - *                         the original file
> - *	Cleanup:
> - *		Print errno log and/or timing stats if options given
> - *		Delete the temporary directory created.
> - *
> - * USAGE
> - *	rename13 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *	where,  -c n : Run n copies concurrently.
> - *		-f   : Turn off functionality Testing.
> - *		-i n : Execute test n times.
> - *		-I x : Execute test for x seconds.
> - *		-P x : Pause for x seconds between iterations.
> - *		-t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> +/*\
> + * [Description]
>   *
> - * RESTRICTIONS
> - *	None.
> + * Verify that rename() does nothing and returns a success status when
> + * oldpath and newpath are existing hard links referring to the same file.
>   */
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> -#include <errno.h>
>  
> -#include "test.h"
> -#include "safe_macros.h"
> +#include <stdio.h>
> +#include "tst_test.h"
>  
> -void setup();
> -void cleanup();
> +#define MNT_POINT "mntpoint"
> +#define TEMP_FILE1 MNT_POINT"/tmpfile1"
> +#define TEMP_FILE2 MNT_POINT"/tmpfile2"
>  
> -char *TCID = "rename13";
> -int TST_TOTAL = 1;
> +static struct stat buf1, buf2;
>  
> -int fd;
> -char fname[255], mname[255];
> -struct stat buf1, buf2;
> -dev_t olddev;
> -ino_t oldino;
> -
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
> -		/*
> -		 * TEST rename()works when
> -		 * both old file and new file link to the same file
> -		 */
> -
> -		/* Call rename(2) */
> -		TEST(rename(fname, mname));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "rename(%s, %s) failed", fname, mname);
> -			continue;
> -		}
> -
> -		/* check the existence of "new", and get the status */
> -		SAFE_STAT(cleanup, mname, &buf2);
> -
> -		/* check the existence of "old", and get the status */
> -		SAFE_STAT(cleanup, fname, &buf1);
> -
> -		/* verify the new file is the same as the original */
> -		if (buf2.st_dev != olddev || buf2.st_ino != oldino) {
> -			tst_resm(TFAIL,
> -				 "rename() failed: new file does "
> -				 "not point to the same file as old "
> -				 "file");
> -			continue;
> -		}
> -
> -		/* verify the old file is unchanged */
> -		if (buf1.st_dev != olddev || buf1.st_ino != oldino) {
> -			tst_resm(TFAIL,
> -				 "rename() failed: old file does "
> -				 "not point to the original file");
> -			continue;
> -		}
> -
> -		tst_resm(TPASS, "functionality of rename() is correct");
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	SAFE_TOUCH(TEMP_FILE1, 0700, NULL);
> +	SAFE_STAT(TEMP_FILE1, &buf1);
> +	SAFE_LINK(TEMP_FILE1, TEMP_FILE2);
>  }
>  
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void run(void)
>  {
> +	TST_EXP_PASS(rename(TEMP_FILE1, TEMP_FILE1));
> +	if (TST_RET != 0)
> +		return;
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/* Create a temporary directory and make it current. */
> -	tst_tmpdir();
> -
> -	sprintf(fname, "./tfile_%d", getpid());
> -	sprintf(mname, "./rnfile_%d", getpid());
> -
> -	SAFE_TOUCH(cleanup, fname, 0700, NULL);
> -
> -	SAFE_STAT(cleanup, fname, &buf1);
> -
> -	/* save the dev and inode */
> -	olddev = buf1.st_dev;
> -	oldino = buf1.st_ino;
> -
> -	/* link the "new" file to the "old" file */
> -	SAFE_LINK(cleanup, fname, mname);
> +	SAFE_STAT(TEMP_FILE2, &buf2);
> +	TST_EXP_EQ_LU(buf1.st_dev, buf2.st_dev);
> +	TST_EXP_EQ_LU(buf1.st_ino, buf2.st_ino);
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
> -
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.mntpoint = MNT_POINT,
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const[]){
> +		"exfat",
> +		"vfat",
> +		NULL
> +	},
> +};
> -- 
> 2.36.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
