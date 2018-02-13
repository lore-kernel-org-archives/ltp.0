From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Feb 2018 14:42:32 +0100
Subject: [LTP] [PATCH v2 2/5] lib/get_high_address.c: Add
 tst_get_bad_addr.h for new API
In-Reply-To: <1518511300-12371-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180212162258.GA26897@rei>
 <1518511300-12371-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1518511300-12371-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180213134232.GA5518@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/include/tst_get_bad_addr.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.

GPLv2+ is slightly pefered, see the license text in the tst_test.h.

> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program.
> + */
> +
> +#ifndef TST_GET_BAD_ADDR_H__
> +#define TST_GET_BAD_ADDR_H__
> +
> +/* Functions from lib/tst_get_bad_addr.c */
> +
> +void *tst_get_bad_addr(void);
> +
> +#endif	/* TST_GET_BAD_ADDR_H__ */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index eaf7a1f..af97b89 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -40,6 +40,7 @@
>  #include "tst_clone.h"
>  #include "tst_kernel.h"
>  #include "tst_minmax.h"
> +#include "tst_get_bad_addr.h"
>  
>  /*
>   * Reports testcase result.
> diff --git a/lib/get_high_address.c b/lib/get_high_address.c
> deleted file mode 100644
> index eed9cf1..0000000
> --- a/lib/get_high_address.c
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -/* $Header: /cvsroot/ltp/ltp/lib/get_high_address.c,v 1.6 2009/07/20 10:59:32 vapier Exp $ */
> -
> -/*
> - * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - * http://www.sgi.com
> - *
> - * For further information regarding this notice, see:
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - */
> -
> -#include <unistd.h>
> -
> -char *get_high_address(void)
> -{
> -	return (char *)sbrk(0) + (4 * getpagesize());
> -}
> diff --git a/lib/tst_get_bad_addr.c b/lib/tst_get_bad_addr.c
> new file mode 100644
> index 0000000..ab12ad1
> --- /dev/null
> +++ b/lib/tst_get_bad_addr.c
> @@ -0,0 +1,49 @@
> +/* $Header: /cvsroot/ltp/ltp/lib/get_high_address.c,v 1.6 2009/07/20 10:59:32 vapier Exp $ */
> +
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> + * Mountain View, CA  94043, or:
> + *
> + * http://www.sgi.com
> + *
> + * For further information regarding this notice, see:
> + *
> + * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> + */

Here as well, we do not use a single line from the original file so we
may as well put GPLv2+ header here.

