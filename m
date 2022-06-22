Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4CEC43334
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 14:51:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DF063C9539
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 16:51:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E28B13C0F84
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 16:51:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C192B200AC4
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 16:51:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B128B1F9F9;
 Wed, 22 Jun 2022 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655909501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QfNgyASAvTs8SfYSFwPzC8uqMnBT0KLyP3Oo0MkdjxY=;
 b=nK2j9RxB3+qKDTLl4+az3x9YFQhUx059hVWe/quU0wMDskh+TLZP05NeghWsy7TMPZY6nN
 2lN+6VLMs0uhxbiei5yIzRSjTWWfU6z+x5dR7A0ITFzfzryUmUqNbNfP1R+riF5Wpf+F1y
 mybVp+JFGryX5eaI0KesL2HjVmge+B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655909501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QfNgyASAvTs8SfYSFwPzC8uqMnBT0KLyP3Oo0MkdjxY=;
 b=2FAHQnnsW3zW/xIQpwchofr/WdmAPrdBQaHJAopAe0z1YuUktSY1h4f7YM0HE1nIa550WM
 ylFy1WsFE6gZiABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BF3013A5D;
 Wed, 22 Jun 2022 14:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tbZgJX0ss2IWYwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 22 Jun 2022 14:51:41 +0000
Date: Wed, 22 Jun 2022 16:53:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YrMs/dt/ioC8p3Sx@yuki>
References: <20220622070137.24286-1-akumar@suse.de>
 <20220622070137.24286-2-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220622070137.24286-2-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/9] Rewrite rename01.c using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*\
> + * [DESCRIPTION]
       ^
       Description
>   *
> - * ALGORITHM
> - *	Setup:
> - *		Setup signal handling.
> - *		Create temporary directory.
> - *		Pause for SIGUSR1 if option specified.
> - *
> - *	Test:
> - *		Loop if the proper options are given.
> - *              1.  "old" is plain file, new does not exists
> - *                  create the "old" file, make sure the "new" file
> - *                  dose not exist
> - *                  rename the "old" to the "new" file
> - *                  verify the "new" file points to the "old" file
> - *                  verify the "old" file does not exist
> - *
> - *              2.  "old" is a directory,"new" does not exists
> - *                  create the "old" directory, make sure "new"
> - *                  dose not exist
> - *                  rename the "old" to the "new"
> - *                  verify the "new" points to the "old"
> - *                  verify the "old" does not exist
> - *	Cleanup:
> - *		Print errno log and/or timing stats if options given
> - *		Delete the temporary directory created.
> - *
> - * USAGE
> - *	rename01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
> + * Verify rename() when the newpath file or directory does not exist.
>   */
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> -#include <errno.h>
>  
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -void setup();
> -void cleanup();
> -
> -char *TCID = "rename01";
> -int TST_TOTAL = 2;
> +#include <sys/stat.h>
> +#include <stdio.h>
> +#include "tst_test.h"
>  
> -char fname[255], mname[255];
> -char fdir[255], mdir[255];
> -struct stat buf1;
> -dev_t f_olddev, d_olddev;
> -ino_t f_oldino, d_oldino;
> +#define OLD_FILE_NAME "oldfile"
> +#define NEW_FILE_NAME "newfile"
> +#define OLD_DIR_NAME "olddir"
> +#define NEW_DIR_NAME "newdir"
>  
> -struct test_case_t {
> -	char *name1;
> -	char *name2;
> -	char *desc;
> -	dev_t *olddev;
> -	ino_t *oldino;
> -} TC[] = {
> -	/* comment goes here */
> -	{
> -	fname, mname, "file", &f_olddev, &f_oldino},
> -	    /* comment goes here */
> -	{
> -	fdir, mdir, "directory", &d_olddev, &d_oldino}
> -};
> +static struct stat old_file_st, old_dir_st, new_file_st, new_dir_st;
>  
> -int main(int ac, char **av)
> +static void setup(void)
>  {
> -	int lc;
> -	int i;
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
> -			SAFE_STAT(cleanup, TC[i].name2, &buf1);
> -
> -			/*
> -			 * verify the new file or directory is the
> -			 * same as the old one
> -			 */
> -			if (buf1.st_dev != *TC[i].olddev ||
> -			    buf1.st_ino != *TC[i].oldino) {
> -				tst_resm(TFAIL, "rename() failed: the "
> -					 "new %s points to a different "
> -					 "inode/location", TC[i].desc);
> -				continue;
> -			}
> -			/*
> -			 * verify that the old file or directory
> -			 * does not exist
> -			 */
> -			if (stat(fname, &buf1) != -1) {
> -				tst_resm(TFAIL, "the old %s still "
> -					 "exists", TC[i].desc);
> -				continue;
> -			}
> -
> -			tst_resm(TPASS, "functionality is correct "
> -				 "for renaming a %s", TC[i].desc);
> -		}
> -		/* reset things in case we are looping */
> -		SAFE_RENAME(cleanup, mname, fname);
> -
> -		SAFE_RENAME(cleanup, mdir, fdir);

