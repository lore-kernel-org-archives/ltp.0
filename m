From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 13 May 2019 15:54:21 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/getcpu:Add libc sched_getcpu()
 detection &&fix compiler errors
In-Reply-To: <1555481102-4158-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190412114632.GD28648@haruka.lan>
 <1555481102-4158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1555481102-4158-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5CD922AD.4050006@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/04/17 14:05, Yang Xu wrote:
> sched_getcpu() isn't defined on some old distros, so we can add dection
> and fix compiler error.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  configure.ac                                | 1 +
>  testcases/kernel/syscalls/getcpu/getcpu01.c | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index fad8f8396..53ad784d7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -77,6 +77,7 @@ AC_CHECK_FUNCS([ \
>      readlinkat \
>      renameat \
>      renameat2 \
> +    sched_getcpu \
>      sigpending \
>      splice \
>      stime \
> diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
> index eb6ded8ab..fcc273e29 100644
> --- a/testcases/kernel/syscalls/getcpu/getcpu01.c
> +++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
> @@ -18,13 +18,14 @@
>  #include "lapi/syscalls.h"
>  #include "lapi/cpuset.h"
>  #include "tst_test.h"
> +#include "config.h"
>  
>  static inline int get_cpu(unsigned *cpu_id,
>  			  unsigned *node_id LTP_ATTRIBUTE_UNUSED,
>  			  void *cache_struct LTP_ATTRIBUTE_UNUSED)
>  {
> -#if defined(__i386__)
> -	return syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
> +#ifndef HAVE_SCHED_GETCPU
> +	return tst_syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
>  #else
>  	*cpu_id = sched_getcpu();
>  #endif
Hi,
Ping. :-)


