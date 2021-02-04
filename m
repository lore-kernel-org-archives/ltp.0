From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Feb 2021 21:51:18 +0800
Subject: [LTP] [PATCH v2 4/5] syscalls/mallinfo02: Add a basic test to
 check use mmap or sbrk
In-Reply-To: <1612440762-22389-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
 <1612440762-22389-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1612440762-22389-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2ehgnR0Ad5VzR63KgtjFBoqH5N_1b13T7f5Gw6n3EkzdA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Feb 4, 2021 at 8:12 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

> According mallinfo man-page, hblkhd member represents
> "The number of bytes in blocks currently allocated using mmap(2).".
> For allocations greater than or equal to 128K and that can't be satisfied
> from
> the free list, the memory-allocation functions employ mmap(2) instead of
> increasing
> the program break using sbrk(2).
>
> In this case, we test 20k size to use sbrk and 128k size to use mmap.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
> v1->v2:
> 1.Use mallopt(M_MMAP_THRESHOLD, 131072) to avoid dynamic mmap threshold
> 2.Use tst_print_malinfo api
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/mallinfo/.gitignore |  1 +
>  .../kernel/syscalls/mallinfo/mallinfo02.c     | 64 +++++++++++++++++++
>  3 files changed, 66 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mallinfo/mallinfo02.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 753340068..a8fa3f7bf 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -683,6 +683,7 @@ lstat02 lstat02
>  lstat02_64 lstat02_64
>
>  mallinfo01 mallinfo01
> +mallinfo02 mallinfo02
>
>  mallopt01 mallopt01
>
> diff --git a/testcases/kernel/syscalls/mallinfo/.gitignore
> b/testcases/kernel/syscalls/mallinfo/.gitignore
> index a7e32a637..678ac277e 100644
> --- a/testcases/kernel/syscalls/mallinfo/.gitignore
> +++ b/testcases/kernel/syscalls/mallinfo/.gitignore
> @@ -1 +1,2 @@
>  /mallinfo01
> +/mallinfo02
> diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo02.c
> b/testcases/kernel/syscalls/mallinfo/mallinfo02.c
> new file mode 100644
> index 000000000..d5bed45a8
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mallinfo/mallinfo02.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + */
> +
> +/*\
> + * [DESCRIPTION]
> + *
> + * Basic mallinfo() test for malloc() using sbrk or mmap.
> + * It size > MMAP_THRESHOLD, it will use mmap. Otherwise, use sbrk.
> +\*/
> +
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "tst_mallinfo.h"
> +
> +#ifdef HAVE_MALLINFO
> +void test_mallopt(void)
>

what about renaming to test_mallinfo(void) ?



> +{
> +       struct mallinfo info;
> +       int size;
> +       char *buf;
> +
> +       buf = SAFE_MALLOC(20480);
> +
> +       info = mallinfo();
> +       if (info.uordblks > 20480 && info.hblkhd == 0) {
> +               tst_res(TPASS, "malloc() uses sbrk when size < 128k");
> +       } else {
> +               tst_res(TFAIL, "malloc() use mmap when size < 128k");
> +               tst_print_mallinfo("Test malloc(20480)", &info);
> +       }
> +       free(buf);
> +
> +       info = mallinfo();
> +       size = MAX(info.fordblks, 131072);
> +
> +       buf = SAFE_MALLOC(size);
> +       info = mallinfo();
> +       if (info.hblkhd > size && info.hblks > 0) {
> +               tst_res(TPASS, "malloc() uses mmap when size >= 128k");
> +       } else {
> +               tst_res(TFAIL, "malloc uses sbrk when size >= 128k");
>

Why not 'TFAIL | TERRNO' ?


> +               tst_print_mallinfo("Test malloc(1024*128)", &info);
> +       }
> +
> +       free(buf);
> +}
> +
> +static void setup(void)
> +{
> +       if (mallopt(M_MMAP_THRESHOLD, 131072) == 0)
> +               tst_res(TFAIL, "mallopt(M_MMAP_THRESHOLD, 128K) failed");
>

Here as well.


> +}
> +
> +static struct tst_test test = {
> +       .setup = setup,
> +       .test_all = test_mallopt,
> +};
> +
> +#else
> +TST_TEST_TCONF("system doesn't implement non-POSIX mallinfo()");
> +#endif
> --
> 2.23.0
>
>
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210204/4e0843f5/attachment-0001.htm>
