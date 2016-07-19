From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jul 2016 12:51:18 +0200
Subject: [LTP] [PATCH] syscalls/access03: reconstruct and convert to new
 API
In-Reply-To: <1467168821-14045-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1467168821-14045-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160719105118.GB6409@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 7d0cff8..265e84a 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -33,6 +33,9 @@
>  #include "tst_atomic.h"
>  #include "tst_kvercmp.h"
>  
> +/* lib/get_high_address.c */
> +char *get_high_address(void);

I do not like this.

If want to add an function to return invalid address it should be
prefixed with tst_ and do something more sensible than advancing a few
pages after the program break.

And given that quite a lot of the testcases just utilize (void*)-1 I
would probably go for this one in this test as well.

>  /*
>   * Reports testcase result.
>   */
> diff --git a/testcases/kernel/syscalls/access/access03.c b/testcases/kernel/syscalls/access/access03.c
> index 6f5fa70..ff93fe2 100644
> --- a/testcases/kernel/syscalls/access/access03.c
> +++ b/testcases/kernel/syscalls/access/access03.c
> @@ -23,101 +23,101 @@
>   */
>  
>  /*
> - * access(2) test for errno(s) EFAULT.
> + * access(2) test for errno(s) EFAULT as root and nobody respectively.
>   */
>  
>  #include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -
>  #include <unistd.h>
> -#include <sys/mman.h>
> -#include "test.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -char *TCID = "access03";
> -int TST_TOTAL = 8;
> +#include <sys/types.h>
> +#include <pwd.h>
> +#include "tst_test.h"
>  
> +#ifndef UCLINUX

Just get rid of the UCLINUX ifdefs. You should filter the test in the
Makefile instead, just line we do in syscalls/writev/Makefile.


The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
