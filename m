From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 8 Oct 2018 02:41:08 -0400 (EDT)
Subject: [LTP] [PATCH v3] syscalls/membarrier: Add membarrier() initial
	test
In-Reply-To: <20181008000851.21418-1-rafael.tinoco@linaro.org>
References: <243767154.55279006.1538383679362.JavaMail.zimbra@redhat.com>
 <20181008000851.21418-1-rafael.tinoco@linaro.org>
Message-ID: <1316052497.56755432.1538980868317.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

----- Original Message -----
> Fixes: #265
> 
> Initial test for membarrier() syscall. It tests all existing membarrier
> "commands" (or features), including the need (or not) for previous
> registration for the call to work.
> 
> Some features did not exist in older kernels and that is covered by
> skipping some calls, flagging test as skipped & okay, and forcing
> others, making sure that return codes and errno are set right in those
> cases.
> 
> Tests are done in a child process due to inexistent kernel interface to
> "unregister" the process from being affected by membarrier() call.
> 
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---
>  configure.ac                                  |   1 +
>  include/lapi/syscalls/aarch64.in              |   1 +
>  include/lapi/syscalls/arm.in                  |   1 +
>  include/lapi/syscalls/hppa.in                 |   1 +
>  include/lapi/syscalls/i386.in                 |   1 +
>  include/lapi/syscalls/ia64.in                 |   1 +
>  include/lapi/syscalls/powerpc.in              |   1 +
>  include/lapi/syscalls/powerpc64.in            |   1 +
>  include/lapi/syscalls/s390.in                 |   1 +
>  include/lapi/syscalls/s390x.in                |   1 +
>  include/lapi/syscalls/sparc.in                |   1 +
>  include/lapi/syscalls/sparc64.in              |   1 +
>  include/lapi/syscalls/x86_64.in               |   1 +
>  runtest/syscalls                              |   2 +
>  .../kernel/syscalls/membarrier/.gitignore     |   1 +
>  testcases/kernel/syscalls/membarrier/Makefile |   8 +
>  .../kernel/syscalls/membarrier/membarrier01.c | 411 ++++++++++++++++++
>  17 files changed, 435 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/membarrier/.gitignore
>  create mode 100644 testcases/kernel/syscalls/membarrier/Makefile
>  create mode 100644 testcases/kernel/syscalls/membarrier/membarrier01.c
> 
> diff --git a/configure.ac b/configure.ac
> index e1ecb32a7..98425f997 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -45,6 +45,7 @@ AC_CHECK_HEADERS([ \
>      linux/mempolicy.h \
>      linux/module.h \
>      linux/netlink.h \
> +    linux/membarrier.h \
>      mm.h \
>      netinet/sctp.h \
>      pthread.h \
> diff --git a/include/lapi/syscalls/aarch64.in
> b/include/lapi/syscalls/aarch64.in
> index 9ac7f997b..f6b0b2949 100644
> --- a/include/lapi/syscalls/aarch64.in
> +++ b/include/lapi/syscalls/aarch64.in
> @@ -256,6 +256,7 @@ sendmmsg 269
>  kcmp 272
>  getrandom 278
>  memfd_create 279
> +membarrier 283
>  mlock2 284
>  copy_file_range 285
>  _sysctl 1078
> diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
> index 0a7f98ac5..d8897b180 100644
> --- a/include/lapi/syscalls/arm.in
> +++ b/include/lapi/syscalls/arm.in
> @@ -341,6 +341,7 @@ renameat2 (__NR_SYSCALL_BASE+382)
>  getrandom (__NR_SYSCALL_BASE+384)
>  memfd_create (__NR_SYSCALL_BASE+385)
>  execveat (__NR_SYSCALL_BASE+387)
> +membarrier (__NR_SYSCALL_BASE+389)
>  mlock2 (__NR_SYSCALL_BASE+390)
>  copy_file_range (__NR_SYSCALL_BASE+391)
>  statx (__NR_SYSCALL_BASE+397)
> diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
> index 3db978069..e961dabe3 100644
> --- a/include/lapi/syscalls/hppa.in
> +++ b/include/lapi/syscalls/hppa.in
> @@ -17,5 +17,6 @@ splice 291
>  tee 293
>  vmsplice 294
>  memfd_create 340
> +membarrier 343
>  mlock2 345
>  copy_file_range 346
> diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
> index a000564d2..2a6df8bda 100644
> --- a/include/lapi/syscalls/i386.in
> +++ b/include/lapi/syscalls/i386.in
> @@ -341,6 +341,7 @@ renameat2 354
>  getrandom 355
>  memfd_create 356
>  execveat 358
> +membarrier 375
>  mlock2 376
>  copy_file_range 377
>  statx 383
> diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
> index 278819387..02f86d7d3 100644
> --- a/include/lapi/syscalls/ia64.in
> +++ b/include/lapi/syscalls/ia64.in
> @@ -296,5 +296,6 @@ prlimit64 1325
>  renameat2 1338
>  getrandom 1339
>  memfd_create 1340
> +membarrier 1344
>  mlock2 1346
>  copy_file_range 1347
> diff --git a/include/lapi/syscalls/powerpc.in
> b/include/lapi/syscalls/powerpc.in
> index c0b4226eb..e8e5acb3b 100644
> --- a/include/lapi/syscalls/powerpc.in
> +++ b/include/lapi/syscalls/powerpc.in
> @@ -347,6 +347,7 @@ sched_getattr 356
>  renameat2 357
>  getrandom 359
>  memfd_create 360
> +membarrier 365
>  mlock2 378
>  copy_file_range 379
>  statx 383
> diff --git a/include/lapi/syscalls/powerpc64.in
> b/include/lapi/syscalls/powerpc64.in
> index c0b4226eb..e8e5acb3b 100644
> --- a/include/lapi/syscalls/powerpc64.in
> +++ b/include/lapi/syscalls/powerpc64.in
> @@ -347,6 +347,7 @@ sched_getattr 356
>  renameat2 357
>  getrandom 359
>  memfd_create 360
> +membarrier 365
>  mlock2 378
>  copy_file_range 379
>  statx 383
> diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
> index 47a04de27..8f0ba9278 100644
> --- a/include/lapi/syscalls/s390.in
> +++ b/include/lapi/syscalls/s390.in
> @@ -331,6 +331,7 @@ sched_getattr 346
>  renameat2 347
>  getrandom 349
>  memfd_create 350
> +membarrier 356
>  execveat 354
>  mlock2 374
>  copy_file_range 375
> diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
> index 83732ffbe..4fe69f41e 100644
> --- a/include/lapi/syscalls/s390x.in
> +++ b/include/lapi/syscalls/s390x.in
> @@ -331,5 +331,6 @@ sched_getattr 346
>  renameat2 347
>  getrandom 349
>  memfd_create 350
> +membarrier 356
>  mlock2 374
>  copy_file_range 375
> diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
> index 2b06a797a..5f061b244 100644
> --- a/include/lapi/syscalls/sparc.in
> +++ b/include/lapi/syscalls/sparc.in
> @@ -336,5 +336,6 @@ kcmp 341
>  renameat2 345
>  getrandom 347
>  memfd_create 348
> +membarrier 350

This should be 351.

>  mlock2 356
>  copy_file_range 357
> diff --git a/include/lapi/syscalls/sparc64.in
> b/include/lapi/syscalls/sparc64.in
> index 8c8a86673..cb821e892 100644
> --- a/include/lapi/syscalls/sparc64.in
> +++ b/include/lapi/syscalls/sparc64.in
> @@ -312,5 +312,6 @@ kcmp 341
>  renameat2 345
>  getrandom 347
>  memfd_create 348
> +membarrier 350

Here as well.

>  mlock2 356
>  copy_file_range 357
> diff --git a/include/lapi/syscalls/x86_64.in
> b/include/lapi/syscalls/x86_64.in
> index 4ce8477de..9a1832114 100644
> --- a/include/lapi/syscalls/x86_64.in
> +++ b/include/lapi/syscalls/x86_64.in
> @@ -308,6 +308,7 @@ renameat2 316
>  getrandom 318
>  memfd_create 319
>  execveat 322
> +membarrier 324
>  mlock2 325
>  copy_file_range 326
>  statx 332
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 0d0be7713..19be14098 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1504,3 +1504,5 @@ statx02 statx02
>  statx03 statx03
>  statx04 statx04
>  statx05 statx05
> +
> +membarrier01 membarrier01
> diff --git a/testcases/kernel/syscalls/membarrier/.gitignore
> b/testcases/kernel/syscalls/membarrier/.gitignore
> new file mode 100644
> index 000000000..eec8058b9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/membarrier/.gitignore
> @@ -0,0 +1 @@
> +/membarrier01
> diff --git a/testcases/kernel/syscalls/membarrier/Makefile
> b/testcases/kernel/syscalls/membarrier/Makefile
> new file mode 100644
> index 000000000..f71e4fc25
> --- /dev/null
> +++ b/testcases/kernel/syscalls/membarrier/Makefile
> @@ -0,0 +1,8 @@
> +# Copyright (c) 2018 - Linaro Limited. All rights reserved.
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> \ No newline at end of file
> diff --git a/testcases/kernel/syscalls/membarrier/membarrier01.c
> b/testcases/kernel/syscalls/membarrier/membarrier01.c
> new file mode 100644
> index 000000000..061e9ed7e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/membarrier/membarrier01.c
> @@ -0,0 +1,411 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2018 Linaro Limited. All rights reserved.
> + * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
> + */
> +/*
> + * Basic tests for membarrier(2) syscall. Tests below are responsible for
> + * testing the membarrier(2) interface only, without checking if the barrier
> + * was successful or not. Check test_case structure for each test
> description.
> + */
> +
> +#include "config.h"
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <syscall.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#ifdef HAVE_LINUX_MEMBARRIER_H
> +# include <linux/membarrier.h>
> +#endif

Problem here is that MEMBARRIER_CMD_* will still be undefined,
so compilation will fail unless you have all that test is using:

membarrier01.c:65:14: error: ‘MEMBARRIER_CMD_QUERY’ undeclared here (not in a function)
   .command = MEMBARRIER_CMD_QUERY,
              ^
membarrier01.c:78:14: error: ‘MEMBARRIER_CMD_GLOBAL’ undeclared here (not in a function)
   .command = MEMBARRIER_CMD_GLOBAL,
              ^
membarrier01.c:93:14: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED’ undeclared here (not in a function)
   .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
              ^
membarrier01.c:105:14: error: ‘MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED’ undeclared here (not in a function)
   .command = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
              ^
membarrier01.c:137:14: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE’ undeclared here (not in a function)
   .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
              ^
membarrier01.c:149:14: error: ‘MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE’ undeclared here (not in a function)
   .command = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
              ^
membarrier01.c:179:14: error: ‘MEMBARRIER_CMD_GLOBAL_EXPEDITED’ undeclared here (not in a function)
   .command = MEMBARRIER_CMD_GLOBAL_EXPEDITED,
              ^
membarrier01.c:190:14: error: ‘MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED’ undeclared here (not in a function)
   .command = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,

Even if you have linux/membarrier.h, you may not have all MEMBARRIER_CMD_*.
First version (4.3) introduced only MEMBARRIER_CMD_QUERY and MEMBARRIER_CMD_SHARED.

<snip>

> +static void setup(void)
> +{
> +	size_t i;
> +	int ret;
> +
> +	ret = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
> +	if (ret < 0) {
> +		if (errno == ENOSYS)
> +			tst_brk(TBROK, "membarrier(2): not supported");
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(tc); i++) {
> +		if ((tc[i].command > 0) && (ret & tc[i].command))
> +			tc[i].enabled = 1;
> +	}
> +
> +	/* case 05: commit 70216e18e5 (v4.16-rc1) changed behavior */
> +
> +	if (tst_kvercmp(4, 16, 0) < 0 && tc[5].enabled == 0)
> +		tc[5].force_exp_errno = EINVAL;

Can you check for this by some flag(s) rather than position in array?
If we add to array later, index will shift and this will break.

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test = wrap_verify_membarrier,
> +	.tcnt = ARRAY_SIZE(tc),
> +	.min_kver = "4.3.0",	/* commit: 5b25b13ab0 (sys_membarrier(): ...) */
> +	.forks_child = 1,
> +};
> +
> +#else /* HAVE_LINUX_MEMBARRIER_H */

This #else is for HAVE_SYS_XATTR_H.

Regards,
Jan

> +TST_TEST_TCONF("<linux/membarrier.h> does not exist");
> +#endif
> --
> 2.19.0.rc2
> 
> 
