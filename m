From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 5 Dec 2016 14:39:02 +0100
Subject: [LTP] [PATCH 1/1] syscalls/mq_open: fix old tests + convert to
 use new API
In-Reply-To: <20161205123551.2881-1-pvorel@suse.cz>
References: <20161205123551.2881-1-pvorel@suse.cz>
Message-ID: <20161205133902.qosubkbxosszf6oy@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Not sure about FILE_SCANF and FILE_PRINTF. They're handy, but there must have
> been a reason not to port them to new API in bbdb9f7. Should I use something different?
> ---
>  testcases/kernel/syscalls/mq_open/mq_open01.c | 601 ++++++++++----------------
>  testcases/kernel/syscalls/utils/common_j_h.c  | 107 -----
>  testcases/kernel/syscalls/utils/include_j_h.h |   6 -
>  3 files changed, 232 insertions(+), 482 deletions(-)

> diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
> index 1ab8185..3496320 100644
> --- a/testcases/kernel/syscalls/mq_open/mq_open01.c
> +++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
> @@ -1,129 +1,42 @@
> -/******************************************************************************/
> -/* Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd		*/
> -/*	  Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,	      */
> -/*		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>, 	      */
> -/*		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>	      */
> -/*								  	      */
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or	  */
> -/* (at your option) any later version.					*/
> -/*									    */
> -/* This program is distributed in the hope that it will be useful,	    */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	    */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		  */
> -/* the GNU General Public License for more details.			   */
> -/*									    */
> -/* You should have received a copy of the GNU General Public License	  */
> -/* along with this program;  if not, write to the Free Software	       */
> -/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
> -/*									    */
> -/******************************************************************************/
> -/******************************************************************************/
> -/*									    */
> -/* File:	mq_open01.c						   */
> -/*									    */
> -/* Description: This tests the mq_open() syscall			      */
> -/*									      */
> -/* 									      */
> -/*									      */
> -/*									      */
> -/*									      */
> -/*									    */
> -/* Usage:  <for command-line>						 */
> -/* mq_open01 [-c n] [-e][-i n] [-I x] [-p x] [-t]			     */
> -/*      where,  -c n : Run n copies concurrently.			     */
> -/*	      -e   : Turn on errno logging.				 */
> -/*	      -i n : Execute test n times.				  */
> -/*	      -I x : Execute test for x seconds.			    */
> -/*	      -P x : Pause for x seconds between iterations.		*/
> -/*	      -t   : Turn on syscall timing.				*/
> -/*									    */
> -/* Total Tests: 1							     */
> -/*									    */
> -/* Test Name:   mq_open01						     */
> -/* History:     Porting from Crackerjack to LTP is done by		    */
> -/*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
> -/******************************************************************************/
> -#include <sys/syscall.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <sys/uio.h>
> -#include <getopt.h>
> -#include <stdlib.h>
> -#include <errno.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <string.h>
> -#include <mqueue.h>
> -#include <limits.h>
> +/*
> + * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
> + *          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
> + *		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
> + *		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
> + * Copyright (c) 2016 Linux Test Project
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */

> -#include "../utils/include_j_h.h"
> -#include "../utils/common_j_h.c"
> +#include <pwd.h>
> +#include <mqueue.h>

> -#include "test.h"
> +#include "tst_test.h"
>  #include "linux_syscall_numbers.h"

