From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 21 Apr 2020 18:21:22 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
In-Reply-To: <CAEemH2eeUa0XJSGeyid2J373FnvqSAQCjdO1AkbpHGTFisGGNA@mail.gmail.com>
References: <1586927503-10827-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eeUa0XJSGeyid2J373FnvqSAQCjdO1AkbpHGTFisGGNA@mail.gmail.com>
Message-ID: <be1c1761-c518-f3ee-ef19-b4f45d36df80@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li

> 
> 
> On Thu, Apr 16, 2020 at 3:29 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com 
> <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
> 
>     Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com
>     <mailto:xuyang2018.jy@cn.fujitsu.com>>
>     ---
>      ?runtest/syscalls? ? ? ? ? ? ? ? ? ? ? ? ? ?|? ?1 +
>      ?testcases/kernel/syscalls/pipe2/.gitignore |? ?1 +
>      ?testcases/kernel/syscalls/pipe2/pipe2_03.c | 157 +++++++++++++++++++++
>      ?3 files changed, 159 insertions(+)
>      ?create mode 100644 testcases/kernel/syscalls/pipe2/pipe2_03.c
> 
>     diff --git a/runtest/syscalls b/runtest/syscalls
>     index 44254d7da..4d8ebc5a3 100644
>     --- a/runtest/syscalls
>     +++ b/runtest/syscalls
>     @@ -912,6 +912,7 @@ pipe13 pipe13
> 
>      ?pipe2_01 pipe2_01
>      ?pipe2_02 pipe2_02
>     +pipe2_03 pipe2_03
> 
>      ?pivot_root01 pivot_root01
> 
>     diff --git a/testcases/kernel/syscalls/pipe2/.gitignore
>     b/testcases/kernel/syscalls/pipe2/.gitignore
>     index 786222de2..4cc5acaf1 100644
>     --- a/testcases/kernel/syscalls/pipe2/.gitignore
>     +++ b/testcases/kernel/syscalls/pipe2/.gitignore
>     @@ -1,3 +1,4 @@
>      ?/pipe2_01
>      ?/pipe2_02
>      ?/pipe2_02_child
>     +/pipe2_03
>     diff --git a/testcases/kernel/syscalls/pipe2/pipe2_03.c
>     b/testcases/kernel/syscalls/pipe2/pipe2_03.c
>     new file mode 100644
>     index 000000000..0b5d37dd0
>     --- /dev/null
>     +++ b/testcases/kernel/syscalls/pipe2/pipe2_03.c
>     @@ -0,0 +1,157 @@
>     +// SPDX-License-Identifier: GPL-2.0-or-later
>     +/*
>     + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
>     + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com
>     <mailto:xuyang2018.jy@cn.fujitsu.com>>
>     + *
>     + * This case is designed to test the basic functionality about the
>     + * O_DIRECT flag of pipe2.
>     + *
>     + * It includes three sub tests.
>     + * 1) Each write(2) to the pipe is dealt with as a separate packet, and
>     + * read(2)s from the pipe will read one packet at a time.
>     + * 2) Writes of greater than PIPE_BUF bytes (see pipe(7)) will be split
>     + * into multiple packet.
>     + * 3)If a read(2) specifies a buffer size that is smaller than the next
>     + * packet, then the requested number of bytes are read, and the excess
>     + * bytes in the packet are discarded.
>     + */
>     +#define _GNU_SOURCE
>     +#include <stdio.h>
>     +#include <unistd.h>
>     +#include <stdlib.h>
>     +#include <linux/limits.h>
>     +#include "lapi/fcntl.h"
>     +#include "tst_test.h"
>     +
>     +static int fds[2], packet_num, pipe_size;
>     +static char *wrbuf;
>     +static char *rdbuf;
>     +static void check_peer_rw(void);
>     +static void check_split(void);
>     +static void check_discard(void);
>     +
>     +static void (*test_func[])(void) = {check_peer_rw, check_split,
>     check_discard};
>     +
>     +static void check_peer_rw(void)
>     +{
>     +? ? ? ?int i, pid;
>     +
>     +? ? ? ?SAFE_PIPE2(fds, O_DIRECT | O_NONBLOCK);
>     +? ? ? ?for (i = 0; i < packet_num; i++)
>     +? ? ? ? ? ? ? ?SAFE_WRITE(1, fds[1], "x", 1);
>     +
>     +? ? ? ?TEST(write(fds[1], "x", 1));
>     +? ? ? ?if (TST_RET != -1) {
>     +? ? ? ? ? ? ? ?tst_res(TFAIL, "write succeeded unexpectedly");
>     +? ? ? ?} else {
>     +? ? ? ? ? ? ? ?if (TST_ERR == EAGAIN)
>     +? ? ? ? ? ? ? ? ? ? ? ?tst_res(TPASS, "Each write(2) uses a
>     separate packet");
>     +? ? ? ? ? ? ? ?else
>     +? ? ? ? ? ? ? ? ? ? ? ?tst_res(TFAIL | TTERRNO, "write failed,
>     expected EAGAIN but got");
>     +? ? ? ?}
>     +? ? ? ?pid = SAFE_FORK();
>     +? ? ? ?if (!pid) {
>     +? ? ? ? ? ? ? ?memset(rdbuf, 0, pipe_size);
>     +? ? ? ? ? ? ? ?for (i = 0; i < packet_num; i++) {
>     +? ? ? ? ? ? ? ? ? ? ? ?TEST(SAFE_READ(0, fds[0], rdbuf, pipe_size));
>     +? ? ? ? ? ? ? ? ? ? ? ?if (TST_RET != 1)
>     +? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?tst_res(TFAIL,
>     +? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"Each read(2) doesn't read a
>     separate packet, return %ld", TST_RET);
>     +? ? ? ? ? ? ? ?}
>     +? ? ? ? ? ? ? ?tst_res(TPASS, "Each read(2) reads a separate packet");
> 
> 
> I would add _exit(0); at the end of the child.
> + ? ? ? ? ? ? ? _exit(0);
> 
>     +? ? ? ?}
> 
> 
> And move the tst_reap_children() from the main process to here.
> 
> + ? ? ? tst_reap_children();
> + ? ? ? SAFE_CLOSE(fds[0]);
> + ? ? ? SAFE_CLOSE(fds[1]);
> 
>     +}
>     +
>     +static void check_split(void)
>     +{
>     +? ? ? ?int i, pid;
>     +
>     +? ? ? ?SAFE_PIPE2(fds, O_DIRECT);
>     +? ? ? ?SAFE_WRITE(1, fds[1], wrbuf, PIPE_BUF * 2);
>     +
>     +? ? ? ?pid = SAFE_FORK();
>     +? ? ? ?if (!pid) {
>     +? ? ? ? ? ? ? ?memset(rdbuf, 0, pipe_size);
>     +? ? ? ? ? ? ? ?for (i = 0; i < 2; i++) {
>     +? ? ? ? ? ? ? ? ? ? ? ?TEST(SAFE_READ(0, fds[0], rdbuf, pipe_size));
>     +? ? ? ? ? ? ? ? ? ? ? ?if (TST_RET != PIPE_BUF)
>     +? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?tst_res(TFAIL,
>     +? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"write(higner than PIPE_BUF)
>     split into multiple packet, return %ld", TST_RET);
>     +? ? ? ? ? ? ? ?}
>     +? ? ? ? ? ? ? ?tst_res(TPASS, "write(higner than PIPE_BUF) split
>     into multiple packet");
> 
> + ? ? ? ? ? ? ? _exit(0);
> 
>     +? ? ? ?}
> 
> + ? ? ? tst_reap_children();
> + ? ? ? SAFE_CLOSE(fds[0]);
> + ? ? ? SAFE_CLOSE(fds[1]);
> 
>     +}
>     +
>     +static void check_discard(void)
>     +{
>     +? ? ? ?int pid;
>     +? ? ? ?char tmp_buf[20];
>     +? ? ? ?char tmp_secondbuf[20];
>     +
>     +? ? ? ?SAFE_PIPE2(fds, O_DIRECT);
>     +? ? ? ?SAFE_WRITE(1, fds[1], wrbuf, PIPE_BUF);
>     +? ? ? ?SAFE_WRITE(1, fds[1], "1", 1);
>     +
>     +? ? ? ?pid = SAFE_FORK();
>     +? ? ? ?if (!pid) {
>     +? ? ? ? ? ? ? ?TEST(SAFE_READ(0, fds[0], tmp_buf, 20));
>     +? ? ? ? ? ? ? ?if (TST_RET != 20)
>     +? ? ? ? ? ? ? ? ? ? ? ?tst_res(TFAIL,
>     +? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"the excess bytes in the packet
>     isn't discarded by read, return %ld", TST_RET);
>     +? ? ? ? ? ? ? ?TEST(SAFE_READ(0, fds[0], tmp_secondbuf, 20));
>     +? ? ? ? ? ? ? ?if (TST_RET == 1) {
>     +? ? ? ? ? ? ? ? ? ? ? ?if (!strcmp(tmp_secondbuf, "1"))
>     +? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?tst_res(TPASS,
>     +? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"the excess bytes in the
>     packet is discarded by read, only read 1");
>     +? ? ? ? ? ? ? ? ? ? ? ?else
>     +? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?tst_res(TFAIL,
>     +? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"the excess bytes in the
>     packet is discarded by read, expect 1 got %s", tmp_secondbuf);
>     +? ? ? ? ? ? ? ?}
> 
> + ? ? ? ? ? ? ? _exit(0);
> 
>     +? ? ? ?}
> 
> + ? ? ? tst_reap_children();
> + ? ? ? SAFE_CLOSE(fds[0]);
> + ? ? ? SAFE_CLOSE(fds[1]);
> 
>     +}
>     +
>     +static void verify_pipe2(unsigned int n)
>     +{
>     +? ? ? ?int pid;
>     +
>     +? ? ? ?pid = SAFE_FORK();
> 
> 
> Why we need fork() here? I don't see any necessary reason for twice fork 
> in the main process.Yes, it only needs one fork. At the beginning, I think we should do 
actual test in child process( I remember having such rule) especially 
when there are multiple subtests.  So I fork twice to make sure all sub 
test in child or grandchild process.
> 
>     +? ? ? ?if (pid == 0) {
>     +? ? ? ? ? ? ? ?(*test_func[n])();
> 
>     +? ? ? ? ? ? ? ?tst_reap_children();
>     +? ? ? ? ? ? ? ?SAFE_CLOSE(fds[0]);
>     +? ? ? ? ? ? ? ?SAFE_CLOSE(fds[1]);
> 
> 
> I tend to move the cloese(fd) to the test process to nearby?pipe2(). 
> Otherwise, it causes an unclear error like:
> 
> # ./pipe2_03
> tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> pipe2_03.c:48: PASS: Each write(2) uses a separate packet
> pipe2_03.c:61: PASS: Each read(2) reads a separate packet
> pipe2_03.c:81: PASS: write(higner than PIPE_BUF) split into multiple packet
> pipe2_03.c:108: FAIL: the excess bytes in the packet is discarded by 
> read, expect 1 got 1%A
Even I use one fork and exit(0), I don't meet this problem. Or, I miss 
something?

--- a/testcases/kernel/syscalls/pipe2/pipe2_03.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_03.c
@@ -59,6 +59,7 @@ static void check_peer_rw(void)
                                         "Each read(2) doesn't read a 
separate packet, return %ld", TST_RET);
                 }
                 tst_res(TPASS, "Each read(2) reads a separate packet");
+                _exit(0);
         }
  }

@@ -79,6 +80,7 @@ static void check_split(void)
                                         "write(higner than PIPE_BUF) 
split into multiple packet, return %ld", TST_RET);
                 }
                 tst_res(TPASS, "write(higner than PIPE_BUF) split into 
multiple packet");
+                _exit(0);
         }
  }

@@ -107,21 +109,17 @@ static void check_discard(void)
                                 tst_res(TFAIL,
                                         "the excess bytes in the packet 
is discarded by read, expect 1 got %s", tmp_secondbuf);
                 }
+                _exit(0);
         }
  }

  static void verify_pipe2(unsigned int n)
  {
-       int pid;
-
-       pid = SAFE_FORK();
-       if (pid == 0) {
-               (*test_func[n])();
-               tst_reap_children();
-               SAFE_CLOSE(fds[0]);
-               SAFE_CLOSE(fds[1]);
-       }
+       (*test_func[n])();
+       SAFE_CLOSE(fds[0]);
+       SAFE_CLOSE(fds[1]);
         tst_reap_children();
+
  }

> 
>     +? ? ? ?}
>     +? ? ? ?tst_reap_children();
>     +}
>     +
>     +static void setup(void)
>     +{
>     +? ? ? ?SAFE_PIPE2(fds, O_DIRECT);
>     +? ? ? ?pipe_size = SAFE_FCNTL(fds[1], F_GETPIPE_SZ);
>     +? ? ? ?wrbuf = SAFE_MALLOC(PIPE_BUF * 2);
>     +? ? ? ?rdbuf = SAFE_MALLOC(pipe_size);
>     +? ? ? ?memset(wrbuf, 'x', PIPE_BUF * 2);
>     +? ? ? ?packet_num = pipe_size / PIPE_BUF;
>     +? ? ? ?SAFE_CLOSE(fds[0]);
>     +? ? ? ?SAFE_CLOSE(fds[1]);
>     +}
>     +
>     +static void cleanup(void)
>     +{
>     +? ? ? ?if (fds[0] > 0)
>     +? ? ? ? ? ? ? ?SAFE_CLOSE(fds[0]);
>     +? ? ? ?if (fds[1] > 0)
>     +? ? ? ? ? ? ? ?SAFE_CLOSE(fds[1]);
>     +? ? ? ?if (wrbuf)
>     +? ? ? ? ? ? ? ?free(wrbuf);
>     +? ? ? ?if (rdbuf)
>     +? ? ? ? ? ? ? ?free(rdbuf);
>     +}
>     +
>     +static struct tst_test test = {
>     +? ? ? ?.setup = setup,
>     +? ? ? ?.cleanup = cleanup,
>     +? ? ? ?.forks_child = 1,
>     +? ? ? ?.test = verify_pipe2,
>     +? ? ? ?.tcnt = ARRAY_SIZE(test_func),
>     +};
>     -- 
>     2.23.0
> 
> 
> 
> 
>     -- 
>     Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> 
> 
> -- 
> Regards,
> Li Wang


