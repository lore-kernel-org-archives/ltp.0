From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 13 Apr 2021 14:50:05 +0100
Subject: [LTP] [PATCH v2] controllers/memcg: Add testcase for
 kmem_limit_in_bytes of memory cgroup
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B49D0@dggeml531-mbx.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B49D0@dggeml531-mbx.china.huawei.com>
Message-ID: <87lf9m2t0y.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

zhaogongyi <zhaogongyi@huawei.com> writes:

> Hi Richard,
>
> Yes, I will pay attention on your patchs about cgroup API.
>
>> > +static void run(void)
>> > +{
>> > +	pid_t pid;
>> > +	int st;
>> > +
>> > +	pid = SAFE_FORK();
>> > +	if (!pid) {
>> > +		SAFE_SETPGID(0, 0);
>> > +
>> > +		SAFE_FILE_PRINTF(KMEM_LIMIT_IN_BYTES, "%d", 0);
>> > +
>> > +		SAFE_FILE_PRINTF(CGROUP_PROCS, "%d", getpgid(getpid()));
>> 
>> After setting this we should avoid doing any work in this process except
>> calling fork. AFAIK there is no guarantee that some other syscall or tasklet
>> etc. Won't try to allocate memory and also fail.
>>
>
> It seems that we would not be afraid since there is no asynchronous
> operation in the test process.

IIRC one of the problems with tasklets is they can run in any
process. Also, in theory stdout can point to anything. So write() might
allocate memory.

Why not do something like:

SAFE_FILE_PRINTF(CGROUP_PROCS, "%d", getpgid(getpid()));
errno = 0;
fork();
exit(errno);

Then check that errno == ENOMEM, in the parent process?

>
>
>> > +		TEST(fork());
>> > +		if (TST_RET == -1) {
>> > +			if (TST_ERR == ENOMEM)
>> > +				tst_res(TPASS, "fork fail as expected");
>> > +			else
>> > +				tst_brk(TFAIL | TTERRNO,
>> > +					"fork fail as unexpected");
>> 
>> This should be "fork failed with unexpected error".
>
> It's right. Thanks for your review.

Thanks :-)

>
> Best Regards,
> Gongyi
>
>
>> 
>> Hello,
>> 
>> Zhao Gongyi <zhaogongyi@huawei.com> writes:
>> 
>> > Add memory cgroup testcase for checking that kmem overflow is
>> > controlled by kmem.limit_in_bytes.
>> 
>> I am currently working on a new LTP CGroups API, please see:
>> https://patchwork.ozlabs.org/project/ltp/list/?series=238773
>> 
>> If the new API is merged quickly, then this test will need to be converted
>> to it. Also please see comments below.
>> 
>> >
>> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
>> > ---
>> > v1->v2:
>> > 	1) add testcase to runtest/controllers
>> > 	2) add testcase to testcases/kernel/controllers/memcg/.gitignore
>> > ---
>> >  runtest/controllers                           |  1 +
>> >  testcases/kernel/controllers/memcg/.gitignore |  1 +
>> >  .../functional/memcg_kmem_limit_in_bytes.c    | 87
>> +++++++++++++++++++
>> >  3 files changed, 89 insertions(+)
>> >  create mode 100644
>> >
>> testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_in_b
>> yte
>> > s.c
>> >
>> > diff --git a/runtest/controllers b/runtest/controllers index
>> > e3d0243f1..f13a112c7 100644
>> > --- a/runtest/controllers
>> > +++ b/runtest/controllers
>> > @@ -15,6 +15,7 @@ memcg_use_hierarchy
>> 	memcg_use_hierarchy_test.sh
>> >  memcg_usage_in_bytes	memcg_usage_in_bytes_test.sh
>> >  memcg_stress		memcg_stress_test.sh
>> >  memcg_control		memcg_control_test.sh
>> > +memcg_kmem_limit_in_bytes memcg_kmem_limit_in_bytes
>> >
>> >  cgroup_fj_function_debug cgroup_fj_function.sh debug
>> > cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset diff --git
>> > a/testcases/kernel/controllers/memcg/.gitignore
>> > b/testcases/kernel/controllers/memcg/.gitignore
>> > index c0b6d0714..dce8412de 100644
>> > --- a/testcases/kernel/controllers/memcg/.gitignore
>> > +++ b/testcases/kernel/controllers/memcg/.gitignore
>> > @@ -1,5 +1,6 @@
>> >  /control/mem_process
>> >  /functional/memcg_process
>> > +/functional/memcg_kmem_limit_in_bytes
>> >  /regression/memcg_test_1
>> >  /regression/memcg_test_2
>> >  /regression/memcg_test_3
>> > diff --git
>> >
>> a/testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_in
>> _by
>> > tes.c
>> >
>> b/testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_in
>> _by
>> > tes.c
>> > new file mode 100644
>> > index 000000000..61f3f6fd5
>> > --- /dev/null
>> > +++
>> b/testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_i
>> > +++ n_bytes.c
>> > @@ -0,0 +1,87 @@
>> > +// SPDX-License-Identifier: GPL-2.0-or-later
>> > +/*
>> > + * Copyright (c) 2021 HUAWEI LIMITED
>> > + * Author: Zhao Gongyi <zhaogongyi@huawei.com>  */
>> > +
>> > +/*\
>> > + * [Description]
>> > + * Check that kmem overflow is controlled by kmem.limit_in_bytes.
>> > + *
>> > + * [Algorithm]
>> > + * 1) mount memory cgroup
>> > + * 2) set 0 to memory.kmem.limit_in_bytes
>> > + * 3) set test process group to cgroup.procs
>> > + * 4) fork in test process group to trig kmem overflow  */
>> > +
>> > +#include <sys/wait.h>
>> > +#include "tst_test.h"
>> > +
>> > +#define MNT_POINT "memcg"
>> > +#define TESTDIR "memcg/ltpmemcg"
>> > +#define CGROUP_PROCS "memcg/ltpmemcg/cgroup.procs"
>> > +#define KMEM_LIMIT_IN_BYTES
>> "memcg/ltpmemcg/memory.kmem.limit_in_bytes"
>> > +
>> > +static void cleanup(void)
>> > +{
>> > +	SAFE_RMDIR(TESTDIR);
>> > +	SAFE_UMOUNT(MNT_POINT);
>> > +	SAFE_RMDIR(MNT_POINT);
>> > +}
>> > +
>> > +static void setup(void)
>> > +{
>> > +	SAFE_MKDIR(MNT_POINT, 0755);
>> > +	SAFE_MOUNT("memcg", MNT_POINT, "cgroup", 0, "memory");
>> > +	SAFE_MKDIR(TESTDIR, 0755);
>> > +}
>> > +
>> > +static void run(void)
>> > +{
>> > +	pid_t pid;
>> > +	int st;
>> > +
>> > +	pid = SAFE_FORK();
>> > +	if (!pid) {
>> > +		SAFE_SETPGID(0, 0);
>> > +
>> > +		SAFE_FILE_PRINTF(KMEM_LIMIT_IN_BYTES, "%d", 0);
>> > +
>> > +		SAFE_FILE_PRINTF(CGROUP_PROCS, "%d", getpgid(getpid()));
>> 
>> After setting this we should avoid doing any work in this process except
>> calling fork. AFAIK there is no guarantee that some other syscall or tasklet
>> etc. Won't try to allocate memory and also fail.
>> 
>> > +
>> > +		TEST(fork());
>> > +		if (TST_RET == -1) {
>> > +			if (TST_ERR == ENOMEM)
>> > +				tst_res(TPASS, "fork fail as expected");
>> > +			else
>> > +				tst_brk(TFAIL | TTERRNO,
>> > +					"fork fail as unexpected");
>> 
>> This should be "fork failed with unexpected error".
>> 
>> > +		} else if (TST_RET == 0) {
>> > +			tst_brk(TFAIL, "fork success as unexpected");
>> > +		} else {
>> > +			SAFE_WAIT(NULL);
>> > +			tst_brk(TFAIL, "fork success as unexpected");
>> > +		}
>> > +	} else {
>> > +		SAFE_WAIT(&st);
>> > +		if (WIFEXITED(st))
>> > +			if (!WEXITSTATUS(st)) {
>> > +				tst_res(TPASS, "kmem alloc is controled "
>> > +					"by memory.kmem.limit_in_bytes");
>> > +				return;
>> > +			}
>> > +
>> > +		tst_res(TFAIL,"kmem alloc is not controled "
>> > +			"by memory.kmem.limit_in_bytes");
>> > +	}
>> > +}
>> > +
>> > +static struct tst_test test = {
>> > +	.needs_root = 1,
>> > +	.needs_tmpdir = 1,
>> > +	.forks_child = 1,
>> > +	.setup = setup,
>> > +	.test_all = run,
>> > +	.cleanup = cleanup,
>> > +};
>> > --
>> > 2.17.1
>> 
>> 
>> --
>> Thank you,
>> Richard.


-- 
Thank you,
Richard.
