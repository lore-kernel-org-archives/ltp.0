From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Jul 2020 11:20:58 +0800
Subject: [LTP] [PATCH v2] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <20200703030811.11521-1-pravinraghul@zilogic.com>
References: <20200703030811.11521-1-pravinraghul@zilogic.com>
Message-ID: <CAEemH2febKOruSdyVDMa8sOTFNnSEdEwZkY1OP_34=Ac2GDxSA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,


On Fri, Jul 3, 2020 at 11:09 AM pravin <pravinraghul@zilogic.com> wrote:

> ...
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
> + * 6. The stack grows beyond the allocated region, into the lower memory
> area.
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
> +
> +static bool check_stackgrow_up(int *local_var_1)
> +{
> +       int local_var_2;
> +
> +       return !(local_var_1 < &local_var_2);
>

Shouldn't local_var_1 less than local_var_2 on a stack grow up arch? why we
return the reverse value here?

And the worth to say that the optimization of GCC will break this rule in
the compilation.

 -O2  (ltp default gcc flag)
mmap18.c:46: INFO: local_var_1 = 0x3ffd177dea0, loval_var_2 = 0x3ffd177dea4
-O0
mmap18.c:46: INFO: local_var_1 = 0x3ffc86fe614, loval_var_2 = 0x3ffc86fe56c

--------

Apart from that, mmap18 also gets FAIL with s390x platform like:

# ./mmap18
tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
mmap18.c:46: INFO: local_var_1 = 0x3fff537e5d4, loval_var_2 = 0x3fff537e52c
mmap18.c:126: INFO: mem = 0x3ff8dd3a000, stack = 0x3ff8dd5a000
mmap18.c:136: FAIL: Child killed by SIGSEGV

Summary:
passed   0
failed   1
skipped  0
warnings 0

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200728/00519f14/attachment-0001.htm>
