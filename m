From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 17 Jun 2020 10:21:48 +0530
Subject: [LTP] [RFC PATCH] lapi: Add posix_types.h
In-Reply-To: <20200616190918.24761-1-pvorel@suse.cz>
References: <20200616190918.24761-1-pvorel@suse.cz>
Message-ID: <20200617045148.vegbo3ufpjeqlrgz@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16-06-20, 21:09, Petr Vorel wrote:
> To fix undefined __kernel_ulong_t, which was defined in v3.4-rc1
> in afead38d011a ("posix_types: Introduce __kernel_[u]long_t").
> 
> This fixed build error:
> 
> In file included from /usr/src/ltp/include/lapi/msgbuf.h:13,
>                  from /usr/src/ltp/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c:9:
> /usr/src/ltp/include/lapi/ipcbuf.h: At top level:
> /usr/src/ltp/include/lapi/ipcbuf.h:187: error: expected specifier-qualifier-list before '__kernel_ulong_t'
> 
> Fixes: 3e1fc0644 ("include: Add declaration of struct ipc64_perm")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> or is it a time to drop that support?
> If I remember we were talking about 3.0, this is 3.4.
> 
> Is this correct?
> +#ifndef __kernel_long_t
> +# if defined(__x86_64__) && defined(__ILP32__)
> +typedef long long		__kernel_long_t;
> +typedef unsigned long long	__kernel_ulong_t;
> +# else
> +typedef long			__kernel_long_t;
> +typedef unsigned long		__kernel_ulong_t;
> +# endif
> +#endif
> 
> Kind regards,
> Petr
> 
>  include/lapi/ipcbuf.h      |  2 +-
>  include/lapi/msgbuf.h      |  2 +-
>  include/lapi/posix_types.h | 21 +++++++++++++++++++++
>  include/lapi/sembuf.h      |  2 +-
>  include/lapi/shmbuf.h      |  2 +-
>  include/tst_timer.h        |  7 +------
>  6 files changed, 26 insertions(+), 10 deletions(-)
>  create mode 100644 include/lapi/posix_types.h

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
