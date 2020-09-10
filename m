From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Sep 2020 11:55:42 +0200
Subject: [LTP] [PATCH v4] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <20200910093532.20223-1-liwang@redhat.com>
References: <20200910093532.20223-1-liwang@redhat.com>
Message-ID: <20200910095542.GA4275@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We assign the memory region allocated using MAP_GROWSDOWN to a thread,
> as a stack, to test the effect of MAP_GROWSDOWN. This is because the
> kernel only grows the memory region when the stack pointer, is within
> guard page, when the guard page is touched.
> 
>   1. Map an anyonymous memory region of size X, and unmap it.
>   2. Split the unmapped memory region into two.
>   3. The lower memory region is left unmapped.
>   4. The higher memory region is mapped for use as stack, using MAP_FIXED | MAP_GROWSDOWN.
>   5. The higher memory region is provided as stack to a thread, where
>      a recursive function is invoked.
>   6. The stack grows beyond the allocated region, into the lower memory area.
>   7. If this results in the memory region being extended, into the
>      unmapped region, the test is considered to have passed.
> 
> Resolves #300
> Signed-off-by: Pravin Raghul S. <pravinraghul@zilogic.com>
> Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> ---
> 
> Notes:
>     V4:
>       - add stack_guard_gap variable
>       - use __attribute__((noinline)) to prevent function optimization
>       - add 256 pages as the stack_guard_gap to let grows safely
>       - prepare the stack into a single function named allocate_stack()
>     
>     Btw, patch v4 get passed on RHEL8(x86_64, s390x, aarch64) and RHEL7(x86_64).
> 
>  runtest/syscalls                          |   1 +
>  testcases/kernel/syscalls/mmap/.gitignore |   1 +
>  testcases/kernel/syscalls/mmap/mmap18.c   | 156 ++++++++++++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mmap/mmap18.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index dc0ca5626..ed86bb593 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -747,6 +747,7 @@ mmap14 mmap14
>  mmap15 mmap15
>  mmap16 mmap16
>  mmap17 mmap17
> +mmap18 mmap18
>  
>  modify_ldt01 modify_ldt01
>  modify_ldt02 modify_ldt02
> diff --git a/testcases/kernel/syscalls/mmap/.gitignore b/testcases/kernel/syscalls/mmap/.gitignore
> index c5c083d4b..4fd90ab5f 100644
> --- a/testcases/kernel/syscalls/mmap/.gitignore
> +++ b/testcases/kernel/syscalls/mmap/.gitignore
> @@ -16,3 +16,4 @@
>  /mmap15
>  /mmap16
>  /mmap17
> +/mmap18
> diff --git a/testcases/kernel/syscalls/mmap/mmap18.c b/testcases/kernel/syscalls/mmap/mmap18.c
> new file mode 100644
> index 000000000..ea02432da
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mmap/mmap18.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2020
> + * Email: code@zilogic.com
> + */
> +
> +/*
> + * Test mmap() MAP_GROWSDOWN flag
> + *
> + * We assign the memory region allocated using MAP_GROWSDOWN to a thread,
> + * as a stack, to test the effect of MAP_GROWSDOWN. This is because the
> + * kernel only grows the memory region when the stack pointer, is within
> + * guard page, when the guard page is touched.
> + *
> + * 1. Map an anyonymous memory region of size X, and unmap it.
> + * 2. Split the unmapped memory region into two.
> + * 3. The lower memory region is left unmapped.
> + * 4. The higher memory region is mapped for use as stack, using
> + *    MAP_FIXED | MAP_GROWSDOWN.
> + * 5. The higher memory region is provided as stack to a thread, where
> + *    a recursive function is invoked.
> + * 6. The stack grows beyond the allocated region, into the lower memory area.
> + * 7. If this results in the memory region being extended, into the
> + *    unmapped region, the test is considered to have passed.
> + */
> +
> +#include <unistd.h>
> +#include <pthread.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <sys/types.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
> +
> +#define UNITS(x) ((x) * PTHREAD_STACK_MIN)
> +
> +static void *stack;
> +static long stack_size = UNITS(8);
> +
> +static bool __attribute__((noinline)) check_stackgrow_up(void)
> +{
> +	char local_var;
> +	static char *addr;
> +
> +       if (!addr) {
> +               addr = &local_var;
> +               return check_stackgrow_up();
> +       }
> +
> +       return (addr < &local_var);
> +}
> +
> +static void setup(void)
> +{
> +	if (check_stackgrow_up())
> +		tst_brk(TCONF, "Test can't be performed with stack grows up architecture");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (stack)
> +		SAFE_MUNMAP(stack, stack_size);
> +}
> +
> +static void allocate_stack(size_t size)
> +{
> +	void *start;
> +
> +	/*
> +	 * Since the newer kernel does not allow a MAP_GROWSDOWN mapping to grow
> +	 * closer than 'stack_guard_gap' pages away from a preceding mapping.
> +	 * The guard then ensures that the next-highest mapped page remains more
> +	 * than 'stack_guard_gap' below the lowest stack address, and if not then
> +	 * it will trigger a segfault. So, here adding 256 pages memory spacing
> +	 * for stack growing safely.
> +	 *
> +	 * Btw, kernel default 'stack_guard_gap' size is '256 * getpagesize()'.
> +	 */
> +	long total_size = 256 * getpagesize() + size * 2;
> +
> +	start = SAFE_MMAP(NULL, total_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	SAFE_MUNMAP(start, total_size);
> +
> +	/* start                             stack
> +	 * +-----------+---------------------+----------------------+
> +	 * | 256 pages | unmapped (size)     | mapped (size)        |
> +	 * +-----------+---------------------+----------------------+
> +	 *
> +	 */
> +	stack = SAFE_MMAP((start + total_size - size), size, PROT_READ | PROT_WRITE,
> +			  MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS | MAP_GROWSDOWN,
> +			  -1, 0);
> +
> +	tst_res(TINFO, "start = %p, stack = %p", start, stack);
> +}
> +
> +static __attribute__((noinline)) void *check_depth_recursive(void *limit)
> +{
> +	if ((off_t) &limit < (off_t) limit) {
> +		tst_res(TINFO, "&limit = %p, limit = %p", &limit, limit);
> +		return NULL;
> +	}
> +
> +	return check_depth_recursive(limit);
> +}
> +
> +static void grow_stack(void *stack, size_t size, void *limit)
> +{
> +	pthread_t test_thread;
> +	pthread_attr_t attr;
> +	int ret;
> +
> +	ret = pthread_attr_init(&attr);
> +	if (ret)
> +		tst_brk(TBROK, "pthread_attr_init failed during setup");
> +
> +	ret = pthread_attr_setstack(&attr, stack, size);
> +	if (ret)
> +		tst_brk(TBROK, "pthread_attr_setstack failed during setup");
> +
> +	SAFE_PTHREAD_CREATE(&test_thread, &attr, check_depth_recursive, limit);
> +	SAFE_PTHREAD_JOIN(test_thread, NULL);
> +
> +	exit(0);
> +}
> +
> +static void run_test(void)
> +{
> +	pid_t child_pid;
> +	int wstatus;
> +
> +	allocate_stack(stack_size);
> +
> +	child_pid = SAFE_FORK();
> +	if (!child_pid)
> +		grow_stack(stack, stack_size, stack - stack_size + UNITS(1));

Why don't we allocate the stack here in the child process? That way we
can also get rid of the cleanup() function.

Also when we are at it, can we also add a second test where we mmap() a
page in the space the stack is supposed to grow into i.e. do
allocate_stack() then mmap() a page in the free address space and check
that the child is killed by a SIGSEGV?

> +	SAFE_WAIT(&wstatus);
> +	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0)
> +		tst_res(TPASS, "Stack grows in unmapped region");
> +	else if (WIFSIGNALED(wstatus))
> +		tst_res(TFAIL, "Child killed by %s", tst_strsig(WTERMSIG(wstatus)));

There is no point in this else if and tst_res(), the tst_strstatus() will print that info
for you.

> +	else
> +		tst_res(TFAIL, "Child %s", tst_strstatus(wstatus));
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.forks_child = 1,
> +};

-- 
Cyril Hrubis
chrubis@suse.cz
