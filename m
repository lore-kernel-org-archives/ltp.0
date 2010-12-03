Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1POYmg-0006ty-QL
	for ltp-list@lists.sourceforge.net; Fri, 03 Dec 2010 16:46:58 +0000
Date: Fri, 3 Dec 2010 18:00:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101203170004.GD28084@saboteur.suse.cz>
References: <1166251801.757981291112911689.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1938220959.758001291112915309.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1938220959.758001291112915309.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] munmap() don't check sysctl_max_mapcount
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> On ia64, the following test program exit abnormally, because glibc
> thread library called abort().
> 
>  ========================================================
>  (gdb) bt
>  #0  0xa000000000010620 in __kernel_syscall_via_break ()
>  #1  0x20000000003208e0 in raise () from /lib/libc.so.6.1
>  #2  0x2000000000324090 in abort () from /lib/libc.so.6.1
>  #3  0x200000000027c3e0 in __deallocate_stack () from
>      /lib/libpthread.so.0
>  #4  0x200000000027f7c0 in start_thread () from /lib/libpthread.so.0
>  #5  0x200000000047ef60 in __clone2 () from /lib/libc.so.6.1
>  ========================================================
> The fact is, glibc call munmap() when thread exitng time for freeing
> stack, and it assume munlock() never fail. However, munmap() often make
> vma splitting and it with many mapcount make -ENOMEM.
> 
> Oh well, stack unfreeing is not reasonable option. Also munlock() via
> free() shouldn't failed.
> 
> Thus, munmap() shoudn't check max-mapcount.
> 
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
>  runtest/syscalls                        |    1 +
>  testcases/kernel/syscalls/mmap/Makefile |    2 +
>  testcases/kernel/syscalls/mmap/mmap11.c |  161 +++++++++++++++++++++++++++++++
>  3 files changed, 164 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/mmap/mmap11.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index d8f9b20..b256b9f 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1288,3 +1288,4 @@ writev04 writev04
>  writev05 writev05
>  writev06 writev06
>  
> +mmap11 mmap11 -i 30000
> \ No newline at end of file
> diff --git a/testcases/kernel/syscalls/mmap/Makefile b/testcases/kernel/syscalls/mmap/Makefile
> index bd617d8..68771cd 100644
> --- a/testcases/kernel/syscalls/mmap/Makefile
> +++ b/testcases/kernel/syscalls/mmap/Makefile
> @@ -21,3 +21,5 @@ top_srcdir		?= ../../../..
>  include $(top_srcdir)/include/mk/testcases.mk
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +LDLIBS 			+= -lpthread
> \ No newline at end of file
> diff --git a/testcases/kernel/syscalls/mmap/mmap11.c b/testcases/kernel/syscalls/mmap/mmap11.c
> new file mode 100644
> index 0000000..55b7af5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mmap/mmap11.c
> @@ -0,0 +1,161 @@
> +/*
> + * munmap() don't check sysctl_max_mapcount
> + *
> + * From http://lkml.org/lkml/2009/10/2/85:
> + *
> + * On ia64, the following test program exit abnormally, because glibc
> + * thread library called abort().
> + *
> + *  ========================================================
> + *  (gdb) bt
> + *  #0  0xa000000000010620 in __kernel_syscall_via_break ()
> + *  #1  0x20000000003208e0 in raise () from /lib/libc.so.6.1
> + *  #2  0x2000000000324090 in abort () from /lib/libc.so.6.1
> + *  #3  0x200000000027c3e0 in __deallocate_stack () from
> + *      /lib/libpthread.so.0
> + *  #4  0x200000000027f7c0 in start_thread () from /lib/libpthread.so.0
> + *  #5  0x200000000047ef60 in __clone2 () from /lib/libc.so.6.1
> + *  ========================================================
> + * The fact is, glibc call munmap() when thread exitng time for freeing
> + * stack, and it assume munlock() never fail. However, munmap() often
> + * make vma splitting and it with many mapcount make -ENOMEM.
> + *
> + * Oh well, stack unfreeing is not reasonable option. Also munlock() via
> + * free() shouldn't failed.
> + *
> + * Thus, munmap() shoudn't check max-mapcount.
> + *
> + * Copyright (C) 2010  Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
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
> + * any, provided herein do not apply to combinations of this program
> + * with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
> + */
> +#include<stdio.h>
> +#include<stdlib.h>
> +#include<string.h>
> +#include<pthread.h>
> +#include<errno.h>
> +#include<unistd.h>
> +#include "test.h"
> +#include "usctest.h"
> +
> +char *TCID = "mmap11";
> +int TST_TOTAL = 1;
> +extern int Tst_count;
> +
> +#define MAL_SIZE (100*1024)
> +
> +static void *wait_thread(void *args);
> +static void *wait_thread2(void *args);
> +static void setup(void);
> +static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
> +static int check(void);
> +
> +int main(int argc, char *argv[])
> +{
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s",
> +			msg);
> +	setup();
> +	TEST(check());
> +	cleanup();
> +}

I would preffer to add empty line between each two functions (as it is
done in the rest of the LTP codebase). The code is much more readable.

Also no need to check return value from check() which always returns
zero.

> +void setup(void)
> +{
> +	/* capture signals */
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	/* Pause if that option was specified */
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +}
> +void cleanup(void)
> +{
> +	/*
> +	 * print timing stats if that option was specified.
> +	 * print errno log if that option was specified.
> +	 */
> +	TEST_CLEANUP;
> +
> +	/* exit with return code appropriate for results */
> +	tst_rmdir();
> +	tst_exit();
> +}

Do you need to create temporary directory for testing pthreads?

> +int check(void)
> +{
> +	int lc;
> +	pthread_t *thread, th;
> +	int ret, count = 0;
> +	pthread_attr_t attr;
> +
> +	ret = pthread_attr_init(&attr);
> +	if(ret)
> +		tst_brkm(TBROK|TERRNO, cleanup, "pthread_attr_init");
> +
> +	ret = pthread_attr_setdetachstate(&attr,
> +					PTHREAD_CREATE_DETACHED);
> +	if(ret)
> +		tst_brkm(TBROK|TERRNO, cleanup,
> +			"pthread_attr_setdetachstate");
> +
> +	thread = malloc(STD_LOOP_COUNT * sizeof(pthread_t));
> +	if (thread == NULL)
> +		tst_brkm(TBROK|TERRNO, cleanup, "malloc");
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		/* Reset Tst_count in case we are looping. */
> +		Tst_count = 0;
> +
> +		ret = pthread_create(&th, &attr, wait_thread, NULL);
> +		if(ret) {
> +			tst_resm(TINFO, "[%d] ", count);
> +			tst_brkm(TBROK|TERRNO, cleanup,
> +				"pthread_create");
> +		}
> +		count++;
> +		ret = pthread_create(&thread[lc], &attr, wait_thread2,
> +				NULL);
> +		if(ret) {
> +			tst_resm(TINFO, "[%d] ", count);
> +			tst_brkm(TBROK|TERRNO, cleanup,
> +				"pthread_create");
> +		}

Space after if.

> +		count++;
> +	}
> +	tst_resm(TPASS, "test completed.");
> +	free(thread);
> +	return 0;
> +}

This function always returns 0 so there is no need to return anyting. I
would change this to void which would be less confusing.

> +void *wait_thread(void *args)
> +{
> +	void *addr;
> +	addr = malloc(MAL_SIZE);
> +	if (addr)
> +		memset(addr, 1, MAL_SIZE);
> +	sleep(1);
> +	return NULL;
> +}
> +void *wait_thread2(void *args)
> +{
> +	return NULL;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
