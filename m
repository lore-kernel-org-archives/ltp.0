From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 May 2021 11:37:30 +0200
Subject: [LTP] [PATCH 2/2] syscalls/sendfile: Convert sendfile09 to the
 new API
In-Reply-To: <20210519084655.52780-3-xieziyao@huawei.com>
References: <20210519084655.52780-1-xieziyao@huawei.com>
 <20210519084655.52780-3-xieziyao@huawei.com>
Message-ID: <YKTcWhMGotujEYLK@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*\
> + * [Description]
>   *
> - * DESCRIPTION
> - *        Testcase copied from sendfile02.c to test the basic functionality of
> - *        the sendfile(2) system call on large file. There is a kernel bug which
> - *        introduced by commit 8f9c0119d7ba and fixed by commit 5d73320a96fcc.
> + * Testcase copied from sendfile02.c to test the basic functionality of
> + * the sendfile(2) system call on large file. There is a kernel bug which
> + * introduced by commit 8f9c0119d7ba and fixed by commit 5d73320a96fcc.
                            ^
	Here as well the commit that introduced the bug should go to
	.tags.
>   *
> - * ALGORITHM
> - *        1. call sendfile(2) with offset at 0
> - *        2. call sendfile(2) with offset at 3GB
> + * [Algorithm]
>   *
> - * USAGE:  <for command-line>
> - *  sendfile09 [-c n] [-i n] [-I x] [-P x] [-t]
> - *     where,
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> + * 1. Call sendfile(2) with offset at 0;
> + * 2. Call sendfile(2) with offset at 3GB.
>   *
> + * [Restrictions]

So far we had only [Description] and [Algorithm] but adding
[Restrictions] sounds reasonable.

>   *
> - * RESTRICTIONS
> - *        Only supports 64bit systems and kernel 2.6.33 or above
> + * Only supports 64bit systems and kernel 2.6.33 or above.

I guess that there is no point in mentioning the kernel version here, we
have it in the tst_test structure and it's exported from that structure
into the metadata as well.

>   */
> -#include <stdio.h>
> -#include <errno.h>
> +
>  #include <fcntl.h>
>  #include <sys/stat.h>
>  #include <sys/sendfile.h>
>  #include <sys/types.h>
>  #include <unistd.h>
>  #include <inttypes.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/abisize.h"
> 
> -#ifndef OFF_T
> -#define OFF_T off_t
> -#endif /* Not def: OFF_T */
> +#include "tst_test.h"
> 
> -TCID_DEFINE(sendfile09);
> -
> -static char *in_file = "in";
> -static char *out_file = "out";
> -static int fd;
> -static int in_fd;
> -static int out_fd;
> +#ifdef TST_ABI32
> +tst_brkm(TCONF, "This test is only for 64bit");
> +#endif

Does this even compile on 32bit?

HINT: You can compile LTP for 32bit with ./configure CFLAGS=-m32 LDFLAGS=-m32


-- 
Cyril Hrubis
chrubis@suse.cz
