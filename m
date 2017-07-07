From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Jul 2017 17:27:14 +0200
Subject: [LTP] [PATCH V2 05/14] mem/thp: convert to new API
In-Reply-To: <20170410100556.4465-6-liwang@redhat.com>
References: <20170410100556.4465-1-liwang@redhat.com>
 <20170410100556.4465-6-liwang@redhat.com>
Message-ID: <20170707152714.GG28534@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	switch (pid = SAFE_FORK()) {
>  		case 0:
>  			memset(arg, 'c', length - 1);
>  			arg[length - 1] = '\0';
> @@ -91,29 +72,31 @@ int main(int argc, char **argv)
>  			}
>  		default:
>  			if (waitpid(pid, &st, 0) == -1)
> -				tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
> +				tst_brk(TBROK | TERRNO, "waitpid");
>  			if (!WIFEXITED(st) || WEXITSTATUS(st) != 0)
> -				tst_brkm(TBROK, cleanup,
> -					 "child exited abnormally");
> -		}
> +				tst_brk(TBROK, "child exited abnormally");
>  	}

We do have SAFE_WAITPID() as well, but in this case we can simply call
tst_reap_children() that would take care of the exit status as well.

> -	tst_resm(TPASS, "system didn't crash, pass.");
> -	cleanup();
> -	tst_exit();
> +
> +	tst_res(TPASS, "system didn't crash, pass.");
>  }
>  
>  static void setup(void)
>  {
>  	ps = sysconf(_SC_PAGESIZE);
>  	length = 32 * ps;
> -	arg = malloc(length);
> -	if (arg == NULL)
> -		tst_brkm(TBROK | TERRNO, NULL, "malloc");
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +	arg = SAFE_MALLOC(length);
>  }
>  
>  static void cleanup(void)
>  {
> +	free(arg);
>  }
> +
> +static struct tst_test test = {
> +	.tid = "thp01",
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = thp_test,
> +};
> diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/thp02.c
> index eb919aa..45cfbe5 100644
> --- a/testcases/kernel/mem/thp/thp02.c
> +++ b/testcases/kernel/mem/thp/thp02.c
> @@ -1,24 +1,15 @@
>  /*
> - * Copyright (C) 2011  Red Hat, Inc.
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> + * Copyright (C) 2011-2017  Red Hat, Inc.
>   *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
>   *
>   * thp02 - detect mremap bug when THP is enabled.
>   *
> @@ -52,36 +43,11 @@
>  #include <unistd.h>
>  #include "mem.h"
>  
> -char *TCID = "thp02";
> -int TST_TOTAL = 1;
> -
>  #ifdef HAVE_MREMAP_FIXED
>  static int ps;
>  static long hps, size;
>  static void *p, *p2, *p3, *p4;
>  
> -static void do_mremap(void);
> -
> -int main(int argc, char **argv)
> -{
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		do_mremap();
> -	}
> -	tst_resm(TPASS, "Still alive.");
> -
> -	cleanup();
> -	tst_exit();
> -
> -}
> -
>  static void do_mremap(void)
>  {
>  	int i;
> @@ -89,11 +55,11 @@ static void do_mremap(void)
>  
>  	for (i = 0; i < 4; i++) {
>  		if (posix_memalign(&p, hps, size))
> -			tst_brkm(TBROK | TERRNO, cleanup, "memalign p");
> +			tst_brk(TBROK | TERRNO, "memalign p");
>  		if (posix_memalign(&p2, hps, size))
> -			tst_brkm(TBROK | TERRNO, cleanup, "memalign p2");
> +			tst_brk(TBROK | TERRNO, "memalign p2");
>  		if (posix_memalign(&p3, hps, size))
> -			tst_brkm(TBROK | TERRNO, cleanup, "memalign p3");
> +			tst_brk(TBROK | TERRNO, "memalign p3");

The posix_memalign() returns errno hence this will print bogus values
with TERRNO. We can either use SAFE_MEMALIGN() or possibly add
POSIX_MEMALIGN() to the safe_macros and use that one instead.

>  		memset(p, 0xff, size);
>  		memset(p2, 0xff, size);
> @@ -108,37 +74,36 @@ static void do_mremap(void)
>  		 */
>  		old_addr = p + ps * (i >> 1);
>  		new_addr = p3 + ps * (i & 1);
> -		tst_resm(TINFO, "mremap %p to %p", old_addr, new_addr);
> +		tst_res(TINFO, "mremap %p to %p", old_addr, new_addr);
>  
>  		p4 = mremap(old_addr, size - ps, size - ps,
>  			    MREMAP_FIXED | MREMAP_MAYMOVE, new_addr);
>  		if (p4 == MAP_FAILED)
> -			tst_brkm(TBROK | TERRNO, cleanup, "mremap");
> +			tst_brk(TBROK | TERRNO, "mremap");
>  		if (memcmp(p4, p2, size - ps))
> -			tst_brkm(TBROK, cleanup, "mremap bug");
> +			tst_brk(TBROK, "mremap bug");
>  	}
> +
> +	tst_res(TPASS, "Still alive.");
>  }
>  
> -void setup(void)
> +static void setup(void)
>  {
>  	if (access(PATH_THP, F_OK) == -1)
> -		tst_brkm(TCONF, NULL, "THP not enabled in kernel?");
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +		tst_brk(TCONF, "THP not enabled in kernel?");
>  
>  	ps = sysconf(_SC_PAGESIZE);
> -	hps = read_meminfo("Hugepagesize:") * 1024;
> +	hps = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
>  	size = hps * 4;
>  }
>  
> -void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.tid = "thp02",
> +	.needs_root = 1,
> +	.setup = setup,
> +	.test_all = do_mremap,
> +};
>  
>  #else
> -int main(void)
> -{
> -	tst_brkm(TCONF, NULL, "MREMAP_FIXED not present in <sys/mman.h>");
> -}
> +	TST_TEST_TCONF("MREMAP_FIXED not present in <sys/mman.h>");
>  #endif /* HAVE_MREMAP_FIXED */
> diff --git a/testcases/kernel/mem/thp/thp03.c b/testcases/kernel/mem/thp/thp03.c
> index 6b0f829..44541d9 100644
> --- a/testcases/kernel/mem/thp/thp03.c
> +++ b/testcases/kernel/mem/thp/thp03.c
> @@ -1,24 +1,15 @@
>  /*
> - * Copyright (C) 2012  Red Hat, Inc.
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> + * Copyright (C) 2012-2017  Red Hat, Inc.
>   *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
>   *
>   * thp03 - Case for spliting unaligned memory.
>   *       - System will panic if failed.
> @@ -46,11 +37,6 @@
>  #include <string.h>
>  #include <errno.h>
>  #include "mem.h"
> -#include "safe_macros.h"
> -#include "test.h"
> -
> -char *TCID = "thp03";
> -int TST_TOTAL = 1;
>  
>  #ifdef MADV_MERGEABLE
>  
> @@ -60,24 +46,6 @@ static long hugepage_size;
>  static long unaligned_size;
>  static long page_size;
>  
> -int main(int argc, char **argv)
> -{
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		thp_test();
> -	}
> -	tst_resm(TPASS, "system didn't crash, pass.");
> -	cleanup();
> -	tst_exit();
> -}
> -
>  static void thp_test(void)
>  {
>  	void *p;
> @@ -85,53 +53,53 @@ static void thp_test(void)
>  	p = mmap(NULL, unaligned_size, PROT_READ | PROT_WRITE,
>  		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>  	if (p == MAP_FAILED)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mmap");
> +		tst_brk(TBROK | TERRNO, "mmap");

Use SAFE_MMAP() here instead.

>  	memset(p, 0x00, unaligned_size);
>  	if (mprotect(p, unaligned_size, PROT_NONE) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mprotect");
> +		tst_brk(TBROK | TERRNO, "mprotect");
>  
>  	if (madvise(p + hugepage_size, page_size, MADV_MERGEABLE) == -1) {
>  		if (errno == EINVAL) {
> -			tst_brkm(TCONF, cleanup,
> +			tst_brk(TCONF,
>  			         "MADV_MERGEABLE is not enabled/supported");
>  		} else {
> -			tst_brkm(TBROK | TERRNO, cleanup, "madvise");
> +			tst_brk(TBROK | TERRNO, "madvise");
>  		}
>  	}
>  
> -	switch (fork()) {
> -	case -1:
> -		tst_brkm(TBROK | TERRNO, cleanup, "fork");
> +	switch (SAFE_FORK()) {
>  	case 0:
>  		exit(0);
>  	default:
>  		if (waitpid(-1, NULL, 0) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
> +			tst_brk(TBROK | TERRNO, "waitpid");

And SAFE_WAITPID() here.

>  	}
> +
> +	tst_res(TPASS, "system didn't crash, pass.");
> +	munmap(p, unaligned_size);
>  }
>  
> -void setup(void)
> +static void setup(void)
>  {
>  	if (access(PATH_THP, F_OK) == -1)
> -		tst_brkm(TCONF, NULL, "THP not enabled in kernel?");
> +		tst_brk(TCONF, "THP not enabled in kernel?");
>  
> -	hugepage_size = read_meminfo("Hugepagesize:") * KB;
> +	hugepage_size = SAFE_READ_MEMINFO("Hugepagesize:") * KB;
>  	unaligned_size = hugepage_size * 4 - 1;
> -	page_size = SAFE_SYSCONF(NULL, _SC_PAGESIZE);
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
>  }
>  
> -void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.tid = "thp03",
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.test_all = thp_test,
> +};
>  
>  #else
> -int main(void)
> -{
> -	tst_brkm(TCONF, NULL, "Kernel doesn't support MADV_MERGEABLE"
> +	TST_TEST_TCONF("Kernel doesn't support MADV_MERGEABLE"
>  		 " or you need to update your glibc-headers");

Hmm, if we get here the problem was MADV_MERGEABLE missing in system
headers. The kernel part is checked at runtime (that is the EINVAL check
from madvise()).

And we have lapi/mmap.h with fallback definition for it, so what about
we get rid of the ifdefs and include the fallback header lapi/mmap.h
instead?

>  }
>  #endif

-- 
Cyril Hrubis
chrubis@suse.cz
