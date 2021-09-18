From: Xiao Yang <ice_yangxiao@163.com>
Date: Sat, 18 Sep 2021 18:24:48 +0800
Subject: [LTP] [PATCH v4 2/5] syscalls/dup2/dup202: Convert to new API
 and merge dup204 into dup202
In-Reply-To: <20210918072609.8576-3-qi.fuli@fujitsu.com>
References: <20210918072609.8576-1-qi.fuli@fujitsu.com>
 <20210918072609.8576-3-qi.fuli@fujitsu.com>
Message-ID: <a2a62fbf-f1a1-30cf-d95a-a9f51cf4df9e@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 9/18/21 3:26 PM, QI Fuli wrote:
> From: QI Fuli <qi.fuli@fujitsu.com>
>
>   - merge dup204 (check whether the inode number are the same) into dup202
>
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup202.c | 205 ++++++++----------------
>   testcases/kernel/syscalls/dup2/dup204.c | 128 ---------------
>   2 files changed, 64 insertions(+), 269 deletions(-)
>   delete mode 100644 testcases/kernel/syscalls/dup2/dup204.c
>
> diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
> index c87769fa9..1d179f1d7 100644
> --- a/testcases/kernel/syscalls/dup2/dup202.c
> +++ b/testcases/kernel/syscalls/dup2/dup202.c
> @@ -1,167 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
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
>    */
>   
> -/*
> - * NAME
> - *	dup202.c
> +/*\
> + * [Description]
>    *
> - * DESCRIPTION
> - *	Is the access mode the same for both file descriptors?
> - *		0: read only ?	"0444"
> - *		1: write only ? "0222"
> - *		2: read/write ? "0666"
> - *
> - * ALGORITHM
> - *	Creat a file with each access mode; dup each file descriptor;
> - *	stat each file descriptor and compare modes of each pair
> - *
> - * USAGE:  <for command-line>
> - *  dup202 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	None
> + * Test whether the access mode and inode number are the same for both file
> + * descriptors.
> + * Is the access mode the same for both file descriptors?

There two descriptions seem redundant.

> + * - 0: read only ? "0444"
> + * - 1: write only ? "0222"
> + * - 2: read/write ? "0666"
>    */
>   
> -#include <sys/types.h>
> -#include <sys/stat.h>
>   #include <errno.h>
> -#include <fcntl.h>
>   #include <stdio.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "dup202";
> -int TST_TOTAL = 3;
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>   
> -void setup(void);
> -void cleanup(void);
> -
> -char testfile[40];
> -int fail;
> -int newfd;
> +static char testfile[40];
>   
>   /* set these to a known index into our local file descriptor table */
> -int duprdo = 10, dupwro = 20, duprdwr = 30;
> +static int duprdo = 10, dupwro = 20, duprdwr = 30;
>   
> -struct test_case_t {
> +static struct tcase {
>   	int *nfd;
>   	mode_t mode;
> -} TC[] = {
> -	/* The first test creat(es) a file with mode 0444 */
> -	{
> -	&duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
> -	    /* The second test creat(es) a file with mode 0222 */
> -	{
> -	&dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
> -	    /* The third test creat(es) a file with mode 0666 */
> -	{
> -	&duprdwr,
> -		    (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP | S_IWOTH)}
> +} tcases[]= {
> +	{&duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
> +	{&dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
> +	{&duprdwr, (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP | S_IWOTH)},
>   };
>   
> -int main(int ac, char **av)
> +static void setup(void)
>   {
> -	int lc;
> -	int i, ofd;
> -	struct stat oldbuf, newbuf;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/* loop through the test cases */
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			if ((ofd = creat(testfile, TC[i].mode)) == -1)
> -				tst_brkm(TBROK | TERRNO, cleanup,
> -					 "creat failed");
> -
> -			TEST(dup2(ofd, *TC[i].nfd));
> -
> -			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "call failed unexpectedly");
> -				continue;
> -			}
> -
> -			/* stat the original file */
> -			SAFE_FSTAT(cleanup, ofd, &oldbuf);
> -
> -			/* stat the duped file */
> -			SAFE_FSTAT(cleanup, *TC[i].nfd, &newbuf);
> -
> -			if (oldbuf.st_mode != newbuf.st_mode)
> -				tst_resm(TFAIL, "original and dup "
> -					 "modes do not match");
> -			else
> -				tst_resm(TPASS, "fstat shows new and "
> -					 "old modes are the same");
> -
> -			/* remove the file so that we can use it again */
> -			if (close(*TC[i].nfd) == -1)
> -				perror("close failed");
> -			if (close(ofd) == -1)
> -				perror("close failed");
> -			if (unlink(testfile) == -1)
> -				perror("unlink failed");
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	umask(0);
> +	sprintf(testfile, "dup202.%d", getpid());
>   }
>   
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void run(unsigned int i)
>   {
> +	int ofd, nfd;
> +	struct stat oldbuf, newbuf;
> +	struct tcase *tc = tcases + i;
>   
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	ofd = SAFE_CREAT(testfile, tc->mode);
> +	nfd = *tc->nfd;
>   
> -	tst_tmpdir();
> +	TEST(dup2(ofd, nfd));
>   
> -	(void)umask(0);
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "call failed unexpectedly");
> +		goto free;
> +	}
>   
> -	sprintf(testfile, "dup202.%d", getpid());
> +	/* stat the original file */
> +	SAFE_FSTAT(ofd, &oldbuf);
I think we need a cleanup() function to clean up some resource when 
SAFE_FSTAT () fails.
> +
> +	/* stat the duped file */
> +	SAFE_FSTAT(nfd, &newbuf);
> +
> +	if (oldbuf.st_mode != newbuf.st_mode)
> +		tst_res(TFAIL, "original(%o) and duped(%o) are not same mode",
> +					oldbuf.st_mode, newbuf.st_mode);
> +	else
> +		tst_res(TPASS, "original(%o) and duped(%o) are the same mode",
> +					oldbuf.st_mode, newbuf.st_mode);
> +
> +	if (oldbuf.st_ino != newbuf.st_ino)
> +		tst_res(TFAIL, "original(%ld) and duped(%ld) are not same inode",
> +					oldbuf.st_ino, newbuf.st_ino);
> +	else
> +		tst_res(TPASS, "original(%ld) and duped(%ld) are not same inode",
> +					oldbuf.st_ino, newbuf.st_ino);
> +
> +	SAFE_CLOSE(nfd);
> +free:
> +	SAFE_CLOSE(ofd);
> +	SAFE_UNLINK(testfile);
>   }
>   
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *	       completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +};
> diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
> deleted file mode 100644
> index a357bc17e..000000000
> --- a/testcases/kernel/syscalls/dup2/dup204.c
> +++ /dev/null
> @@ -1,128 +0,0 @@
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
> - * NAME
> - *	dup204.c
> - *
> - * DESCRIPTION
> - *	Testcase to check the basic functionality of dup2(2).
> - *
> - * ALGORITHM
> - *	attempt to call dup2() on read/write ends of a pipe
> - *
> - * USAGE:  <for command-line>
> - *  dup204 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * RESTRICTION
> - *	NONE
> - */
> -
> -#ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> -#endif
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <sys/stat.h>
> -#include <errno.h>
> -#include <signal.h>
> -#include <string.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -void setup();
> -void cleanup();
> -
> -char *TCID = "dup204";
> -int TST_TOTAL = 2;
> -
> -int fd[2];
> -int nfd[2];
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -	struct stat oldbuf, newbuf;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/* loop through the test cases */
> -		for (i = 0; i < TST_TOTAL; i++) {
> -			TEST(dup2(fd[i], nfd[i]));
> -
> -			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL, "call failed unexpectedly");
> -				continue;
> -			}
> -
> -			SAFE_FSTAT(cleanup, fd[i], &oldbuf);
> -			SAFE_FSTAT(cleanup, nfd[i], &newbuf);
> -
> -			if (oldbuf.st_ino != newbuf.st_ino)
> -				tst_resm(TFAIL, "original and duped "
> -					 "inodes do not match");
> -			else
> -				tst_resm(TPASS, "original and duped "
> -					 "inodes are the same");
> -
> -			SAFE_CLOSE(cleanup, TEST_RETURN);
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -void setup(void)
> -{
> -	fd[0] = -1;
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	SAFE_PIPE(cleanup, fd);
> -}
> -
> -void cleanup(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < (int)ARRAY_SIZE(fd); i++) {
> -		close(fd[i]);
> -		close(nfd[i]);
> -	}
> -
> -	tst_rmdir();
> -}

