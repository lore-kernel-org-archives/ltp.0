From: Helge Deller <deller@gmx.de>
Date: Mon, 21 Dec 2015 14:36:39 +0100
Subject: [LTP] [PATCH v4] hugetlb/hugemmap: add new testcase hugemmap06.c
In-Reply-To: <1450696613-6847-1-git-send-email-liwang@redhat.com>
References: <1450696613-6847-1-git-send-email-liwang@redhat.com>
Message-ID: <56780067.1020704@gmx.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 21.12.2015 12:16, Li Wang wrote:
> Description of Problem:
>         There is a race condition if we map a same file on different processes.
>         Region tracking is protected by mmap_sem and hugetlb_instantiation_mutex.
>         When we do mmap, we don't grab a hugetlb_instantiation_mutex, but only
>         mmap_sem (exclusively).  This doesn't prevent other tasks from modifying
>         the region structure, so it can be modified by two processes concurrently.
> 
>         Testcase hugemmap06.c is the trigger to cause system crash:
>         crash> bt -s
>         PID: 4492   TASK: ffff88033e437520  CPU: 2   COMMAND: "hugemmap06"
>          #0 [ffff88033dbb3960] machine_kexec+395 at ffffffff8103d1ab
>          #1 [ffff88033dbb39c0] crash_kexec+114 at ffffffff810cc4f2
>          #2 [ffff88033dbb3a90] oops_end+192 at ffffffff8153c840
>          #3 [ffff88033dbb3ac0] die+91 at ffffffff81010f5b
>          #4 [ffff88033dbb3af0] do_general_protection+338 at ffffffff8153c332
>          #5 [ffff88033dbb3b20] general_protection+37 at ffffffff8153bb05
>             [exception RIP: list_del+40]
>             RIP: ffffffff812a3598  RSP: ffff88033dbb3bd8  RFLAGS: 00010292
>             RAX: dead000000100100  RBX: ffff88013cf37340  RCX: 0000000000002dc2
>             RDX: dead000000200200  RSI: 0000000000000046  RDI: 0000000000000009
>             RBP: ffff88033dbb3be8   R8: 0000000000015598   R9: 0000000000000000
>             R10: 000000000000000f  R11: 0000000000000009  R12: 000000000000000a
>             R13: ffff88033d64b9e8  R14: ffff88033e5b9720  R15: ffff88013cf37340
>             ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
>          #6 [ffff88033dbb3bf0] region_add+154 at ffffffff811698da
>          #7 [ffff88033dbb3c40] alloc_huge_page+669 at ffffffff8116a61d
>          #8 [ffff88033dbb3ce0] hugetlb_fault+1083 at ffffffff8116b9bb
>          #9 [ffff88033dbb3d90] handle_mm_fault+917 at ffffffff81153295
>         #10 [ffff88033dbb3e00] __do_page_fault+326 at ffffffff8104f156
>         #11 [ffff88033dbb3f20] do_page_fault+62 at ffffffff8153e78e
>         #12 [ffff88033dbb3f50] page_fault+37 at ffffffff8153bb35
>             RIP: 00000000004027c6  RSP: 00007f7cadef9e80  RFLAGS: 00010297
>             RAX: 000000005a49238f  RBX: 00007ffcb2d19320  RCX: 000000357498e084
>             RDX: 000000357498e0b0  RSI: 00007f7cadef9e5c  RDI: 000000357498e4e0
>             RBP: 0000000000000008   R8: 000000357498e0a0   R9: 000000357498e100
>             R10: 00007f7cadefa9d0  R11: 0000000000000206  R12: 0000000000000007
>             R13: 0000000000000002  R14: 0000000000000003  R15: 00002aaaac000000
>             ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b
> 
> The fix are all these below commits:
>        f522c3ac00(mm, hugetlb: change variable name reservations to resv)
>        9119a41e90(mm, hugetlb: unify region structure handling)
>        7b24d8616b(mm, hugetlb: fix race in region tracking)
>        1406ec9ba6(mm, hugetlb: improve, cleanup resv_map parameters)
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
> 
> Notes:
>     v3 --> v4
>     - declare sz type and assign value at the same line
>     - change 'void *addr' to 'char * addr' in the mp struct
>     - take use of 'mmap_sz->addr + ...' in a clean way
>     - remove the useless pthread_join
>     - fix a tpyo 'mremap'

