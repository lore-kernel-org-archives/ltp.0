From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 4 Sep 2019 15:32:08 +0800
Subject: [LTP] [PATCH] syscalls/move_pages: Remove obsolete
 move_pages08.c
In-Reply-To: <1567581571-2303-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1567581571-2303-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5D6F6878.1090902@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/09/04 15:19, Yang Xu wrote:
> E2BIG was removed in 2.6.29, no one will test it with such an old
> kernel. So I think we can remove this error tests.
Hi,

It's reasonable to delete the quite old test.
Reviewed-by: Xiao Yang <ice_yangxiao@163.com>

Best Regards,
Xiao Yang
> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> ---
>   runtest/numa                                  |   1 -
>   runtest/syscalls                              |   1 -
>   .../kernel/syscalls/move_pages/.gitignore     |   1 -
>   .../kernel/syscalls/move_pages/move_pages08.c | 157 ------------------
>   4 files changed, 160 deletions(-)
>   delete mode 100644 testcases/kernel/syscalls/move_pages/move_pages08.c
>
> diff --git a/runtest/numa b/runtest/numa
> index 97ab5f076..7b9c2ae9d 100644
> --- a/runtest/numa
> +++ b/runtest/numa
> @@ -9,7 +9,6 @@ move_pages04 move_pages04
>   move_pages05 move_pages05
>   move_pages06 move_pages06
>   move_pages07 move_pages07
> -move_pages08 move_pages08
>   move_pages09 move_pages09
>   move_pages10 move_pages10
>   move_pages11 move_pages11
> diff --git a/runtest/syscalls b/runtest/syscalls
> index d2547b045..eb3295b9e 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -718,7 +718,6 @@ move_pages04 move_pages04
>   move_pages05 move_pages05
>   move_pages06 move_pages06
>   move_pages07 move_pages07
> -move_pages08 move_pages08
>   move_pages09 move_pages09
>   move_pages10 move_pages10
>   move_pages11 move_pages11
> diff --git a/testcases/kernel/syscalls/move_pages/.gitignore b/testcases/kernel/syscalls/move_pages/.gitignore
> index 419829d5f..2d1785e62 100644
> --- a/testcases/kernel/syscalls/move_pages/.gitignore
> +++ b/testcases/kernel/syscalls/move_pages/.gitignore
> @@ -5,7 +5,6 @@
>   /move_pages05
>   /move_pages06
>   /move_pages07
> -/move_pages08
>   /move_pages09
>   /move_pages10
>   /move_pages11
> diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
> deleted file mode 100644
> index e1bf64b77..000000000
> --- a/testcases/kernel/syscalls/move_pages/move_pages08.c
> +++ /dev/null
> @@ -1,157 +0,0 @@
> -/*
> - *   Copyright (c) 2008 Vijay Kumar B.<vijaykumar@bravegnu.org>
> - *
> - *   Based on testcases/kernel/syscalls/waitpid/waitpid01.c
> - *   Original copyright message:
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
> - *	move_pages08.c
> - *
> - * DESCRIPTION
> - *      Failure when the no. of pages is ULONG_MAX.
> - *
> - * ALGORITHM
> - *
> - *      1. Pass ULONG_MAX pages to move_pages().
> - *      2. Check if errno is set to E2BIG.
> - *
> - * USAGE:<for command-line>
> - *      move_pages08 [-c n] [-i n] [-I x] [-P x] [-t]
> - *      where,  -c n : Run n copies concurrently.
> - *              -i n : Execute test n times.
> - *              -I x : Execute test for x seconds.
> - *              -P x : Pause for x seconds between iterations.
> - *              -t   : Turn on syscall timing.
> - *
> - * History
> - *	05/2008 Vijay Kumar
> - *		Initial Version.
> - *
> - * Restrictions
> - *	kernel<  2.6.29
> - */
> -
> -#include<sys/mman.h>
> -#include<sys/types.h>
> -#include<sys/wait.h>
> -#include<unistd.h>
> -#include<errno.h>
> -#include<limits.h>
> -#include "test.h"
> -#include "move_pages_support.h"
> -
> -#define TEST_PAGES 2
> -#define TEST_NODES 2
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -char *TCID = "move_pages08";
> -int TST_TOTAL = 1;
> -
> -int main(int argc, char **argv)
> -{
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -#ifdef HAVE_NUMA_V2
> -	unsigned int i;
> -	int lc;
> -	unsigned int from_node;
> -	unsigned int to_node;
> -	int ret;
> -
> -	ret = get_allowed_nodes(NH_MEMS, 2,&from_node,&to_node);
> -	if (ret<  0)
> -		tst_brkm(TBROK | TERRNO, cleanup, "get_allowed_nodes: %d", ret);
> -
> -	/* check for looping state if -i option is given */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		void *pages[TEST_PAGES] = { 0 };
> -		int nodes[TEST_PAGES];
> -		int status[TEST_PAGES];
> -
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		ret = alloc_pages_on_node(pages, TEST_PAGES, from_node);
> -		if (ret == -1)
> -			continue;
> -
> -		for (i = 0; i<  TEST_PAGES; i++)
> -			nodes[i] = to_node;
> -
> -		ret = numa_move_pages(0, ULONG_MAX, pages, nodes,
> -				      status, MPOL_MF_MOVE);
> -		if (ret == -1&&  errno == E2BIG)
> -			tst_resm(TPASS, "move_pages failed with "
> -				 "E2BIG as expected");
> -		else
> -			tst_resm(TFAIL|TERRNO, "move pages did not fail "
> -				 "with E2BIG ret: %d", ret);
> -
> -		free_pages(pages, TEST_PAGES);
> -	}
> -#else
> -	tst_resm(TCONF, NUMA_ERROR_MSG);
> -#endif
> -
> -	cleanup();
> -	tst_exit();
> -
> -}
> -
> -/*
> - * setup() - performs all ONE TIME setup for this test
> - */
> -static void setup(void)
> -{
> -	/*
> -	 * commit 3140a2273009c01c27d316f35ab76a37e105fdd8
> -	 * Author: Brice Goglin<Brice.Goglin@inria.fr>
> -	 * Date:   Tue Jan 6 14:38:57 2009 -0800
> -	 *     mm: rework do_pages_move() to work on page_sized chunks
> -	 *
> -	 * reworked do_pages_move() to work by page-sized chunks and removed E2BIG
> -	 */
> -	if ((tst_kvercmp(2, 6, 29))>= 0)
> -		tst_brkm(TCONF, NULL, "move_pages: E2BIG was removed in "
> -			 "commit 3140a227");
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	check_config(TEST_NODES);
> -
> -	/* Pause if that option was specified
> -	 * TEST_PAUSE contains the code to fork the test with the -c option.
> -	 */
> -	TEST_PAUSE;
> -}
> -
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at completion
> - */
> -static void cleanup(void)
> -{
> -
> -}



