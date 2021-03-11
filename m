From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 11 Mar 2021 17:16:37 +0800
Subject: [LTP] [PATCH v3] syscalls/chdir04: Convert to the new API
In-Reply-To: <20210311080648.311648-1-ruansy.fnst@fujitsu.com>
References: <20210311080648.311648-1-ruansy.fnst@fujitsu.com>
Message-ID: <6049DFF5.9000609@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ruan,

Pushed with three minor changes:
1) Remove space between tcases and [].
2) Printing "chdir(tcases[i].dir )" doesn't make sense so print 
"chdir()" directly.
3) Rename bad_dir to long_dir.

Best Regards,
Xiao Yang
On 2021/3/11 16:06, Shiyang Ruan wrote
> Signed-off-by: Shiyang Ruan<ruansy.fnst@fujitsu.com>
> ---
>   testcases/kernel/syscalls/chdir/chdir04.c | 174 ++++------------------
>   1 file changed, 27 insertions(+), 147 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel/syscalls/chdir/chdir04.c
> index f0420e4c9..e6b128652 100644
> --- a/testcases/kernel/syscalls/chdir/chdir04.c
> +++ b/testcases/kernel/syscalls/chdir/chdir04.c
> @@ -1,162 +1,42 @@
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
>    */
>
> -/*
> - * NAME
> - * 	chdir04.c
> - *
> - * DESCRIPTION
> - *	Testcase to test whether chdir(2) sets errno correctly.
> - *
> - * ALGORITHM
> - *	1.	Test for ENAMETOOLONG:
> - *		Create a bad directory name with length more than
> - *
> - *		VFS_MAXNAMELEN (Linux kernel variable), and attempt to
> - *		chdir(2) to it.
> - *
> - *	2.	Test for ENOENT:
> - *		Attempt to chdir(2) on a non-existent directory
> - *
> - *	3.	Test for EFAULT:
> - *		Pass an address which lies outside the address space of the
> - *		process, and expect an EFAULT.
> +/*\
> + * [DESCRIPTION]
>    *
> - * USAGE:<for command-line>
> - * chdir04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	NONE
> + * Testcase to test whether chdir(2) sets errno correctly.
>    */
>
> -#include<stdio.h>
>   #include<errno.h>
> -#include<sys/stat.h>
> -#include<sys/mman.h>
> -#include "test.h"
> -
> -char *TCID = "chdir04";
> -
> -char bad_dir[] =
> -    "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
> -
> -char noexist_dir[] = "/tmp/noexistdir";
> -
> -struct test_case_t {
> -	char *dname;
> -	int error;
> -} TC[] = {
> -	/*
> -	 * to test whether chdir() is setting ENAMETOOLONG if the
> -	 * directory is more than VFS_MAXNAMELEN
> -	 */
> -	{
> -	bad_dir, ENAMETOOLONG},
> -	    /*
> -	     * to test whether chdir() is setting ENOENT if the
> -	     * directory is not existing.
> -	     */
> -	{
> -	noexist_dir, ENOENT},
> -	    /*
> -	     * to test whether chdir() is setting EFAULT if the
> -	     * directory is an invalid address.
> -	     */
> -	{
> -	(void *)-1, EFAULT}
> +#include "tst_test.h"
> +
> +static char bad_dir[] = "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
> +static char noexist_dir[] = "/tmp/noexistdir";
> +
> +static struct tcase {
> +	char *dir;
> +	int exp_errno;
> +} tcases [] = {
> +	{bad_dir, ENAMETOOLONG},
> +	{noexist_dir, ENOENT},
> +	{0, EFAULT}, // bad_addr
>   };
>
> -int TST_TOTAL = ARRAY_SIZE(TC);
> -
> -int flag;
> -#define	FAILED	1
> -
> -void setup(void);
> -void cleanup(void);
> -
> -char *bad_addr = 0;
> -
> -int main(int ac, char **av)
> +static void verify_chdir(unsigned int i)
>   {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i<  TST_TOTAL; i++) {
> -
> -			TEST(chdir(TC[i].dname));
> -
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> -				continue;
> -			}
> -
> -			if (TEST_ERRNO == TC[i].error)
> -				tst_resm(TPASS | TTERRNO, "failed as expected");
> -			else {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "didn't fail as expected (expected %d)",
> -					 TC[i].error);
> -			}
> -		}
> -	}
> -	cleanup();
> -
> -	tst_exit();
> -
> +	TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno);
>   }
>
> -void setup(void)
> +static void setup(void)
>   {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -#ifdef UCLINUX
> -	bad_addr = mmap(0, 1, PROT_NONE,
> -			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	if (bad_addr == MAP_FAILED)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mmap() failed");
> -	TC[2].dname = bad_addr;
> -#endif
> +	tcases[2].dir = tst_get_bad_addr(NULL);
>   }
>
> -void cleanup(void)
> -{
> -	tst_rmdir();
> -
> -}
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test = verify_chdir,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +};



