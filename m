From: Xiao Yang <ice_yangxiao@163.com>
Date: Sat, 18 Sep 2021 18:38:21 +0800
Subject: [LTP] [PATCH v4 4/5] syscalls/dup2/dup205: Convert to new API
In-Reply-To: <20210918072609.8576-5-qi.fuli@fujitsu.com>
References: <20210918072609.8576-1-qi.fuli@fujitsu.com>
 <20210918072609.8576-5-qi.fuli@fujitsu.com>
Message-ID: <6a9e0bf7-4ab0-9a3b-40b7-cfde3922b1a9@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 9/18/21 3:26 PM, QI Fuli wrote:
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup205.c | 168 ++++++++----------------
>   1 file changed, 52 insertions(+), 116 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
> index 0b324531f..9942e63a7 100644
> --- a/testcases/kernel/syscalls/dup2/dup205.c
> +++ b/testcases/kernel/syscalls/dup2/dup205.c
> @@ -1,134 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2002
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
> + * Copyright (c) International Business Machines  Corp., 2002
> + * Ported from SPIE, section2/iosuite/dup6.c, by Airong Zhang
>    */
>   
> -/* Ported from SPIE, section2/iosuite/dup6.c, by Airong Zhang */
> -
> -/*======================================================================
> -	=================== TESTPLAN SEGMENT ===================
> ->KEYS:  < dup2()
> ->WHAT:  < Does dup return -1 on the 21st file?
> ->HOW:   < Create up to _NFILE files and check for -1 return on the
> -	< next attempt
> -	< Should check NOFILE as well as _NFILE.  19-Jun-84 Dale.
> ->BUGS:  <
> -======================================================================*/
> +/*\
> + * [Description]
> + * Negative test for dup2() with max open file descriptors.
> + */
>   
> -#include <sys/param.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <errno.h>
> -#include <fcntl.h>
> +#include <stdlib.h>
>   #include <stdio.h>
>   #include <unistd.h>
> -#include "test.h"
> -
> -char *TCID = "dup205";
> -int TST_TOTAL = 1;
> -int *fildes;
> -int min;
> -int local_flag;
> -
> -#define PASSED 1
> -#define FAILED 0
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -int main(int ac, char *av[])
> -{
> -	int ifile;
> -	char pfilname[40];
> -	int serrno;
> -
> -	int lc;
> -
> -	ifile = -1;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	local_flag = PASSED;
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>   
> -		sprintf(pfilname, "./dup205.%d\n", getpid());
> -		unlink(pfilname);
> -		serrno = 0;
> -		if ((fildes[0] = creat(pfilname, 0666)) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "creat failed");
> -		else {
> -			fildes[fildes[0]] = fildes[0];
> -			for (ifile = fildes[0] + 1; ifile < min + 10; ifile++) {
> -				if ((fildes[ifile] = dup2(fildes[ifile - 1],
> -							  ifile)) == -1) {
> -					serrno = errno;
> -					break;
> -				} else {
> -					if (fildes[ifile] != ifile) {
> -						tst_brkm(TFAIL, cleanup,
> -							 "got wrong descriptor "
> -							 "number back (%d != %d)",
> -							 fildes[ifile], ifile);
> -					}
> -				}
> -			}	/* end for */
> -			if (ifile < min) {
> -				tst_resm(TFAIL, "Not enough files duped");
> -				local_flag = FAILED;
> -			} else if (ifile > min) {
> -				tst_resm(TFAIL, "Too many files duped");
> -				local_flag = FAILED;
> -			}
> -			if (serrno != EBADF && serrno != EMFILE &&
> -			    serrno != EINVAL) {
> -				tst_resm(TFAIL, "bad errno on dup2 failure");
> -				local_flag = FAILED;
> -			}
> -		}
> -		unlink(pfilname);
> -		for (ifile = fildes[0]; ifile < min + 10; ifile++)
> -			close(fildes[ifile]);
> -		if (local_flag == PASSED) {
> -			tst_resm(TPASS, "Test passed.");
> -		} else {
> -			tst_resm(TFAIL, "Test failed.");
> -		}
> -
> -	}
> -	cleanup();
> -	tst_exit();
> -}
> +static int *fildes;
> +static int min;
> +static char pfilname[40];
>   
>   static void setup(void)
>   {
> -	tst_tmpdir();
> -
>   	min = getdtablesize();	/* get number of files allowed open */
> -	fildes = malloc((min + 10) * sizeof(int));
> -	if (fildes == NULL)
> -		tst_brkm(TBROK | TERRNO, cleanup, "malloc error");
> +	fildes = SAFE_MALLOC((min + 10) * sizeof(int));
> +	sprintf(pfilname, "./dup205.%d\n", getpid());
dup204?
>   }
>   
>   static void cleanup(void)
>   {
>   	if (fildes != NULL)
>   		free(fildes);
> -	tst_rmdir();
>   }
> +
> +static void run(void)
> +{
> +	int ifile = -1;
> +
> +	fildes[0] = SAFE_CREAT(pfilname, 0666);
> +	fildes[fildes[0]] = fildes[0];
> +	for (ifile = fildes[0] + 1; ifile < min + 10; ifile++) {
> +		TEST(dup2(fildes[ifile - 1], ifile));
> +		if ((fildes[ifile] = TST_RET) == -1)
> +			break;
> +		if (fildes[ifile] != ifile)
> +			tst_brk(TFAIL, "got wrong descriptor number back "
> +				"(%d != %d)", fildes[ifile], ifile);
> +	}
> +
> +	if (TST_ERR != EBADF && TST_ERR != EMFILE && TST_ERR != EINVAL)
> +		tst_res(TFAIL, "bad errno on dup2 failure");
> +
> +	if (ifile < min)
> +		tst_res(TFAIL, "Not enough files duped");
> +	else if (ifile > min)
> +		tst_res(TFAIL, "Too many files duped");
> +	else
> +		tst_res(TPASS, "Test passed.");

The logic is wrong. (You changed the old logic.)

If TST_ERR != either of three errno and ifile == min, dup204 will show 
strange messages:

-------------------------------

tst_res(TFAIL, "bad errno on dup2 failure");
tst_res(TPASS, "Test passed.");

-------------------------------

> +
> +	SAFE_UNLINK(pfilname);
> +	for (ifile = fildes[0]; ifile < min + 10; ifile++)
> +		close(fildes[ifile]);
> +}
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

