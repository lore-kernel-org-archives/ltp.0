Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E029C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 10:16:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E94A3C9423
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 12:15:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35D083C93B6
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 12:15:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3FC98100094A
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 12:15:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81D031F9BF;
 Tue, 21 Jun 2022 10:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655806545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RkvgpVeQEbdMITUOl3KIxZ4eQIuN7t8HjpIO9gJFR9I=;
 b=bC30Bedr7AOwPj0+Gk69LDCnUHxS5ctTUsOoqLUp7Ql3n9oVvxv5c35x118BXw6noma4sb
 byuOha3m6AJF2RcrWNgHmYpaAvThkiHidXtOOMNCX4ml/iaPBSaK7HmP8swrYC8zGvVttN
 YWyTInm8DWfhEdbVWNzivwukGlRlKuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655806545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RkvgpVeQEbdMITUOl3KIxZ4eQIuN7t8HjpIO9gJFR9I=;
 b=CmI30RXRhr78Yj4V3U/ThFIWjOO6gOJp7JXKx/j0WTkhlkXqBN1YmWIVVAmQwilQEeR6w2
 pPP5vlsBQxIKsNBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21A6E13638;
 Tue, 21 Jun 2022 10:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /nWWBlGasWJsQgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Jun 2022 10:15:45 +0000
Date: Tue, 21 Jun 2022 12:17:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YrGa0N26h8eGSGUA@yuki>
References: <20220617172025.23975-1-akumar@suse.de>
 <20220617172025.23975-2-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220617172025.23975-2-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] Rewrite utime01.c using new LTP API
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
> + * [Description]

Please add newline after the [Description]

> + *  Verify that the system call utime() successfully changes the last
> + *  access and modification times of a file to the current time if the
> + *  times argument is NULL and the user ID of the process is "root".
      ^
      Just single space here please.
>   */
>  
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <sys/types.h>
> -#include <errno.h>
> -#include <fcntl.h>
>  #include <utime.h>
> -#include <string.h>
> -#include <sys/stat.h>
> -#include <signal.h>
> -#include <time.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -#define TEMP_FILE	"tmp_file"
> -#define FILE_MODE	S_IRUSR | S_IRGRP | S_IROTH
>  
> -char *TCID = "utime01";
> -int TST_TOTAL = 1;
> -time_t curr_time;		/* current time in seconds */
> +#include "tst_test.h"
> +#include "tst_clocks.h"
>  
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> +#define MNT_POINT	"mntpoint"
> +#define TEMP_FILE	MNT_POINT"/tmp_file"
> +#define FILE_MODE	0444
>  
> -int main(int ac, char **av)
> +static void setup(void)
>  {
> -	struct stat stat_buf;	/* struct buffer to hold file info. */
> -	int lc;
> -	long type;
> -	time_t modf_time, access_time;
> -	time_t pres_time;	/* file modification/access/present time */
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	switch ((type = tst_fs_type(cleanup, "."))) {
> -	case TST_NFS_MAGIC:
> -		if (tst_kvercmp(2, 6, 18) < 0)
> -			tst_brkm(TCONF, cleanup, "Cannot do utime on a file"
> -				" on %s filesystem before 2.6.18",
> -				 tst_fs_type_name(type));
> -		break;
> -	case TST_V9FS_MAGIC:
> -		tst_brkm(TCONF, cleanup,
> -			 "Cannot do utime on a file on %s filesystem",
> -			 tst_fs_type_name(type));
> -		break;
> -	}
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/*
> -		 * Invoke utime(2) to set TEMP_FILE access and
> -		 * modification times to the current time.
> -		 */
> -		TEST(utime(TEMP_FILE, NULL));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL|TTERRNO, "utime(%s) failed", TEMP_FILE);
> -		} else {
> -			/*
> -			 * Sleep for a second so that mod time and
> -			 * access times will be different from the
> -			 * current time
> -			 */
> -			sleep(2);
> -
> -			/*
> -			 * Get the current time now, after calling
> -			 * utime(2)
> -			 */
> -			pres_time = time(NULL);
> -
> -			/*
> -			 * Get the modification and access times of
> -			 * temporary file using stat(2).
> -			 */
> -			SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
> -			modf_time = stat_buf.st_mtime;
> -			access_time = stat_buf.st_atime;
> -
> -			/* Now do the actual verification */
> -			if (modf_time <= curr_time ||
> -			    modf_time >= pres_time ||
> -			    access_time <= curr_time ||
> -			    access_time >= pres_time) {
> -				tst_resm(TFAIL, "%s access and "
> -					 "modification times not set",
> -					 TEMP_FILE);
> -			} else {
> -				tst_resm(TPASS, "Functionality of "
> -					 "utime(%s, NULL) successful",
> -					 TEMP_FILE);
> -			}
> -		}
> -		tst_count++;
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	SAFE_TOUCH(TEMP_FILE, FILE_MODE, NULL);
>  }
>  
> -/*
> - * void
> - * setup() - performs all ONE TIME setup for this test.
> - *  Create a temporary directory and change directory to it.
> - *  Create a test file under temporary directory and close it
> - */
> -void setup(void)
> +static void run(void)
>  {
> -	int fildes;		/* file handle for temp file */
> -
> -	tst_require_root();
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	/* Creat a temporary file under above directory */
> -	fildes = SAFE_CREAT(cleanup, TEMP_FILE, FILE_MODE);
> -
> -	/* Close the temporary file created */
> -	SAFE_CLOSE(cleanup, fildes);
> -
> -	/* Get the current time */
> -	curr_time = time(NULL);
> +	struct stat stat_buf;
> +	time_t pre_time, post_time;

The utime03.c makes sure that the actime and modtime are different from
a current time by explicitly setting it before we call utime() with NULL
argument. Can we do the same here please?

> +	pre_time = tst_get_fs_timestamp();
> +	TST_EXP_PASS(utime(TEMP_FILE, NULL), "utime(%s, NULL)", TEMP_FILE);
> +	if (!TST_PASS) {
> +		tst_res(TFAIL | TTERRNO, "utime(%s) failed", TEMP_FILE);
> +		return;
> +	}
> +	post_time = tst_get_fs_timestamp();
> +	SAFE_STAT(TEMP_FILE, &stat_buf);
>  
> -	/*
> -	 * Sleep for a second so that mod time and access times will be
> -	 * different from the current time
> -	 */
> -	sleep(2);		/* sleep(1) on IA64 sometimes sleeps < 1 sec!! */
> +	if (stat_buf.st_mtime < pre_time || stat_buf.st_mtime > post_time)
> +		tst_res(TFAIL, "utime() did not set expected mtime");
>  
> +	if (stat_buf.st_atime < pre_time || stat_buf.st_atime > post_time)
> +		tst_res(TFAIL, "utime() did not set expected atime");

Jan just send a similar patch that prints the pre_time and post_time as
well to aid debuggin, can you pleas add that too?

See: http://patchwork.ozlabs.org/project/ltp/patch/e942179576028d20ad2c381d442fefec1af6a556.1655797247.git.jstancek@redhat.com/

>  }
>  
> -/*
> - * void
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - *  Remove the test directory and testfile created in the setup.
> - */
> -void cleanup(void)
> -{
> -
> -	tst_rmdir();
> -
> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.mntpoint = MNT_POINT,
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const[]) {
> +		"vfat",
> +		"exfat",
> +		NULL
> +	}
> +};

Otherwise the changes looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
