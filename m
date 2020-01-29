From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Jan 2020 11:06:19 +0100
Subject: [LTP] [PATCH 1/1] ioctl02.c: check for struct termio
In-Reply-To: <20200128212725.22781-1-petr.vorel@gmail.com>
References: <20200128212725.22781-1-petr.vorel@gmail.com>
Message-ID: <20200129100619.GC21699@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  configure.ac                              |  1 +
>  m4/ltp-termio.m4                          |  6 ++++++
>  testcases/kernel/syscalls/ioctl/ioctl01.c | 20 ++++++++++++--------
>  3 files changed, 19 insertions(+), 8 deletions(-)
>  create mode 100644 m4/ltp-termio.m4
> 
> diff --git a/configure.ac b/configure.ac
> index c7cdff1c4..b860bdacc 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -257,6 +257,7 @@ LTP_CHECK_SYSCALL_QUOTACTL
>  LTP_CHECK_SYSCALL_SIGNALFD
>  LTP_CHECK_SYSCALL_UTIMENSAT
>  LTP_CHECK_TASKSTATS
> +LTP_CHECK_TERMIO
>  LTP_CHECK_TIMERFD
>  test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
>  LTP_CHECK_TPACKET_V3
> diff --git a/m4/ltp-termio.m4 b/m4/ltp-termio.m4
> new file mode 100644
> index 000000000..e745df1d9
> --- /dev/null
> +++ b/m4/ltp-termio.m4
> @@ -0,0 +1,6 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2020 Petr Vorel <petr.vorel@gmail.com>
> +
> +AC_DEFUN([LTP_CHECK_TERMIO],[
> +AC_CHECK_TYPES([struct termio],,,[#include <sys/ioctl.h>])
> +])

What about we add a fallback defition of the structure into
lapi/termio.h instead of disabling the test?

That way we would be able to test the kernel even if the userspace
headers were missing...

#include "config.h"

#ifndef HAVE_STRUCT_TERMIO
struct termio {
...
}
#ifdef

Should be enough to be able to compile that test, right?

-- 
Cyril Hrubis
chrubis@suse.cz
