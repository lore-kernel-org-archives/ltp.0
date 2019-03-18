From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Mar 2019 16:30:56 +0100
Subject: [LTP] [PATCH v2] Test ioctl syscall for NS_GET_* requests
In-Reply-To: <20190311072537.22080-1-fedebonfi95@gmail.com>
References: <20190304161602.GB15696@rei>
 <20190311072537.22080-1-fedebonfi95@gmail.com>
Message-ID: <20190318153056.GC18993@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  include/lapi/ioctl_ns.h                      | 29 +++++++++++
>  include/tst_safe_macros.h                    |  4 ++
>  lib/tst_safe_macros.c                        | 17 +++++++

Ideally unrelated changes should be each in separate commits, i.e. one
for ioctl_ns.h and one for safe macros, but that is no big issue.

>  runtest/syscalls                             |  8 +++
>  testcases/kernel/syscalls/ioctl/.gitignore   |  7 +++
>  testcases/kernel/syscalls/ioctl/ioctl_ns01.c | 59 ++++++++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns02.c | 43 ++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns04.c | 44 +++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns05.c | 42 ++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 72 +++++++++++++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns07.c | 73 ++++++++++++++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns08.c | 51 +++++++++++++++++++
>  12 files changed, 449 insertions(+)
>  create mode 100644 include/lapi/ioctl_ns.h
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns01.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns02.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns04.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns05.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns06.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns07.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns08.c
> 
> diff --git a/include/lapi/ioctl_ns.h b/include/lapi/ioctl_ns.h
> new file mode 100644
> index 000000000..ebaf43a24
> --- /dev/null
> +++ b/include/lapi/ioctl_ns.h
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
> + */
> +
> +#ifndef __IOCTL_NS_H__
> +#define __IOCTL_NS_H__

All identifiers starting with underscore are resevered for libc and
kernel headers.

> +#ifndef _IO
> +#define _IO			volatile
> +#endif

This is obviously nonsense, the _IO() definition you are looking for
packs the parameters into an integer with bitshifts and or. See
include/uapi/asm-generic/ioctl.h

It looks like it should be safe enough to include the header here, i.e.
#include <asm-generic/ioctl.h> as there does not seem to be any other
(glibc) header defining the _IO* macros.

> +#ifndef NSIO
> +#define NSIO	0xb7
> +#endif
> +#ifndef NS_GET_PARENT
> +#define NS_GET_PARENT		_IO(NSIO, 0x2)
> +#endif
> +#ifndef NS_GET_OWNER_UID
> +#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> +#endif
> +#ifndef NS_GET_USERNS
> +#define NS_GET_USERNS		_IO(NSIO, 0x1)
> +#endif
> +#ifndef NS_GET_NSTYPE
> +#define NS_GET_NSTYPE		_IO(NSIO, 0x3)
> +#endif
> +
> +
> +#endif /* __IOCTL_NS_H__ */
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index d31762f4a..b63e7493a 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -526,4 +526,8 @@ int safe_personality(const char *filename, unsigned int lineno,
>  	}							\
>  	} while (0)
>  
> +void safe_unshare(const char *file, const int lineno, int flags);
> +#define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
> +
> +
>  #endif /* SAFE_MACROS_H__ */
> diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
> index c375030a4..761d1d3dd 100644
> --- a/lib/tst_safe_macros.c
> +++ b/lib/tst_safe_macros.c
> @@ -18,6 +18,7 @@
>  #define _GNU_SOURCE
>  #include <unistd.h>
>  #include <errno.h>
> +#include <sched.h>
>  #include "config.h"
>  #ifdef HAVE_SYS_FANOTIFY_H
>  # include <sys/fanotify.h>
> @@ -197,3 +198,19 @@ int safe_chroot(const char *file, const int lineno, const char *path)
>  
>  	return rval;
>  }
> +
> +void safe_unshare(const char *file, const int lineno, int flags)
> +{
> +	int res;
> +
> +	res = unshare(flags);
> +	if (res == -1) {
> +		if (errno == EINVAL) {
> +			tst_brk_(file, lineno, TCONF,
> +				 "unshare(%d) failed", flags);
                                               ^
					       This should be rather
					       "unsupported"
					       and I would have added
					       the TERRNO flag as well
					       so that the user sees the
					       errno that lead to this
> +		} else {
> +			tst_brk_(file, lineno, TBROK | TERRNO,
> +				 "dup(%d) failed", flags);
                                   ^
				   Copy&paste error I guess
> +		}
> +	}
> +}
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 978a56a07..f8fa2dfc4 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -500,6 +500,14 @@ ioctl06      ioctl06
>  
>  ioctl07      ioctl07
>  
> +ioctl_ns01 ioctl_ns01
> +ioctl_ns02 ioctl_ns02
> +ioctl_ns04 ioctl_ns04
> +ioctl_ns05 ioctl_ns05
> +ioctl_ns06 ioctl_ns06
> +ioctl_ns07 ioctl_ns07
> +ioctl_ns08 ioctl_ns08
> +
>  inotify_init1_01 inotify_init1_01
>  inotify_init1_02 inotify_init1_02
>  
> diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
> index 79516a17c..57d6a58fa 100644
> --- a/testcases/kernel/syscalls/ioctl/.gitignore
> +++ b/testcases/kernel/syscalls/ioctl/.gitignore
> @@ -5,3 +5,10 @@
>  /ioctl05
>  /ioctl06
>  /ioctl07
> +/ioctl_ns01
> +/ioctl_ns02
> +/ioctl_ns04
> +/ioctl_ns05
> +/ioctl_ns06
> +/ioctl_ns07
> +/ioctl_ns08
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> new file mode 100644
> index 000000000..88f3fb043
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
> + */
> +
> +/*
> + * Test ioctl_ns with NS_GET_PARENT request.
> + *
> + * Parent process tries to get parent of initial namespace, which should
> + * fail with EPERM because it has no parent.
> + *
> + * Child process has a new pid namespace, which should make the call fail
> + * with EPERM error.
> + *
> + */
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <sched.h>
> +#include "tst_test.h"
> +#include "lapi/ioctl_ns.h"
> +
> +static void test_ns_get_parent(void)
> +{
> +	int exists, fd, parent_fd;
> +
> +	exists = access("/proc/self/ns/pid", F_OK);
> +	if (exists < 0)
> +		tst_res(TCONF, "namespace not available");

Can we do this check in test setup?

Or do we actually have to check after the unshare as well?

(and the same applies to most of these testcases)


The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
