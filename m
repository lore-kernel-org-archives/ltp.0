From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jan 2020 11:31:08 +0100
Subject: [LTP] [PATCH 2/3] tst_device.h: Use lapi/syscalls.h instead of
 <sys/syscall.h>
In-Reply-To: <20200117113715.22786-3-pvorel@suse.cz>
References: <20200117113715.22786-1-pvorel@suse.cz>
 <20200117113715.22786-3-pvorel@suse.cz>
Message-ID: <20200120103108.GA15405@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> As a fallback for old distros which does not define __NR_syncfs
> (the dependency is in the library itself).

> This was needed on SLES 11 (kernel 2.6.32).

> Fixes: 74aeb88c9 ("tst_device: use raw syscall in the tst_device.h")

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  include/tst_device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/include/tst_device.h b/include/tst_device.h
> index 3db5275c9..13d92ee54 100644
> --- a/include/tst_device.h
> +++ b/include/tst_device.h
> @@ -19,7 +19,7 @@
>  #define TST_DEVICE_H__

>  #include <unistd.h>
> -#include <sys/syscall.h>
> +#include "lapi/syscalls.h"
Hm, maybe this fix wasn't a good idea.
It effectively uses lapi/syscalls.h everywhere instead of <sys/syscall.h>.
Not sure if this is what we want.

Example of the error is #634 [1], which is caused by __NR_socketcall being -1
instead of not defined (socketcall is not defined on some archs, e.g. x86-64 and ARM).
We can fix the condition, but it will lead to numerous not obvious errors, so I
suggest to revert this (and thus get LTP broken on very old distros).

I'm sorry to break LTP just before release.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/634
