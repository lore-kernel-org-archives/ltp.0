From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Fri, 17 Sep 2021 05:52:52 +0000
Subject: [LTP] [PATCH 1/2] syscalls/dup3_01: Rewrite and convert to new
 API
In-Reply-To: <20210916144605.36204-2-qi.fuli@fujitsu.com>
References: <20210916144605.36204-1-qi.fuli@fujitsu.com>
 <20210916144605.36204-2-qi.fuli@fujitsu.com>
Message-ID: <61442D4A.7020404@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Qi
> From: QI Fuli<qi.fuli@fujitsu.com>
>
>      - divide into two testcases
>      - convert to new API
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup3/dup3_01.c | 157 ++++++++---------------
>   1 file changed, 50 insertions(+), 107 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup3/dup3_01.c b/testcases/kernel/syscalls/dup3/dup3_01.c
> index 6a44ec809..9a233f51b 100644
> --- a/testcases/kernel/syscalls/dup3/dup3_01.c
> +++ b/testcases/kernel/syscalls/dup3/dup3_01.c
> @@ -1,120 +1,63 @@
> -/******************************************************************************/
> -/*                                                                            */
> -/* Copyright (c) Ulrich Drepper<drepper@redhat.com>                           */
> -/* Copyright (c) International Business Machines  Corp., 2009                 */
> -/*                                                                            */
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> -/* (at your option) any later version.                                        */
> -/*                                                                            */
> -/* This program is distributed in the hope that it will be useful,            */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> -/* the GNU General Public License for more details.                           */
> -/*                                                                            */
> -/* You should have received a copy of the GNU General Public License          */
> -/* along with this program;  if not, write to the Free Software               */
> -/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
> -/*                                                                            */
> -/******************************************************************************/
> -/******************************************************************************/
> -/*                                                                            */
> -/* File:        dup3_01.c                                                     */
> -/*                                                                            */
> -/* Description: This Program tests the new system call introduced in 2.6.27.  */
> -/*              Ulrich?s comment as in:                                       */
> -/* http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=336dd1f70ff62d7dd8655228caed4c5bfc818c56 */
> -/*              says:                                                         */
> -/* This patch adds the new dup3 syscall.  It extends the old dup2 syscall by  */
> -/* one parameter which is meant to hold a flag value.  Support for the        */
> -/* O_CLOEXEC flag is added in this patch. The following test must be adjusted */
> -/* for architectures other than x86 and x86-64 and in case the                */
> -/* syscall numbers changed.                                                   */
> -/*                                                                            */
> -/* Usage:<for command-line>                                                  */
> -/* dup3_01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                               */
> -/*      where,  -c n : Run n copies concurrently.                             */
> -/*              -e   : Turn on errno logging.                                 */
> -/*              -i n : Execute test n times.                                  */
> -/*              -I x : Execute test for x seconds.                            */
> -/*              -P x : Pause for x seconds between iterations.                */
> -/*              -t   : Turn on syscall timing.                                */
> -/*                                                                            */
> -/* Total Tests: 1                                                             */
> -/*                                                                            */
> -/* Test Name:   dup3_01                                                       */
> -/*                                                                            */
> -/* Author:      Ulrich Drepper<drepper@redhat.com>                            */
> -/*                                                                            */
> -/* History:     Created - Jan 13 2009 - Ulrich Drepper<drepper@redhat.com>    */
> -/*              Ported to LTP                                                 */
> -/*                      - Jan 13 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
> -/******************************************************************************/
> -#include<fcntl.h>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Ulrich Drepper<drepper@redhat.com>
> + * Copyright (c) International Business Machines  Corp., 2009
> + *	Created - Jan 13 2009 - Ulrich Drepper<drepper@redhat.com>
> + *	Ported to LTP - Jan 13 2009 - Subrata<subrata@linux.vnet.ibm.com>
> + */
> +
> +/*\
> + * [Description]
> + * 	Testcase to check whether dup3() supports O_CLOEXEC flag.
> + */
> +
>   #include<stdio.h>
> -#include<time.h>
> -#include<unistd.h>
> -#include<sys/syscall.h>
> +#include<stdbool.h>
>   #include<errno.h>
>
> -#include "test.h"
> -#include "lapi/fcntl.h"
> +#include "tst_test.h"
>   #include "lapi/syscalls.h"
> -
> -char *TCID = "dup3_01";
> -int TST_TOTAL = 1;
> -
> -void cleanup(void)
> +#include "tst_safe_macros.h"
> +
> +static struct tcase {
> +	int oflag;
> +	bool tflag;
This variable(tflag)looks confusing. Can we use a meaningful name?

> +	char *desc;
> +} tcases [] = {
> +	{0, true, "dup3(0)"},
> +	{O_CLOEXEC, false, "dup3(O_CLOEXEC)"},
I prefer to use dup3(1,4,0) and dup3(1,4,O_CLOEXEC) because it is more 
clear.
> +};
> +
> +static void setup(void)
>   {
> -	tst_rmdir();
> -}
> -
> -void setup(void)
> -{
> -	TEST_PAUSE;
> -	tst_tmpdir();
> -}
> +	if ((tst_kvercmp(2, 6, 27))<  0)
> +		tst_brk(TCONF,
> +			"This test can only run on kernels 2.6.27 and higher");
Lastest upstream kernel has reached to 5.15-rc1 and we don't need to 
check this very old kernel version. So we can remove this check.

