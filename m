From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Dec 2018 22:25:05 +0100
Subject: [LTP] [PATCH 1/2] getrlimit/getrlimit03: add configure-time
 check for struct ulimit64
In-Reply-To: <20181203190148.93108-1-ghackmann@google.com>
References: <20181203190148.93108-1-ghackmann@google.com>
Message-ID: <20181203212505.GA2022@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Greg,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +++ b/m4/ltp-rlimit64.m4
> @@ -0,0 +1,10 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2018 Google, Inc.
> +
> +AC_DEFUN([LTP_CHECK_RLIMIT64],[
> +AC_CHECK_TYPES([struct rlimit64],,,[
> +#include <sys/time.h>
> +#include <sys/resource.h>
> +])
> +])
Glibc and uclibc-ng define struct rlimit64 only #ifdef __USE_LARGEFILE64.
Would it make sense to change autoconf test to AC_COMPILE_IFELSE and pass -D_LARGEFILE64_SOURCE to it?
+ Use it in Makefile, of course.


Kind regards,
Petr
