From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jun 2020 21:44:29 +0200
Subject: [LTP] [RFC PATCH] lapi: Add posix_types.h
In-Reply-To: <20200616190918.24761-1-pvorel@suse.cz>
References: <20200616190918.24761-1-pvorel@suse.cz>
Message-ID: <20200616194429.GA31700@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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

As far as I can tell yes, I came to the same conclusion.

I guess that we may as well push this patch since you already put an
effort into crafting it.

-- 
Cyril Hrubis
chrubis@suse.cz