> -char *TCID = "mq_open01";
> -int testno;
> -int TST_TOTAL = 1;
> -
> -/* Extern Global Functions */
> -/******************************************************************************/
> -/*									    */
> -/* Function:    cleanup						       */
> -/*									    */
> -/* Description: Performs all one time clean up for this test on successful    */
> -/*	      completion,  premature exit or  failure. Closes all temporary */
> -/*	      files, removes all temporary directories exits the test with  */
> -/*	      appropriate return code by calling tst_exit() function.       */
> -/*									    */
> -/* Input:       None.							 */
> -/*									    */
> -/* Output:      None.							 */
> -/*									    */
> -/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
> -/*	      On success - Exits calling tst_exit(). With '0' return code.  */
> -/*									    */
> -/******************************************************************************/
> -void cleanup(void)
> -{
> +#define FILE_SCANF(path, fmt, ...) \
> +	file_scanf(__FILE__, __LINE__, \
> +	           (path), (fmt), ## __VA_ARGS__)

> -	tst_rmdir();
> -}
> +#define FILE_PRINTF(path, fmt, ...) \
> +	file_printf(__FILE__, __LINE__, \
> +	            (path), (fmt), ## __VA_ARGS__)

> -/* Local  Functions */
> -/******************************************************************************/
> -/*									    */
> -/* Function:    setup							 */
> -/*									    */
> -/* Description: Performs all one time setup for this test. This function is   */
> -/*	      typically used to capture signals, create temporary dirs      */
> -/*	      and temporary files that may be used in the course of this    */
> -/*	      test.							 */
> -/*									    */
> -/* Input:       None.							 */
> -/*									    */
> -/* Output:      None.							 */
> -/*									    */
> -/* Return:      On failure - Exits by calling cleanup().		      */
> -/*	      On success - returns 0.				       */
> -/*									    */
> -/******************************************************************************/
> -void setup(void)
> -{
> -	tst_require_root();
> -
> -	/* Capture signals if any */
> -	/* Create temporary directories */
> -	TEST_PAUSE;
> -	tst_tmpdir();
> -}
> +#define QUEUE_NAME	"/test_mqueue"

> -/*
> - * Macros
> - */
> -#define SYSCALL_NAME    "mq_open"
> +static uid_t euid;

>  enum test_type {
>  	NORMAL,
> @@ -131,307 +44,257 @@ enum test_type {
>  	NO_SPACE,
>  };

> -/*
> - * Data Structure
> - */
> +#define TYPE_NAME(x) .ttype = x, .desc = #x
>  struct test_case {
>  	int ttype;
> +	const char *desc;
>  	char *user;
>  	char *qname;
>  	int oflag;
> -	long mq_maxmsg;		// Maximum numebr of messages.
> -	long mq_msgsize;	// Maximum message size.
> +	long mq_maxmsg;		/* max number of messages */
> +	long mq_msgsize;	/* max message size */
>  	int ret;
>  	int err;
>  };

> -#define ULIMIT_FNUM     0
> +#define NOFILE_LIMIT     0
>  #define PROC_MAX_QUEUES "/proc/sys/fs/mqueue/queues_max"

> -/* Test cases
> - *
> - *   test status of errors on man page
> - *
> - *   EACCES	     v (permission is denied)
> - *   EEXIST	     v (named message queue already exists)
> - *   EINTR	      --- (interrupted by a signal)
> - *   EINVAL	     v (not supported for the given name, or invalid
> - *			 arguments)
> - *   EMFILE	     v (process file table overflow)
> - *   ENAMETOOLONG       v (too long name length)
> - *   ENFILE	     can't check because it's difficult to create no-fd
> - *   ENOENT	     v (O_CREAT is not set and the named message queue
> - *			 does not exist)
> - *   ENOSPC	     v (no space for the new message queue)
> - */
> -
>  static struct test_case tcase[] = {
> -#if 1
> -	{			// case00
> -	 .ttype = NORMAL,
> -	 .qname = QUEUE_NAME,
> -	 .oflag = O_CREAT,
> -	 .mq_maxmsg = 20,
> -	 .mq_msgsize = 16384,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -#else
> -	{			// case00
> -	 .ttype = NORMAL,
> -	 .qname = QUEUE_NAME,
> -	 .oflag = O_CREAT,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			// case01
> -	 .ttype = NORMAL,
> -	 //  0    1       2       3
> -	 //  0123456789012345678901234567890123456789
> -	 "aaaaaaaaaaaaaaa",
> -	 .oflag = O_CREAT,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			// case02
> -	 .ttype = NORMAL,
> -	 //  0    1       2       3
> -	 //  0123456789012345678901234567890123456789
> -	 "aaaaaaaaaaaaaaaa",
> -	 .oflag = O_CREAT,
> -	 .ret = -1,
> -	 .err = ENAMETOOLONG,
> -	 },
> -
> -	{			// case03
> -	 .ttype = NORMAL,
> -	 .qname = "",
> -	 .oflag = O_CREAT,
> -	 .ret = -1,
> -	 .err = EINVAL,
> -	 },
> -	{			// case04
> -	 .ttype = NORMAL,
> -	 .user = "nobody",
> -	 .qname = QUEUE_NAME,
> -	 .ret = -1,
> -	 .err = EACCES,
> -	 },
> -	{			// case05
> -	 .ttype = NORMAL,
> -	 .qname = QUEUE_NAME,
> -	 .oflag = O_CREAT | O_EXCL,
> -	 .ret = -1,
> -	 .err = EEXIST,
> -	 },
> -	{			// case06
> -	 .ttype = NO_FILE,
> -	 .qname = QUEUE_NAME,
> -	 .oflag = O_CREAT,
> -	 .ret = -1,
> -	 .err = EMFILE,
> -	 },
> -	{			// case07
> -	 .ttype = NORMAL,
> -	 .qname = "/notexist",
> -	 .oflag = 0,
> -	 .ret = -1,
> -	 .err = ENOENT,
> -	 },
> -
> -	{			// case08
> -	 .ttype = NO_SPACE,
> -	 .user = "nobody",
> -	 .qname = QUEUE_NAME,
> -	 .oflag = O_CREAT,
> -	 .ret = -1,
> -	 .err = ENOSPC,
> -	 },
> -#endif
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = QUEUE_NAME,
> +		.oflag = O_CREAT,
> +		.mq_maxmsg = 20,
> +		.mq_msgsize = 16384,
> +		.ret = 0,
> +		.err = 0,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = QUEUE_NAME,
> +		.oflag = O_CREAT,
> +		.ret = 0,
> +		.err = 0,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = "/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaa",
> +		.oflag = O_CREAT,
> +		.ret = 0,
> +		.err = 0,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = "/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaa",
> +		.oflag = O_CREAT,
> +		.ret = -1,
> +		.err = ENAMETOOLONG,
> +	},
> +
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = "",
> +		.oflag = O_CREAT,
> +		.ret = -1,
> +		.err = EINVAL,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.user = "nobody",
> +		.qname = QUEUE_NAME,
> +		.ret = -1,
> +		.err = EACCES,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = QUEUE_NAME,
> +		.oflag = O_CREAT | O_EXCL,
> +		.ret = -1,
> +		.err = EEXIST,
> +	},
> +	{
> +		TYPE_NAME(NO_FILE),
> +		.qname = QUEUE_NAME,
> +		.oflag = O_CREAT,
> +		.ret = -1,
> +		.err = EMFILE,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = "/notexist",
> +		.oflag = 0,
> +		.ret = -1,
> +		.err = ENOENT,
> +	},
> +	{
> +		TYPE_NAME(NO_SPACE),
> +		.user = "nobody",
> +		.qname = QUEUE_NAME,
> +		.oflag = O_CREAT,
> +		.ret = -1,
> +		.err = ENOSPC,
> +	}
>  };

> -/*
> - * do_test()
> - *
> - *   Input  : TestCase Data
> - *   Return : RESULT_OK(0), RESULT_NG(1)
> - *
> - */
> +void setup(void)
> +{
> +	euid = geteuid();
> +}

> -static int do_test(struct test_case *tc)
> +static void do_test(unsigned int i)
>  {
> -	int sys_ret;
> -	int sys_errno;
> -	int result = RESULT_OK;
> -	int rc, fd1 = -1, fd2 = -1, cmp_ok = 1;
> -	uid_t old_uid = -1;
> -	rlim_t oldlim = -1;
> -	int oldval = -1;
> +	struct test_case *tc = &tcase[i];
> +	struct rlimit rlim;
> +	int oldlim = -1;
> +	struct passwd *pw;
> +
> +	int max_queues;
> +
> +	int fd1 = -1, fd2 = -1;
>  	struct mq_attr new, old, *p_attr;

> +	tst_res(TINFO, "queue name '%s'", tc->qname);
> +
>  	/*
>  	 * When test ended with SIGTERM etc, mq descriptor is left remains.
>  	 * So we delete it first.
>  	 */
> -	TEST(mq_unlink(QUEUE_NAME));
> +	mq_unlink(QUEUE_NAME);

> -	/*
> -	 * Execute system call
> -	 */
> -
> -	if (tc->ttype != NO_SPACE && !(tc->oflag & O_CREAT)) {
> -		errno = 0;
> -		TEST(sys_ret =
> -		     mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU,
> -			     NULL));
> -		sys_errno = errno;
> -		if (sys_ret < 0)
> +	if (tc->ttype != NO_SPACE &&
> +		(!(tc->oflag & O_CREAT) || tc->oflag & O_EXCL)) {
> +		TEST(fd1 = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR,
> +			S_IRWXU, NULL));
> +		if (fd1 < 0)
>  			goto TEST_END;
> -		fd1 = sys_ret;
>  	}
> +
>  	if (tc->ttype == NO_FILE) {
> -		TEST(rc = setup_ulimit_fnum(ULIMIT_FNUM, &oldlim));
> -		if (rc < 0) {
> -			result = 1;
> -			goto EXIT;
> +		if (getrlimit(RLIMIT_NOFILE, &rlim) == -1) {
> +			tst_res(TFAIL | TTERRNO, "getrlimit failed");
> +			goto CLEANUP;
> +		}
> +		if (rlim.rlim_cur > NOFILE_LIMIT) {
> +			oldlim = rlim.rlim_cur;
> +			rlim.rlim_cur = NOFILE_LIMIT;
> +			if (setrlimit(RLIMIT_NOFILE, &rlim) == -1) {
> +				tst_res(TFAIL | TTERRNO, "setrlimit %d to %ld failed",
> +						RLIMIT_NOFILE, rlim.rlim_cur);
> +				goto CLEANUP;
> +			}
>  		}
>  	}

> -	/*
> -	 * Change /proc/sys/fs/mqueue/queues_max
> -	 */
>  	if (tc->ttype == NO_SPACE) {
> -		TEST(rc = setup_proc_fs(PROC_MAX_QUEUES, 0, &oldval));
> -		if (rc < 0) {
> -			result = 1;
> -			goto EXIT;
> +		if (FILE_SCANF(PROC_MAX_QUEUES, "%d", &max_queues)) {
> +			tst_res(TFAIL | TTERRNO, "Read %s failed",
> +				PROC_MAX_QUEUES);
> +			goto CLEANUP;
> +		}
> +		if (FILE_PRINTF(PROC_MAX_QUEUES, "%d", 0)) {
> +			tst_res(TFAIL | TTERRNO, "Write %s failed",
> +				PROC_MAX_QUEUES);
> +			goto CLEANUP;
>  		}
>  	}

> -	/*
> -	 * Change effective user id
> -	 */
>  	if (tc->user != NULL) {
> -		TEST(rc = setup_euid(tc->user, &old_uid));
> -		if (rc < 0) {
> -			result = 1;
> -			goto EXIT;
> +		pw = getpwnam(tc->user);
> +		if (!pw) {
> +			tst_res(TFAIL | TTERRNO, "getpwnam failed");
> +			goto CLEANUP;
> +		}
> +		if (seteuid(pw->pw_uid)) {
> +			tst_res(TFAIL | TTERRNO, "seteuid failed");
> +			goto CLEANUP;
>  		}
>  	}

> -	/*
> -	 * Execute system call
> -	 */
> -	//tst_resm(TINFO,"PATH_MAX: %d\n", PATH_MAX);
> -	//tst_resm(TINFO,"NAME_MAX: %d", NAME_MAX);
>  	p_attr = NULL;
>  	if (tc->mq_maxmsg || tc->mq_msgsize) {
>  		new.mq_maxmsg = tc->mq_maxmsg;
>  		new.mq_msgsize = tc->mq_msgsize;
>  		p_attr = &new;
>  	}
> -	errno = 0;
> +
>  	if (tc->oflag & O_CREAT)
> -		TEST(sys_ret = mq_open(tc->qname, tc->oflag, S_IRWXU, p_attr));
> +		TEST(fd2 = mq_open(tc->qname, tc->oflag, S_IRWXU, p_attr));
>  	else
> -		TEST(sys_ret = mq_open(tc->qname, tc->oflag));
> -	sys_errno = errno;
> -	if (sys_ret < 0)
> -		goto TEST_END;
> -	fd2 = sys_ret;
> -
> -	if (p_attr) {
> -		TEST(rc = ltp_syscall(__NR_mq_getsetattr, fd2, NULL, &old));
> -		if (TEST_RETURN < 0) {
> -			tst_resm(TFAIL,
> -				 "mq_getsetattr failed - errno = %d : %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -			result = 1;
> -			goto EXIT;
> +		TEST(fd2 = mq_open(tc->qname, tc->oflag));
> +
> +	if (fd2 > 0 && p_attr) {
> +		if (tst_syscall(__NR_mq_getsetattr, fd2, NULL, &old) < 0) {
> +			tst_res(TFAIL | TTERRNO, "mq_getsetattr failed");
> +			goto CLEANUP;
> +		}
> +
> +		if (old.mq_maxmsg != new.mq_maxmsg
> +			|| old.mq_msgsize != new.mq_msgsize) {
> +			tst_res(TFAIL | TTERRNO, "wrong mq_attr: "
> +				"mq_maxmsg expected %ld return %ld, "
> +				"mq_msgsize expected %ld return %ld",
> +				new.mq_maxmsg, old.mq_maxmsg, new.mq_msgsize,
> +				old.mq_msgsize);
> +			goto CLEANUP;
>  		}
> -		tst_resm(TINFO, "mq_maxmsg E:%ld,\tR:%ld", new.mq_maxmsg,
> -			 old.mq_maxmsg);
> -		tst_resm(TINFO, "mq_msgsize E:%ld,\tR:%ld", new.mq_msgsize,
> -			 old.mq_msgsize);
> -		cmp_ok = old.mq_maxmsg == new.mq_maxmsg
> -		    && old.mq_msgsize == new.mq_msgsize;
>  	}

>  TEST_END:
> -	/*
> -	 * Check results
> -	 */
> -	result |= (sys_errno != tc->err) || !cmp_ok;
> -	PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
> -			 cmp_ok);
> -
> -EXIT:
> -	if (tc->user != NULL && old_uid != -1)
> -		TEST(cleanup_euid(old_uid));
> -
> -	if (tc->ttype == NO_SPACE && oldval != -1)
> -		TEST(cleanup_proc_fs(PROC_MAX_QUEUES, oldval));
> -
> -	if (tc->ttype == NO_FILE && oldlim != -1)
> -		TEST(cleanup_ulimit_fnum(oldlim));
> -	if (fd1 >= 0)
> -		TEST(close(fd1));
> -	if (fd2 >= 0)
> -		TEST(close(fd2));
> -	if (fd1 >= 0)
> -		TEST(mq_unlink(QUEUE_NAME));
> -	if (fd2 >= 0 && strcmp(tc->qname, QUEUE_NAME) != 0)
> -		TEST(mq_unlink(tc->qname));
> -
> -	return result;
> -}
> -
> -/*
> - * main()
> - */
> +	if (TEST_ERRNO != tc->err || (tc->ret < 0 && TEST_RETURN != tc->ret) ||
> +		(tc->ret >= 0 && TEST_RETURN < 0)) {
> +		tst_res(TFAIL | TTERRNO, "%s returned: %ld, "
> +			"expected: %d, expected errno: %s (%d)", tc->desc,
> +			TEST_RETURN, tc->ret, tst_strerrno(tc->err), tc->err);
> +	} else {
> +		tst_res(TPASS | TTERRNO, "%s returned: %ld", tc->desc,
> +			TEST_RETURN);
> +	}

> -int main(int ac, char **av)
> -{
> -	int result = RESULT_OK;
> -	int i;
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> -		tst_count = 0;
> -		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -
> -			/*
> -			 * Execute test
> -			 */
> -			for (i = 0; i < (int)ARRAY_SIZE(tcase); i++) {
> -				int ret;
> -				tst_resm(TINFO, "(case%02d) START", i);
> -				ret = do_test(&tcase[i]);
> -				tst_resm(TINFO, "(case%02d) END => %s", i,
> -					 (ret == 0) ? "OK" : "NG");
> -				result |= ret;
> -			}
> +CLEANUP:
> +	if (tc->user != NULL && seteuid(euid) == -1)
> +		tst_res(TWARN | TTERRNO, "seteuid back to %d failed", euid);

> -			/*
> -			 * Check results
> -			 */
> -			switch (result) {
> -			case RESULT_OK:
> -				tst_resm(TPASS, "mq_open call succeeded ");
> -				break;
> -
> -			default:
> -				tst_brkm(TFAIL | TTERRNO, cleanup,
> -					 "mq_open failed");
> -				break;
> -			}
> +	if (tc->ttype == NO_SPACE && max_queues != -1 &&
> +		FILE_PRINTF(PROC_MAX_QUEUES, "%d", max_queues))
> +		tst_res(TWARN | TTERRNO, "restoring max_queues back to %d failed", max_queues);

> -		}
> +	if (tc->ttype == NO_FILE && oldlim != -1) {
> +		rlim.rlim_cur = oldlim;
> +		if (setrlimit(RLIMIT_NOFILE, &rlim) == -1)
> +			tst_res(TWARN | TTERRNO, "Restore limit %d back to %lu failed",
> +					RLIMIT_NOFILE, rlim.rlim_cur);
>  	}
> -	cleanup();
> -	tst_exit();
> +
> +	if (fd1 > 0 && close(fd1))
> +		tst_res(TWARN | TTERRNO, "close(fd1) failed");
> +
> +	if (fd2 > 0 && close(fd2))
> +		tst_res(TWARN | TTERRNO, "close(fd2) failed");
> +
> +	if (fd1 > 0)
> +		mq_unlink(QUEUE_NAME);
> +
> +	if (fd2 > 0 && strcmp(tc->qname, QUEUE_NAME) != 0)
> +		mq_unlink(tc->qname);
>  }
> +
> +static struct tst_test test = {
> +	.tid = "mq_open01",
> +	.tcnt = ARRAY_SIZE(tcase),
> +	.test = do_test,
> +	.needs_root = 1,
> +	.setup = setup,
> +};
> diff --git a/testcases/kernel/syscalls/utils/common_j_h.c b/testcases/kernel/syscalls/utils/common_j_h.c
> index 43165ca..dbdbc11 100644
> --- a/testcases/kernel/syscalls/utils/common_j_h.c
> +++ b/testcases/kernel/syscalls/utils/common_j_h.c
> @@ -227,113 +227,6 @@ int cleanup_swapfile(char *path)
>  	return 0;
>  }

> -/*
> - * Change user limit that the calling process can open
> - */
> -int setup_ulimit_fnum(rlim_t newlim, rlim_t * oldlim)
> -{
> -	int rc;
> -	struct rlimit rlim;
> -
> -	rc = getrlimit(RLIMIT_NOFILE, &rlim);
> -	if (rc < 0) {
> -		EPRINTF("getrlimit failed.\n");
> -		return -1;
> -	}
> -	*oldlim = rlim.rlim_cur;
> -	if (newlim > rlim.rlim_max) {
> -		EPRINTF("can't set ulimit value: %ld.\n", newlim);
> -		return -1;
> -	}
> -	rlim.rlim_cur = newlim;
> -	rc = setrlimit(RLIMIT_NOFILE, &rlim);
> -	if (rc < 0) {
> -		EPRINTF("setrlimit failed.\n");
> -		return -1;
> -	}
> -	return 0;
> -}
> -
> -int cleanup_ulimit_fnum(rlim_t oldlim)
> -{
> -	int rc;
> -	struct rlimit rlim;
> -
> -	rc = getrlimit(RLIMIT_NOFILE, &rlim);
> -	if (rc < 0) {
> -		EPRINTF("getrlimit failed.\n");
> -		return -1;
> -	}
> -	if (oldlim > rlim.rlim_max) {
> -		EPRINTF("can't set ulimit value: %ld.\n", oldlim);
> -		return -1;
> -	}
> -	rlim.rlim_cur = oldlim;
> -	rc = setrlimit(RLIMIT_NOFILE, &rlim);
> -	if (rc < 0) {
> -		EPRINTF("setrlimit failed.\n");
> -		return -1;
> -	}
> -	return 0;
> -}
> -
> -/*
> - * Change /proc or /sys setting
> - */
> -int setup_proc_fs(char *path, int newval, int *oldval)
> -{
> -	int fd = -1, rc, len;
> -	char buf[32];
> -
> -	fd = open(path, O_RDWR);
> -	if (fd < 0) {
> -		EPRINTF("open %s failed.\n", path);
> -		return -1;
> -	}
> -
> -	do {
> -		rc = read(fd, buf, 32);
> -	} while (rc < 0 && errno == EAGAIN);
> -	if (rc < 0) {
> -		EPRINTF("read failed.\n");
> -		close(fd);
> -		return -1;
> -	}
> -
> -	*oldval = atoi(buf);
> -	sprintf(buf, "%d\n", newval);
> -	len = strlen(buf);
> -	rc = write(fd, buf, len);
> -	close(fd);
> -	if (rc != len) {
> -		EPRINTF("write failed.\n");
> -		return -1;
> -	}
> -	return 0;
> -}
> -
> -int cleanup_proc_fs(char *path, int oldval)
> -{
> -	int fd = -1, rc, len;
> -	char buf[32];
> -
> -	fd = open(path, O_RDWR);
> -	if (fd < 0) {
> -		EPRINTF("open %s failed.\n", path);
> -		return -1;
> -	}
> -
> -	sprintf(buf, "%d\n", oldval);
> -	len = strlen(buf);
> -	rc = write(fd, buf, len);
> -	close(fd);
> -	if (rc != len) {
> -		EPRINTF("write failed.\n");
> -		return -1;
> -	}
> -	return 0;
> -}
> -
>  #if 0
>  /*
>   * Check max nodes from /sys/devices/system/node/node* files (for NUMA)
> diff --git a/testcases/kernel/syscalls/utils/include_j_h.h b/testcases/kernel/syscalls/utils/include_j_h.h
> index ff6aaf4..742d964 100644
> --- a/testcases/kernel/syscalls/utils/include_j_h.h
> +++ b/testcases/kernel/syscalls/utils/include_j_h.h
> @@ -135,12 +135,6 @@ int cleanup_file(char *path);
>  int setup_swapfile(char *testdir, char *fname, char *path, size_t size);
>  int cleanup_swapfile(char *path);

> -int setup_ulimit_fnum(rlim_t newlim, rlim_t *oldlim);
> -int cleanup_ulimit_fnum(rlim_t oldlim);
> -
> -int setup_proc_fs(char *path, int newval, int *oldval);
> -int cleanup_proc_fs(char *path, int oldval);
> -
>  #define QUEUE_NAME	"/test_mqueue"
>  pid_t create_echo_msg_proc(void);

Please don't review this, I'll create v2 with SAFE_GETPWNAM() in setup().

Kind regards,
Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161205/b30a2dd3/attachment-0001.sig>
