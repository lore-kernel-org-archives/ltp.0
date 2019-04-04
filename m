From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Apr 2019 15:19:11 +0200
Subject: [LTP] [PATCH 2/2] syscalls/stat03,
 06: Cleanup && Convert to new API
In-Reply-To: <1554280180-4089-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1554280180-4089-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1554280180-4089-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190404131911.GB10585@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
> index 2e4c83a93..27937f852 100644
> --- a/testcases/kernel/syscalls/stat/stat03.c
> +++ b/testcases/kernel/syscalls/stat/stat03.c
> @@ -1,333 +1,96 @@
> -/*
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
> - */
> -
> -/*
> - * Test Name: stat03
> - *
> - * Test Description:
> - *   Verify that,
> - *   1) stat(2) returns -1 and sets errno to EACCES if search permission is
> - *      denied on a component of the path prefix.
> - *   2) stat(2) returns -1 and sets errno to ENOENT if the specified file
> - *	does not exists or empty string.
> - *   3) stat(2) returns -1 and sets errno to EFAULT if pathname points
> - *	outside user's accessible address space.
> - *   4) stat(2) returns -1 and sets errno to ENAMETOOLONG if the pathname
> - *	component is too long.
> - *   5) stat(2) returns -1 and sets errno to ENOTDIR if the directory
> - *	component in pathname is not a directory.
> - *
> - * Expected Result:
> - *  stat() should fail with return value -1 and set expected errno.
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
> - *   	if errno set == expected errno
> - *   		Issue sys call fails with expected return value and errno.
> - *   	Otherwise,
> - *		Issue sys call fails with unexpected errno.
> - *   Otherwise,
> - *	Issue sys call returns unexpected value.
> - *
> - *  Cleanup:
> - *   Print errno log and/or timing stats if options given
> - *   Delete the temporary directory(s)/file(s) created.
> - *
> - * Usage:  <for command-line>
> - *  stat03 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
> - *	where,  -c n : Run n copies concurrently.
> - *		-e   : Turn on errno logging.
> - *		-i n : Execute test n times.
> - *		-I x : Execute test for x seconds.
> - *		-P x : Pause for x seconds between iterations.
> - *		-t   : Turn on syscall timing.
> - *
> - * History
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (c) International Business Machines  Corp., 2001
>   *	07/2001 John George
>   *		-Ported
>   *
> - * Restrictions:
> - *
> + * check stat() with various error conditions that should produce
> + * EACCES, EFAULT, ENAMETOOLONG,  ENOENT, ENOTDIR, ELOOP
>   */
>  
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <unistd.h>
>  #include <fcntl.h>
>  #include <errno.h>
> -#include <string.h>
> -#include <signal.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> -#include <sys/mman.h>
>  #include <pwd.h>
> +#include "tst_test.h"
>  
> -#include "test.h"
> -#include "safe_macros.h"
> +#define TST_EACCES_DIR  "tst_eaccesdir"
> +#define TST_EACCES_FILE "tst_eaccesdir/tst"
> +#define TST_ENOENT      "tst_enoent/tst"
> +#define TST_ENOTDIR_DIR "tst_enotdir/tst"
> +#define TST_ENOTDIR_FILE "tst_enotdir"
>  
> -#define MODE_RWX	S_IRWXU | S_IRWXG | S_IRWXO
> -#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
> -#define DIR_TEMP	"testdir_1"
> -#define TEST_FILE1	"testdir_1/tfile_1"
> -#define TEST_FILE2	"t_file/tfile_2"
> +#define MODE_RW	        0666
> +#define DIR_MODE        0755
>  
> -int no_setup();
> -int setup1();			/* setup function to test chmod for EACCES */
> -int setup2();			/* setup function to test chmod for ENOTDIR */
> -int longpath_setup();		/* setup function to test chmod for ENAMETOOLONG */
> -char nobody_uid[] = "nobody";
>  struct passwd *ltpuser;
>  
> -char Longpathname[PATH_MAX + 2];
> +static char long_dir[PATH_MAX + 2] = {[0 ... PATH_MAX + 1] = 'a'};
> +static char loop_dir[PATH_MAX] = ".";
> +
> +struct tcase;

It's useless to forward declare the structure if you are not using it
for the structure members themselves.

