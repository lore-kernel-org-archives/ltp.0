From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Apr 2020 16:08:53 +0800
Subject: [LTP] [PATCH v4 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
In-Reply-To: <1587552329-21738-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1587552329-21738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587552329-21738-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2ea_CtRyP9KtpJDjpEzobRyhrodiycDCAxhLbCjuOwhCQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 22, 2020 at 6:47 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  runtest/syscalls                           |   1 +
>  testcases/kernel/syscalls/pipe2/.gitignore |   1 +
>  testcases/kernel/syscalls/pipe2/pipe2_03.c | 172 +++++++++++++++++++++
>  3 files changed, 174 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/pipe2/pipe2_03.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 9bb72beb2..16add02d3 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -916,6 +916,7 @@ pipe13 pipe13
>
>  pipe2_01 pipe2_01
>  pipe2_02 pipe2_02
> +pipe2_03 pipe2_03
>  pipe2_04 pipe2_04
>
>  pivot_root01 pivot_root01
> diff --git a/testcases/kernel/syscalls/pipe2/.gitignore
> b/testcases/kernel/syscalls/pipe2/.gitignore
> index 773450a48..ede1da65e 100644
> --- a/testcases/kernel/syscalls/pipe2/.gitignore
> +++ b/testcases/kernel/syscalls/pipe2/.gitignore
> @@ -1,3 +1,4 @@
>  /pipe2_01
>  /pipe2_02
> +/pipe2_03
>  /pipe2_04
> diff --git a/testcases/kernel/syscalls/pipe2/pipe2_03.c
> b/testcases/kernel/syscalls/pipe2/pipe2_03.c
> new file mode 100644
> index 000000000..0314f9eda
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pipe2/pipe2_03.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + *
> + * This case is designed to test the basic functionality about the
> + * O_DIRECT flag of pipe2.
> + *
> + * It includes three sub tests.
> + * 1) Each write(2) to the pipe is dealt with as a separate packet, and
> + * read(2)s from the pipe will read one packet at a time.
> + * 2) Writes of greater than PIPE_BUF bytes (see pipe(7)) will be split
> + * into multiple packet.
> + * 3)If a read(2) specifies a buffer size that is smaller than the next
> + * packet, then the requested number of bytes are read, and the excess
> + * bytes in the packet are discarded.
> + */
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <linux/limits.h>
> +#include "lapi/fcntl.h"
> +#include "tst_test.h"
> +
> +static int fds[2], packet_num, pipe_size;
> +static char *wrbuf;
> +static char *rdbuf;
> +static void check_peer_rw(void);
> +static void check_split(void);
> +static void check_discard(void);
> +
> +static void (*test_func[])(void) = {check_peer_rw, check_split,
> check_discard};
> +
> +static void check_peer_rw(void)
> +{
> +       int i, pid;
> +
> +       SAFE_PIPE2(fds, O_DIRECT | O_NONBLOCK);
> +
> +       pid = SAFE_FORK();
> +       if (!pid) {
> +               SAFE_CLOSE(fds[1]);
> +               memset(rdbuf, 0, pipe_size);
> +               TST_CHECKPOINT_WAIT(0);
> +               for (i = 0; i < packet_num; i++) {
> +                       TEST(SAFE_READ(0, fds[0], rdbuf, pipe_size));
> +                       if (TST_RET != 1)
> +                               tst_res(TFAIL,
> +                                       "Each read(2) doesn't read a
> separate packet, return %ld", TST_RET);
> +               }
> +               tst_res(TPASS, "Each read(2) reads a separate packet");
> +                _exit(0);
> +       }
> +
> +       SAFE_CLOSE(fds[0]);
> +       for (i = 0; i < packet_num; i++)
> +               SAFE_WRITE(1, fds[1], "x", 1);
> +
>

I got a failure on the ppc64le platform(page size: 65536kB).

# ./pipe2_03
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
pipe_size = 1048576
PIPE_BUF = 4096
packet_num = 256
safe_macros.c:457: BROK: pipe2_03.c:58:
write(4,0x1001d2b8,18446744073709551615) failed: EAGAIN/EWOULDBLOCK (11)
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200423/ab57c8b1/attachment.htm>
