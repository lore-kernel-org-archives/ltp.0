From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Fri, 26 Mar 2021 03:03:39 +0000
Subject: [LTP] [PATCH] syscalls/mallopt:fix compiling error
In-Reply-To: <1616726772-29562-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1616726772-29562-1-git-send-email-liuxp11@chinatelecom.cn>
Message-ID: <605D4F1F.3020301@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

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
