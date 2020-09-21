From: Li Wang <liwang@redhat.com>
Date: Mon, 21 Sep 2020 12:08:41 +0800
Subject: [LTP] [PATCH v6] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <20200918171710.19227-1-chrubis@suse.cz>
References: <20200918171710.19227-1-chrubis@suse.cz>
Message-ID: <CAEemH2d_m16MhGrjxWHCeQ0BU9Fa562TVjaa+C_ecnPYhCfthw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Sep 19, 2020 at 1:16 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> ...
> +/*
> + * Test mmap() MAP_GROWSDOWN flag
> + *
> + * # Test1:
> + *
> + *   We assign the memory region partially allocated with MAP_GROWSDOWN
> flag to
> + *   a thread as a stack and expect the mapping to grow when we touch the
> + *   guard page by calling a recusive function in the thread that uses the
> + *   growable mapping as a stack.
> + *
> + *   The kernel only grows the memory region when the stack pointer is
> within
> + *   guard page when the guard page is touched so simply faulting the
> guard
> + *   page will not cause the mapping to grow.
> + *
> + *   Newer kernels does not allow a MAP_GROWSDOWN mapping to grow closer
> than
> + *   'stack_guard_gap' pages to an existing mapping. So when we map the
> stack we
> + *   make sure there is enough of free address space before the lowest
> stack
> + *   address.
> + *
> + *   Kernel default 'stack_guard_gap' size is '256 * getpagesize()'.
> + *
> + *   The stack memory map would look like:
> + *
> + *   |  -  -  -   reserved  size   -  -  -  |
> + *
> + *   +-- - - - --+------------+-------------+
> + *   | 256 pages |  unmapped  |   mapped    |
> + *   +-- - - - --+------------+-------------+
> + *                            | mapped size |
> + *   ^           |  -  -  stack size  -  -  |
> + *   start
> + *               ^                          ^
> + *               stack bottom       stack top
> + *
> + * # Test2:
> + *
> + *   We allocate stack as we do in the first test but we mmap a page in
> the
> + *   space the stack is supposed to grow into and we expect the thread to
> + *   segfault when the guard page is faulted.
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
> +static long page_size;
> +
> +static bool __attribute__((noinline)) check_stackgrow_up(void)
> +{
> +       char local_var;
> +       static char *addr;
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
> +       if (check_stackgrow_up())
> +               tst_brk(TCONF, "Test can't be performed with stack grows
> up architecture");
> +
> +       page_size = getpagesize();
> +}
> +
> +/*
> + * Returns stack lowest address. Note that the address is not mapped and
> will
> + * be mapped on page fault when we grow the stack to the lowest address
> possible.
> + */
> +static void *allocate_stack(size_t stack_size, size_t mapped_size)
> +{
> +       void *start, *stack_top, *stack_bottom;
> +
> +       long reserved_size = 256 * page_size + stack_size;
> +
> +       start = SAFE_MMAP(NULL, reserved_size, PROT_READ | PROT_WRITE,
> +                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       SAFE_MUNMAP(start, reserved_size);
> +
> +       SAFE_MMAP((start + reserved_size - mapped_size), mapped_size,
> PROT_READ | PROT_WRITE,
> +                 MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS | MAP_GROWSDOWN,
> +                 -1, 0);
> +
> +       stack_top = start + reserved_size;
> +       stack_bottom = start + reserved_size - stack_size;
>

As the stack grows down, shouldn't grow from stack_bottom to stack_top?
which
means stack_bottom = start + reserved_size.

 *   |  -  -  -   reserved  size   -  -  -  |
 *
 *   +-- - - - --+------------+-------------+
 *   | 256 pages |  unmapped  |   mapped    |
 *   +-- - - - --+------------+-------------+
 *                            | mapped size |
 *   ^           |  -  -  stack size  -  -  |
 *   start
 *               ^                          ^
 *               stack top       stack bottom



> +
> +       tst_res(TINFO, "start = %p, stack_top = %p, stack bottom = %p",
>

a typo here: stack_bottom ^



> +               start, stack_top, stack_bottom);
> +       tst_res(TINFO, "mapped pages %zu, stack pages %zu",
> +               mapped_size/page_size, stack_size/page_size);
> +
> +       return stack_bottom;
>

return stack_top here?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200921/5c817a49/attachment.htm>
