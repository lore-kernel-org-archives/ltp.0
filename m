From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 15 Apr 2021 08:47:09 +0100
Subject: [LTP] [PATCH v3] controllers/memcg: Add testcase for
 kmem_limit_in_bytes of memory cgroup
In-Reply-To: <20210415032911.7542-1-zhaogongyi@huawei.com>
References: <20210415032911.7542-1-zhaogongyi@huawei.com>
Message-ID: <878s5k2dmq.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Zhao Gongyi <zhaogongyi@huawei.com> writes:

> Add memory cgroup testcase for checking that kmem overflow is controlled
> by kmem.limit_in_bytes.
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
> v2->v3: remove the calling of tst_res/tst_brk in test process to avoid
> kmem allocation
> ---
>  runtest/controllers                           |  1 +
>  testcases/kernel/controllers/memcg/.gitignore |  1 +
>  .../functional/memcg_kmem_limit_in_bytes.c    | 76 +++++++++++++++++++
>  3 files changed, 78 insertions(+)
>  create mode 100644 testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_in_bytes.c
>
> diff --git a/runtest/controllers b/runtest/controllers
> index e3d0243f1..f13a112c7 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -15,6 +15,7 @@ memcg_use_hierarchy	memcg_use_hierarchy_test.sh
>  memcg_usage_in_bytes	memcg_usage_in_bytes_test.sh
>  memcg_stress		memcg_stress_test.sh
>  memcg_control		memcg_control_test.sh
> +memcg_kmem_limit_in_bytes memcg_kmem_limit_in_bytes
>
>  cgroup_fj_function_debug cgroup_fj_function.sh debug
>  cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
> diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kernel/controllers/memcg/.gitignore
> index c0b6d0714..dce8412de 100644
> --- a/testcases/kernel/controllers/memcg/.gitignore
> +++ b/testcases/kernel/controllers/memcg/.gitignore
> @@ -1,5 +1,6 @@
>  /control/mem_process
>  /functional/memcg_process
> +/functional/memcg_kmem_limit_in_bytes
>  /regression/memcg_test_1
>  /regression/memcg_test_2
>  /regression/memcg_test_3
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_in_bytes.c b/testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_in_bytes.c
> new file mode 100644
> index 000000000..4521d299c
> --- /dev/null
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_in_bytes.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 HUAWEI LIMITED
> + * Author: Zhao Gongyi <zhaogongyi@huawei.com>
> + */
> +
> +/*\
> + * [Description]
> + * Check that kmem overflow is controlled by kmem.limit_in_bytes.
> + *
> + * [Algorithm]
> + * 1) mount memory cgroup
> + * 2) set 0 to memory.kmem.limit_in_bytes
> + * 3) set test process id to cgroup.procs
> + * 4) fork in test process to trig kmem overflow
> + */
> +
> +#include <sys/wait.h>
> +#include "tst_test.h"
> +
> +#define MNT_POINT "memcg"
> +#define TESTDIR "memcg/ltpmemcg"
> +#define CGROUP_PROCS "memcg/ltpmemcg/cgroup.procs"
> +#define KMEM_LIMIT_IN_BYTES "memcg/ltpmemcg/memory.kmem.limit_in_bytes"
> +
> +static void cleanup(void)
> +{
> +	SAFE_RMDIR(TESTDIR);
> +	SAFE_UMOUNT(MNT_POINT);
> +	SAFE_RMDIR(MNT_POINT);
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_MKDIR(MNT_POINT, 0755);
> +	SAFE_MOUNT("memcg", MNT_POINT, "cgroup", 0, "memory");

This won't work on systems where memcg is mounted with different
options. However we can convert the test to my new API. So this is not
an issue.

> +	SAFE_MKDIR(TESTDIR, 0755);
> +}
> +
> +static void run(void)
> +{
> +	pid_t pid;
> +	int st;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		SAFE_FILE_PRINTF(KMEM_LIMIT_IN_BYTES, "%d", 0);

kmem can be disabled which will result in TBROK. However this can also
be handled by the new CGroup API.

> +		SAFE_FILE_PRINTF(CGROUP_PROCS, "%d", getpid());
> +
> +		TEST(fork());
> +		if (TST_RET == -1 && TST_ERR == ENOMEM)

This is much better, but why not return errno to the parent and print
it?

As I said before:

errno=0
fork();
_exit(errno);

> +			_exit(TPASS);
> +		else
> +			_exit(TFAIL);
> +	} else {
> +		SAFE_WAIT(&st);
> +		if (WIFEXITED(st))
> +			if (!WEXITSTATUS(st)) {
> +				tst_res(TPASS, "kmem alloc is controled "
> +					"by memory.kmem.limit_in_bytes");
> +				return;
> +			}
> +
> +		tst_res(TFAIL,"kmem alloc is not controled "
> +			"by memory.kmem.limit_in_bytes");

In this case we do not know what happened. It would be nice to at least
know what the errno was.

> +	}
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.test_all = run,
> +	.cleanup = cleanup,
> +};
> --
> 2.17.1

Apart from the above issues the test looks good :-)

-- 
Thank you,
Richard.