> +#include <sys/mman.h>
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_get_bad_addr.h"
> +
> +void *tst_get_bad_addr(void)
> +{
> +	void *bad_addr;
> +
> +	bad_addr = mmap(0, 1, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +	if (bad_addr == MAP_FAILED)
> +		tst_brk(TBROK, "mmap() failed to get bad address");

I suppose that we have to actually use tst_brkm() and the old test.h if
this is supposed to be called from the old library tests. Otherwise
things will crash and burn once this tst_brk() gets called.

That is because we route tst_brkm() to the tst_brk() if new library is
detected but not the other way around.

> +	return bad_addr;
> +}
> diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
> index 326e584..77b03a3 100644
> --- a/testcases/kernel/syscalls/lchown/lchown02.c
> +++ b/testcases/kernel/syscalls/lchown/lchown02.c
> @@ -79,7 +79,6 @@ static void setup_eacces(int pos);
>  static void setup_enotdir(int pos);
>  static void setup_longpath(int pos);
>  static void setup_efault(int pos);
> -static void setup_highaddress(int pos);
>  
>  static char path[PATH_MAX + 2];
>  
> @@ -93,7 +92,6 @@ struct test_case_t {
>  static struct test_case_t test_cases[] = {
>  	{SFILE1, "Process is not owner/root", EPERM, setup_eperm},
>  	{SFILE2, "Search permission denied", EACCES, setup_eacces},
> -	{NULL, "Address beyond address space", EFAULT, setup_highaddress},
>  	{NULL, "Unaccessible address space", EFAULT, setup_efault},
>  	{path, "Pathname too long", ENAMETOOLONG, setup_longpath},
>  	{SFILE3, "Path contains regular file", ENOTDIR, setup_enotdir},
> @@ -254,27 +252,12 @@ static void setup_efault(int pos)
>  {
>  	char *bad_addr = 0;
>  
> -	bad_addr = mmap(NULL, 1, PROT_NONE,
> -			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, -1, 0);
> -
> -	if (bad_addr == MAP_FAILED)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
> +	bad_addr = (char *)tst_get_bad_addr();
                    ^
		    Plese get rid of useless casts like this one.

>  	test_cases[pos].pathname = bad_addr;
>  }
>  
>  /*
> - * setup_efault() -- setup for a test condition where lchown(2) returns -1 and
> - *                   sets errno to EFAULT.
> - *
> - * Use ltp function get_high_address() to compute high address.
> - */
> -static void setup_highaddress(int pos)
> -{
> -	test_cases[pos].pathname = get_high_address();
> -}
> -
> -/*
>   * setup_enotdir() - setup function for a test condition for which chown(2)
>   *	             returns -1 and sets errno to ENOTDIR.
>   *
> diff --git a/testcases/kernel/syscalls/link/link04.c b/testcases/kernel/syscalls/link/link04.c
> index 679753f..ead9935 100644
> --- a/testcases/kernel/syscalls/link/link04.c
> +++ b/testcases/kernel/syscalls/link/link04.c
> @@ -54,9 +54,6 @@
>  static char *bad_addr = 0;
>  
>  static char longpath[PATH_MAX + 2];
> -#if !defined(UCLINUX)
> -char high_addr[64];
> -#endif
>  
>  struct test_case_t {
>  	char *file1;
> @@ -73,9 +70,6 @@ struct test_case_t {
>  	{"regfile/file", "path contains a regular file", "nefile", "nefile",
>  	 ENOTDIR},
>  	{longpath, "pathname too long", "nefile", "nefile", ENAMETOOLONG},
> -#if !defined(UCLINUX)
> -	{high_addr, "address beyond address space", "nefile", "nefile", EFAULT},
> -#endif
>  	{(char *)-1, "negative address", "nefile", "nefile", EFAULT},
>  	/* second path is invalid */
>  	{"regfile", "regfile", "", "empty string", ENOENT},
> @@ -84,10 +78,6 @@ struct test_case_t {
>  	{"regfile", "regfile", "file/file",
>  		    "path contains a regular file", ENOENT},
>  	{"regfile", "regfile", longpath, "pathname too long", ENAMETOOLONG},
> -#if !defined(UCLINUX)
> -	{"regfile", "regfile", high_addr,
> -		    "address beyond address space", EFAULT},
> -#endif
>  	{"regfile", "regfile", (char *)-1, "negative address", EFAULT},
>  	/* two existing files */
>  	{"regfile", "regfile", "regfile2", "regfile2", EEXIST},
> @@ -121,14 +111,6 @@ int main(int ac, char **av)
>  			fname2 = test_cases[i].file2;
>  			desc2 = test_cases[i].desc2;
>  
> -#if !defined(UCLINUX)
> -			if (fname1 == high_addr)
> -				fname1 = get_high_address();
> -
> -			if (fname2 == high_addr)
> -				fname2 = get_high_address();
> -#endif
> -
>  			TEST(link(fname1, fname2));
>  
>  			if (TEST_RETURN == -1) {
> @@ -167,10 +149,9 @@ static void setup(void)
>  	tst_tmpdir();
>  
>  #if !defined(UCLINUX)
> -	bad_addr = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
> -	                     MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	test_cases[6].file1 = bad_addr;
> -	test_cases[12].file2 = bad_addr;
> +	bad_addr = (char *)tst_get_bad_addr(),
                    ^
		    Here as well.

And the same applies to the rest of the patchset.

> +	test_cases[5].file1 = bad_addr;
> +	test_cases[10].file2 = bad_addr;

Also assigning to random array members here is kind of ugly, we usually
go for pointer to a pointer and assignd &bad_addr in the test structure.

But given that it has been there already, if we want to fix it, it
should be done in a follow up patch...


-- 
Cyril Hrubis
chrubis@suse.cz
