From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 17 Jul 2020 12:38:16 +0200
Subject: [LTP] [PATCH] lapi/io_uring.h: Add declaration of __kernel_rwf_t
In-Reply-To: <1eac1ed9-66dd-5141-0bc2-cc05312704c8@cn.fujitsu.com>
References: <1594959191-25155-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200717073842.GA31254@dell5510> <20200717080840.GB32407@dell5510>
 <1eac1ed9-66dd-5141-0bc2-cc05312704c8@cn.fujitsu.com>
Message-ID: <20200717103816.GA28835@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> how about the follwing change
> 
> +#ifdef __CHECKER__
> +#define __bitwise__ __attribute__((bitwise))
> +#else
> +#define __bitwise__
> +#endif
> +#define __bitwise __bitwise__
> +
> +#ifndef __kernel_rwf_t
> +typedef int __bitwise __kernel_rwf_t;
> +#endif
> 
> Also, I think we should replace _u32 with uint32 in lapi/loop.h if we 
> don't want to include linux kernel header for single use.

The whole __bitwise is used only by a sparse checker, there is no point
to include it in LTP. So we can just typedef the __kernel_rwf_t to int.

-- 
Cyril Hrubis
chrubis@suse.cz