ps: user who use old distros can use old ltp release to test. I don't 
want to keep it.
> +};
>
> -int main(int argc, char *argv[])
> +static void run(unsigned int i)
>   {
>   	int fd, coe;
coe represent what? ret looks better.
> +	struct tcase *tc = tcases + i;
>
> -	tst_parse_opts(argc, argv, NULL, NULL);
> +	TEST(tst_syscall(__NR_dup3, 1, 4, tc->oflag));
I think this case was introduced by long time ago and glibc doesn't 
support it so case uses syscall directly. Now, I think using glicb 
wrapper is enough.
>
> -	if ((tst_kvercmp(2, 6, 27))<  0)
> -		tst_brkm(TCONF, NULL,
> -			 "This test can only run on kernels that are 2.6.27 and higher");
> -	setup();
> +	fd = TST_RET;
> +	if (TST_RET == -1)
> +		tst_brk(TFAIL | TTERRNO, "%s failed", tc->desc);
We don't need to break and should run the second case.
Please use tst_res and return.
>
> -	fd = ltp_syscall(__NR_dup3, 1, 4, 0);
> -	if (fd == -1) {
> -		tst_brkm(TFAIL | TERRNO, cleanup, "dup3(0) failed");
> -	}
> -	coe = fcntl(fd, F_GETFD);
> -	if (coe == -1) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "fcntl failed");
> -	}
> -	if (coe&  FD_CLOEXEC) {
> -		tst_brkm(TFAIL, cleanup, "dup3(0) set close-on-exec flag");
> -	}
> -	close(fd);
> +	coe = SAFE_FCNTL(fd, F_GETFD);
> +	if ((coe&  FD_CLOEXEC) == tc->tflag)
> +		tst_brk(TFAIL, "%s set close-on-exec flag", tc->desc);
Use tst_res.
> +	else
> +		tst_res(TPASS, "%s PASSED", tc->desc);
>
> -	fd = ltp_syscall(__NR_dup3, 1, 4, O_CLOEXEC);
> -	if (fd == -1) {
> -		tst_brkm(TFAIL | TERRNO, cleanup, "dup3(O_CLOEXEC) failed");
> -	}
> -	coe = fcntl(fd, F_GETFD);
> -	if (coe == -1) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "fcntl failed");
> -	}
> -	if ((coe&  FD_CLOEXEC) == 0) {
> -		tst_brkm(TFAIL, cleanup,
> -			 "dup3(O_CLOEXEC) set close-on-exec flag");
> -	}
> -	close(fd);
> -	tst_resm(TPASS, "dup3(O_CLOEXEC) PASSED");
> +	SAFE_CLOSE(fd);
> +};
>
> -	cleanup();
> -	tst_exit();
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_tmpdir = 1,
Remove.

Best Regards
Yang Xu
> +	.test = run,
> +};
>
>
>
>
