From: Xiao Yang <ice_yangxiao@163.com>
Date: Sun, 19 Sep 2021 23:48:08 +0800
Subject: [LTP] [PATCH v5 4/5] syscalls/dup2/dup205: Convert to new API
In-Reply-To: <20210918121114.10694-5-qi.fuli@fujitsu.com>
References: <20210918121114.10694-1-qi.fuli@fujitsu.com>
 <20210918121114.10694-5-qi.fuli@fujitsu.com>
Message-ID: <d5e3c2f5-1a32-af4c-cd63-518b997193d4@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 9/18/21 8:11 PM, QI Fuli wrote:
> From: QI Fuli <qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup205.c | 171 ++++++++----------------
>   1 file changed, 55 insertions(+), 116 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
> index 0b324531f..e6fc175c3 100644
> --- a/testcases/kernel/syscalls/dup2/dup205.c
> +++ b/testcases/kernel/syscalls/dup2/dup205.c
> @@ -1,134 +1,73 @@
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
Please initialize fildes to 0.
> +	sprintf(pfilname, "./dup205.%d\n", getpid());
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
> +	if (TST_ERR != EBADF && TST_ERR != EMFILE && TST_ERR != EINVAL) {
> +		tst_res(TFAIL, "bad errno on dup2 failure");
> +		goto close;
> +	}
> +
> +	if (ifile < min)
> +		tst_res(TFAIL, "Not enough files duped");
> +	else if (ifile > min)
> +		tst_res(TFAIL, "Too many files duped");
> +	else
> +		tst_res(TPASS, "Test passed.");

I perfer to keep the previous logic:

1) compare ifile and min firstly.

2) check errno secondly.

BTW: remove the full stop for "Test passed."

> +
> +close:
> +	SAFE_UNLINK(pfilname);
> +	for (ifile = fildes[0]; ifile < min + 10; ifile++)
> +		close(fildes[ifile]);

There is an very old issue that the fd of stdout is closed here.

With this issue, dup205 -i 5 shows only one message:

------------------------------

tst_test.c:1353: TINFO: Timeout per run is 0h 05m 00s
dup205.c:60: TPASS: Test passed.

------------------------------

Please close the fds which are not equal to 0.

> +}
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

