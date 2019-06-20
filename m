From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 20 Jun 2019 09:05:23 -0400 (EDT)
Subject: [LTP] [PATCH] pkey: Add test for memory protection keys
In-Reply-To: <20190620095548.28335-1-liwang@redhat.com>
References: <20190620095548.28335-1-liwang@redhat.com>
Message-ID: <222124720.29320832.1561035923712.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  configure.ac                               |   1 +
>  include/lapi/syscalls/aarch64.in           |   3 +
>  include/lapi/syscalls/arm.in               |   3 +
>  include/lapi/syscalls/i386.in              |   3 +
>  include/lapi/syscalls/ia64.in              |   3 +
>  include/lapi/syscalls/powerpc.in           |   3 +
>  include/lapi/syscalls/powerpc64.in         |   3 +
>  include/lapi/syscalls/s390.in              |   3 +
>  include/lapi/syscalls/s390x.in             |   3 +
>  include/lapi/syscalls/sh.in                |   3 +
>  include/lapi/syscalls/sparc.in             |   3 +
>  include/lapi/syscalls/sparc64.in           |   3 +
>  include/lapi/syscalls/x86_64.in            |   3 +
>  runtest/syscalls                           |   2 +
>  testcases/kernel/syscalls/pkeys/.gitignore |   1 +
>  testcases/kernel/syscalls/pkeys/Makefile   |   8 ++
>  testcases/kernel/syscalls/pkeys/pkey.h     |  44 +++++++++
>  testcases/kernel/syscalls/pkeys/pkey01.c   | 105 +++++++++++++++++++++
>  18 files changed, 197 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/pkeys/.gitignore
>  create mode 100644 testcases/kernel/syscalls/pkeys/Makefile
>  create mode 100644 testcases/kernel/syscalls/pkeys/pkey.h
>  create mode 100644 testcases/kernel/syscalls/pkeys/pkey01.c
> 
> diff --git a/configure.ac b/configure.ac
> index 5ecc92781..35997699f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -76,6 +76,7 @@ AC_CHECK_FUNCS([ \
>      profil \
>      pwritev \
>      pwritev2 \
> +    pkey_mprotect \
>      readlinkat \
>      renameat \
>      renameat2 \
> diff --git a/include/lapi/syscalls/aarch64.in
> b/include/lapi/syscalls/aarch64.in
> index 177dd0115..4232defbe 100644
> --- a/include/lapi/syscalls/aarch64.in
> +++ b/include/lapi/syscalls/aarch64.in
> @@ -266,3 +266,6 @@ copy_file_range 285
>  preadv2 286
>  pwritev2 287
>  _sysctl 1078
> +pkey_mprotect 394
> +pkey_alloc 395
> +pkey_free 396

288, 289, 290

> diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
> index f4adedb2c..48b55b5ff 100644
> --- a/include/lapi/syscalls/arm.in
> +++ b/include/lapi/syscalls/arm.in
> @@ -350,3 +350,6 @@ copy_file_range (__NR_SYSCALL_BASE+391)
>  preadv2 (__NR_SYSCALL_BASE+392)
>  pwritev2 (__NR_SYSCALL_BASE+393)
>  statx (__NR_SYSCALL_BASE+397)
> +pkey_mprotect (__NR_SYSCALL_BASE+394)
> +pkey_alloc (__NR_SYSCALL_BASE+395)
> +pkey_free (__NR_SYSCALL_BASE+396)
> diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
> index af5254f77..c54573547 100644
> --- a/include/lapi/syscalls/i386.in
> +++ b/include/lapi/syscalls/i386.in
> @@ -348,3 +348,6 @@ copy_file_range 377
>  preadv2 378
>  pwritev2 379
>  statx 383
> +pkey_mprotect 380
> +pkey_alloc 381
> +pkey_free 382
> diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
> index c0aeed08b..56bfd7928 100644
> --- a/include/lapi/syscalls/ia64.in
> +++ b/include/lapi/syscalls/ia64.in
> @@ -305,3 +305,6 @@ mlock2 1346
>  copy_file_range 1347
>  preadv2 1348
>  pwritev2 1349
> +pkey_mprotect 330
> +pkey_alloc 331
> +pkey_free 332
> diff --git a/include/lapi/syscalls/powerpc.in
> b/include/lapi/syscalls/powerpc.in
> index 6b6be58a7..eaf8d45ed 100644
> --- a/include/lapi/syscalls/powerpc.in
> +++ b/include/lapi/syscalls/powerpc.in
> @@ -355,3 +355,6 @@ copy_file_range 379
>  preadv2 380
>  pwritev2 381
>  statx 383
> +pkey_mprotect 386
> +pkey_alloc 384
> +pkey_free 385
> diff --git a/include/lapi/syscalls/powerpc64.in
> b/include/lapi/syscalls/powerpc64.in
> index 6b6be58a7..eaf8d45ed 100644
> --- a/include/lapi/syscalls/powerpc64.in
> +++ b/include/lapi/syscalls/powerpc64.in
> @@ -355,3 +355,6 @@ copy_file_range 379
>  preadv2 380
>  pwritev2 381
>  statx 383
> +pkey_mprotect 386
> +pkey_alloc 384
> +pkey_free 385
> diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
> index 2a2ffe223..3ee5547f1 100644
> --- a/include/lapi/syscalls/s390.in
> +++ b/include/lapi/syscalls/s390.in
> @@ -338,3 +338,6 @@ mlock2 374
>  copy_file_range 375
>  preadv2 376
>  pwritev2 377
> +pkey_mprotect 384
> +pkey_alloc 385
> +pkey_free 386
> diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
> index 4c36ce17c..92e882aae 100644
> --- a/include/lapi/syscalls/s390x.in
> +++ b/include/lapi/syscalls/s390x.in
> @@ -337,3 +337,6 @@ mlock2 374
>  copy_file_range 375
>  preadv2 376
>  pwritev2 377
> +pkey_mprotect 384
> +pkey_alloc 385
> +pkey_free 386
> diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
> index a942fb506..00726c1cc 100644
> --- a/include/lapi/syscalls/sh.in
> +++ b/include/lapi/syscalls/sh.in
> @@ -369,3 +369,6 @@ mlock2 390
>  copy_file_range 391
>  preadv2 392
>  pwritev2 393
> +pkey_mprotect 384
> +pkey_alloc 385
> +pkey_free 386
> diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
> index 20dc37b01..1b34ab489 100644
> --- a/include/lapi/syscalls/sparc.in
> +++ b/include/lapi/syscalls/sparc.in
> @@ -343,3 +343,6 @@ mlock2 356
>  copy_file_range 357
>  preadv2 358
>  pwritev2 359
> +pkey_mprotect 362
> +pkey_alloc 363
> +pkey_free 364
> diff --git a/include/lapi/syscalls/sparc64.in
> b/include/lapi/syscalls/sparc64.in
> index c100b8e3e..f3142fbdd 100644
> --- a/include/lapi/syscalls/sparc64.in
> +++ b/include/lapi/syscalls/sparc64.in
> @@ -319,3 +319,6 @@ mlock2 356
>  copy_file_range 357
>  preadv2 358
>  pwritev2 359
> +pkey_mprotect 362
> +pkey_alloc 363
> +pkey_free 364
> diff --git a/include/lapi/syscalls/x86_64.in
> b/include/lapi/syscalls/x86_64.in
> index 87849e5c0..9c77f1c67 100644
> --- a/include/lapi/syscalls/x86_64.in
> +++ b/include/lapi/syscalls/x86_64.in
> @@ -315,3 +315,6 @@ copy_file_range 326
>  preadv2 327
>  pwritev2 328
>  statx 332
> +pkey_mprotect 329
> +pkey_alloc 330
> +pkey_free 331
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a1106fb84..a236fce09 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -723,6 +723,8 @@ mprotect02 mprotect02
>  mprotect03 mprotect03
>  mprotect04 mprotect04
>  
> +pkey01 pkey01
> +
>  mq_notify01 mq_notify01
>  mq_notify02 mq_notify02
>  mq_open01 mq_open01
> diff --git a/testcases/kernel/syscalls/pkeys/.gitignore
> b/testcases/kernel/syscalls/pkeys/.gitignore
> new file mode 100644
> index 000000000..6fd5addb8
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pkeys/.gitignore
> @@ -0,0 +1 @@
> +/pkey01
> diff --git a/testcases/kernel/syscalls/pkeys/Makefile
> b/testcases/kernel/syscalls/pkeys/Makefile
> new file mode 100644
> index 000000000..9ee2c2ea5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pkeys/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2019 Red Hat, Inc.
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/pkeys/pkey.h
> b/testcases/kernel/syscalls/pkeys/pkey.h
> new file mode 100644
> index 000000000..bd86bebcc
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pkeys/pkey.h
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Red Hat, Inc.
> + */
> +
> +#ifndef PKEYS_H
> +#define PKEYS_H
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +#ifndef PKEY_DISABLE_ACCESS
> +# define PKEY_DISABLE_ACCESS 0x1
> +# define PKEY_DISABLE_WRITE  0x2
> +#endif
> +
> +#ifndef HAVE_PKEY_MPROTECT
> +static inline int pkey_mprotect(void *addr, size_t len, int prot, int pkey)
> +{
> +	return tst_syscall(SYS_pkey_mprotect, addr, len, prot, pkey);
> +}
> +
> +static inline int pkey_alloc(unsigned int flags, unsigned int access_rights)
> +{
> +	return tst_syscall(SYS_pkey_alloc, flags, access_rights);
> +}
> +
> +static inline int pkey_free(int pkey)
> +{
> +	return tst_syscall(SYS_pkey_free, pkey);
> +}
> +#endif /* HAVE_PKEY_MPROTECT */
> +
> +static inline void check_pkey_support(void)
> +{
> +	int pkey = pkey_alloc(0, 0);
> +
> +	if ((pkey == -1) && (errno == EINVAL))

Shouldn't this handle also ENOSPC?

      ENOSPC (pkey_alloc()) All protection keys available for the current process have been allocated.  The number of keys available is
              architecture-specific  and  implementation-specific  and may be reduced by kernel-internal use of certain keys.  There are
              currently 15 keys available to user programs on x86.

              This error will also be returned if the processor or operating system does  not  support  protection  keys.   Applications
              should  always  be prepared to handle this error, since factors outside of the application's control can reduce the number
              of available pkeys.

> +		tst_brk(TCONF, "pkey_alloc is not supported");
> +	else
> +		pkey_free(pkey);
> +}
> +
> +#endif /* PKEYS_H */
> diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c
> b/testcases/kernel/syscalls/pkeys/pkey01.c
> new file mode 100644
> index 000000000..8faa4be4c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pkeys/pkey01.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Test for Memory Protection Keys
> + * Reference: https://lwn.net/Articles/689395/
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <sys/syscall.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +
> +#include "pkey.h"
> +
> +static int psize;
> +static char *buffer;
> +
> +static struct tcase {
> +	unsigned long flags;
> +	unsigned long access_rights;
> +	char *name;
> +} tcases[] = {
> +	{0, PKEY_DISABLE_ACCESS, "PKEY_DISABLE_ACCESS"},
> +	{0, PKEY_DISABLE_WRITE, "PKEY_DISABLE_WRITE"},
> +};
> +
> +static void setup(void)
> +{
> +	check_pkey_support();
> +
> +	psize = getpagesize();
> +	buffer = SAFE_MMAP(NULL, psize, PROT_READ | PROT_WRITE,
> +			MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> +	memset(buffer, 'a', psize);
> +}
> +
> +static void verify_pkey(unsigned int i)
> +{
> +	int pkey, status;
> +	pid_t pid;
> +
> +	struct tcase *tc = &tcases[i];
> +
> +	pkey = pkey_alloc(tc->flags, tc->access_rights);
> +	if (pkey == -1)
> +		tst_brk(TBROK, "pkey_alloc failed");
> +
> +	tst_res(TINFO, "Set %s on buffer", tc->name);
> +	if (pkey_mprotect(buffer, psize, PROT_READ | PROT_WRITE, pkey) == -1)
> +		tst_brk(TBROK, "pkey_mprotect failed");
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {

I'd suggest something like:
                struct rlimit r;                                                                                                            
                                                                                                                                            
                r.rlim_cur = 1;                                                                                                             
                r.rlim_max = 1;                                                                                                             
                SAFE_SETRLIMIT(RLIMIT_CORE, &r); 

to avoid getting cores from this child - since it is expected to segfault.

> +		switch (tc->access_rights) {
> +		case PKEY_DISABLE_ACCESS:
> +			tst_res(TFAIL, "Read buffer success, buffer[0] = %d", *buffer);
> +		break;
> +		case PKEY_DISABLE_WRITE:
> +			*buffer = 'b';
> +		break;
> +		}
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +	if (WIFSIGNALED(status)) {
> +		if (WTERMSIG(status) == SIGSEGV) {
> +			tst_res(TPASS, "Child ended by %s as expected",
> +				tst_strsig(SIGSEGV));
> +		} else {
> +			tst_res(TFAIL, "Child ended by %s unexpected" ,
> +				tst_strsig(WTERMSIG(status)));
> +		}
> +	} else {
> +		tst_res(TFAIL, "Child unexpectedly ended");
> +	}
> +
> +	tst_res(TINFO, "Remove %s from buffer", tc->name);
> +	if (pkey_mprotect(buffer, psize, PROT_READ | PROT_WRITE, 0x0) == -1)
> +		tst_brk(TBROK, "pkey_mprotect failed");
> +	*buffer = i;
> +	tst_res(TPASS, "Write buffer success, buffer[0] = %d", *buffer);
> +
> +	if (pkey_free(pkey) == -1)
> +		tst_brk(TBROK, "pkey_free failed");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (buffer)
> +		SAFE_MUNMAP(buffer, psize);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.forks_child = 1,
> +	.test = verify_pkey,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> --
> 2.20.1
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
