Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495E1C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 09:10:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D7883C97DD
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 11:10:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 256B33C05C3
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 11:10:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DEC406002E4
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 11:10:03 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 215B73761F
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658826601;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tPIL2gShBZ6VJKH+im613R6vFXmI9B4u04tZarwaQv8=;
 b=cR00t1zFlLLKSap9Zl5HqiPVJlb0Uv487sJg6tGEKouw8vui/QHPfwpM8+z/L3lL7yHUbl
 MHqj5Y7WZow6spespvGHWp3TIX0i6n+a1hxoVHEfqxf9qZ1/mhuO1V8urKgkUfBImbwoa6
 GbTKpusSWjpwj4EO/j6TmeZ1lfDLQRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658826601;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tPIL2gShBZ6VJKH+im613R6vFXmI9B4u04tZarwaQv8=;
 b=5UCVSDM6ceHiwKWssJTY+n94SRiN7JB254RMpUJBuYVsVH8ZswO0VU3jbLJKzo3BlKfRk0
 KpypdEONbncGBSBw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B832B2C15D;
 Tue, 26 Jul 2022 09:10:00 +0000 (UTC)
References: <20220725173702.9359-1-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Tue, 26 Jul 2022 10:09:30 +0100
In-reply-to: <20220725173702.9359-1-akumar@suse.de>
Message-ID: <87lesg44uv.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rename12.c: Convert to new LTP API
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
>  testcases/kernel/syscalls/rename/rename12.c | 253 ++++----------------
>  1 file changed, 50 insertions(+), 203 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/rename/rename12.c b/testcases/kernel/syscalls/rename/rename12.c
> index 36691783f..d6e1ccbe9 100644
> --- a/testcases/kernel/syscalls/rename/rename12.c
> +++ b/testcases/kernel/syscalls/rename/rename12.c
> @@ -1,222 +1,69 @@
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
> - *	rename12
> - *
> - * DESCRIPTION
> - *      check rename() fails with EPERM or EACCES
> - *
> - * ALGORITHM
> - *	Setup:
> - *		Setup signal handling.
> - *		Create temporary directory.
> - *		Pause for SIGUSR1 if option specified.
> - *
> - *	Test:
> - *		Loop if the proper options are given.
> - *              create a directory fdir and set the sticky bit
> - *              create file fname under fdir
> - *              fork a child
> - *                      set to nobody
> - *                      try to rename fname to mname
> - *                      check the return value, if succeeded (return=0)
> - *			       Log the errno and Issue a FAIL message.
> - *		        Otherwise,
> - *			       Verify the errno
> - *			       if equals to EPERMS or EACCES,
> - *				       Issue Pass message.
> - *			       Otherwise,
> - *				       Issue Fail message.
> - *	Cleanup:
> - *		Print errno log and/or timing stats if options given
> - *		Delete the temporary directory created.
> - * USAGE
> - *	rename12 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *	where,  -c n : Run n copies concurrently.
> - *		-e   : Turn on errno logging.
> - *		-i n : Execute test n times.
> - *		-I x : Execute test for x seconds.
> - *		-P x : Pause for x seconds between iterations.
> - *		-t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	Must run test as root.
> +/*\
> + * [Description]
>   *
> + * Verify that rename() fails with EPERM or EACCES when the directory
> + * containing oldpath has the sticky bit (S_ISVTX) set and the caller
> + * is not privileged.
>   */
> -#include <errno.h>
> -#include <sys/stat.h>
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include <fcntl.h>
> -#include <pwd.h>
> -#include <unistd.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -void setup();
> -void cleanup();
> -
> -#define PERMS		0777
> -
> -char *TCID = "rename12";
> -int TST_TOTAL = 1;
> -
> -int fd;
> -char fdir[255];
> -char fname[255], mname[255];
> -uid_t nobody_uid;
> -struct stat buf1;
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	pid_t pid;
> -	int status;
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
> -		 * rename a file whose parent directory has
> -		 * the sticky bit set without root permission
> -		 * or effective uid
> -		 */
> -
> -		if ((pid = FORK_OR_VFORK()) == -1) {
> -			tst_brkm(TBROK, cleanup, "fork() failed");
> -		}
>  
> -		if (pid == 0) {	/* child */
> -			/* set to nobody */
> -			if (seteuid(nobody_uid) == -1) {
> -				tst_resm(TWARN, "setreuid failed");
> -				perror("setreuid");
> -				exit(1);
> -			}
> -
> -			/* rename "old" to "new" */
> -			TEST(rename(fname, mname));
> -
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> -				exit(1);
> -			}
> -
> -			if ((TEST_ERRNO != EPERM) && (TEST_ERRNO != EACCES)) {
> -				tst_resm(TFAIL,
> -					 "Expected EPERM or EACCES, got %d",
> -					 TEST_ERRNO);
> -				exit(1);
> -			} else {
> -				tst_resm(TPASS,
> -					 "rename returned EPERM or EACCES");
> -			}
> -
> -			/* set the id back to root */
> -			if (seteuid(0) == -1) {
> -				tst_resm(TWARN, "seteuid(0) failed");
> -			}
> -		} else {	/* parent */
> -			wait(&status);
> -			if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0)) {
> -				exit(WEXITSTATUS(status));
> -			} else {
> -				exit(0);
> -			}
> -
> -		}
> -	}
> +#include <stdio.h>
> +#include <pwd.h>
> +#include "tst_test.h"
>  
> -	cleanup();
> -	tst_exit();
> +#define MNT_POINT "mntpoint"
> +#define TEMP_DIR "tempdir"
> +#define TEMP_FILE1 TEMP_DIR"/tmpfile1"
> +#define TEMP_FILE2 TEMP_DIR"/tmpfile2"
>  
> -}
> +static uid_t nobody_uid;
> +static struct stat buf1;
>  
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void setup(void)
>  {
>  	struct passwd *pw;
>  
> -	tst_require_root();
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	pw = SAFE_GETPWNAM(NULL, "nobody");
> +	pw = SAFE_GETPWNAM("nobody");
>  	nobody_uid = pw->pw_uid;
>  
> -	TEST_PAUSE;
> -
> -	/* Create a temporary directory and make it current. */
> -	tst_tmpdir();
> -
> -	umask(0);
> -
> -	sprintf(fdir, "./tdir_%d", getpid());
> -	sprintf(fname, "%s/tfile_%d", fdir, getpid());
> -	sprintf(mname, "%s/rnfile_%d", fdir, getpid());
> -
> -	/* create a directory */
> -	SAFE_MKDIR(cleanup, fdir, PERMS);
> -
> -	SAFE_STAT(cleanup, fdir, &buf1);
> -
> -	/* set the sticky bit */
> -	if (chmod(fdir, buf1.st_mode | S_ISVTX) != 0) {
> -		tst_brkm(TBROK, cleanup, "failed to set the S_ISVTX bit");
> -
> -	}
> -
> -	/* create a file under fdir */
> -	SAFE_TOUCH(cleanup, fname, 0700, NULL);
> +	SAFE_CHDIR(MNT_POINT);
> +	SAFE_MKDIR(TEMP_DIR, 0777);
> +	SAFE_STAT(TEMP_DIR, &buf1);
> +	SAFE_CHMOD(TEMP_DIR, buf1.st_mode | S_ISVTX);
> +	SAFE_TOUCH(TEMP_FILE1, 0700, NULL);
>  }
>  
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - */
> -void cleanup(void)
> +static void run(void)
>  {
> -
> -	/*
> -	 * Remove the temporary directory.
> -	 */
> -	tst_rmdir();
> +	SAFE_SETEUID(nobody_uid);
> +
> +	TEST(rename(TEMP_FILE1, TEMP_FILE2));
> +	if (TST_RET == -1 && (TST_ERR == EPERM || TST_ERR == EACCES))
> +		tst_res(TPASS | TTERRNO, "rename() failed as expected");
> +	else if (TST_RET == 0)
> +		tst_res(TFAIL, "rename() succeeded unexpectedly");
> +	else
> +		tst_res(TFAIL | TTERRNO, "rename() failed, but not with expected errno");
>  }
> +
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
> +		"fuse",
> +		"ntfs",
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
