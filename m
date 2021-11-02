Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8505AC433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 16:30:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3C560EB8
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 16:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE3C560EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DE133C71C6
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 17:30:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 115C03C6AA8
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 17:29:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E3E3F1000611
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 17:29:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38330218EF;
 Tue,  2 Nov 2021 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635870592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfRGZ0Ga2M28X2t3O6h1ma35Vxna/PxZGeQUa325UjU=;
 b=SdOrxO1w37mrMyn3MbleFUz4cYhLrFIqHm16qefnb4/qM+YrgXL/H2wigsZ8Z5jw+qzAdR
 dV4u09yuxCIQlcq9CCysRB5+ZCF616zbFKnANPIiF1FWmtlkDSNFkG+tKIepxMcU6BMbK7
 QsbWhiwqcj3vtUoARKF44k/vd7dCeR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635870592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfRGZ0Ga2M28X2t3O6h1ma35Vxna/PxZGeQUa325UjU=;
 b=H2nN30HsaehgxS0w3afHztuCMyhf0ZWjOcQC30j+W5IgIv3su7Bd2wD+6Cqd4gJ2TxDqhj
 TFsMPRaSUoDYu3Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2135313BB8;
 Tue,  2 Nov 2021 16:29:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id k4UOB4BngWF1bQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 02 Nov 2021 16:29:52 +0000
Date: Tue, 2 Nov 2021 17:30:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <YYFntyuvAn8V9lxa@yuki>
References: <1635755386-4012-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1635755386-4012-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pread02: Convert to new API and merge
 pread03 into pread02
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

> diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
> index aa194f6..54c1a4a 100644
> --- a/testcases/kernel/syscalls/pread/pread02.c
> +++ b/testcases/kernel/syscalls/pread/pread02.c
> @@ -1,295 +1,94 @@
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
> + * 07/2001 Ported by Wayne Boyer
>   */
>  
> -/*
> - * Test Name: pread02
> - *
> - * Test Description:
> - *  Verify that,
> - *   1) pread() fails when attempted to read from an unnamed pipe.
> - *   2) pread() fails if the specified offset position was invalid.
> - *
> - * Expected Result:
> - *  1) pread() should return -1 and set errno to ESPIPE.
> - *  2) pread() should return -1 and set errno to EINVAL.
> - *
> - * Algorithm:
> - *  Setup:
> - *   Setup signal handling.
> - *   Create a temporary directory.
> - *   Pause for SIGUSR1 if option specified.
> - *
> - *  Test:
> - *   Loop if the proper options are given.
> - *   Execute system call
> - *   Check return code, if system call failed (return=-1)
> - *      if errno set == expected errno
> - *              Issue sys call fails with expected return value and errno.
> - *      Otherwise,
> - *              Issue sys call fails with unexpected errno.
> - *   Otherwise,
> - *      Issue sys call returns unexpected value.
> - *
> - *  Cleanup:
> - *   Print errno log and/or timing stats if options given
> - *   Delete the temporary directory(s)/file(s) created.
> +/*\
> + * [Description]
>   *
> - * Usage:  <for command-line>
> - *  pread02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> + * Tests basic error handling of the pread syscall.
>   *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS:
> - *  None.
> + * - ESPIPE when attempted to read from an unnamed pipe
> + * - EINVAL if the specified offset position was invalid
> + * - EISDIR when fd refers to a directory
>   */
>  
> -#define _XOPEN_SOURCE 500
> -
> -#include <errno.h>
> -#include <unistd.h>
>  #include <fcntl.h>
> +#include <stdlib.h>
> +#include "tst_test.h"
>  
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -#define TEMPFILE	"pread_file"
> +#define PREAD_TEMPFILE  "pread_file"
> +#define PREAD_TEMPDIR	"pread_dir"
>  #define K1              1024
>  #define NBUFS           4
>  
> -char *TCID = "pread02";
> -int TST_TOTAL = 2;
> -
> -char *write_buf[NBUFS];		/* buffer to hold data to be written */
> -char *read_buf[NBUFS];		/* buffer to hold data read from file */
> -int pfd[2];			/* pair of file descriptors */
> -int fd1;
> -
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -int setup1();			/* setup function for test #1 */
> -int setup2();			/* setup function for test #2 */
> -int no_setup();
> -void init_buffers();		/* function to initialize/allocate buffers */
> +char *write_buf[NBUFS];
> +char *read_buf[NBUFS];
> +static int pfd[2];
> +static int fd[2];
>  
> -struct test_case_t {		/* test case struct. to hold ref. test cond's */
> -	int fd;
> +struct test_case_t {
> +	int *fd;
>  	size_t nb;
>  	off_t offst;
>  	char *desc;
>  	int exp_errno;
> -	int (*setupfunc) ();
> -} Test_cases[] = {
> -	{
> -	1, K1, 0, "file descriptor is a PIPE or FIFO", ESPIPE, setup1}, {
> -	2, K1, -1, "specified offset is -ve or invalid", EINVAL, setup2}, {
> -	0, 0, 0, NULL, 0, no_setup}
> +} tcases[] = {
> +	{&pfd[0], K1, 0, "file descriptor is a PIPE or FIFO", ESPIPE},
> +	{&fd[0], K1, -1, "specified offset is -ve or invalid", EINVAL},
> +	{&fd[1], K1, 0, "file descriptor is a directory", EISDIR}
>  };
>  
> -int main(int ac, char **av)
> +static void verify_pread(unsigned int n)
>  {
> -	int lc;
> -	int i;
> -	int fildes;		/* file descriptor of test file */
> -	size_t nbytes;		/* no. of bytes to be written */
> -	off_t offset;		/* offset position in the specified file */
> -	char *test_desc;	/* test specific error message */
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> +	struct test_case_t *tc = &tcases[n];
>  
> -		/* loop through the test cases */
> -		for (i = 0; Test_cases[i].desc != NULL; i++) {
> -			fildes = Test_cases[i].fd;
> -			test_desc = Test_cases[i].desc;
> -			nbytes = Test_cases[i].nb;
> -			offset = Test_cases[i].offst;
> -
> -			if (fildes == 1) {
> -				fildes = pfd[0];
> -			} else if (fildes == 2) {
> -				fildes = fd1;
> -			}
> -
> -			/*
> -			 * Call pread() with the specified file descriptor,
> -			 * no. of bytes to be read from specified offset.
> -			 * and verify that call should fail with appropriate
> -			 * errno set.
> -			 */
> -			TEST(pread(fildes, read_buf[0], nbytes, offset));
> -
> -			/* Check for the return code of pread() */
> -			if (TEST_RETURN != -1) {
> -				tst_brkm(TFAIL, cleanup, "pread() returned "
> -					 "%ld, expected -1, errno:%d",
> -					 TEST_RETURN, Test_cases[i].exp_errno);
> -			}
> -
> -			/*
> -			 * Verify whether expected errno is set.
> -			 */
> -			if (TEST_ERRNO == Test_cases[i].exp_errno) {
> -				tst_resm(TPASS, "pread() fails, %s, errno:%d",
> -					 test_desc, TEST_ERRNO);
> -			} else {
> -				tst_resm(TFAIL, "pread() fails, %s, unexpected "
> -					 "errno:%d, expected:%d", test_desc,
> -					 TEST_ERRNO, Test_cases[i].exp_errno);
> -			}
> -		}
> -	}
> -
> -	cleanup();
> -
> -	tst_exit();
> +	TST_EXP_FAIL2(pread(*tc->fd, read_buf[0], tc->nb, tc->offst), tc->exp_errno,
> +		"pread(%d, %zu, %ld, %s, %d)", *tc->fd, tc->nb, tc->offst, tc->desc, tc->exp_errno);
>  }
>  
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - *           Initialize/allocate write buffer.
> - *           Call individual setup function.
> - */
>  void setup(void)

missing static

