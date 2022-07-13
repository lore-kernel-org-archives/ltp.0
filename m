Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61929C433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 05:36:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B30103CA316
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 07:36:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C0363CA2D4
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 07:36:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1E8FF2000F0
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 07:36:09 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 708711FD00
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 05:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657690569;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cZkDZmB4Nfbaiv1CaxVtAfEfhSFx5o7B0HRwRVNTvVg=;
 b=Wtax4TpypWC57RQOXvHMHVbonze3IBr1hIALxlC1IQwIkKYjV4AFxtIa4hFs7gEbDK+Uvw
 OYX7ZKWp1MDwqWEDY7tVSnrDQOM8vn0Zt7NGl3/IMy2DJR6A3ykHYXerH4QNOa307RPZWW
 SgqJuEEF1czcELKEykYt4CKMPfmfokI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657690569;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cZkDZmB4Nfbaiv1CaxVtAfEfhSFx5o7B0HRwRVNTvVg=;
 b=ZxDzaGVKo6BVc8jamJdHQI/rLHAthz1Nu2aZGVSGehddqDmOxQA5FWS2i0H8Kba0BFLyH/
 hWYZLTJ7b50QnlAw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 125892C141;
 Wed, 13 Jul 2022 05:36:09 +0000 (UTC)
References: <20220712153417.14551-1-akumar@suse.de>
 <20220712153417.14551-4-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Wed, 13 Jul 2022 06:35:48 +0100
