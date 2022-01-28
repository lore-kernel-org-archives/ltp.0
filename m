Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAD4C433F5
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 15:29:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E5713C9765
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 16:28:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DDB03C2159
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 16:28:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 489756000E0
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 16:28:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 721C82114E;
 Fri, 28 Jan 2022 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643383725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fS94rkJIkYK3/BFy1NuveWDUxls+QZ0nOAeYG2N6WB8=;
 b=LVVX64DUUhB6cdHazFg45PI1OQtjBVEJSdw9+ktVwhXHdd6dFlf7EdbFEBywP6/s2rUzCN
 C2LMG0ooXdqpnyyrVRpvjqti1VsTWA4kKRtOgcilUB/XeyXf4dClB17PtlXjpEvEGl8ZEW
 wTtIeoyPJ4QqxuJbo9vpl7gQHZTnqLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643383725;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fS94rkJIkYK3/BFy1NuveWDUxls+QZ0nOAeYG2N6WB8=;
 b=l4jN/9bQKE3eIn1XCMFd2yF2RLqbfDx3Js8Pe5oeTlwl0XWdArE19d4zGDWi4r75xELLj0
 rFcKmR6+qcAxaLCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41FC0139D2;
 Fri, 28 Jan 2022 15:28:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3arbCq0L9GEuRwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jan 2022 15:28:45 +0000
Date: Fri, 28 Jan 2022 16:30:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: tangmeng <tangmeng@uniontech.com>
Message-ID: <YfQMHSeSqmXNACLh@yuki>
References: <20211119071637.19635-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211119071637.19635-1-tangmeng@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/fchmod_03: Convert to new API
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
>   *
> - * Test Description:
> - *  Verify that, fchmod(2) will succeed to change the mode of a file
> - *  and set the sticky bit on it if invoked by non-root (uid != 0)
> - *  process with the following constraints,
> + * Verify that, fchmod(2) will succeed to change the mode of a file
> + * and set the sticky bit on it if invoked by non-root (uid != 0)
> + * process with the following constraints,
>   *	- the process is the owner of the file.
>   *	- the effective group ID or one of the supplementary group ID's of the
>   *	  process is equal to the group ID of the file.
> - *
> - * Expected Result:
> - *  fchmod() should return value 0 on success and succeeds to change
> - *  the mode of specified file, sets sticky bit on it.
> - *
> - * Algorithm:
> - *  Setup:
> - *   Setup signal handling.
> - *   Create temporary directory.
> - *   Pause for SIGUSR1 if option specified.
> - *
> - *  Test:
> - *   Loop if the proper options are given.
> - *   Execute system call
> - *   Check return code, if system call failed (return=-1)
> - *   	Log the errno and Issue a FAIL message.
> - *   Otherwise,
> - *   	Verify the Functionality of system call
> - *      if successful,
> - *      	Issue Functionality-Pass message.
> - *      Otherwise,
> - *		Issue Functionality-Fail message.
> - *  Cleanup:
> - *   Print errno log and/or timing stats if options given
> - *   Delete the temporary directory created.
> - *
> - * Usage:  <for command-line>
> - *  fchmod03 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS:
> - *  This test should be run by 'non-super-user' only.
> - *
>   */
> 
> -#include <stdio.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
>  #include <pwd.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
>  #include "fchmod.h"
> +#include "tst_test.h"
> 
>  int fd;				/* file descriptor for test file */
                                           ^
					   Useless comment, please
					   remove.
> -char *TCID = "fchmod03";
> -int TST_TOTAL = 1;
> -
>  char nobody_uid[] = "nobody";

These two variables should be static.

>  struct passwd *ltpuser;

This is not used outside setup() function so it should be variable local
to the test setup.

> -void setup();			/* Main setup function for the test */
> -void cleanup();			/* Main cleanup function for the test */
> -
> -int main(int ac, char **av)
> +static void verify_fchmod(void)
>  {
>  	struct stat stat_buf;	/* stat struct. */
> -	int lc;
>  	mode_t file_mode;	/* mode permissions set on testfile */

Useless comments.

> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> +	TST_EXP_PASS_SILENT(fchmod(fd, PERMS));
> 
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		TEST(fchmod(fd, PERMS));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO, "fchmod failed");
> -			continue;
> -		}
> -		/*
> -		 * Get the file information using
> -		 * fstat(2).
> -		 */
> -		if (fstat(fd, &stat_buf) == -1)
> -			tst_brkm(TFAIL | TERRNO, cleanup,
> -				 "fstat failed");
> -		file_mode = stat_buf.st_mode;
> -
> -		/* Verify STICKY BIT set on testfile */
> -		if ((file_mode & PERMS) != PERMS)
> -			tst_resm(TFAIL, "%s: Incorrect modes 0%3o, "
> -				 "Expected 0777", TESTFILE, file_mode);
> -		else
> -			tst_resm(TPASS, "Functionality of fchmod(%d, "
> -				 "%#o) successful", fd, PERMS);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	/*
> +	 * Get the file information using
> +	 * fstat(2).
> +	 */

Useless comment.

> +	if (fstat(fd, &stat_buf) == -1)
> +		tst_brk(TFAIL | TERRNO, "fstat failed");
> +	file_mode = stat_buf.st_mode;

SAFE_FSTAT()

> +	/* Verify STICKY BIT set on testfile */

Useless comment.

> +	if ((file_mode & PERMS) != PERMS)
> +		tst_res(TFAIL, "%s: Incorrect modes 0%3o, "
> +			 "Expected 0777", TESTFILE, file_mode);
> +	else
> +		tst_res(TPASS, "Functionality of fchmod(%d, "
> +			 "%#o) successful", fd, PERMS);
>  }
> 
>  void setup(void)

static

>  {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	tst_require_root();
> -
>  	ltpuser = getpwnam(nobody_uid);
> -	if (ltpuser == NULL)
> -		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
> -	SAFE_SETEUID(NULL, ltpuser->pw_uid);
> -
> -	TEST_PAUSE;
> 
> -	tst_tmpdir();
> +	if (ltpuser == NULL)
> +		tst_brk(TBROK | TERRNO, "getpwnam failed");

SAFE_GETPWNAM()

> +	SAFE_SETEUID(ltpuser->pw_uid);
> 
>  	/*
>  	 * Create a test file under temporary directory with specified
> @@ -157,14 +60,18 @@ void setup(void)
>  	 * uid/gid of guest user.
>  	 */

Useless comment.

>  	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
> +		tst_brk(TBROK | TERRNO, "open failed");

SAFE_OPEN()

>  }
> 
>  void cleanup(void)

and here as well.

>  {
>  	if (close(fd) == -1)
> -		tst_resm(TWARN | TERRNO, "close failed");
> -
> -	tst_rmdir();
> -
> +		tst_res(TWARN | TERRNO, "close failed");
>  }
> +
> +static struct tst_test test = {
> +	.test_all = verify_fchmod,
> +	.setup = setup,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +};
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
