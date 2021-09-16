From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 16 Sep 2021 08:42:05 +0000
Subject: [LTP] [PATCH v2 4/4] syscalls/dup2/dup205: Convert to new API
In-Reply-To: <20210915155152.8515-5-qi.fuli@fujitsu.com>
References: <20210915155152.8515-1-qi.fuli@fujitsu.com>
 <20210915155152.8515-5-qi.fuli@fujitsu.com>
Message-ID: <61430371.4010209@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Qi
> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup205.c | 167 ++++++++----------------
>   1 file changed, 57 insertions(+), 110 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
> index 0b324531f..1f4796659 100644
> --- a/testcases/kernel/syscalls/dup2/dup205.c
> +++ b/testcases/kernel/syscalls/dup2/dup205.c
> @@ -1,134 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
>   /*
> + * Copyright (c) International Business Machines  Corp., 2002
>    *
> - *   Copyright (c) International Business Machines  Corp., 2002
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + */
> +
> +/*\
> + * [Description]
>    *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> + * Negative test for dup2() with max open file descriptors.
>    *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>    */
>
>   /* Ported from SPIE, section2/iosuite/dup6.c, by Airong Zhang */
>
> -/*======================================================================
> -	=================== TESTPLAN SEGMENT ===================
> ->KEYS:<  dup2()
> ->WHAT:<  Does dup return -1 on the 21st file?
> ->HOW:<  Create up to _NFILE files and check for -1 return on the
> -	<  next attempt
> -	<  Should check NOFILE as well as _NFILE.  19-Jun-84 Dale.
> ->BUGS:<
> -======================================================================*/
> -
> -#include<sys/param.h>
> -#include<sys/types.h>
> -#include<sys/stat.h>
> -#include<errno.h>
> -#include<fcntl.h>
> +#include<stdlib.h>
>   #include<stdio.h>
>   #include<unistd.h>
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
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>
> -	local_flag = PASSED;
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		sprintf(pfilname, "./dup205.%d\n", getpid());
> -		unlink(pfilname);
> -		serrno = 0;
> -		if ((fildes[0] = creat(pfilname, 0666)) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "creat failed");
> -		else {
> -			fildes[fildes[0]] = fildes[0];
> -			for (ifile = fildes[0] + 1; ifile<  min + 10; ifile++) {
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
> -			if (ifile<  min) {
> -				tst_resm(TFAIL, "Not enough files duped");
> -				local_flag = FAILED;
> -			} else if (ifile>  min) {
> -				tst_resm(TFAIL, "Too many files duped");
> -				local_flag = FAILED;
> -			}
> -			if (serrno != EBADF&&  serrno != EMFILE&&
> -			    serrno != EINVAL) {
> -				tst_resm(TFAIL, "bad errno on dup2 failure");
> -				local_flag = FAILED;
> -			}
> -		}
> -		unlink(pfilname);
> -		for (ifile = fildes[0]; ifile<  min + 10; ifile++)
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
>
>   static void setup(void)
>   {
> -	tst_tmpdir();
> -
>   	min = getdtablesize();	/* get number of files allowed open */
>   	fildes = malloc((min + 10) * sizeof(int));
>   	if (fildes == NULL)
> -		tst_brkm(TBROK | TERRNO, cleanup, "malloc error");
> +		tst_brk(TBROK | TERRNO, "malloc error");
We have SAFE_MALLOC marco.
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
> +	int ifile;
> +	char pfilname[40];
> +
> +	ifile = -1;
> +
> +	sprintf(pfilname, "./dup205.%d\n", getpid());
we can move it into setup function.

Best Regards
Yang Xu
> +	unlink(pfilname);
> +
> +	fildes[0] = SAFE_CREAT(pfilname, 0666);
> +	fildes[fildes[0]] = fildes[0];
> +	for (ifile = fildes[0] + 1; ifile<  min + 10; ifile++) {
> +		TEST(dup2(fildes[ifile - 1], ifile));
> +		if ((fildes[ifile] = TST_RET) == -1)
> +			break;
> +		if (fildes[ifile] != ifile)
> +			tst_brk(TFAIL, "got wrong descriptor number back "
> +				"(%d != %d)", fildes[ifile], ifile);
> +	}	/* end for */
> +
> +	if (TST_ERR != EBADF)
> +		tst_res(TFAIL, "bad errno on dup2 failure");
> +
> +	if (ifile<  min)
> +		tst_res(TFAIL, "Not enough files duped");
> +	else if (ifile>  min)
> +		tst_res(TFAIL, "Too many files duped");
> +	else
> +		tst_res(TPASS, "Test passed.");
> +
> +	unlink(pfilname);
> +	for (ifile = fildes[0]; ifile<  min + 10; ifile++)
> +		close(fildes[ifile]);
> +}
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