In-reply-to: <20220712153417.14551-4-akumar@suse.de>
Message-ID: <87pmi9mv5j.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/9] Rewrite rename03.c using new LTP API
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
>  testcases/kernel/syscalls/rename/rename03.c | 279 +++++---------------
>  1 file changed, 61 insertions(+), 218 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/rename/rename03.c b/testcases/kernel/syscalls/rename/rename03.c
> index 396e95c4d..652fa3bdb 100644
> --- a/testcases/kernel/syscalls/rename/rename03.c
> +++ b/testcases/kernel/syscalls/rename/rename03.c
> @@ -1,230 +1,73 @@
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
> - *	rename03
> - *
> - * DESCRIPTION
> - *	This test will verify that rename(2) functions correctly
> - *	when the "new" file or directory exists
> - *
> - * ALGORITHM
> - *	Setup:
> - *		Setup signal handling.
> - *		Create temporary directory.
> - *		Pause for SIGUSR1 if option specified.
> +/*\
> + * [Description]
>   *
> - *	Test:
> - *		Loop if the proper options are given.
> - *              1.  both old and new file exist
> - *                  create the "old" file and the "new" file
> - *                  rename the "old" to the "new" file
> - *                  verify the "new" file points to the "old" file
> - *                  verify the "old" file does not exists
> - *              2.  both old file and new directory exist
> - *                  create the "old" and the "new" directory
> - *                  rename the "old" to the "new" directory
> - *                  verify the "new" points to the "old" directory
> - *                  verify the "old" does not exists
> - *	Cleanup:
> - *		Print errno log and/or timing stats if options given
> - *		Delete the temporary directory created.
> - *
> - * USAGE
> - *	rename03 [-c n] [-f] [-i n] [-I x] [-p x] [-t]
> - *	where,  -c n : Run n copies concurrently.
> - *		-f   : Turn off functionality Testing.
> - *		-i n : Execute test n times.
> - *		-I x : Execute test for x seconds.
> - *		-P x : Pause for x seconds between iterations.
> - *		-t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	None.
> - */
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
> -void setup2();
> -void cleanup();
> -
> -char *TCID = "rename03";
> -int TST_TOTAL = 2;
> -
> -char fname[255], mname[255];
> -char fdir[255], mdir[255];
> -struct stat buf1, buf2;
> -dev_t f_olddev, d_olddev;
> -ino_t f_oldino, d_oldino;
> -
> -struct test_case_t {
> -	char *name1;
> -	char *name2;
> -	char *desc;
> -	dev_t *olddev;
> -	ino_t *oldino;
> -} TC[] = {
> -	{
> -	fname, mname, "file", &f_olddev, &f_oldino}, {
> -	fdir, mdir, "directory", &d_olddev, &d_oldino}
> -};
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -
> -	/*
> -	 * parse standard options
> -	 */
> -	tst_parse_opts(ac, av, NULL, NULL);
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
> -		/* set up the files and directories for the tests */
> -		setup2();
> -
> -		/* loop through the test cases */
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			TEST(rename(TC[i].name1, TC[i].name2));
> -
> -			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL, "call failed unexpectedly");
> -				continue;
> -			}
> -
> -			SAFE_STAT(cleanup, TC[i].name2, &buf2);
> -
> -			/*
> -			 * verify the new file or directory is the
> -			 * same as the old one
> -			 */
> -			if (buf2.st_dev != *TC[i].olddev ||
> -			    buf2.st_ino != *TC[i].oldino) {
> -				tst_resm(TFAIL, "rename() failed: the "
> -					 "new %s points to a different "
> -					 "inode/location", TC[i].desc);
> -				continue;
> -			}
> -			/*
> -			 * verify that the old file or directory
> -			 * does not exist
> -			 */
> -			if (stat(fname, &buf2) != -1) {
> -				tst_resm(TFAIL, "the old %s still "
> -					 "exists", TC[i].desc);
> -				continue;
> -			}
> -
> -			tst_resm(TPASS, "functionality is correct "
> -				 "for renaming a %s", TC[i].desc);
> -		}
> -
> -		/* reset things in case we are looping */
> -
> -		/* unlink the new file */
> -		SAFE_UNLINK(cleanup, mname);
> -
> -		/* remove the new directory */
> -		SAFE_RMDIR(cleanup, mdir);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -
> -}
> -
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> + * Verify rename(2) functions correctly when the newpath
> + * file or directory (empty) exists.
>   */
> -void setup(void)
> -{
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +#include <sys/stat.h>
> +#include <stdio.h>
> +#include "tst_test.h"
>  
> -	/* Create a temporary directory and make it current. */
> -	tst_tmpdir();
> +#define MNT_POINT "mntpoint"
> +#define OLD_FILE_NAME MNT_POINT"/oldfile"
> +#define NEW_FILE_NAME MNT_POINT"/newfile"
> +#define OLD_DIR_NAME MNT_POINT"/olddir"
> +#define NEW_DIR_NAME MNT_POINT"/newdir"
>  
> -	sprintf(fname, "./tfile_%d", getpid());
> -	sprintf(mname, "./rnfile_%d", getpid());
> -	sprintf(fdir, "./tdir_%d", getpid());
> -	sprintf(mdir, "./rndir_%d", getpid());
> -}
> +static struct stat old_file_st, old_dir_st, new_file_st, new_dir_st;
>  
> -/*
> - * setup2() - set up the files and directories for the tests
> - */
> -void setup2(void)
> +static void run(void)
>  {
> -	SAFE_TOUCH(cleanup, fname, 0700, NULL);
> -
> -	SAFE_STAT(cleanup, fname, &buf1);
> -
> -	/* save original file's dev and ino */
> -	f_olddev = buf1.st_dev;
> -	f_oldino = buf1.st_ino;
> -
> -	SAFE_TOUCH(cleanup, mname, 0700, NULL);
> -
> -	/* create "old" directory */
> -	SAFE_MKDIR(cleanup, fdir, 00770);
> -	SAFE_STAT(cleanup, fdir, &buf1);
> -
> -	d_olddev = buf1.st_dev;
> -	d_oldino = buf1.st_ino;
> -
> -	/* create another directory */
> -	SAFE_MKDIR(cleanup, mdir, 00770);
> +	SAFE_TOUCH(OLD_FILE_NAME, 0700, NULL);
> +	SAFE_MKDIR(OLD_DIR_NAME, 00770);
> +	SAFE_TOUCH(NEW_FILE_NAME, 0700, NULL);
> +	SAFE_MKDIR(NEW_DIR_NAME, 00770);
> +
> +	SAFE_STAT(OLD_FILE_NAME, &old_file_st);
> +	SAFE_STAT(OLD_DIR_NAME, &old_dir_st);
> +
> +	TST_EXP_PASS(rename(OLD_FILE_NAME, NEW_FILE_NAME),
> +						"rename(%s, %s)",
> +						OLD_FILE_NAME, NEW_FILE_NAME);
> +	TST_EXP_PASS(rename(OLD_DIR_NAME, NEW_DIR_NAME),
> +						"rename(%s, %s)",
> +						OLD_DIR_NAME, NEW_DIR_NAME);
> +
> +	SAFE_STAT(NEW_FILE_NAME, &new_file_st);
> +	SAFE_STAT(NEW_DIR_NAME, &new_dir_st);
> +
> +	TST_EXP_EQ_LU(old_file_st.st_dev, new_file_st.st_dev);
> +	TST_EXP_EQ_LU(old_file_st.st_ino, new_file_st.st_ino);
> +
> +	TST_EXP_EQ_LU(old_dir_st.st_dev, new_dir_st.st_dev);
> +	TST_EXP_EQ_LU(old_dir_st.st_ino, new_dir_st.st_ino);
> +
> +	TST_EXP_FAIL(stat(OLD_FILE_NAME, &old_file_st),
> +				ENOENT,
> +				"stat(%s, &old_file_st)",
> +				OLD_FILE_NAME);
> +	TST_EXP_FAIL(stat(OLD_DIR_NAME, &old_dir_st),
> +				ENOENT,
> +				"stat(%s, &old_dir_st)",
> +				OLD_DIR_NAME);
> +
> +	/* cleanup between loops */
> +	SAFE_UNLINK(NEW_FILE_NAME);
> +	SAFE_RMDIR(NEW_DIR_NAME);
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
