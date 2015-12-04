From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 4 Dec 2015 19:28:36 +0300
Subject: [LTP] [PATCH] hugetlb: add new testcase hugeshmat05.c
In-Reply-To: <1448619845-7867-1-git-send-email-liwang@redhat.com>
References: <1448619845-7867-1-git-send-email-liwang@redhat.com>
Message-ID: <5661BF34.2090305@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 11/27/2015 01:24 PM, Li Wang wrote:
> shmget()/shmat() fails to allocate huge pages shared memory segment
> with EINVAL if its size is not in the range [ N*HUGE_PAGE_SIZE - 4095,
> N*HUGE_PAGE_SIZE ]. This is a problem in the memory segment size round
> up algorithm. The requested size is rounded up to PAGE_SIZE (4096), but
> if this roundup does not match HUGE_PAGE_SIZE (2Mb) boundary - the
> allocation fails.
>
> This bug is present in all RHEL6 versions, but not in RHEL7. It looks
> like this was fixed in mainstream kernel > v3.3 by the following patches:
>
> 091d0d5 shm: fix null pointer deref when userspace specifies invalid hugepage size
> af73e4d hugetlbfs: fix mmap failure in unaligned size request
> 42d7395 mm: support more pagesizes for MAP_HUGETLB/SHM_HUGETLB
> 40716e2 hugetlbfs: fix alignment of huge page requests
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>   runtest/hugetlb                                    |   1 +
>   testcases/kernel/mem/.gitignore                    |   1 +
>   .../kernel/mem/hugetlb/hugeshmat/hugeshmat05.c     | 140 +++++++++++++++++++++
>   3 files changed, 142 insertions(+)
>   create mode 100644 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 2e9f215..75e6426 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -10,6 +10,7 @@ hugeshmat01 hugeshmat01 -i 5
>   hugeshmat02 hugeshmat02 -i 5
>   hugeshmat03 hugeshmat03 -i 5
>   hugeshmat04 hugeshmat04 -i 5
> +hugeshmat05 hugeshmat05 -i 5
>   
>   hugeshmctl01 hugeshmctl01 -i 5
>   hugeshmctl02 hugeshmctl02 -i 5
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 4702377..46c2432 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -7,6 +7,7 @@
>   /hugetlb/hugeshmat/hugeshmat02
>   /hugetlb/hugeshmat/hugeshmat03
>   /hugetlb/hugeshmat/hugeshmat04
> +/hugetlb/hugeshmat/hugeshmat05
>   /hugetlb/hugeshmctl/hugeshmctl01
>   /hugetlb/hugeshmctl/hugeshmctl02
>   /hugetlb/hugeshmctl/hugeshmctl03
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
> new file mode 100644
> index 0000000..f7cbc93
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
> @@ -0,0 +1,140 @@
> +/*
> + * Copyright (c) 2015 Red Hat, Inc.
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
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * DESCRIPTION
> + *	shmget()/shmat() fails to allocate huge pages shared memory segment
> + *	with EINVAL if its size is not in the range [ N*HUGE_PAGE_SIZE - 4095,
> + *	N*HUGE_PAGE_SIZE ]. This is a problem in the memory segment size round
> + *	up algorithm. The requested size is rounded up to PAGE_SIZE (4096), but
> + *	if this roundup does not match HUGE_PAGE_SIZE (2Mb) boundary - the
> + *	allocation fails.
> + *
> + *	This bug is present in all RHEL6 versions, but not in RHEL7. It looks
> + *	like this was fixed in mainstream kernel > v3.3 by the following patches:
> + *
> + *	091d0d5 (shm: fix null pointer deref when userspace specifies invalid hugepage size)
> + *	af73e4d (hugetlbfs: fix mmap failure in unaligned size request)
> + *	42d7395 (mm: support more pagesizes for MAP_HUGETLB/SHM_HUGETLB)
> + *	40716e2 (hugetlbfs: fix alignment of huge page requests)
> + *
> + * AUTHOR
Authors
> + *	Vladislav Dronov <vdronov@redhat.com>
> + *	Li Wang <liwang@redhat.com>
> + *
> + */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/shm.h>
> +#include <sys/mman.h>
> +#include <fcntl.h>
> +
> +#include "test.h"
> +#include "mem.h"
> +#include "hugetlb.h"
> +
> +char *TCID = "hugeshmat05";
> +int TST_TOTAL = 3;
> +
> +static long page_size;
> +static long hpage_size;
> +static long hugepages;
> +
> +#define N 4
> +
> +void setup(void)
> +{
> +	tst_require_root();
> +	check_hugepage();
> +
> +	orig_hugepages = get_sys_tune("nr_hugepages");
> +	page_size = getpagesize();
> +	hpage_size = read_meminfo("Hugepagesize:") * 1024;
> +
> +	hugepages = N + 1;
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
> +void shm_test(int size)
> +{
> +	int shmid;
> +	char *shmaddr;
> +	key_t key = 5;
> +
> +	shmid = shmget(key, size, SHM_R | SHM_W | IPC_CREAT | SHM_HUGETLB);

Why not just "shmid = shmget(IPC_PRIVATE, size, 0600 | IPC_CREAT | 
SHM_HUGETLB);"? Do we need a key_t for the test?

> +	if (shmid < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "shmget");

The message should be at least "shmget failed".

> +
> +	shmaddr = shmat(shmid, 0, 0);
> +	if (shmaddr == (char *)-1) {
> +		shmctl(shmid, IPC_RMID, NULL);
> +		tst_brkm(TFAIL | TERRNO, cleanup, "Bug: shared memory attach failure.");
> +	}
> +
> +	shmaddr[0] = 1;
> +	tst_resm(TINFO, "allocated %d huge bytes", size);
> +
> +	if (shmdt((const void *)shmaddr) != 0) {
> +		shmctl(shmid, IPC_RMID, NULL);
> +		tst_brkm(TFAIL | TERRNO, cleanup, "Detach failure.");
> +	}
> +
> +	shmctl(shmid, IPC_RMID, NULL);
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
> +		for (i = 0; i < TST_TOTAL; i++) {
> +
> +			/* N*hpage_size - page_size FAIL */
> +			shm_test(N * hpage_size - page_size);
> +
> +			/* N*hpage_size - page_size - 1 SUCCESS*/
> +			shm_test(N * hpage_size - page_size - 1);
> +
> +			/* N*hpage_size  SUCCESS */
> +			shm_test(N * hpage_size);
> +
> +			/* N*hpage_size + 1 FAIL */
> +			shm_test(N * hpage_size + 1);
> +
> +			tst_resm(TPASS, "No regression found.");
> +		}

These two loops look very similar.
We can just call the test with -i 15 iterations in runtest, no need for 
such a redundancy.

Otherwise it looks good.

Best regards,
Alexey

> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}