> -struct test_case_t {		/* test case struct. to hold ref. test cond's */
> +static struct tcase{
>  	char *pathname;
> -	char *desc;
>  	int exp_errno;
> -	int (*setupfunc) ();
> -} Test_cases[] = {
> -	{TEST_FILE1, "No Search permissions to process", EACCES, setup1}, {
> -	NULL, "Invalid address", EFAULT, no_setup}, {
> -	Longpathname, "Pathname too long", ENAMETOOLONG, longpath_setup}, {
> -	"", "Pathname is empty", ENOENT, no_setup}, {
> -	TEST_FILE2, "Path contains regular file", ENOTDIR, setup2}, {
> -	NULL, NULL, 0, no_setup}
> +} TC[] = {
> +	{TST_EACCES_FILE, EACCES},
> +	{NULL, EFAULT},
> +	{long_dir, ENAMETOOLONG},
> +	{TST_ENOENT, ENOENT},
> +	{TST_ENOTDIR_DIR, ENOTDIR},
> +	{loop_dir, ELOOP}
>  };
>  
> -char *TCID = "stat03";
> -int TST_TOTAL = ARRAY_SIZE(Test_cases);
> -
> -void setup();			/* Main setup function for the tests */
> -void cleanup();			/* cleanup function for the test */
> -
> -int main(int ac, char **av)
> -{
> -	struct stat stat_buf;	/* stat structure buffer */
> -	int lc;
> -	char *file_name;	/* ptr. for file name whose mode is modified */
> -	char *test_desc;	/* test specific error message */
> -	int ind;		/* counter to test different test conditions */
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	/*
> -	 * Invoke setup function to call individual test setup functions
> -	 * to simulate test conditions.
> -	 */
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
> -			file_name = Test_cases[ind].pathname;
> -			test_desc = Test_cases[ind].desc;
> -
> -			/*
> -			 * Call stat(2) to test different test conditions.
> -			 * verify that it fails with -1 return value and
> -			 * sets appropriate errno.
> -			 */
> -			TEST(stat(file_name, &stat_buf));
> -
> -			/* Check return code from stat(2) */
> -			if (TEST_RETURN == -1) {
> -				if (TEST_ERRNO == Test_cases[ind].exp_errno) {
> -					tst_resm(TPASS,
> -						 "stat() fails, %s, errno:%d",
> -						 test_desc, TEST_ERRNO);
> -				} else {
> -					tst_resm(TFAIL,
> -						 "stat() fails, %s, errno:%d, expected errno:%d",
> -						 test_desc, TEST_ERRNO,
> -						 Test_cases[ind].exp_errno);
> -				}
> -			} else {
> -				tst_resm(TFAIL,
> -					 "stat(2) returned %ld, expected -1, errno:%d",
> -					 TEST_RETURN,
> -					 Test_cases[ind].exp_errno);
> -			}
> -		}
> -		tst_count++;	/* incr TEST_LOOP counter */
> -	}
> -
> -	/*
> -	 * Invoke cleanup() to delete the test directory/file(s) created
> -	 * in the setup().
> -	 */
> -	cleanup();
> -	tst_exit();
> -
> -}
> -
> -/*
> - * void
> - * setup(void) - performs all ONE TIME setup for this test.
> - * 	Exit the test program on receipt of unexpected signals.
> - *	Create a temporary directory and change directory to it.
> - *	Invoke individual test setup functions according to the order
> - *	set in struct. definition.
> - */
> -void setup(void)
> +static void verify_stat(unsigned int n)
>  {
> -	int ind;
> -
> -	tst_require_root();
> -
> -	/* Capture unexpected signals */
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	/* Switch to nobody user for correct error code collection */
> -	ltpuser = getpwnam(nobody_uid);
> -	if (setuid(ltpuser->pw_uid) == -1) {
> -		tst_resm(TINFO, "setuid failed to "
> -			 "to set the effective uid to %d", ltpuser->pw_uid);
> -		perror("setuid");
> +	struct tcase *tc = TC + n;
> +	struct stat stat_buf;
> +
> +	TEST(stat(tc->pathname, &stat_buf));
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "stat() returned %ld, expected -1, errno=%d",
> +			TST_RET, tc->exp_errno);

I think that printing the expecte errno here is a bit confusing and even
if you think that it should stay it should be printed with
tst_strerrno().

> +		return;
>  	}
>  
> -	/* Pause if that option was specified
> -	 * TEST_PAUSE contains the code to fork the test with the -i option.
> -	 * You want to make sure you do this before you create your temporary
> -	 * directory.
> -	 */
> -	TEST_PAUSE;
> -
> -	/* Make a temp dir and cd to it */
> -	tst_tmpdir();
> -
> -	/* call individual setup functions */
> -	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
> -		if (!Test_cases[ind].pathname)
> -			Test_cases[ind].pathname = tst_get_bad_addr(cleanup);
> -		Test_cases[ind].setupfunc();
> +	if (TST_ERR == tc->exp_errno) {
> +		tst_res(TPASS | TTERRNO, "stat() failed as expected");
> +	} else {
> +		tst_res(TFAIL | TTERRNO,
> +			"stat() failed unexpectedly; expected: %d - %s",
> +			tc->exp_errno, strerror(tc->exp_errno));

Here as well, we should use tst_strerrno() instead of strerror().

>  	}
>  }

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
