From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Sep 2020 15:08:36 +0200
Subject: [LTP] [PATCH v5] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <20200911035533.30538-1-liwang@redhat.com>
References: <20200911035533.30538-1-liwang@redhat.com>
Message-ID: <20200911130836.GA2582@yuki.lan>
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
> Also, to verify that(Test2) the stack grows to within a page of the high
> end of the next lower map???ping will result in a SIGSEGV signal.
> 
> Resolves #300
> Signed-off-by: Pravin Raghul S. <pravinraghul@zilogic.com>
> Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/syscalls                          |   1 +
>  testcases/kernel/syscalls/mmap/.gitignore |   1 +
>  testcases/kernel/syscalls/mmap/mmap18.c   | 177 ++++++++++++++++++++++
>  3 files changed, 179 insertions(+)
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
> index 000000000..b5008497d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mmap/mmap18.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2020
> + * Email: code@zilogic.com
> + */
> +
> +/*
> + * Test mmap() MAP_GROWSDOWN flag
> + *
> + * # Test1:
> + *   We assign the memory region allocated using MAP_GROWSDOWN to a thread,
> + *   as a stack, to test the effect of MAP_GROWSDOWN. This is because the
> + *   kernel only grows the memory region when the stack pointer, is within
> + *   guard page, when the guard page is touched.
> + *
> + *   1. Map an anyonymous memory region of size X, and unmap it.
> + *   2. Split the unmapped memory region into two.
> + *   3. The lower memory region is left unmapped.
> + *   4. The higher memory region is mapped for use as stack, using
> + *      MAP_FIXED | MAP_GROWSDOWN.
> + *   5. The higher memory region is provided as stack to a thread, where
> + *      a recursive function is invoked.
> + *   6. The stack grows beyond the allocated region, into the lower memory area.
> + *   7. If this results in the memory region being extended, into the
> + *      unmapped region, the test is considered to have passed.
> + *
> + * # Test2:
> + *   Steps mostly like Test1, but mmaping a page in the space the stack is
> + *   supposed to grow into. To verify that the stack grows to within a page
> + *   of the high end of the next lower map???ping, at which point touching
> + *   the "guard" page will result in a SIGSEGV signal.
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

Well it's not wrong per se but as it is we do not use the pre-allocated
part of the stack at all, we directly jump for the guard page as we use
the stack pointer as a base for the pthread stack. The actual pointer
that points to the start of the region is stack - stack_size.

There is no point in adding size * 2 here. We can as well reserve 256 *
page_size + size. Then map() a single page at the end, which would be at
start + total_size - page_size and finally return start + total_size
from this function and pass that to pthread_attr_setstack().

That way it would look like:

| 256 pages | unmapped | 1 mapped page |

            | - - -  stack_size  - - - |


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
> +	if (stack)
> +		SAFE_MUNMAP(stack, stack_size);

I'ts a bit unexpected to unmap the stack here. I guess that unamping it
in the run_test() after the grow_stack() call would be a bit cleaner but
we would have to move the exit(0) there as well.

> +	exit(0);
> +}
> +
> +static void run_test(void)
> +{
> +	pid_t child_pid;
> +	int wstatus;
> +
> +	/* Test 1 */
> +	child_pid = SAFE_FORK();
> +	if (!child_pid) {
> +		allocate_stack(stack_size);
> +		grow_stack(stack, stack_size, stack - stack_size + UNITS(1));


> +	}
> +
> +	SAFE_WAIT(&wstatus);
> +	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0)
> +		tst_res(TPASS, "Stack grows in unmapped region");
> +	else
> +		tst_res(TFAIL, "Child: %s", tst_strstatus(wstatus));
> +
> +	/* Test 2 */
> +	child_pid = SAFE_FORK();
> +	if (!child_pid) {
> +		tst_no_corefile(0);
                  ^
		 This should go to the test setup.

> +		allocate_stack(stack_size);
> +
> +		SAFE_MMAP(stack - stack_size, UNITS(1), PROT_READ | PROT_WRITE,
> +			  MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +		/* This will cause to segment fault (SIGSEGV) */
> +		grow_stack(stack, stack_size, stack - stack_size + UNITS(1));
> +	}
> +
> +	SAFE_WAIT(&wstatus);
> +        if (WIFSIGNALED(wstatus) && WTERMSIG(wstatus) == SIGSEGV)
> +		tst_res(TPASS, "Child ended by %s as expected", tst_strsig(SIGSEGV));
> +        else
> +                tst_res(TFAIL, "Child: %s", tst_strstatus(wstatus));
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run_test,
> +	.forks_child = 1,
> +};
> -- 
> 2.21.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
