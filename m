From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Nov 2020 12:33:03 +0800
Subject: [LTP] [PATCH] lapi/name_to_handle_at.h: Fix compiler error on
 centos6
In-Reply-To: <20201126012838.531070-1-yangx.jy@cn.fujitsu.com>
References: <20201126012838.531070-1-yangx.jy@cn.fujitsu.com>
Message-ID: <CAEemH2eQNTy9V+NSn+kwV8zZ0BTr+PEHuD_RPhx3Ns1v=+iPNw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

The patch itself looks good, but I remember we were planning to
drop support for the old distro e.g CentOS6.

The previous discussion here:
http://lists.linux.it/pipermail/ltp/2020-March/016164.html

On Thu, Nov 26, 2020 at 9:49 AM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> From travis-ci, compiling name_to_handle_at/open_by_handle_at tests
> failed on centos6 due to undefined AT_EMPTY_PATH and MAX_HANDLE_SZ.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  include/lapi/fcntl.h             | 4 ++++
>  include/lapi/name_to_handle_at.h | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
> index 576a18daf..d6665915f 100644
> --- a/include/lapi/fcntl.h
> +++ b/include/lapi/fcntl.h
> @@ -136,4 +136,8 @@
>  # define SPLICE_F_NONBLOCK 2
>  #endif
>
> +#ifndef MAX_HANDLE_SZ
> +# define MAX_HANDLE_SZ 128
> +#endif
> +
>  #endif /* __LAPI_FCNTL_H__ */
> diff --git a/include/lapi/name_to_handle_at.h
> b/include/lapi/name_to_handle_at.h
> index c0759c463..3484133d1 100644
> --- a/include/lapi/name_to_handle_at.h
> +++ b/include/lapi/name_to_handle_at.h
> @@ -10,6 +10,7 @@
>  #include <sys/syscall.h>
>  #include "config.h"
>  #include "lapi/syscalls.h"
> +#include "lapi/fcntl.h"
>  #include "tst_buffers.h"
>  #include "tst_test.h"
>
> --
> 2.25.1
>
>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201126/62f14889/attachment.htm>
