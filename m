From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Fri, 26 Mar 2021 11:08:26 +0800
Subject: [LTP] [PATCH] syscalls/mallopt:fix compiling error
References: <1616726772-29562-1-git-send-email-liuxp11@chinatelecom.cn>, 
 <605D4F1F.3020301@fujitsu.com>
Message-ID: <202103261108256329041@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thanks,please ignore this patch.
 
From: xuyang2018.jy@fujitsu.com
Date: 2021-03-26 11:03
To: Xinpeng Liu
CC: ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] syscalls/mallopt:fix compiling error
Hi Liu
> mallopt01.c:33:3: warning: implicit declaration of function ?print_mallinfo?
> [-Wimplicit-function-declaration]
>     print_mallinfo("Test uordblks",&info);
>        ^
> /tmp/ccOU0s7e.o: In function `test_mallopt':
> /root/mywork/ltp_github/testcases/kernel/syscalls/mallopt/mallopt01.c:37:
> undefined reference to `print_mallinfo'
> /root/mywork/ltp_github/testcases/kernel/syscalls/mallopt/mallopt01.c:33:
> undefined reference to `print_mallinfo'
Usually, if glibc supports mallopt, it should also support mallinfo. So 
I guess you met this problem because your compile enviroment wat not clean.
Please try again as the following step:
make distclean
make autotools
./configure
cd testcases/kernel/syscalls/mallopt/
make
>
> Signed-off-by: Xinpeng Liu<liuxp11@chinatelecom.cn>
> ---
>   testcases/kernel/syscalls/mallopt/mallopt01.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
> index 8ff4649..bb7234f 100644
> --- a/testcases/kernel/syscalls/mallopt/mallopt01.c
> +++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
> @@ -13,6 +13,7 @@
>    */
>
>
> +#define HAVE_MALLINFO
We have checked mallinfo function in configure.ac. We never define this 
directly.
>   #include "../mallinfo/mallinfo_common.h"
>   #include "tst_safe_macros.h"
>
 
Best Regards
Yang Xu
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210326/3fc13610/attachment-0001.htm>