> 
>  runtest/hugetlb                                    |   1 +
>  testcases/kernel/mem/.gitignore                    |   1 +
>  testcases/kernel/mem/hugetlb/hugemmap/Makefile     |   2 +
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c | 175 +++++++++++++++++++++
>  4 files changed, 179 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 2e9f215..ac24513 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -2,6 +2,7 @@ hugemmap01 hugemmap01
>  hugemmap02 hugemmap02
>  hugemmap04 hugemmap04
>  hugemmap05 hugemmap05
> +hugemmap06 hugemmap06
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 4702377..ac8e6d8 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -3,6 +3,7 @@
>  /hugetlb/hugemmap/hugemmap02
>  /hugetlb/hugemmap/hugemmap04
>  /hugetlb/hugemmap/hugemmap05
> +/hugetlb/hugemmap/hugemmap06
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> index f51f6b9..2473aca 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> @@ -25,3 +25,5 @@ top_srcdir		?= ../../../../..
>  include $(top_srcdir)/include/mk/testcases.mk
>  include $(abs_srcdir)/../Makefile.inc
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +hugemmap06: CFLAGS+=-pthread
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
> new file mode 100644
> index 0000000..e52b21d
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
> @@ -0,0 +1,175 @@
> +/*
> + *  Copyright (c) 2015 Red Hat, Inc.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 3 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * DESCRIPTION
> + *
> + *   There is a race condition if we map a same file on different processes.
> + *   Region tracking is protected by mmap_sem and hugetlb_instantiation_mutex.
> + *   When we do mmap, we don't grab a hugetlb_instantiation_mutex, but only
> + *   mmap_sem (exclusively).  This doesn't prevent other tasks from modifying
> + *   the region structure, so it can be modified by two processes concurrently.
> + *
> + *   This bug was fixed on stable kernel by commits:
> + *       f522c3ac00(mm, hugetlb: change variable name reservations to resv)
> + *       9119a41e90(mm, hugetlb: unify region structure handling)
> + *       7b24d8616b(mm, hugetlb: fix race in region tracking)
> + *       1406ec9ba6(mm, hugetlb: improve, cleanup resv_map parameters)
> + *
> + * AUTHOR:
> + *    Herton R. Krzesinski <herton@redhat.com>
> + *    Li Wang <liwang@redhat.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <pthread.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include "test.h"
> +#include "mem.h"
> +#include "hugetlb.h"
> +
> +char *TCID = "hugemmap06";
> +int TST_TOTAL = 5;
> +
> +static long hpage_size;
> +static long hugepages;
> +
> +struct mp {
> +	char *addr;
> +	int sz;
> +};
> +
> +#define ARSZ 50
> +
> +void setup(void)
> +{
> +	tst_require_root();
> +	check_hugepage();
> +
> +	hpage_size = read_meminfo("Hugepagesize:") * 1024;
> +	orig_hugepages = get_sys_tune("nr_hugepages");
> +
> +	hugepages = (ARSZ + 1) * TST_TOTAL;
> +
> +	if (hugepages * read_meminfo("Hugepagesize:") > read_meminfo("MemTotal:"))
> +		tst_brkm(TCONF, NULL, "System RAM is not enough to test.");


Just a general note:

What happens on architectures where no hugepages are available?
Maybe you should add a check and return TCONF() in those cases?
I think this is missing for the other existing hugepage testcases as well...

Helge


> +
> +	set_sys_tune("nr_hugepages", hugepages, 1);
> +
> +	TEST_PAUSE;
> +}
> +
> +void cleanup(void)
> +{
> +	set_sys_tune("nr_hugepages", orig_hugepages, 0);
> +}
> +
> +void *thr(void *arg)
> +{
> +	struct mp *mmap_sz = arg;
> +	int i, lim, a, b, c;
> +
> +	srand(time(NULL));
> +	lim = rand() % 10;
> +	for (i = 0; i < lim; i++) {
> +		a = rand() % mmap_sz->sz;
> +		for (c = 0; c <= a; c++) {
> +			b = rand() % mmap_sz->sz;
> +			*(mmap_sz->addr + b * hpage_size) = rand();
> +		}
> +	}
> +	return NULL;
> +}
> +
> +void do_mmap(void)
> +{
> +	int i, sz = ARSZ + 1;
> +	void *addr, *new_addr;
> +	struct mp mmap_sz[ARSZ];
> +	pthread_t tid[ARSZ];
> +
> +	addr = mmap(NULL, sz * hpage_size,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> +			-1, 0);
> +
> +	if (addr == MAP_FAILED) {
> +		if (errno == ENOMEM) {
> +			tst_brkm(TCONF, cleanup,
> +				"Cannot allocate hugepage, memory too fragmented?");
> +		}
> +
> +		tst_brkm(TBROK | TERRNO, cleanup, "Cannot allocate hugepage");
> +	}
> +
> +	for (i = 0; i < ARSZ; ++i, --sz) {
> +		mmap_sz[i].sz = sz;
> +		mmap_sz[i].addr = addr;
> +
> +		TEST(pthread_create(&tid[i], NULL, thr, &mmap_sz[i]));
> +		if (TEST_RETURN)
> +			tst_brkm(TBROK | TRERRNO, cleanup,
> +					"pthread_create failed");
> +
> +		new_addr = mmap(addr, (sz - 1) * hpage_size,
> +				PROT_READ | PROT_WRITE,
> +				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_FIXED,
> +				-1, 0);
> +
> +		if (new_addr == MAP_FAILED)
> +			tst_brkm(TFAIL | TERRNO, cleanup, "mmap failed");
> +
> +		addr = new_addr;
> +	}
> +
> +	for (i = 0; i < ARSZ; ++i) {
> +		TEST(pthread_join(tid[i], NULL));
> +		if (TEST_RETURN)
> +			tst_brkm(TBROK | TRERRNO, cleanup,
> +					"pthread_join failed");
> +	}
> +
> +	if (munmap(addr, sz * hpage_size) == -1)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "huge munmap failed");
> +}
> +
> +int main(int ac, char **av)
> +{
> +	int lc, i;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++)
> +			do_mmap();
> +
> +		tst_resm(TPASS, "No regression found.");
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> 

