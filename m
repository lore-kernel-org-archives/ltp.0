From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Jul 2019 14:37:34 +0200
Subject: [LTP] [PATCH 1/3] syscalls/ftruncate: Rewrite ftruncate01 and
 merge ftruncate02
In-Reply-To: <1564395109-7165-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1564395109-7165-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20190730123734.GC10214@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate01.c b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
> index 3309af5..c98b50b 100644
> --- a/testcases/kernel/syscalls/ftruncate/ftruncate01.c
> +++ b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
> @@ -1,203 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
                                       ^
				       -or-later

You have to replace the exact version of the licence.

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
> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.

You are missing the IBM copyright here.

> + * Author: Wayne Boyer
>   */
> -
>  /*
> - * Test Name: ftruncate01
> - *
>   * Test Description:
> - *  Verify that, ftruncate(2) succeeds to truncate a file to a specified
> - *  length if the file indicated by file descriptor opened for writing.
> - *
> - * Expected Result:
> - *  ftruncate(2) should return a value 0 and the length of the file after
> - *  truncation should be equal to the length it is truncated to.
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
> - *	Log the errno and Issue a FAIL message.
> - *   Otherwise,
> - *	Verify the Functionality of system call
> - *      if successful,
> - *		Issue Functionality-Pass message.
> - *      Otherwise,
> - *		Issue Functionality-Fail message.
> - *  Cleanup:
> - *   Print errno log and/or timing stats if options given
> - *   Delete the temporary directory created.
> - *
> - * Usage:  <for command-line>
> - *  ftruncate01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
> + *  Verify that, ftruncate() succeeds to truncate a file to a certain length,
> + *  but it fails to attempt to read past the truncated length.
          ^
	  What fails? The ftruncate does not read anything.

Also this should say that we are testing both the cases so that
resulting size is larger and smaller.

>   */
>  
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <unistd.h>
>  #include <fcntl.h>
>  #include <errno.h>
>  #include <string.h>
> -#include <signal.h>
> -#include <inttypes.h>
>  
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
>  
> -#define TESTFILE	"testfile"	/* file under test */
> -#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
> -#define BUF_SIZE	256	/* buffer size */
> -#define FILE_SIZE	1024	/* test file size */
> -#define TRUNC_LEN	256	/* truncation length */
> +#define TESTFILE	"testfile"
>  
> -TCID_DEFINE(ftruncate01);
> -int TST_TOTAL = 1;		/* Total number of test conditions */
> -int fildes;			/* file descriptor for test file */
> +#define TRUNC_LEN1	256
> +#define TRUNC_LEN2	512
> +#define FILE_SIZE	1024
>  
> -void setup();			/* setup function for the test */
> -void cleanup();			/* cleanup function for the test */
> +static int fd;
> +static struct stat stat_buf;
>  
> -int main(int ac, char **av)
> +static int get_file_length(off_t offset, char date)
                                                  ^
               ^				  data
               |
	       this name is misleading we are checking the
	       content of the file in this function as well

Why don't we just pass the expected file size to this function as well
and do all the checks in this function?

