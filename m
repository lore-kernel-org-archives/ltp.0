From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jan 2017 17:59:25 +0100
Subject: [LTP] [PATCH] syscalls/move_pages12: Add new regression test
In-Reply-To: <1484744313-20305-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1484744313-20305-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170123165924.GI25788@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/runtest/numa b/runtest/numa
> index 87f64da..5dc6f48 100644
> --- a/runtest/numa
> +++ b/runtest/numa
> @@ -10,3 +10,4 @@ move_pages08 move_pages.sh 08
>  move_pages09 move_pages.sh 09
>  move_pages10 move_pages.sh 10
>  move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod 04755 move_pages11 && move_pages.sh 11
> +move_pages12 move_pages.sh 12
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 884ab80..9711cba 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -645,6 +645,7 @@ move_pages08 move_pages.sh 08
>  move_pages09 move_pages.sh 09
>  move_pages10 move_pages.sh 10
>  move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod 04755 move_pages11 && move_pages.sh 11
> +move_pages12 move_pages.sh 12

I do not like this wrapper. Can we rather get rid of it?

The move_pages* testcases seems to have ifdefs and are compiled as stubs
that produce TCONF when HAVE_NUMA_MOVE_PAGES was not defined at compile
time. Even the one you wrote. So there is no need for this kind of
wrapper at all.

At least don't use the script with new tests.

>  mprotect01 mprotect01
>  mprotect02 mprotect02
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index 3201fa9..21ed466 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -589,6 +589,7 @@
>  /move_pages/move_pages09
>  /move_pages/move_pages10
>  /move_pages/move_pages11
> +/move_pages/move_pages12
>  /mprotect/mprotect01
>  /mprotect/mprotect02
>  /mprotect/mprotect03
> diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
> new file mode 100644
> index 0000000..593d4ea
> --- /dev/null
> +++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
> @@ -0,0 +1,171 @@
> +/*
> + * Copyright (c) 2016 Fujitsu Ltd.
> + *  Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> + *  Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program, if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * This is a regression test for the race condition between move_pages()
> + * and freeing hugepages, where move_pages() calls follow_page(FOLL_GET)
> + * for hugepages internally and tries to get its refcount without
> + * preventing concurrent freeing.
> + *
> + * This test can crash the buggy kernel, and the bug was fixed in:
> + *
> + *  commit e66f17ff71772b209eed39de35aaa99ba819c93d
> + *  Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> + *  Date:   Wed Feb 11 15:25:22 2015 -0800
> + *
> + *  mm/hugetlb: take page table lock in follow_huge_pmd()
> + */
> +
> +#include <errno.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "move_pages_support.h"
> +
> +#define LOOPS	10000
> +#define PATH_MEMINFO	"/proc/meminfo"
> +#define PATH_NR_HUGEPAGES	"/proc/sys/vm/nr_hugepages"
> +#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
> +#define TEST_PAGES	2
> +#define TEST_NODES	2
> +#define TEST_ADDR	0x700000000000UL
                           ^
			Why do we need this specific address?

> +static int pgsz, hpsz;
> +static long orig_hugepages;
> +
> +static int read_hugepagesize(void)
> +{
> +	FILE *fp;
> +	char line[BUFSIZ], buf[BUFSIZ];
> +	int val;
> +
> +	fp = SAFE_FOPEN(PATH_MEMINFO, "r");
> +	while (fgets(line, BUFSIZ, fp) != NULL) {
> +		if (sscanf(line, "%64s %d", buf, &val) == 2) {
> +			if (strcmp(buf, "Hugepagesize:") == 0) {
> +				SAFE_FCLOSE(fp);
> +				return 1024 * val;
> +			}
> +		}
> +	}
> +
> +	SAFE_FCLOSE(fp);
> +	tst_brk(TBROK, "can't find \"%s\" in %s",
> +		"Hugepagesize:", PATH_MEMINFO);
> +}

We have SAFE_FILE_LINES_SCANF() exactly for this purpose.

This function could be replaced with:

SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "Hugepagesize: %d", &val);

> +static void do_child(void)
> +{
> +	char *p;
> +
> +	while (1) {
> +		p = SAFE_MMAP((void *)TEST_ADDR, TEST_PAGES * hpsz,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> +		if (p != (void *)TEST_ADDR)
> +			tst_brk(TBROK, "Failed to mmap at desired addr");
> +
> +		memset(p, 0, TEST_PAGES * hpsz);
> +
> +		SAFE_MUNMAP(p, TEST_PAGES * hpsz);
> +	}
> +}
> +
> +static void verify_move_pages(void)
> +{
> +#if HAVE_NUMA_MOVE_PAGES

Can we rather ifdef around the whole test code and use TST_TEST_TCONF()?

See for example the kernel/syscalls/flistxattr/flistxattr01.c testcase.

> +	unsigned int node1, node2;
> +	int i, j, ret;
> +	int test_pages = TEST_PAGES * hpsz / pgsz;
> +	int *nodes, *status;
> +	void **pages;
> +	pid_t cpid;
> +
> +	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "get_allowed_nodes: %d", ret);
> +
> +	pages = SAFE_MALLOC(sizeof(char *) * test_pages + 1);
> +	nodes = SAFE_MALLOC(sizeof(char *) * test_pages + 1);
> +	status = SAFE_MALLOC(sizeof(char *) * test_pages + 1);
> +
> +	for (i = 0; i < test_pages; i++)
> +		pages[i] = (void *)TEST_ADDR + i * pgsz;
> +
> +	cpid = SAFE_FORK();
> +	if (cpid == 0)
> +		do_child();
> +
> +	for (i = 0; i < LOOPS; i++) {
> +		for (j = 0; j < test_pages; j++) {
> +			if (i % 2 == 0)
> +				nodes[j] = node1;
> +			else
> +				nodes[j] = node2;
> +			status[j] = 0;
> +		}
> +
> +		TEST(numa_move_pages(cpid, test_pages, pages, nodes, status,
> +			MPOL_MF_MOVE_ALL));
> +		if (TEST_RETURN) {
> +			tst_res(TFAIL | TTERRNO, "move_pages failed");
> +			break;
> +		}
> +	}
> +
> +	SAFE_KILL(cpid, SIGKILL);
> +	SAFE_WAITPID(cpid, NULL, 0);
> +
> +	if (i == LOOPS)
> +		tst_res(TPASS, "Bug not reproduced");
> +#else
> +	tst_res(TCONF, "move_pages support not found.");
> +#endif
> +}
> +
> +static void setup(void)
> +{
> +	check_config(TEST_NODES);
> +
> +	if (access(PATH_HUGEPAGES, F_OK))
> +		tst_brk(TCONF, "Huge page not supported.");
> +
> +	pgsz = (int)get_page_size();
> +	hpsz = read_hugepagesize();
> +
> +	SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
> +	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%d", 40);

Huh, this is higly suspicious. What do you want to have here? Does the
test need 40 hugepages?

Have you considered that hugepages are enabled on the system already and
that there are some hugepages allocated as well? Shouldn't we rather try
to increase the limit to the number of already used hugepages + 40?

> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
> +}
> +
> +static struct tst_test test = {
> +	.tid = "move_pages12",
> +	.min_kver = "2.6.32",
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_move_pages,
> +};
> -- 
> 1.8.4.2
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