>  {
> -	int i;
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/* Allocate/Initialize the read/write buffer with known data */
> -	init_buffers();
> -
> -	/* Call individual setup functions */
> -	for (i = 0; Test_cases[i].desc != NULL; i++) {
> -		Test_cases[i].setupfunc();
> -	}
> -}
> -
> -/*
> - * no_setup() - This function simply returns.
> - */
> -int no_setup(void)
> -{
> -	return 0;
> -}
> -
> -/*
> - * setup1() - setup function for a test condition for which pread()
> - *            returns -ve value and sets errno to ESPIPE.
> - *
> - *  Create an unnamed pipe using pipe().
> - *  Write some known data to the write end of the pipe.
> - *  return 0.
> - */
> -int setup1(void)
> -{
> -	/* Create a pair of unnamed pipe */
> -	SAFE_PIPE(cleanup, pfd);
> -
> -	/* Write known data (0's) of K1 bytes */
> -	if (write(pfd[1], write_buf[0], K1) != K1) {
> -		tst_brkm(TBROK, cleanup, "write to pipe failed: errno=%d : %s",
> -			 errno, strerror(errno));
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * setup2 - setup function for a test condition for which pread()
> - *          returns -ve value and sets errno to EINVAL.
> - *
> - *  Create a temporary directory and a file under it.
> - *  return 0.
> - */
> -int setup2(void)
> -{
> -
> -	tst_tmpdir();
> +	int count;
>  
> -	/* Creat a temporary file used for mapping */
> -	if ((fd1 = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
> -		tst_brkm(TBROK, cleanup, "open() on %s Failed, errno=%d : %s",
> -			 TEMPFILE, errno, strerror(errno));
> +	for (count = 0; count < NBUFS; count++) {
> +		write_buf[count] = SAFE_MALLOC(K1);
> +		read_buf[count] = SAFE_MALLOC(K1);
> +		memset(write_buf[count], count, K1);
>  	}

Do we actually need these buffers for anything?

As far as I can tell we can just pass a buffer of size 1 to the pread
that is defined on the stack in the verify_pread() function. No need to
allocate 4 sets of buffers at all.

> -	return 0;
> -}
> -
> -/*
> - * init_buffers() - allocate/Initialize write_buf array.
> - *
> - *  Allocate read/write buffer.
> - *  Fill the write buffer with the following data like,
> - *    write_buf[0] has 0's, write_buf[1] has 1's, write_buf[2] has 2's
> - *    write_buf[3] has 3's.
> - */
> -void init_buffers(void)
> -{
> -	int count;		/* counter variable for loop */
> +	SAFE_PIPE(pfd);
> +	SAFE_WRITE(1, pfd[1], write_buf[0], K1);

And we don't have to write 1024 bytes here either, single byte will do.

> -	/* Allocate and Initialize write buffer with known data */
> -	for (count = 0; count < NBUFS; count++) {
> -		write_buf[count] = malloc(K1);
> -		read_buf[count] = malloc(K1);
> +	fd[0] = SAFE_OPEN(PREAD_TEMPFILE, O_RDWR | O_CREAT, 0666);
>  
> -		if ((write_buf[count] == NULL) || (read_buf[count] == NULL)) {
> -			tst_brkm(TBROK, NULL,
> -				 "malloc() failed on read/write buffers");
> -		}
> -		memset(write_buf[count], count, K1);
> -	}
> +	SAFE_MKDIR(PREAD_TEMPDIR, 0777);
> +	fd[1] = SAFE_OPEN(PREAD_TEMPDIR, O_RDONLY);

Can we please, rather than using array here choose reasonable names for
the file descriptors?

This one would be better as:

	dirfd = SAFE_OPEN(...);

>  }
>  
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - *
> - *  Deallocate the memory allocated to read/write buffers.
> - *  Close the temporary file.
> - *  Remove the temporary directory created.
> - */
> -void cleanup(void)
> +static void cleanup(void)
>  {
>  	int count;
> +	int i;
>  
> -	/* Free the memory allocated for the read/write buffer */
>  	for (count = 0; count < NBUFS; count++) {
>  		free(write_buf[count]);
>  		free(read_buf[count]);
>  	}
>  
> -	/* Close the temporary file created in setup2 */
> -	SAFE_CLOSE(NULL, fd1);
> -
> -	tst_rmdir();
> -
> +	for (i = 0; i < 2; i++) {
> +		if (pfd[i] > 0)
> +			SAFE_CLOSE(pfd[i]);
> +		if (fd[i] > 0)
> +			SAFE_CLOSE(fd[i]);
> +	}
>  }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = verify_pread,
> +};
> diff --git a/testcases/kernel/syscalls/pread/pread03.c b/testcases/kernel/syscalls/pread/pread03.c
> deleted file mode 100644
> index 51819e7..0000000
> --- a/testcases/kernel/syscalls/pread/pread03.c
> +++ /dev/null
> @@ -1,214 +0,0 @@
> -/*
> - *
> - *   Copyright (C) Bull S.A. 2001
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
> - */
> -
> -/*
> - * Test Name: pread03
> - *
> - * Test Description:
> - *  Verify that,
> - *   1) pread() fails when fd refers to a directory.
> - *
> - *
> - * Expected Result:
> - *   1) pread() should return -1 and set errno to EISDIR.
> - *
> - * Algorithm:
> - *  Setup:
> - *   Setup signal handling.
> - *   Pause for SIGUSR1 if option specified.
> - *   Create a temporary directory.
> - *   Get the currect directory name
> - *   Open temporary directory
> - *
> - *  Test:
> - *   Loop if the proper options are given.
> - *   Execute system call
> - *   Check return code, if system call failed (return=-1)
> - *      if errno set == expected errno
> - *              Issue sys call fails with expected return value and errno.
> - *      Otherwise,
> - *              Issue sys call fails with unexpected errno.
> - *   Otherwise,
> - *      Issue sys call returns unexpected value.
> - *
> - *  Cleanup:
> - *   Print errno log and/or timing stats if options given
> - *   Delete the temporary directory(s)/file(s) created.
> - *
> - * Usage:  <for command-line>
> - *  pread03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	04/2002 Ported by Andr? Merlier
> - *
> - * RESTRICTIONS:
> - *  None.
> - */
> -
> -#define _XOPEN_SOURCE 500
> -
> -#include <sys/stat.h>
> -#include <sys/types.h>
> -#include <errno.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <string.h>
> -#include <stdlib.h>
> -#include <sys/file.h>
> -
> -#include "test.h"
> -
> -#define PREAD_TEMPDIR	"test"
> -#define K1              2048
> -#define NBUFS           1
> -
> -char *TCID = "pread03";
> -int TST_TOTAL = 1;
> -
> -char *read_buf[NBUFS];		/* buffer to hold data read from file */
> -int fd1;
> -
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -void init_buffers();		/* function to initialize/allocate buffers */
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	size_t nbytes;		/* no. of bytes to be written */
> -	off_t offset;		/* offset position in the specified file */
> -	char *test_desc;	/* test specific error message */
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	/* Check for looping state if -i option is given */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		test_desc = "EISDIR";
> -		nbytes = K1;
> -		offset = 20;
> -
> -		TEST(pread(fd1, read_buf[0], nbytes, offset));
> -
> -		/* Check for the return code of pread() */
> -		if (TEST_RETURN != -1) {
> -			tst_brkm(TFAIL, cleanup, "pread() returned "
> -				 "%ld, expected -1, errno:%d\n",
> -				 TEST_RETURN, EISDIR);
> -		}
> -
> -		/*
> -		 * Verify whether expected errno is set.
> -		 */
> -		if (TEST_ERRNO == EISDIR) {
> -			tst_resm(TPASS,
> -				 "pread() fails with expected error EISDIR errno:%d",
> -				 TEST_ERRNO);
> -		} else {
> -			tst_resm(TFAIL, "pread() fails, %s, unexpected "
> -				 "errno:%d, expected:%d\n", test_desc,
> -				 TEST_ERRNO, EISDIR);
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -
> -}
> -
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - *           create temporary directory and open it
> - */
> -void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/* Allocate the read buffer */
> -	init_buffers();
> -
> -	tst_tmpdir();
> -
> -	/*
> -	 * create a temporary directory
> -	 */
> -	if (mkdir(PREAD_TEMPDIR, 0777) != 0) {
> -		tst_resm(TFAIL, "mkdir() failed to create" " test directory");
> -		exit(1);
> -
> -	}
> -
> -	/* open temporary directory used for test */
> -	if ((fd1 = open(PREAD_TEMPDIR, O_RDONLY)) < 0) {
> -		tst_brkm(TBROK, cleanup, "open() on %s Failed, errno=%d : %s",
> -			 PREAD_TEMPDIR, errno, strerror(errno));
> -	}
> -}
> -
> -/*
> - * init_buffers() - allocate/Initialize write_buf array.
> - *
> - *  Allocate read buffer.
> - */
> -void init_buffers(void)
> -{
> -	int count;		/* counter variable for loop */
> -
> -	/* Allocate and Initialize read buffer */
> -	for (count = 0; count < NBUFS; count++) {
> -		read_buf[count] = malloc(K1);
> -
> -		if (read_buf[count] == NULL) {
> -			tst_brkm(TBROK, NULL,
> -				 "malloc() failed on read buffers");
> -		}
> -	}
> -}
> -
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - *
> - *  Close/Remove the temporary directory created.
> - */
> -void cleanup(void)
> -{
> -	int count;
> -
> -	/* Free the memory allocated for the read buffer */
> -	for (count = 0; count < NBUFS; count++) {
> -		free(read_buf[count]);
> -	}
> -
> -	/* delete the test directory created in setup() */
> -	tst_rmdir();
> -
> -}
> -- 
> 1.8.3.1
> 

> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
