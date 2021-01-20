From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 20 Jan 2021 11:55:05 +0800
Subject: [LTP] [PATCH 1/1] mallopt01: Rewrite to new API
In-Reply-To: <20210119132427.6342-1-pvorel@suse.cz>
References: <20210119132427.6342-1-pvorel@suse.cz>
Message-ID: <6007A999.7090903@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> From: Petr Vorel<petr.vorel@gmail.com>
>
> Detect non-POSIX mallopt() support with autotools.
>
> NOTE: mallopt() is supported in glibc and uClibc.
>
> Signed-off-by: Petr Vorel<petr.vorel@gmail.com>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   configure.ac                                  |   1 +
>   testcases/kernel/syscalls/mallopt/mallopt01.c | 158 ++++++------------
>   2 files changed, 51 insertions(+), 108 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index e44e25cc6..17ef76c1a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -94,6 +94,7 @@ AC_CHECK_FUNCS_ONCE([ \
>       io_uring_register \
>       io_uring_enter \
>       kcmp \
> +    mallopt \
If glibc/ulibc supports mallopt, it also should support mallinfo. So 
only check mallopt, I think it is ok.
I guess musl libc doesn't support it, is it right?
>       mkdirat \
>       mknodat \
>       modify_ldt \
> diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
> index 14e26dd81..f6999bd52 100644
> --- a/testcases/kernel/syscalls/mallopt/mallopt01.c
> +++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
> @@ -1,155 +1,97 @@
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
> + * Copyright (c) Linux Test Project, 2003-2021
> + * Copyright (c) International Business Machines  Corp., 2002
> + * 01/02/2003	Port to LTP	<avenkat@us.ibm.com>
> + * 06/30/2001	Port to Linux<nsharoff@us.ibm.com>
>    */
>
> -/* 01/02/2003	Port to LTP	avenkat@us.ibm.com*/
> -/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
> -
> -/*
> - * NAME
> - *	mallopt
> - *
> - * CALLS
> - *	malloc(3x), mallopt(3x), mallinfo(3x).
> - *
> - * ALGORITHM
> - *	Set options, malloc memory, and check resource ussage.
> +/*\
> + * [DESCRIPTION]
>    *
> - * RESTRICTIONS
> - */
> + * Basic mallinfo() and mallopt() testing (M_MXFAST, M_NLBLKS).
> +\*/
I see glibc code, it said "Only one of these (M_MXFAST) is used
   in this malloc. The others (M_NLBLKS, M_GRAIN, M_KEEP) don't apply,
   so setting them has no effect. But this malloc also supports four
   other options in mallopt. "

Also, I don't see M_NLBLKS handle in __libc_mallopt.

I think that is why man-pages said "The SVID defined
options M_MXFAST, M_NLBLKS, M_GRAIN, and M_KEEP, but only the first of 
these is implemented in glibc."

I guess we can remove useless M_NLBLKS test.
>
> -#ifdef CONFIG_COLDFIRE
> -#define __MALLOC_STANDARD__
> -#endif
> -#include<errno.h>
> -/*
> - * NOTE: struct mallinfo is only exported via malloc.h (not stdlib.h), even
> - * though it's an obsolete header for malloc(3).
> - *
> - * Inconsistencies rock.
> - */
>   #include<malloc.h>
> -#include<stdio.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -#define FAILED 0
> -#define PASSED 1
> -#define MAX_FAST_SIZE	(80 * sizeof(size_t) / 4)
>
> -int local_flag = PASSED;
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>
> -char *TCID = "mallopt01";
> -int block_number;
> -FILE *temp;
> -int TST_TOTAL = 6;
> -extern int tst_COUNT;		/* Test Case counter for tst_routines */
> +#ifdef HAVE_MALLOPT
>
> -void printinfo();
> +#define MAX_FAST_SIZE	(80 * sizeof(size_t) / 4)
>
> -#if defined(__GLIBC__)
>   struct mallinfo info;
>
> -int main(int argc, char *argv[])
> +void print_mallinfo(void)
>   {
> -	char *buf;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	tst_tmpdir();
> +	tst_res(TINFO, "mallinfo structure:");
> +	tst_res(TINFO, "mallinfo.arena = %d", info.arena);
> +	tst_res(TINFO, "mallinfo.ordblks = %d", info.ordblks);
> +	tst_res(TINFO, "mallinfo.smblks = %d", info.smblks);
> +	tst_res(TINFO, "mallinfo.hblkhd = %d", info.hblkhd);
> +	tst_res(TINFO, "mallinfo.hblks = %d", info.hblks);
> +	tst_res(TINFO, "mallinfo.usmblks = %d", info.usmblks);
> +	tst_res(TINFO, "mallinfo.fsmblks = %d", info.fsmblks);
> +	tst_res(TINFO, "mallinfo.uordblks = %d", info.uordblks);
> +	tst_res(TINFO, "mallinfo.fordblks = %d", info.fordblks);
> +	tst_res(TINFO, "mallinfo.keepcost = %d", info.keepcost);
> +}
>
> -	buf = SAFE_MALLOC(NULL, 20480);
> +void test_mallopt(void)
> +{
> +	char *buf;
>
> -	/*
> -	 * Check space usage.
> -	 */
> +	buf = SAFE_MALLOC(20480);
>
>   	info = mallinfo();
The lastest mallinfo man-pages said " However, the older function, 
mallinfo(), is deprecated since the type used for the fields is too 
small". The mallinfo2 structure used size_t data type instead of int 
data type in mallinfo struct. Maybe we can add a new test for it.
>   	if (info.uordblks<  20480) {
> -		printinfo();
> -		tst_resm(TFAIL, "mallinfo failed: uordblks<  20K");
> +		print_mallinfo();
> +		tst_res(TFAIL, "mallinfo() failed: uordblks<  20K");
>   	}
>   	if (info.smblks != 0) {
> -		printinfo();
> -		tst_resm(TFAIL, "mallinfo failed: smblks != 0");
> +		print_mallinfo();
> +		tst_res(TFAIL, "mallinfo() failed: smblks != 0");
>   	}
>   	if (info.uordblks>= 20480&&  info.smblks == 0)
> -		tst_resm(TPASS, "mallinfo() succeeded");
> -	free(buf);
> +		tst_res(TPASS, "mallinfo() succeeded");
>
> -	/*
> -	 * Test mallopt's M_MXFAST and M_NLBLKS cmds.
> -	 */
> +	free(buf);
>
>   	if (mallopt(M_MXFAST, MAX_FAST_SIZE) == 0)
> -		tst_resm(TFAIL, "mallopt(M_MXFAST, %d) failed", (int)MAX_FAST_SIZE);
> +		tst_res(TFAIL, "mallopt(M_MXFAST, %d) failed", (int)MAX_FAST_SIZE);
>   	else
> -		tst_resm(TPASS, "mallopt(M_MXFAST, %d) succeeded", (int)MAX_FAST_SIZE);
> +		tst_res(TPASS, "mallopt(M_MXFAST, %d) succeeded", (int)MAX_FAST_SIZE);
>
>   	if (mallopt(M_NLBLKS, 50) == 0)
> -		tst_resm(TFAIL, "mallopt(M_NLBLKS, 50) failed");
> +		tst_res(TFAIL, "mallopt(M_NLBLKS, 50) failed");
>   	else
> -		tst_resm(TPASS, "mallopt(M_NLBLKS, 50) succeeded");
> +		tst_res(TPASS, "mallopt(M_NLBLKS, 50) succeeded");
>
>   	if ((buf = malloc(1024)) == NULL) {
> -		tst_resm(TFAIL, "malloc(1024) failed");
> +		tst_res(TFAIL, "malloc(1024) failed");
>   	} else {
> -		tst_resm(TPASS, "malloc(1024) succeeded");
> +		tst_res(TPASS, "malloc(1024) succeeded");
>   		free(buf);
>   	}
>
>   	if (mallopt(M_MXFAST, 0) == 0)
> -		tst_resm(TFAIL, "mallopt(M_MXFAST, 0) failed");
> +		tst_res(TFAIL, "mallopt(M_MXFAST, 0) failed");
>   	else
> -		tst_resm(TPASS, "mallopt(M_MXFAST, 0) succeeded");
> +		tst_res(TPASS, "mallopt(M_MXFAST, 0) succeeded");
>
>   	if ((buf = malloc(1024)) == NULL) {
> -		tst_resm(TFAIL, "malloc(1024) failed");
> +		tst_res(TFAIL, "malloc(1024) failed");
>   	} else {
> -		tst_resm(TPASS, "malloc(1024) succeeded");
> +		tst_res(TPASS, "malloc(1024) succeeded");
>   		free(buf);
>   	}
> -
> -	unlink("core");
> -	tst_rmdir();
> -	tst_exit();
>   }
>
> -void printinfo(void)
> -{
> -
> -	fprintf(stderr, "mallinfo structure:\n");
> -	fprintf(stderr, "mallinfo.arena = %d\n", info.arena);
> -	fprintf(stderr, "mallinfo.ordblks = %d\n", info.ordblks);
> -	fprintf(stderr, "mallinfo.smblks = %d\n", info.smblks);
> -	fprintf(stderr, "mallinfo.hblkhd = %d\n", info.hblkhd);
> -	fprintf(stderr, "mallinfo.hblks = %d\n", info.hblks);
> -	fprintf(stderr, "mallinfo.usmblks = %d\n", info.usmblks);
> -	fprintf(stderr, "mallinfo.fsmblks = %d\n", info.fsmblks);
> -	fprintf(stderr, "mallinfo.uordblks = %d\n", info.uordblks);
> -	fprintf(stderr, "mallinfo.fordblks = %d\n", info.fordblks);
> -	fprintf(stderr, "mallinfo.keepcost = %d\n", info.keepcost);
> -}
> +static struct tst_test test = {
> +	.test_all = test_mallopt,
> +};
>
>   #else
> -int main(void)
> -{
> -	tst_brkm(TCONF, NULL, "mallopt defined only for glibc");
> -}
> +TST_TEST_TCONF("system doesn't implement non-POSIX mallopt()");
>   #endif



