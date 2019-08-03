From: Li Wang <liwang@redhat.com>
Date: Sat, 3 Aug 2019 20:55:41 +0800
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <20190801092616.30553-2-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-2-chrubis@suse.cz>
Message-ID: <CAEemH2dBj6Re=+booW5Lc77P1yumEbqP_4g6NMRPji-CtUG-aw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

This is a quite good idea to involve guard buffer in LTP testing. And
you patch set looks very clean & tidy, just have some few comments in
below.

On Thu, Aug 1, 2019 at 5:27 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> This commit adds a support for guarder buffers. Guarded buffer is a
> buffer allocated so that there is PROT_NONE page immediatelly after the
> end of the buffer i.e. any access after the buffer generates
> SEGFAULT/EFAULT etc.
>
> The library is hooked into the tst_test structure so that all you need
> is to fill up an NULL terminated array of buffer pointers and sizes to
> get the respective buffers allocated. The library supports allocating
> memory in test runtime as well as well as allocating more complex
> buffers, which currently are iovec vectors.
>
> All buffers are freeed automatically at the end of the test.
...

> + * Allocates size bytes, returns pointer to the allocated buffer.
> + */
> +void *tst_alloc(size_t size);

What about drawing a simple picture in the code comments? That can
help people to understand what kind of buffer structure the
tst_alloc() returned.

/*
 * Allocates size bytes, returns pointer to the allocated buffer.
 *
 * This is the structure of the allocated buferr:
 *
 * |<--  1 page  -->|                 |<--  1 page  -->|
 *
 * -----------------------------------------------------
 * | buf_shift | <-- bufs[i].size --> |  1 guard page  |
 * -----------------------------------------------------
 */
void *tst_alloc(size_t size);

> +++ b/include/tst_test.h
> @@ -35,6 +35,7 @@
>  #include "tst_path_has_mnt_flags.h"
>  #include "tst_sys_conf.h"
>  #include "tst_coredump.h"
> +#include "tst_buffers.h"
>
>  /*
>   * Reports testcase result.
> @@ -200,6 +201,11 @@ struct tst_test {
>          * test.
>          */
>         const char *const *needs_kconfigs;
> +
> +       /*
> +        * NULL-terminated array to be allocated buffers.
> +        */
> +       struct tst_buffers *bufs;

I tend to agree with Richard for this. Looks like adding such a new
field in tst_test struct is a little bit complicated. Maybe we can
define a series macro for doing that, which something likes:

TST_INIT_GUARD_BUFFER(ptr, size)
TST_INIT_IOVEC_GUARD_BUFFER(ptr, iov_sizes)

then, testcase just calling it in setup() if needed.

--
Regards,
Li Wang