>  {
> -	struct stat stat_buf;	/* stat(2) struct contents */
> -	int lc;
> -	off_t file_length;	/* test file length */
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> +	int i, read_len, file_length;
> +	char buf[FILE_SIZE];
>  
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +	memset(buf, '*', sizeof(buf));
>  
> -		tst_count = 0;
> +	SAFE_FSTAT(fd, &stat_buf);
> +	file_length = stat_buf.st_size;
>  
> -		/*
> -		 * Call ftruncate(2) to truncate a test file to a
> -		 * specified length.
> -		 */
> -		TEST(ftruncate(fildes, TRUNC_LEN));
> +	SAFE_LSEEK(fd, offset, SEEK_SET);
> +	read_len = SAFE_READ(0, fd, buf, sizeof(buf));
>  
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO, "ftruncate(%s) failed",
> -				 TESTFILE);
> -			continue;
> -		}
> -		/*
> -		 * Get the testfile information using
> -		 * fstat(2).
> -		 */
> -		if (fstat(fildes, &stat_buf) < 0) {
> -			tst_brkm(TFAIL, cleanup,
> -				 "stat(2) of %s failed, error:%d",
> -				 TESTFILE, errno);
> -		}
> -		stat_buf.st_mode &= ~S_IFREG;
> -		file_length = stat_buf.st_size;
> -
> -		/*
> -		 * Check for expected size of testfile after
> -		 * truncate(2) on it.
> -		 */
> -		if (file_length != TRUNC_LEN) {
> -			tst_resm(TFAIL,
> -				 "%s: Incorrect file size %" PRId64 ", "
> -				 "Expected %d", TESTFILE,
> -				 (int64_t) file_length, TRUNC_LEN);
> -		} else {
> -			tst_resm(TPASS, "Functionality of ftruncate() "
> -				 "on %s successful", TESTFILE);
> +	if (read_len > 0) {
            ^
	    this is useless

If read_len <= 0 the loop will do zero iterations.

> +		for (i = 0; i < read_len; i++) {
> +			if (buf[i] != date) {
> +				tst_brk(TBROK,
> +					"ftruncate() got incorrect date");
                                                                     ^
								    data
> +			}
>  		}
>  	}
>  
> -	cleanup();
> -	tst_exit();
> +	return file_length;
>  }
>  
> -/*
> - * void
> - * setup() - performs all ONE TIME setup for this test.
> - *  Create a temporary directory and change directory to it.
> - *  Create a test file under temporary directory and write some
> - *  data into it.
> - */
> -void setup(void)
> +static void verify_ftruncate(void)
>  {
> -	int i;
> -	int c, c_total = 0;	/* bytes to be written to file */
> -	char tst_buff[BUF_SIZE];	/* buffer to hold data */
> +	off_t file_length1, file_length2;
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	TEST(ftruncate(fd, TRUNC_LEN1));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "ftruncate() failed");
> +		return;
> +	}
>  
> -	tst_tmpdir();
> +	file_length1 = get_file_length(0, 'a');
>  
> -	/* Fill the test buffer with the known data */
> -	for (i = 0; i < BUF_SIZE; i++) {
> -		tst_buff[i] = 'a';
> -	}
> +	TEST(ftruncate(fd, TRUNC_LEN2));
>  
> -	/* open a file for reading/writing */
> -	fildes = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
> +	file_length2 = get_file_length(TRUNC_LEN1, 0);
>  
> -	/* Write to the file 1k data from the buffer */
> -	while (c_total < FILE_SIZE) {
> -		if ((c = write(fildes, tst_buff, sizeof(tst_buff))) <= 0) {
> -			tst_brkm(TBROK | TERRNO, cleanup, "write(%s) failed",
> -				 TESTFILE);
> -		} else {
> -			c_total += c;
> +	/*
> +	 * Check for expected size of testfile after issuing ftruncate() on it.
> +	 * If the ftruncate() to a smaller file passed, then check to see if
> +	 * file size was increased.
> +	 * If the ftruncate()to a smaller file failed, then don't check.
> +	 * Both results are allowed according to the SUS.
> +	 */

This is no longer true, the latest POSIX specification requires that the
size is increased.

See the bottom of CHANGE HISTORY in:

http://pubs.opengroup.org/onlinepubs/9699919799/

> +	if (TST_RET != -1) {
> +		if (file_length1 != TRUNC_LEN1 || file_length2 != TRUNC_LEN2) {
> +			tst_res(TFAIL, "ftruncate() got incorrected size");
> +			return;
> +		}
> +	} else {
> +		if (file_length1 != TRUNC_LEN1) {
> +			tst_res(TFAIL, "ftruncate() got incorrected size");
> +			return;
>  		}
>  	}
> +
> +	tst_res(TPASS, "ftruncate() secceeded");
                                      ^
				     succeeded
>  }
>  

-- 
Cyril Hrubis
chrubis@suse.cz
