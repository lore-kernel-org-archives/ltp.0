From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 21 Apr 2020 17:41:59 +0800
Subject: [LTP] [PATCH v3 2/3] syscalls/pipe2_02: Add new test for pipe2
 O_CLOEXEC flag
In-Reply-To: <CAEemH2eN1gJ8p2EWts4qj=tDaV0QUoHrNX36cqkPM0xf92KDuw@mail.gmail.com>
References: <1586927503-10827-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eN1gJ8p2EWts4qj=tDaV0QUoHrNX36cqkPM0xf92KDuw@mail.gmail.com>
Message-ID: <324c7f62-a57f-b950-7178-5ba05ac6616b@cn.fujitsu.com>
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
>      ?runtest/syscalls? ? ? ? ? ? ? ? ? ? ? ? ? ? ? |? 1 +
>      ?testcases/kernel/syscalls/pipe2/.gitignore? ? |? 2 +
>      ?testcases/kernel/syscalls/pipe2/pipe2_02.c? ? | 69 +++++++++++++++++++
>      ?.../kernel/syscalls/pipe2/pipe2_02_child.c? ? | 26 +++++++
>      ?4 files changed, 98 insertions(+)
>      ?create mode 100644 testcases/kernel/syscalls/pipe2/pipe2_02.c
>      ?create mode 100644 testcases/kernel/syscalls/pipe2/pipe2_02_child.c
> 
>     diff --git a/runtest/syscalls b/runtest/syscalls
>     index 79b671d50..44254d7da 100644
>     --- a/runtest/syscalls
>     +++ b/runtest/syscalls
>     @@ -911,6 +911,7 @@ pipe12 pipe12
>      ?pipe13 pipe13
> 
>      ?pipe2_01 pipe2_01
>     +pipe2_02 pipe2_02
> 
>      ?pivot_root01 pivot_root01
> 
>     diff --git a/testcases/kernel/syscalls/pipe2/.gitignore
>     b/testcases/kernel/syscalls/pipe2/.gitignore
>     index 42350bbdc..786222de2 100644
>     --- a/testcases/kernel/syscalls/pipe2/.gitignore
>     +++ b/testcases/kernel/syscalls/pipe2/.gitignore
>     @@ -1 +1,3 @@
>      ?/pipe2_01
>     +/pipe2_02
>     +/pipe2_02_child
>     diff --git a/testcases/kernel/syscalls/pipe2/pipe2_02.c
>     b/testcases/kernel/syscalls/pipe2/pipe2_02.c
>     new file mode 100644
>     index 000000000..743d78c58
>     --- /dev/null
>     +++ b/testcases/kernel/syscalls/pipe2/pipe2_02.c
>     @@ -0,0 +1,69 @@
>     +// SPDX-License-Identifier: GPL-2.0-or-later
>     +/*
>     + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
>     + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com
>     <mailto:xuyang2018.jy@cn.fujitsu.com>>
>     + *
>     + * This case is designed to test the basic functionality about the
>     + * O_CLOEXEC flag of pipe2.
>     + */
>     +#define _GNU_SOURCE
>     +#include <stdio.h>
>     +#include <unistd.h>
>     +#include <stdlib.h>
>     +#include "lapi/fcntl.h"
>     +#include "tst_test.h"
>     +
>     +#define TESTBIN "pipe2_02_child"
>     +static int fds[2];
>     +
>     +static void cleanup(void)
>     +{
>     +? ? ? ?if (fds[0] > 0)
>     +? ? ? ? ? ? ? ?SAFE_CLOSE(fds[0]);
>     +? ? ? ?if (fds[1] > 0)
>     +? ? ? ? ? ? ? ?SAFE_CLOSE(fds[1]);
>     +}
>     +
>     +static void verify_pipe2(void)
>     +{
>     +? ? ? ?int pid, status;
>     +? ? ? ?char buf[20];
>     +
>     +? ? ? ?SAFE_PIPE2(fds, O_CLOEXEC);
>     +? ? ? ?sprintf(buf, "%d", fds[1]);
>     +? ? ? ?pid = SAFE_FORK();
>     +? ? ? ?if (pid == 0) {
>     +? ? ? ? ? ? ? ?if (execlp(TESTBIN, TESTBIN, buf, NULL))
>     +? ? ? ? ? ? ? ? ? ? ? ?exit(2);
> 
> 
> Do we really need the if() condition and exit(2)? AFAIK, the exec() 
> family of functions replaces the current process image with a new 
> process and returns zero if succeeded.
  If failed, it will return -1. So we can catch 2(exit code) in the 
following code, but SAFE_EXECLP is also ok.
> 
>     +? ? ? ?}
>     +
>     +? ? ? ?SAFE_WAIT(&status);
>     +? ? ? ?if (WIFEXITED(status)) {
>     +? ? ? ? ? ? ? ?switch (WEXITSTATUS(status)) {
>     +? ? ? ? ? ? ? ?case 0:
>     +? ? ? ? ? ? ? ? ? ? ? ?tst_res(TPASS, "test O_CLOEXEC for pipe2
>     success");
>     +? ? ? ? ? ? ? ?break;
>     +? ? ? ? ? ? ? ?case 1:
>     +? ? ? ? ? ? ? ? ? ? ? ?tst_res(TFAIL, "test O_CLOEXEC for pipe2
>     failed");
>     +? ? ? ? ? ? ? ?break;
>     +? ? ? ? ? ? ? ?default:
>     +? ? ? ? ? ? ? ? ? ? ? ?tst_brk(TBROK, "execlp() failed");
>     +? ? ? ? ? ? ? ?}
>     +? ? ? ?} else {
>     +? ? ? ? ? ? ? ?tst_brk(TBROK, "%s exits with unexpected error",
>     TESTBIN);
>     +? ? ? ?}
>     +? ? ? ?cleanup();
>     +}
>     +
>     +static const char *const resfile[] = {
>     +? ? ? ?TESTBIN,
>     +? ? ? ?NULL,
>     +};
>     +
>     +static struct tst_test test = {
>     +? ? ? ?.resource_files = resfile,
>     +? ? ? ?.cleanup = cleanup,
>     +? ? ? ?.forks_child = 1,
>     +? ? ? ?.needs_root = 1,
>     +? ? ? ?.test_all = verify_pipe2,
>     +};
>     diff --git a/testcases/kernel/syscalls/pipe2/pipe2_02_child.c
>     b/testcases/kernel/syscalls/pipe2/pipe2_02_child.c
>     new file mode 100644
>     index 000000000..d5ed68cf7
>     --- /dev/null
>     +++ b/testcases/kernel/syscalls/pipe2/pipe2_02_child.c
>     @@ -0,0 +1,26 @@
>     +// SPDX-License-Identifier: GPL-2.0-or-later
>     +/*
>     + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
>     + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com
>     <mailto:xuyang2018.jy@cn.fujitsu.com>
>     + */
>     +#include <stdio.h>
>     +#include <stdlib.h>
>     +#include <string.h>
>     +#include <errno.h>
>     +#include <unistd.h>
>     +
>     +int main(int argc, char **argv)
>     +{
>     +? ? ? ?int ret;
>     +? ? ? ?int fd;
>     +
>     +? ? ? ?if (argc != 2) {
>     +? ? ? ? ? ? ? ?fprintf(stderr, "Only two arguments: %s <fd>\n",
>     argv[0]);
>     +? ? ? ? ? ? ? ?exit(1);
>     +? ? ? ?}
>     +
>     +? ? ? ?fd = atoi(argv[1]);
>     +? ? ? ?ret = write(fd, "x", 1);
>     +
>     +? ? ? ?return ret != -1;
> 
> 
> To check if the return value equals -1 maybe not a good idea to confirm 
> the 'fd' is closed. That only proof it failed to write "x" to the fd, we 
> are not sure if that exists?other errors.
> 
> What about using the fcntl() in the fd status check?
> 
>  ? ? if (fcntl(fd, F_GETFL) < 0 && errno == EBADF)
>  ? ? ? ? ? ? return 0;
> 
Looks good to me.
> -- 
> Regards,
> Li Wang


