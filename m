From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 17 Jul 2020 18:32:58 +0800
Subject: [LTP] [PATCH] lapi/io_uring.h: Add declaration of __kernel_rwf_t
In-Reply-To: <20200717080840.GB32407@dell5510>
References: <1594959191-25155-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200717073842.GA31254@dell5510> <20200717080840.GB32407@dell5510>
Message-ID: <1eac1ed9-66dd-5141-0bc2-cc05312704c8@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr


>>> Since kernel commit ddef7ed2b5cb ("annotate RWF_... flags"), fs.h introduced
>>>   __kernel_rwf_t data type in 4.14-rc1.
>>>
>>> Fix build error on old kernel.
> 
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> Thanks for the fix.
>> Going to merge it, just wait for travis verification.
> BTW the regression was caused by my changes to the lapi header in 95399bc87
> ("lapi/io_uring: Preparation for io_uring tests") - I updated the header.
> 
> We might consider not including <linux/types.h>, it's needed just for
> __kernel_rwf_t. I'm against these optimisations (as the definition can change),
> but I remember Jan asked me to avoid including kernel header just for single use
> [1], but maybe this is a different case.
I still remember the similar case when clean up quotactl code(commit 
c4bf6f66 lapi/quotactl.h: Use libc headers instead kernel uapi) last year.

how about the follwing change

+#ifdef __CHECKER__
+#define __bitwise__ __attribute__((bitwise))
+#else
+#define __bitwise__
+#endif
+#define __bitwise __bitwise__
+
+#ifndef __kernel_rwf_t
+typedef int __bitwise __kernel_rwf_t;
+#endif

Also, I think we should replace _u32 with uint32 in lapi/loop.h if we 
don't want to include linux kernel header for single use.

> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/project/ltp/patch/20191016211501.3777-1-petr.vorel@gmail.com/#2281586
> 
> 


