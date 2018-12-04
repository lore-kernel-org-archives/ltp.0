From: Greg Hackmann <ghackmann@google.com>
Date: Tue, 4 Dec 2018 09:34:28 -0800
Subject: [LTP] [PATCH 1/2] getrlimit/getrlimit03: add configure-time
 check for struct ulimit64
In-Reply-To: <20181204090130.GA24014@dell5510>
References: <20181203190148.93108-1-ghackmann@google.com>
 <20181203212505.GA2022@x230>
 <98a5058e-939b-3fb5-4f78-4e11f6901e0e@google.com>
 <20181204090130.GA24014@dell5510>
Message-ID: <4cf455cd-8734-f606-ef6e-11dcf7d42d19@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/04/2018 01:01 AM, Petr Vorel wrote:
> Hi Greg,
> 
>> On 12/03/2018 01:25 PM, Petr Vorel wrote:
>>> Glibc and uclibc-ng define struct rlimit64 only #ifdef __USE_LARGEFILE64.
> 
>> Makes sense.  I ran into this issue with bionic, which doesn't require
>> -D_LARGEFILE64_SOURCE for these kinds of definitions.
> Out of curiosity: how do you use it on bionic? Looking into git, struct rlimit64
> is defined in libc/kernel/uapi/linux/resource.h (generated file form kernel
> headers), not in libc/include/sys/resource.h. And you include in getrlimit03.c
> <sys/resource.h> (not <linux/resource.h>).
> 

bionic prefers to grab kernel-facing definitions directly from the UAPI 
headers, so sys/resource.h includes linux/resource.h.

I could switch the test to explicitly use linux/resource.h, if you feel 
that makes more sense.  I originally used sys/resource.h to get all the 
other rlimit-related constants.  I actually didn't realize that the 
kernel already exported a struct rlimit64 definition that we could use 
in place of open-coding something.

>>> Would it make sense to change autoconf test to AC_COMPILE_IFELSE and pass -D_LARGEFILE64_SOURCE to it?
>>> + Use it in Makefile, of course.
> 
> 
>> I'm honestly not that familiar with autotools, so I'm not sure I follow
>> this.  Are you suggesting that we assume struct rlimit64 is defined
>> (possibly conditionally on -D_LARGEFILE64_SOURCE), and we really ought to
>> probe whether -D_LARGEFILE64_SOURCE is required to make it visible?
> I propose to define _LARGEFILE64_SOURCE anyway, as it allows us to use structures on
> glibc[1] and uclibc{,-ng} while it does not harm musl and bionic.
> your way to check for it before using it makes sense. I just pointed out,
> 
> + <sys/time.h> is no t needed in LTP_CHECK_RLIMIT64.
> 
> So I propose following changes to your patch:
> 
> diff --git m4/ltp-rlimit64.m4 m4/ltp-rlimit64.m4
> index 6513e65e5..dccb40188 100644
> --- m4/ltp-rlimit64.m4
> +++ m4/ltp-rlimit64.m4
> @@ -3,7 +3,7 @@ dnl Copyright (c) 2018 Google, Inc.
>   
>   AC_DEFUN([LTP_CHECK_RLIMIT64],[
>   AC_CHECK_TYPES([struct rlimit64],,,[
> -#include <sys/time.h>
> +#define _LARGEFILE64_SOURCE
>   #include <sys/resource.h>
>   ])
>   ])
> diff --git testcases/kernel/syscalls/getrlimit/Makefile testcases/kernel/syscalls/getrlimit/Makefile
> index bd617d806..4a776e7b1 100644
> --- testcases/kernel/syscalls/getrlimit/Makefile
> +++ testcases/kernel/syscalls/getrlimit/Makefile
> @@ -18,6 +18,8 @@
>   
>   top_srcdir		?= ../../../..
>   
> +getrlimit03: CFLAGS += -D_LARGEFILE64_SOURCE
> +
>   include $(top_srcdir)/include/mk/testcases.mk
>   
>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> 
> 
> 
> Kind regards,
> Petr
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=blob;f=bits/resource.h;h=7693d20fed284ee1bae5cba8884da319f58e262e;hb=HEAD#l112
> 

Sounds reasonable.  Thanks for your help here.