This was there for a reason, the test now fails with -i 2

I guess that better solution would be swapping the old and new directory
pointers after each iteration as:

static const char *old_file_name = "oldfile";
static const char *old_dir_name = "olddir";
static const char *new_file_name = "newfile";
static const char *new_dir_name = "newdir";

#define SWAP(a, b) do { \
	const char *tmp__ = a; \
	a = b; \
	b = tmp__; \
} while (0)

static void run(void)
{
	...


	SWAP(old_file_name, new_file_name);
	SWAP(old_dir_name, new_dir_name);
}


> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	SAFE_TOUCH(OLD_FILE_NAME, 0700, NULL);
> +	SAFE_MKDIR(OLD_DIR_NAME, 00770);
>  
> +	SAFE_STAT(OLD_FILE_NAME, &old_file_st);
> +	SAFE_STAT(OLD_DIR_NAME, &old_dir_st);
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
> -	sprintf(fname, "./tfile_%d", getpid());
> -	sprintf(mname, "./rnfile_%d", getpid());
> -	sprintf(fdir, "./tdir_%d", getpid());
> -	sprintf(mdir, "./rndir_%d", getpid());
> -
> -	SAFE_TOUCH(cleanup, fname, 0700, NULL);
> -
> -	SAFE_STAT(cleanup, fname, &buf1);
> -
> -	f_olddev = buf1.st_dev;
> -	f_oldino = buf1.st_ino;
> -
> -	/* create "old" directory */
> -	SAFE_MKDIR(cleanup, fdir, 00770);
> -
> -	SAFE_STAT(cleanup, fdir, &buf1);
> -
> -	d_olddev = buf1.st_dev;
> -	d_oldino = buf1.st_ino;
> +	TST_EXP_PASS(rename(OLD_FILE_NAME, NEW_FILE_NAME),
> +						"rename(%s, %s)",
> +						OLD_FILE_NAME, NEW_FILE_NAME);
> +	TST_EXP_PASS(rename(OLD_DIR_NAME, NEW_DIR_NAME),
> +						"rename(%s, %s)",
> +						OLD_DIR_NAME, NEW_DIR_NAME);

It would be better to do return; if either of the renames had failed,
i.e. to add after each:

	if (!TST_PASS)
		return;

> +	SAFE_STAT(NEW_FILE_NAME, &new_file_st);
> +	SAFE_STAT(NEW_DIR_NAME, &new_dir_st);
> +
> +	TST_EXP_EQ_LI(old_file_st.st_dev, new_file_st.st_dev);
> +	TST_EXP_EQ_LI(old_file_st.st_ino, new_file_st.st_ino);
> +
> +	TST_EXP_EQ_LI(old_dir_st.st_dev, new_dir_st.st_dev);
> +	TST_EXP_EQ_LI(old_dir_st.st_ino, new_dir_st.st_ino);
> +
> +	TST_EXP_FAIL(stat(OLD_FILE_NAME, &old_file_st),
> +				ENOENT,
> +				"stat(%s, &old_file_st)",
> +				OLD_FILE_NAME);
> +	TST_EXP_FAIL(stat(OLD_DIR_NAME, &old_dir_st),
> +				ENOENT,
> +				"stat(%s, &old_dir_st)",
> +				OLD_DIR_NAME);
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
> +	.needs_tmpdir = 1
> +};
> -- 
> 2.36.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
